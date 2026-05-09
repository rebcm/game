// =====================================================================
// main.js — Entry point: init + loop + handlers de ações de jogo
// =====================================================================

import * as THREE from 'three';
import { PointerLockControls } from 'three/addons/controls/PointerLockControls.js';
import {
  CHUNK_SIZE, WORLD_Y, VIEW_RADIUS, BLOCO, BLOCO_INFO, ITEM, ITEM_INFO,
  ALCANCE_BLOCO, TEMPO_QUEBRA_BASE, DIA_SEGUNDOS,
} from './constants.js';
import { clamp } from './utils.js';
import { state } from './state.js';
import { Audio } from './audio.js';
import { World } from './world.js';
import { Renderer } from './render.js';
import { Player } from './player.js';
import { Inventario, Drops, Crafting } from './inventory.js';
import { Achievements } from './achievements.js';
import { Multiplayer } from './multiplayer.js';
import { inicializar as initQuality, tickFps as qualityTickFps, aplicarTier, salvarPreferencia, PRESETS } from './quality.js';
import { MobManager, MOB_INFO } from './mobs.js';
import {
  Particulas, spawnItemDrop, atualizarItemDrops,
  spawnXPOrb, atualizarXpOrbs, atualizarAmbientTriggers,
  atualizarAmbientBioma,
  spawnArrow, atualizarArrows,
  castFishingLine, atualizarFishingBobber,
  lancarFoguete, atualizarFireworks,
  lancarTridente, atualizarTridents,
} from './particles.js';
import { UI } from './ui.js';
import { Save } from './save.js';
import { setupInput, setupTouchControls, setActions } from './input.js';
import { atualizarClima } from './weather.js';

// Vetor temporário pra raycast
const _tmpVecAux = new THREE.Vector3();

// === XP ===
function xpProximoNivel() {
  return Math.max(7, state.player.nivel * state.player.nivel * 4 + 7);
}
function ganharXP(pts) {
  state.player.xp += pts;
  while (state.player.xp >= xpProximoNivel()) {
    state.player.xp -= xpProximoNivel();
    state.player.nivel += 1;
    Audio.levelUp();
    state.ui.toast(`⭐ Nível ${state.player.nivel}!`);
  }
  state.ui.atualizarXP();
}

// === Memory watchdog ===
// Roda 1×/s. Se o heap JS estourar 80% do limite, libera chunks BEM
// distantes (mais agressivo que a limpeza padrão) e mostra warning.
let _memWarnedAt = 0;
function _checkMemory() {
  const m = performance && performance.memory;
  if (!m) return;
  const usado = m.usedJSHeapSize, limite = m.jsHeapSizeLimit;
  const rel = usado / limite;
  if (rel > 0.85) {
    // Pressão crítica: agressiva limpeza
    const pcx = Math.floor(state.player.pos.x / CHUNK_SIZE);
    const pcz = Math.floor(state.player.pos.z / CHUNK_SIZE);
    const VR = state.quality?.viewRadius ?? VIEW_RADIUS;
    let liberados = 0;
    for (const [k, c] of state.world.chunks) {
      const dx = c.cx - pcx, dz = c.cz - pcz;
      if (Math.abs(dx) > VR || Math.abs(dz) > VR) {
        if (c.mesh) state.renderer.liberarChunkMesh(c);
        if (!c.modificado) { state.world.chunks.delete(k); liberados++; }
      }
    }
    if (Date.now() - _memWarnedAt > 10000) {
      _memWarnedAt = Date.now();
      state.ui.toast(`⚠ Memória alta (${(rel * 100).toFixed(0)}%) — liberou ${liberados} chunks`);
    }
  }
}

// === Atacar mob ===
// Se item ativo é ARCO e player tem flechas, dispara projétil em vez
// de atacar corpo-a-corpo. Caso contrário, melee normal.
function atacarMob() {
  if (state.player.morto) return;
  const sel = state.inv.itemSelecionado();
  const usandoArco = sel && sel.i === ITEM.ARCO && state.inv.contar(undefined, ITEM.FLECHA) > 0;
  if (usandoArco) {
    // Inicia o charge do arco; quem dispara é o release (F keyup).
    if (!state.player.bowCharging) {
      state.player.bowCharging = true;
      state.player.bowCharge = 0;
      Audio.bowDraw();
    }
    return;
  }
  const m = state.mobMgr.maisProximo(state.player, ALCANCE_BLOCO);
  if (!m) return;
  const isCrit = !state.player.noChao && state.player.vel.y < -0.3 && state.player.modo === 'survival';
  Audio.atacar();
  if (isCrit) {
    Audio.critical();
    state.particulas?.spawnCritStars?.(m.x, m.y + 1.5, m.z);
  }
  const tier = state.inv.melhorEspada();
  let dano = 2 + tier * 2;
  if (isCrit) dano = Math.round(dano * 1.5);
  // Sharpness enchantment do item ativo (sel.encant.sharpness 1-3 = +1/+2/+3 dano)
  const selAtual = state.inv.itemSelecionado();
  if (selAtual?.encant?.sharpness) dano += selAtual.encant.sharpness;
  // Poção de Strength: +50% dano enquanto ativa
  if (state.player.efeitos?.strength && Date.now() < state.player.efeitos.strength) {
    dano = Math.round(dano * 1.5);
  } else if (state.player.efeitos?.strength) delete state.player.efeitos.strength;
  if (m.tipo === 'zumbi') Audio.zumbiHit();
  else Audio.hit();
  // Damage number flutuante na tela
  if (state.ui?.spawnDamageNumber) {
    state.ui.spawnDamageNumber(m.x, m.y + 1.5, m.z, dano, isCrit);
  }
  // Knockback velocity (smooth) — força ~6 m/s na direção do golpe
  const dirCam = state.renderer.camera.getWorldDirection(_tmpVecAux);
  let kbForca = isCrit ? 8.5 : 6.0;
  // Knockback enchantment: +50% por nível
  if (selAtual?.encant?.knockback) kbForca *= 1 + 0.5 * selAtual.encant.knockback;
  m.tomarDano(dano, dirCam.x * kbForca, dirCam.z * kbForca);
  if (m.hp <= 0) {
    const drops = MOB_INFO[m.tipo].drops();
    // Looting: por nível, 25/50/75% chance de dropar 1 item adicional do mesmo set
    if (selAtual?.encant?.looting && Math.random() < 0.25 * selAtual.encant.looting) {
      const extra = MOB_INFO[m.tipo].drops();
      for (const d of extra) drops.push(d);
    }
    if (state.player.modo === 'creative') {
      for (const d of drops) state.inv.adicionar(d);
    } else {
      for (const d of drops) spawnItemDrop(d, m.x, m.y, m.z);
    }
    const xp = MOB_INFO[m.tipo].hostil ? 5 : 2;
    spawnXPOrb(xp, m.x, m.y + 0.5, m.z);
    state.ui.toast(`${m.tipo} derrotado! ${isCrit ? '⚡ CRÍTICO! ' : ''}(+${xp} XP)`);
    if (MOB_INFO[m.tipo].hostil) Achievements.unlock('PRIMEIRO_MOB');
    if (m.tipo === 'ender_dragon') Achievements.unlock('SLAY_DRAGON');
    Save.incrementarStat('mobsKilled');
  } else {
    state.ui.toast(`Atingiu ${m.tipo}${isCrit ? ' ⚡' : ''} (-${dano})`);
  }
}

// === Trades de villager ===
// Cada villager tem 4 trades fixos baseados em seed (não mudam por sessão).
// Player paga ITEM.X * Q1 → recebe ITEM.Y * Q2.
const _TRADES_BASE = [
  { paga: { i: ITEM.TRIGO, q: 5 },        recebe: { i: ITEM.ESMERALDA, q: 1 } },
  { paga: { i: ITEM.CARNE_COZIDA, q: 3 }, recebe: { i: ITEM.ESMERALDA, q: 1 } },
  { paga: { i: ITEM.PAU, q: 8 },          recebe: { i: ITEM.ESMERALDA, q: 1 } },
  { paga: { i: ITEM.CARVAO, q: 4 },       recebe: { i: ITEM.ESMERALDA, q: 1 } },
  { paga: { i: ITEM.ESMERALDA, q: 1 },    recebe: { i: ITEM.PAO, q: 5 } },
  { paga: { i: ITEM.ESMERALDA, q: 1 },    recebe: { i: ITEM.LIVRO, q: 1 } },
  { paga: { i: ITEM.ESMERALDA, q: 2 },    recebe: { i: ITEM.LAPIS, q: 3 } },
  { paga: { i: ITEM.ESMERALDA, q: 5 },    recebe: { i: ITEM.DIAMANTE, q: 1 } },
];

function abrirTradeVillager(mob) {
  const modal = document.getElementById('trade-modal');
  const lista = document.getElementById('trade-list');
  // Seleciona 4 trades aleatórios (seed = posição do mob, estável entre right-clicks)
  const seed = (Math.floor(mob.x * 100) ^ Math.floor(mob.z * 100)) >>> 0;
  const trades = [];
  let s = seed;
  for (let i = 0; i < 4; i++) {
    s = (s * 9301 + 49297) % 233280;
    trades.push(_TRADES_BASE[s % _TRADES_BASE.length]);
  }
  lista.innerHTML = '';
  for (const t of trades) {
    const div = document.createElement('div');
    div.className = 'trade-row';
    const tem = state.inv.contar(undefined, t.paga.i) >= t.paga.q;
    if (!tem) div.classList.add('disabled');
    const nomePaga = ITEM_INFO[t.paga.i]?.nome || '?';
    const nomeRec = ITEM_INFO[t.recebe.i]?.nome || '?';
    const icoPaga = ITEM_INFO[t.paga.i]?.icone || '';
    const icoRec  = ITEM_INFO[t.recebe.i]?.icone || '';
    div.innerHTML = `<span>${icoPaga} ${t.paga.q} ${nomePaga}</span><span class="arrow">→</span><span>${icoRec} ${t.recebe.q} ${nomeRec}</span>`;
    div.onclick = () => {
      if (state.inv.contar(undefined, t.paga.i) < t.paga.q) {
        state.ui.toast(`Falta ${t.paga.q - state.inv.contar(undefined, t.paga.i)}× ${nomePaga}`);
        return;
      }
      state.inv.consumir(undefined, t.paga.i, t.paga.q);
      state.inv.adicionar({ i: t.recebe.i, q: t.recebe.q });
      Audio.colocar?.();
      state.ui.toast(`Trocou por ${t.recebe.q}× ${nomeRec}`);
      abrirTradeVillager(mob); // reabre pra refresh dos disabled
    };
    lista.appendChild(div);
  }
  modal.classList.remove('hidden');
  try { state.player.controls.unlock(); } catch (_) {}
  document.getElementById('trade-close').onclick = () => modal.classList.add('hidden');
}

// === Encantar item ativo: abre modal com enchants disponíveis ===
// Espada → sharpness, knockback, looting
// Picareta → efficiency, fortune
// Armadura → protection
// Cada nível custa nivel×10 XP + 1 lápis lazuli. Máx 3.
const _ENCHANTS_POR_TIPO = {
  esp: [
    { id: 'sharpness',  nome: 'Sharpness',  desc: '+1 dano por nível' },
    { id: 'knockback',  nome: 'Knockback',  desc: '+50% empurrão por nível' },
    { id: 'looting',    nome: 'Looting',    desc: 'chance de drop extra' },
  ],
  pic: [
    { id: 'efficiency', nome: 'Efficiency', desc: '+20% velocidade por nível' },
    { id: 'fortune',    nome: 'Fortune',    desc: 'chance de drop extra de minério' },
  ],
};
function encantarItemAtual() {
  const sel = state.inv.itemSelecionado();
  if (!sel || sel.i === undefined) {
    state.ui.toast('Selecione um item pra encantar');
    return;
  }
  const info = ITEM_INFO[sel.i];
  let opcoes = null;
  if (info?.ferramenta === 'esp') opcoes = _ENCHANTS_POR_TIPO.esp;
  else if (info?.ferramenta === 'pic') opcoes = _ENCHANTS_POR_TIPO.pic;
  else if (info?.armadura) opcoes = [{ id: 'protection', nome: 'Protection', desc: '-1 dano sofrido por nível' }];
  if (!opcoes) {
    state.ui.toast('Item não encantável (use espada/picareta/armadura)');
    return;
  }
  // Renderiza modal
  const itemEl = document.getElementById('enchant-item');
  const opcoesEl = document.getElementById('enchant-opcoes');
  const ico = info?.icone || '';
  const nomeBase = sel.nomeCustom ? `"${sel.nomeCustom}" (${info.nome})` : info.nome;
  // Conta estantes pra mostrar selo de bônus no header
  const _px = Math.floor(state.player.pos.x);
  const _py = Math.floor(state.player.pos.y);
  const _pz = Math.floor(state.player.pos.z);
  let _est = 0;
  for (let dx = -2; dx <= 2; dx++) for (let dz = -2; dz <= 2; dz++) for (let dy = -1; dy <= 1; dy++) {
    if (state.world.get(_px + dx, _py + dy, _pz + dz) === BLOCO.ESTANTE) _est++;
  }
  const bonus = _est >= 4 ? ' · 📚 -30% XP (4+ estantes)' : '';
  if (itemEl) itemEl.textContent = `${ico} ${nomeBase}${bonus}`;
  if (opcoesEl) {
    opcoesEl.innerHTML = '';
    for (const op of opcoes) {
      const nivelAtual = sel.encant?.[op.id] || 0;
      const proxNivel = nivelAtual + 1;
      const max = nivelAtual >= 3;
      // Bônus: conta estantes ao redor do player (raio 2 blocos, qualquer Y).
      // 4+ estantes = -30% custo XP (paridade Minecraft real).
      const px = Math.floor(state.player.pos.x);
      const py = Math.floor(state.player.pos.y);
      const pz = Math.floor(state.player.pos.z);
      let estantes = 0;
      for (let dx = -2; dx <= 2; dx++) for (let dz = -2; dz <= 2; dz++) for (let dy = -1; dy <= 1; dy++) {
        if (state.world.get(px + dx, py + dy, pz + dz) === BLOCO.ESTANTE) estantes++;
      }
      const desconto = estantes >= 4 ? 0.3 : 0;
      const custoXP = Math.max(1, Math.round(proxNivel * 10 * (1 - desconto)));
      const temXP = (state.player.xp || 0) >= custoXP;
      const temLapis = state.inv.contar(undefined, ITEM.LAPIS) > 0;
      const enabled = !max && temXP && temLapis;
      const div = document.createElement('div');
      div.className = `enchant-opt ${enabled ? '' : 'disabled'}`;
      div.innerHTML = `
        <div>
          <div>${op.nome} <span class="enchant-nivel">${nivelAtual > 0 ? `(nv ${nivelAtual})` : ''}</span></div>
          <div class="enchant-custo">${op.desc}</div>
        </div>
        <div class="enchant-custo">${max ? 'MAX' : `${custoXP} XP + 1 🔷`}</div>`;
      if (enabled) {
        div.onclick = () => {
          state.player.xp -= custoXP;
          state.inv.consumir(undefined, ITEM.LAPIS, 1);
          sel.encant = sel.encant || {};
          sel.encant[op.id] = proxNivel;
          Audio.levelUp?.();
          state.ui.toast(`✨ ${info.nome} +${op.id} ${proxNivel}!`);
          state.ui.atualizarXP?.();
          state.ui.renderHotbar?.();
          encantarItemAtual(); // re-renderiza pra refletir novo nível/custo
        };
      }
      opcoesEl.appendChild(div);
    }
  }
  document.getElementById('painel-enchant').classList.remove('hidden');
  try { document.exitPointerLock?.(); } catch (_) {}
}

// === Solta o arco (chamado em F keyup) — dispara flecha com força
// proporcional ao tempo de charge. Hold máx ~1.2s = full power.
function soltarArco() {
  const p = state.player;
  if (!p.bowCharging) return;
  const charge = Math.min(1, (p.bowCharge || 0) / 1.2);
  p.bowCharging = false;
  p.bowCharge = 0;
  // Charge mínimo de 0.15s pra evitar tap-spam
  if (charge < 0.12) return;
  if (state.inv.contar(undefined, ITEM.FLECHA) <= 0) return;
  state.inv.consumir(undefined, ITEM.FLECHA, 1);
  const dirCam = state.renderer.camera.getWorldDirection(_tmpVecAux).clone();
  const dano = Math.round(2 + charge * 8);   // 2 (tap) → 10 (full)
  const vel  = 18 + charge * 22;             // 18 → 40 m/s
  spawnArrow(state.renderer.camera.position, dirCam, dano, vel);
  Audio.bowRelease();
}

// === Comer item da hotbar ===
function comerSlot() {
  if (state.player.morto) return;
  const s = state.inv.itemSelecionado();
  if (!s || s.i === undefined) { state.ui.toast('Nada comestível selecionado'); return; }
  const info = ITEM_INFO[s.i];
  // Poções: efeitos imediatos ou timer
  if (info?.pocao) {
    aplicarPocao(info.pocao);
    state.inv.consumirAtual();
    Audio.eatCrunch();
    state.ui.toast(`🧪 Poção de ${info.pocao}`);
    return;
  }
  // Maçã Dourada: nutrição 4 + Regen 30s + Absorption 5s extra HP
  // (paridade Minecraft real — item endgame de cura)
  if (s.i === ITEM.MACA_DOURADA) {
    state.player.fome = clamp(state.player.fome + 4, 0, state.player.fomeMax);
    state.player.saturation = Math.min(20, (state.player.saturation || 0) + 9.6);
    state.player.efeitos = state.player.efeitos || {};
    state.player.efeitos.regen = Date.now() + 30000;
    // Absorption: HP extra temporário (acima do max). Decai naturalmente.
    state.player.absorptionHP = (state.player.absorptionHP || 0) + 4;
    state.player.absorptionExpira = Date.now() + 120000; // 2 min
    state.inv.consumirAtual();
    Audio.eatCrunch();
    Audio.levelUp?.();
    state.ui.toast('🍏 Maçã dourada! Regen + 4 HP extra');
    return;
  }
  // Sopa de Cogumelo: nutrição 6 + devolve tigela vazia (paridade MC)
  if (s.i === ITEM.SOPA_COGUMELO) {
    state.player.fome = clamp(state.player.fome + 6, 0, state.player.fomeMax);
    state.player.saturation = Math.min(20, (state.player.saturation || 0) + 7.2);
    state.inv.consumirAtual();
    state.inv.adicionar({ i: ITEM.TIGELA, q: 1 });
    Audio.eatCrunch();
    state.ui.toast('🍲 Sopa deliciosa! (+6 fome)');
    return;
  }
  // Balde de Leite: remove TODOS os efeitos ativos (paridade Minecraft) +
  // restaura saturação. Devolve balde vazio.
  if (s.i === ITEM.BUCKET_LEITE) {
    state.player.efeitos = {};
    state.player.saturation = Math.min(20, (state.player.saturation || 0) + 6);
    state.inv.consumirAtual();
    state.inv.adicionar({ i: ITEM.BUCKET, q: 1 });
    Audio.eatCrunch();
    state.ui.toast('🥛 Bebeu leite — efeitos removidos');
    return;
  }
  if (!info || !info.nutricao) { state.ui.toast('Não comestível'); return; }
  state.player.fome = clamp(state.player.fome + info.nutricao, 0, state.player.fomeMax);
  state.player.saturation = Math.min(20, state.player.saturation + info.nutricao * 0.6);
  state.inv.consumirAtual();
  Audio.eatCrunch();
  if (info.suspeito && Math.random() < 0.15) state.player.aplicarDano(1, 'comida estragada');
  else state.ui.toast(`Comeu ${info.nome} (+${info.nutricao} fome)`);
  if (s.i === ITEM.CARNE_COZIDA) Achievements.unlock('COMER_CARNE');
}

// Aplica efeito de poção. Heal é instantâneo; speed/strength/regen têm
// timer (state.player.efeitos[tipo] = msAteAcabar).
function aplicarPocao(tipo) {
  const p = state.player;
  p.efeitos = p.efeitos || {};
  if (tipo === 'heal') {
    p.hp = Math.min(p.hpMax, p.hp + 5);
  } else if (tipo === 'levitacao') {
    // Levitação: empurra player verticalmente por 10s
    p.efeitos.levitacao = Date.now() + 10000;
    p.vel.y = 4;
  } else if (tipo === 'resistencia') {
    // Resistência: -50% dano por 30s
    p.efeitos.resistencia = Date.now() + 30000;
  } else if (tipo === 'fire_res') {
    p.efeitos.fire_res = Date.now() + 60000; // 1 min imune a fogo/lava
  } else if (tipo === 'slow_fall') {
    p.efeitos.slow_fall = Date.now() + 30000;
  } else if (tipo === 'invisivel') {
    p.efeitos.invisivel = Date.now() + 30000;
    state.ui?.toast?.('🫥 Invisível! Mobs te ignoram.');
  } else if (tipo === 'noite') {
    p.efeitos.noite = Date.now() + 60000; // visão noturna 1min
    state.ui?.toast?.('🌙 Visão noturna ativa');
  } else {
    p.efeitos[tipo] = Date.now() + 30000; // 30s default
  }
}

// === Dormir ===
function dormir() {
  const sun = Math.max(0.05, 0.5 + 0.5 * Math.sin(state.tempoDia * Math.PI * 2 - Math.PI / 2));
  if (sun > 0.4) { state.ui.toast('Você só pode dormir à noite'); return; }
  Audio.cama();
  const overlay = document.getElementById('dormindo-overlay');
  overlay.classList.remove('hidden');
  setTimeout(() => {
    state.tempoDia = 0.22;
    state.player.hp = state.player.hpMax;
    state.player.fome = Math.max(state.player.fome - 1, 0);
    overlay.classList.add('hidden');
    state.ui.toast('Bom dia! ☀️');
  }, 1200);
}

// === Painel do baú ===
function abrirPainelBau(x, y, z) {
  state.bauAtivoCoords = { x, y, z };
  Audio.chestOpen();
  state.ui.renderBauPainel();
  document.getElementById('painel-bau').classList.remove('hidden');
  try { document.exitPointerLock?.(); } catch (_) {}
}

// === Painel da bigorna ===
// Renomeia o item ativo da hotbar. Custo 3 XP por rename. O nome custom
// fica em sel.nomeCustom e é exibido no tooltip + hotbar.
function abrirPainelBigorna() {
  const sel = state.inv.itemSelecionado();
  const itemEl = document.getElementById('bigorna-item');
  const nomeInput = document.getElementById('bigorna-nome');
  const aplicarBtn = document.getElementById('bigorna-aplicar');
  const xpEl = document.getElementById('bigorna-xp');
  const custoXP = 3;
  if (xpEl) xpEl.textContent = custoXP;
  if (sel && (sel.i !== undefined || sel.b !== undefined)) {
    const info = sel.i !== undefined ? ITEM_INFO[sel.i] : BLOCO_INFO[sel.b];
    const ico = sel.i !== undefined ? (ITEM_INFO[sel.i]?.icone || '') : '';
    const nome = sel.nomeCustom || info?.nome || '?';
    if (itemEl) itemEl.textContent = `${ico} ${nome} ×${sel.q}`;
    if (nomeInput) nomeInput.value = sel.nomeCustom || '';
  } else {
    if (itemEl) itemEl.textContent = '— nada selecionado —';
    if (nomeInput) nomeInput.value = '';
  }
  if (aplicarBtn) {
    aplicarBtn.onclick = () => {
      const sel2 = state.inv.itemSelecionado();
      if (!sel2 || (sel2.i === undefined && sel2.b === undefined)) {
        state.ui.toast('Selecione um item na hotbar primeiro');
        return;
      }
      const novo = (nomeInput?.value || '').trim();
      if (!novo) { state.ui.toast('Digite um nome'); return; }
      if ((state.player.xp || 0) < custoXP) {
        state.ui.toast(`Precisa de ${custoXP} XP (você tem ${state.player.xp})`);
        return;
      }
      state.player.xp -= custoXP;
      sel2.nomeCustom = novo.slice(0, 24);
      Audio.colocar?.();
      state.ui.toast(`✏ Renomeado: "${sel2.nomeCustom}"`);
      state.ui.atualizarXP?.();
      state.ui.renderHotbar?.();
      document.getElementById('painel-bigorna').classList.add('hidden');
    };
  }
  document.getElementById('painel-bigorna').classList.remove('hidden');
  try { document.exitPointerLock?.(); } catch (_) {}
}

// === Painel da fornalha ===
function abrirPainelFornalha(x, y, z) {
  state.fornalhaAtivaCoords = { x, y, z };
  state.ui.renderFornalhaPainel();
  document.getElementById('painel-fornalha').classList.remove('hidden');
  try { document.exitPointerLock?.(); } catch (_) {}
}

// === Raycast bloco-alvo (DDA voxel) ===
function raycastBloco(world, origem, dir, alc) {
  const x0 = origem.x, y0 = origem.y, z0 = origem.z;
  const dx = dir.x, dy = dir.y, dz = dir.z;
  let x = Math.floor(x0), y = Math.floor(y0), z = Math.floor(z0);
  const stepX = dx > 0 ? 1 : -1;
  const stepY = dy > 0 ? 1 : -1;
  const stepZ = dz > 0 ? 1 : -1;
  const tDeltaX = Math.abs(1 / dx);
  const tDeltaY = Math.abs(1 / dy);
  const tDeltaZ = Math.abs(1 / dz);
  let tMaxX = (dx > 0 ? (Math.floor(x0) + 1 - x0) : (x0 - Math.floor(x0))) / Math.abs(dx);
  let tMaxY = (dy > 0 ? (Math.floor(y0) + 1 - y0) : (y0 - Math.floor(y0))) / Math.abs(dy);
  let tMaxZ = (dz > 0 ? (Math.floor(z0) + 1 - z0) : (z0 - Math.floor(z0))) / Math.abs(dz);
  let t = 0;
  let face = null;
  while (t < alc) {
    if (tMaxX < tMaxY && tMaxX < tMaxZ) { x += stepX; t = tMaxX; tMaxX += tDeltaX; face = 'x'; }
    else if (tMaxY < tMaxZ)              { y += stepY; t = tMaxY; tMaxY += tDeltaY; face = 'y'; }
    else                                 { z += stepZ; t = tMaxZ; tMaxZ += tDeltaZ; face = 'z'; }
    const b = world.get(x, y, z);
    if (b !== BLOCO.AR) {
      // Mira em qualquer bloco não-ar: sólidos OU shape custom (torch,
      // ladder, etc) — usuário precisa quebrar tocha mesmo sendo solido:false
      const info = BLOCO_INFO[b];
      if (info.solido || info.shape) {
        const adj = { x, y, z };
        if (face === 'x') adj.x -= stepX;
        else if (face === 'y') adj.y -= stepY;
        else                   adj.z -= stepZ;
        return { hit: { x, y, z, b }, adj };
      }
    }
  }
  return null;
}

// === init() — chamado quando user clica JOGAR ===
let ultimoT = 0;
function init() {
  state.ui = new UI();
  state.inv = new Inventario();
  // Detecta capacidade do dispositivo e aplica preset adequado.
  // Roda ANTES do renderer pra que pixelRatio + AA sejam aplicados na
  // construção. Resultado disponível em state.quality.
  const q = initQuality();
  console.log(`[quality] tier=${q.tier} (auto=${q.detectado}, mode=${q.modo})`,
              `score: mem=${q.info.mem}GB cpu=${q.info.cpu} mob=${q.info.isMobile} gpu=${q.info.gpuInfo}`);
  // Hotbar inicial
  state.inv.adicionar({ b: BLOCO.GRAMA, q: 64 });
  state.inv.adicionar({ b: BLOCO.TERRA, q: 64 });
  state.inv.adicionar({ b: BLOCO.PEDRA, q: 64 });
  state.inv.adicionar({ b: BLOCO.MADEIRA, q: 32 });
  state.inv.adicionar({ b: BLOCO.VIDRO, q: 32 });
  state.inv.adicionar({ b: BLOCO.NEVE, q: 32 });
  state.inv.adicionar({ b: BLOCO.LUZ, q: 4 });
  state.inv.adicionar({ b: BLOCO.TOCHA, q: 16 });
  state.inv.adicionar({ i: ITEM.PIC_MADEIRA, q: 1 });
  state.inv.adicionar({ i: ITEM.VARA_PESCA, q: 1 });
  state.inv.adicionar({ i: ITEM.BUSSOLA, q: 1 });
  state.inv.adicionar({ i: ITEM.BUCKET, q: 1 });
  state.inv.adicionar({ b: BLOCO.BIGORNA, q: 1 });
  state.inv.adicionar({ i: ITEM.FOGUETE, q: 8 });
  state.inv.adicionar({ b: BLOCO.BEACON, q: 1 });
  state.inv.adicionar({ i: ITEM.LUNETA, q: 1 });
  state.inv.adicionar({ i: ITEM.TRIDENTE, q: 1 });
  state.inv.adicionar({ b: BLOCO.ESTANTE, q: 8 });
  state.inv.adicionar({ b: BLOCO.LA_VERMELHA, q: 16 });
  state.inv.adicionar({ b: BLOCO.LA_AZUL, q: 16 });
  state.inv.adicionar({ b: BLOCO.LA_VERDE, q: 16 });
  state.inv.adicionar({ b: BLOCO.LA_AMARELA, q: 16 });
  state.inv.adicionar({ b: BLOCO.VIDRO_VERMELHO, q: 16 });
  state.inv.adicionar({ b: BLOCO.VIDRO_AZUL, q: 16 });
  state.inv.adicionar({ b: BLOCO.VIDRO_VERDE, q: 16 });
  state.inv.adicionar({ b: BLOCO.VIDRO_AMARELO, q: 16 });
  state.inv.adicionar({ b: BLOCO.QUARTZO, q: 32 });
  state.inv.adicionar({ b: BLOCO.QUARTZO_POLIDO, q: 32 });
  state.inv.adicionar({ b: BLOCO.COGUMELO_VERM, q: 8 });
  state.inv.adicionar({ b: BLOCO.COGUMELO_MARROM, q: 8 });
  state.inv.adicionar({ i: ITEM.TIGELA, q: 4 });
  state.inv.adicionar({ b: BLOCO.COBRE, q: 16 });
  state.inv.adicionar({ b: BLOCO.COBRE_GASTO, q: 8 });
  state.inv.adicionar({ b: BLOCO.COBRE_OXIDADO, q: 8 });
  state.inv.adicionar({ b: BLOCO.VELA, q: 4 });
  state.inv.adicionar({ b: BLOCO.VELA_VERMELHA, q: 4 });
  state.inv.adicionar({ b: BLOCO.VELA_AZUL, q: 4 });
  state.inv.adicionar({ i: ITEM.MACA, q: 5 });
  state.inv.adicionar({ i: ITEM.MACA_DOURADA, q: 1 });
  state.inv.adicionar({ b: BLOCO.MAGMA, q: 8 });
  state.inv.adicionar({ b: BLOCO.LANTERNA, q: 4 });
  state.inv.adicionar({ b: BLOCO.COLMEIA, q: 2 });
  state.inv.adicionar({ b: BLOCO.LILY_PAD, q: 8 });
  state.inv.adicionar({ i: ITEM.MEL, q: 4 });
  state.inv.adicionar({ b: BLOCO.BLOCO_MEL, q: 8 });
  state.inv.adicionar({ b: BLOCO.GRANITO, q: 32 });
  state.inv.adicionar({ b: BLOCO.DIORITO, q: 32 });
  state.inv.adicionar({ b: BLOCO.ANDESITO, q: 32 });
  state.inv.adicionar({ b: BLOCO.ARGILA, q: 16 });
  state.inv.adicionar({ b: BLOCO.BAMBU, q: 16 });
  state.inv.adicionar({ b: BLOCO.GRANITO_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.DIORITO_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.ANDESITO_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.PEDRA_LISA, q: 32 });
  state.inv.adicionar({ b: BLOCO.TIJOLO_MUSGO, q: 16 });
  state.inv.adicionar({ b: BLOCO.ARENITO, q: 32 });
  state.inv.adicionar({ b: BLOCO.ARENITO_LISO, q: 16 });
  state.inv.adicionar({ b: BLOCO.ARENITO_CORTADO, q: 16 });
  state.inv.adicionar({ b: BLOCO.TIJOLO_NETHER, q: 16 });
  state.inv.adicionar({ b: BLOCO.NETHER_CORTADO, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAVIMENTO, q: 32 });
  state.inv.adicionar({ b: BLOCO.GELO, q: 16 });
  state.inv.adicionar({ b: BLOCO.GELO_EMPACOTADO, q: 8 });
  state.inv.adicionar({ b: BLOCO.GELO_AZUL, q: 4 });
  state.inv.adicionar({ b: BLOCO.BASALTO, q: 16 });
  state.inv.adicionar({ b: BLOCO.BASALTO_POLIDO, q: 16 });
  state.inv.adicionar({ b: BLOCO.SOUL_SAND, q: 16 });
  state.inv.adicionar({ b: BLOCO.SOUL_SOIL, q: 16 });
  state.inv.adicionar({ b: BLOCO.CRIMSON_STEM, q: 16 });
  state.inv.adicionar({ b: BLOCO.WARPED_STEM, q: 16 });
  state.inv.adicionar({ b: BLOCO.BLACKSTONE, q: 16 });
  state.inv.adicionar({ b: BLOCO.DEEPSLATE, q: 16 });
  state.inv.adicionar({ b: BLOCO.AMETHYST, q: 8 });
  state.inv.adicionar({ b: BLOCO.CALCITE, q: 16 });
  state.inv.adicionar({ b: BLOCO.DEEPSLATE_PAV, q: 16 });
  state.inv.adicionar({ b: BLOCO.DEEPSLATE_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.BLACKSTONE_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.LAMA, q: 16 });
  state.inv.adicionar({ b: BLOCO.LAMA_COMPACTA, q: 16 });
  state.inv.adicionar({ b: BLOCO.TIJOLO_LAMA, q: 16 });
  state.inv.adicionar({ b: BLOCO.TUFF, q: 16 });
  state.inv.adicionar({ b: BLOCO.DRIPSTONE, q: 16 });
  state.inv.adicionar({ b: BLOCO.BLOCO_FERRO, q: 4 });
  state.inv.adicionar({ b: BLOCO.BLOCO_OURO, q: 4 });
  state.inv.adicionar({ b: BLOCO.BLOCO_DIAMANTE, q: 4 });
  state.inv.adicionar({ b: BLOCO.BLOCO_CARVAO, q: 8 });
  state.inv.adicionar({ b: BLOCO.BLOCO_LAPIS, q: 4 });
  state.inv.adicionar({ b: BLOCO.BLOCO_ESMERALDA, q: 4 });
  state.inv.adicionar({ b: BLOCO.BLOCO_REDSTONE, q: 4 });
  state.inv.adicionar({ b: BLOCO.PRISMARINE, q: 16 });
  state.inv.adicionar({ b: BLOCO.PRISMARINE_BRK, q: 16 });
  state.inv.adicionar({ b: BLOCO.SEA_LANTERN, q: 8 });
  state.inv.adicionar({ b: BLOCO.SLIME_BLOCK, q: 8 });
  state.inv.adicionar({ b: BLOCO.CRYING_OBSIDIAN, q: 4 });
  state.inv.adicionar({ b: BLOCO.NETHER_WART_R, q: 8 });
  state.inv.adicionar({ b: BLOCO.NETHER_WART_A, q: 8 });
  state.inv.adicionar({ b: BLOCO.SHROOMLIGHT, q: 4 });
  state.inv.adicionar({ b: BLOCO.END_BRICK, q: 16 });
  state.inv.adicionar({ b: BLOCO.PURPUR_BLOCK, q: 16 });
  state.inv.adicionar({ b: BLOCO.PURPUR_PILLAR, q: 16 });
  state.inv.adicionar({ b: BLOCO.CRIMSON_PLANKS, q: 16 });
  state.inv.adicionar({ b: BLOCO.WARPED_PLANKS, q: 16 });
  state.inv.adicionar({ b: BLOCO.SPONGE, q: 4 });
  state.inv.adicionar({ b: BLOCO.SPONGE_WET, q: 4 });
  state.inv.adicionar({ b: BLOCO.JACK_O_LANTERN, q: 4 });
  state.inv.adicionar({ b: BLOCO.TINTED_GLASS, q: 16 });
  state.inv.adicionar({ b: BLOCO.SNOW_BLOCK, q: 32 });
  state.inv.adicionar({ b: BLOCO.GLOW_LICHEN, q: 8 });
  state.inv.adicionar({ b: BLOCO.SPORE_BLOSSOM, q: 4 });
  state.inv.adicionar({ b: BLOCO.POWDER_SNOW, q: 8 });
  state.inv.adicionar({ b: BLOCO.SCULK, q: 8 });
  state.inv.adicionar({ b: BLOCO.SCULK_VEIN, q: 8 });
  state.inv.adicionar({ b: BLOCO.SCULK_SHRIEKER, q: 4 });
  state.inv.adicionar({ b: BLOCO.SCULK_SENSOR, q: 4 });
  state.inv.adicionar({ b: BLOCO.SCULK_CATALYST, q: 4 });
  state.inv.adicionar({ b: BLOCO.CAMA_AZUL, q: 1 });
  state.inv.adicionar({ b: BLOCO.CAMA_VERDE, q: 1 });
  state.inv.adicionar({ b: BLOCO.CAMA_AMARELA, q: 1 });
  state.inv.adicionar({ b: BLOCO.CAMA_ROXA, q: 1 });
  state.inv.adicionar({ b: BLOCO.PORTA_CRIMSON, q: 4 });
  state.inv.adicionar({ b: BLOCO.PORTA_WARPED, q: 4 });
  state.inv.adicionar({ b: BLOCO.PORTA_FERRO, q: 4 });
  state.inv.adicionar({ b: BLOCO.TRAPDOOR_M, q: 8 });
  state.inv.adicionar({ b: BLOCO.TRAPDOOR_F, q: 4 });
  state.inv.adicionar({ b: BLOCO.PORTAO_M, q: 4 });
  state.inv.adicionar({ b: BLOCO.PORTAO_C, q: 4 });
  state.inv.adicionar({ b: BLOCO.SIGN_MADEIRA, q: 8 });
  state.inv.adicionar({ b: BLOCO.ESCADA_PEDRA, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_MADEIRA, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_TIJOLO, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_PEDRA, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_TIJOLO, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_PAVIMENTO, q: 16 });
  state.inv.adicionar({ b: BLOCO.BTN_PEDRA, q: 4 });
  state.inv.adicionar({ b: BLOCO.BTN_MADEIRA, q: 4 });
  state.inv.adicionar({ b: BLOCO.BTN_OURO, q: 4 });
  state.inv.adicionar({ b: BLOCO.PLATE_PEDRA, q: 4 });
  state.inv.adicionar({ b: BLOCO.PLATE_MADEIRA, q: 4 });
  state.inv.adicionar({ b: BLOCO.ALAVANCA, q: 4 });
  state.inv.adicionar({ b: BLOCO.TNT, q: 4 });
  state.inv.adicionar({ b: BLOCO.FLOR_VERMELHA, q: 8 });
  state.inv.adicionar({ b: BLOCO.FLOR_AMARELA, q: 8 });
  state.inv.adicionar({ b: BLOCO.FLOR_AZUL, q: 8 });
  state.inv.adicionar({ b: BLOCO.FLOR_BRANCA, q: 8 });
  state.inv.adicionar({ b: BLOCO.FLOR_ROXA, q: 8 });
  state.inv.adicionar({ b: BLOCO.VASO_FLOR, q: 4 });
  state.inv.adicionar({ b: BLOCO.GRADE_FERRO, q: 16 });
  state.inv.adicionar({ b: BLOCO.HOPPER, q: 4 });
  state.inv.adicionar({ b: BLOCO.DISPENSER, q: 2 });
  state.inv.adicionar({ b: BLOCO.OBSERVER, q: 2 });
  state.inv.adicionar({ b: BLOCO.TOCHA_REDSTONE, q: 16 });
  state.inv.adicionar({ b: BLOCO.COGUMELO_VERM_P, q: 8 });
  state.inv.adicionar({ b: BLOCO.COGUMELO_MARROM_P, q: 8 });
  state.inv.adicionar({ b: BLOCO.CAVEIRA, q: 2 });
  state.inv.adicionar({ b: BLOCO.CRANIO_WITHER, q: 1 });
  state.inv.adicionar({ b: BLOCO.CONDUIT, q: 1 });
  state.inv.adicionar({ b: BLOCO.HEAD_CREEPER, q: 1 });
  state.inv.adicionar({ b: BLOCO.HEAD_ZUMBI, q: 1 });
  state.inv.adicionar({ b: BLOCO.HEAD_DRAGON, q: 1 });
  state.inv.adicionar({ b: BLOCO.SOUL_TORCH, q: 16 });
  state.inv.adicionar({ b: BLOCO.SOUL_LANTERN, q: 4 });
  state.inv.adicionar({ b: BLOCO.LAMPADA_RED, q: 8 });
  state.inv.adicionar({ b: BLOCO.BLAZE_BLOCK, q: 4 });
  state.inv.adicionar({ b: BLOCO.LA_LARANJA, q: 16 });
  state.inv.adicionar({ b: BLOCO.LA_ROSA, q: 16 });
  state.inv.adicionar({ b: BLOCO.LA_CIANO, q: 16 });
  state.inv.adicionar({ b: BLOCO.LA_MARROM, q: 16 });
  state.inv.adicionar({ b: BLOCO.LA_PRETA, q: 16 });
  state.inv.adicionar({ b: BLOCO.LA_CINZA, q: 16 });
  state.inv.adicionar({ b: BLOCO.CONCRETO_R, q: 16 });
  state.inv.adicionar({ b: BLOCO.CONCRETO_A, q: 16 });
  state.inv.adicionar({ b: BLOCO.CONCRETO_V, q: 16 });
  state.inv.adicionar({ b: BLOCO.CONCRETO_AM, q: 16 });
  state.inv.adicionar({ b: BLOCO.CONCRETO_BR, q: 16 });
  state.inv.adicionar({ b: BLOCO.CONCRETO_PR, q: 16 });
  state.inv.adicionar({ b: BLOCO.TERRACOTA_R, q: 16 });
  state.inv.adicionar({ b: BLOCO.TERRACOTA_A, q: 16 });
  state.inv.adicionar({ b: BLOCO.TERRACOTA_AM, q: 16 });
  state.inv.adicionar({ b: BLOCO.TERRACOTA_BR, q: 16 });
  state.inv.adicionar({ b: BLOCO.CONCRETO_LR, q: 16 });
  state.inv.adicionar({ b: BLOCO.CONCRETO_RS, q: 16 });
  state.inv.adicionar({ b: BLOCO.CONCRETO_CN, q: 16 });
  state.inv.adicionar({ b: BLOCO.CONCRETO_MR, q: 16 });
  state.inv.adicionar({ b: BLOCO.TERRACOTA_V, q: 16 });
  state.inv.adicionar({ b: BLOCO.TERRACOTA_RX, q: 16 });
  state.inv.adicionar({ b: BLOCO.TERRACOTA_LR, q: 16 });
  state.inv.adicionar({ b: BLOCO.TERRACOTA_PR, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAINEL_VIDRO_R, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAINEL_VIDRO_A, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAINEL_VIDRO_V, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAINEL_VIDRO_AM, q: 16 });
  state.inv.adicionar({ b: BLOCO.GLAZED_R, q: 8 });
  state.inv.adicionar({ b: BLOCO.GLAZED_A, q: 8 });
  state.inv.adicionar({ b: BLOCO.GLAZED_V, q: 8 });
  state.inv.adicionar({ b: BLOCO.GLAZED_AM, q: 8 });
  state.inv.adicionar({ b: BLOCO.GLAZED_LR, q: 8 });
  state.inv.adicionar({ b: BLOCO.GLAZED_RS, q: 8 });
  state.inv.adicionar({ b: BLOCO.GLAZED_BR, q: 8 });
  state.inv.adicionar({ b: BLOCO.GLAZED_PR, q: 8 });
  state.inv.adicionar({ b: BLOCO.SLAB_ARENITO, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_QUARTZO, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_DEEPSLATE, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_BLACKSTONE, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_ARENITO, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_QUARTZO, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_DEEPSLATE, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_BLACKSTONE, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_ANDESITO, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_BLACKSTONE, q: 16 });
  state.inv.adicionar({ b: BLOCO.BONE_BLOCK, q: 8 });
  state.inv.adicionar({ b: BLOCO.ROOTED_DIRT, q: 16 });
  state.inv.adicionar({ b: BLOCO.CHISELED_STONE, q: 8 });
  state.inv.adicionar({ b: BLOCO.CHISELED_QUARTZO, q: 8 });
  state.inv.adicionar({ b: BLOCO.CHISELED_DEEPSLATE, q: 8 });
  state.inv.adicionar({ b: BLOCO.CHISELED_BLACKSTONE, q: 8 });
  state.inv.adicionar({ b: BLOCO.CRIMSON_HYPHAE, q: 16 });
  state.inv.adicionar({ b: BLOCO.WARPED_HYPHAE, q: 16 });
  state.inv.adicionar({ b: BLOCO.FROGLIGHT_VERDE, q: 4 });
  state.inv.adicionar({ b: BLOCO.FROGLIGHT_ROXO, q: 4 });
  state.inv.adicionar({ b: BLOCO.MELANCIA, q: 8 });
  state.inv.adicionar({ b: BLOCO.MELANCIA_GLISTER, q: 4 });
  state.inv.adicionar({ b: BLOCO.GIRASSOL, q: 8 });
  state.inv.adicionar({ b: BLOCO.ABACAXI, q: 4 });
  state.inv.adicionar({ b: BLOCO.PAINEL_VIDRO_LR, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAINEL_VIDRO_RS, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAINEL_VIDRO_CN, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAINEL_VIDRO_BR, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAINEL_VIDRO_PR, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAINEL_VIDRO_CZ, q: 16 });
  state.inv.adicionar({ b: BLOCO.BAMBU_BLOCO, q: 8 });
  state.inv.adicionar({ b: BLOCO.CACTO_BLOCO, q: 8 });
  state.inv.adicionar({ b: BLOCO.ESCADA_COBRE, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_NETHER, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_PAVIMENTO, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_LAMA, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_ARENITO, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_LAMA, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_PAVIMENTO, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_CALCITE, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_GRANITO, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_DIORITO, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_ANDESITO, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_PRISMARINE, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_GRANITO, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_DIORITO, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_GRANITO, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_DIORITO, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_GRANITO_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_DIORITO_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_ANDESITO_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_PEDRA_LISA, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_ANDESITO_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_BLACKSTONE_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_ANDESITO_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_BLACKSTONE_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_END_BRICK, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_PURPUR, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_NETHER_BRICK, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_MUSGO, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_END_BRICK, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_NETHER_BRICK, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_END_BRICK, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_PURPUR, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_DEEPSLATE_PAV, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_DEEPSLATE_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_OBSIDIANA, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_BASALTO, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_DEEPSLATE_POL, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_BASALTO, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_DEEPSLATE_PAV, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_BASALTO, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_CRIMSON, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_WARPED, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_BAMBU, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_COBRE_GASTO, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_COBRE, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_COBRE_OXIDADO, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_CRIMSON, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_WARPED, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_CONCRETO_R, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_CONCRETO_A, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_CONCRETO_V, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_CONCRETO_BR, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_CONCRETO_R, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_CONCRETO_PR, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_CONCRETO_R, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_CONCRETO_A, q: 16 });
  state.inv.adicionar({ b: BLOCO.COBRE_CORTADO, q: 16 });
  state.inv.adicionar({ b: BLOCO.COBRE_GASTO_CORTADO, q: 16 });
  state.inv.adicionar({ b: BLOCO.COBRE_OXIDADO_CORTADO, q: 16 });
  state.inv.adicionar({ b: BLOCO.COBRE_LISO, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_PURPUR_PILLAR, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_PURPUR, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_PURPUR_PILLAR, q: 16 });
  state.inv.adicionar({ b: BLOCO.PURPUR_LIMPO, q: 16 });
  state.inv.adicionar({ b: BLOCO.SMITHING_TABLE, q: 1 });
  state.inv.adicionar({ b: BLOCO.BREWING_STAND, q: 1 });
  state.inv.adicionar({ b: BLOCO.BLAST_FURNACE, q: 1 });
  state.inv.adicionar({ b: BLOCO.SMOKER, q: 1 });
  state.inv.adicionar({ b: BLOCO.CARTOGRAPHY, q: 1 });
  state.inv.adicionar({ b: BLOCO.FLETCHING, q: 1 });
  state.inv.adicionar({ b: BLOCO.LOOM, q: 1 });
  state.inv.adicionar({ b: BLOCO.STONECUTTER, q: 1 });
  state.inv.adicionar({ b: BLOCO.TARGET_BLOCK, q: 4 });
  state.inv.adicionar({ b: BLOCO.ANCIENT_DEBRIS, q: 4 });
  state.inv.adicionar({ b: BLOCO.HONEYCOMB_BLOCK, q: 8 });
  state.inv.adicionar({ b: BLOCO.COMPOSTER, q: 1 });
  state.inv.adicionar({ b: BLOCO.LECTERN, q: 1 });
  state.inv.adicionar({ b: BLOCO.BARREL, q: 1 });
  state.inv.adicionar({ b: BLOCO.CAMPFIRE, q: 4 });
  state.inv.adicionar({ b: BLOCO.DRIED_KELP_BLOCK, q: 8 });
  state.inv.adicionar({ b: BLOCO.BOOKSHELF_CHISELED, q: 4 });
  state.inv.adicionar({ b: BLOCO.JUKEBOX, q: 1 });
  state.inv.adicionar({ b: BLOCO.END_ROD, q: 8 });
  state.inv.adicionar({ b: BLOCO.LIGHT_BLOCK, q: 4 });
  state.inv.adicionar({ b: BLOCO.DAYLIGHT_DETECTOR, q: 1 });
  state.inv.adicionar({ b: BLOCO.NOTE_BLOCK, q: 4 });
  state.inv.adicionar({ b: BLOCO.BELL, q: 1 });
  state.inv.adicionar({ b: BLOCO.SEA_PICKLE, q: 8 });
  state.inv.adicionar({ b: BLOCO.ENDER_CHEST, q: 1 });
  state.inv.adicionar({ b: BLOCO.SHULKER_BOX, q: 2 });
  state.inv.adicionar({ b: BLOCO.ANVIL_DAMAGED, q: 1 });
  state.inv.adicionar({ b: BLOCO.DECORATED_POT, q: 4 });
  state.inv.adicionar({ b: BLOCO.ESCADA_PRISMARINE_BRK, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_PRISMARINE, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_PRISMARINE_BRK, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_PRISMARINE, q: 16 });
  state.inv.adicionar({ b: BLOCO.SHULKER_R, q: 1 });
  state.inv.adicionar({ b: BLOCO.SHULKER_A, q: 1 });
  state.inv.adicionar({ b: BLOCO.SHULKER_V, q: 1 });
  state.inv.adicionar({ b: BLOCO.SHULKER_AM, q: 1 });
  state.inv.adicionar({ b: BLOCO.ESCADA_ARENITO_LISO, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_ARENITO_LISO, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_ARENITO_LISO, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_ARENITO_CORT, q: 16 });
  state.inv.adicionar({ b: BLOCO.SHULKER_BR, q: 1 });
  state.inv.adicionar({ b: BLOCO.SHULKER_PR, q: 1 });
  state.inv.adicionar({ b: BLOCO.SHULKER_LR, q: 1 });
  state.inv.adicionar({ b: BLOCO.SHULKER_RS, q: 1 });
  state.inv.adicionar({ b: BLOCO.ESCADA_TERRACOTA_R, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_TERRACOTA_R, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_TERRACOTA_R, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_TERRACOTA_A, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_NETHER, q: 16 });
  state.inv.adicionar({ b: BLOCO.PAREDE_NETHER, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_GLAZED_R, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_GLAZED_R, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_GLAZED_A, q: 16 });
  state.inv.adicionar({ b: BLOCO.SLAB_GLAZED_A, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_GLAZED_V, q: 16 });
  state.inv.adicionar({ b: BLOCO.ESCADA_GLAZED_AM, q: 16 });
  state.inv.adicionar({ i: ITEM.MACHADO_FERRO, q: 1 });
  state.inv.adicionar({ i: ITEM.MACHADO_DIAMANTE, q: 1 });
  state.inv.adicionar({ i: ITEM.PA_FERRO, q: 1 });
  state.inv.adicionar({ i: ITEM.PA_DIAMANTE, q: 1 });
  state.inv.adicionar({ i: ITEM.ENXADA_FERRO, q: 1 });
  state.inv.adicionar({ i: ITEM.TESOURA, q: 1 });
  state.inv.adicionar({ i: ITEM.SELA, q: 1 });
  state.inv.adicionar({ i: ITEM.CORDA, q: 2 });
  state.inv.adicionar({ i: ITEM.RELOGIO, q: 1 });
  state.inv.adicionar({ i: ITEM.ESPELHO, q: 1 });
  state.inv.adicionar({ i: ITEM.RECOVERY_COMPASS, q: 1 });
  state.inv.adicionar({ i: ITEM.BLAZE_POWDER, q: 4 });
  state.inv.adicionar({ i: ITEM.MAGMA_CREAM, q: 4 });
  state.inv.adicionar({ i: ITEM.GHAST_TEAR, q: 2 });
  state.inv.adicionar({ i: ITEM.FERMENTED_EYE, q: 4 });
  state.inv.adicionar({ i: ITEM.GLOWSTONE_DUST, q: 4 });
  state.inv.adicionar({ i: ITEM.GUNPOWDER, q: 4 });
  state.inv.adicionar({ i: ITEM.GARRAFA_VIDRO, q: 6 });
  state.inv.adicionar({ i: ITEM.BLAZE_ROD, q: 2 });
  state.inv.adicionar({ i: ITEM.NETHER_STAR, q: 1 });
  state.inv.adicionar({ i: ITEM.POTE_AGUA, q: 4 });
  state.inv.adicionar({ i: ITEM.POCAO_INVISIVEL, q: 1 });
  state.inv.adicionar({ i: ITEM.POCAO_NOITE, q: 1 });
  state.inv.adicionar({ i: ITEM.POCAO_FIRE_RES, q: 1 });
  state.inv.adicionar({ i: ITEM.MUSIC_DISC_13, q: 1 });
  state.inv.adicionar({ i: ITEM.MUSIC_DISC_CAT, q: 1 });
  state.inv.adicionar({ i: ITEM.COOKIE, q: 8 });
  state.inv.adicionar({ i: ITEM.PUMPKIN_PIE, q: 4 });
  state.inv.adicionar({ i: ITEM.BEETROOT, q: 8 });
  state.inv.adicionar({ i: ITEM.SOPA_BEETROOT, q: 2 });
  state.inv.adicionar({ i: ITEM.NETHERITE, q: 4 });
  state.inv.adicionar({ i: ITEM.ESP_DIAMANTE, q: 1 });
  state.inv.adicionar({ i: ITEM.PIC_NETHERITE, q: 1 });
  state.inv.adicionar({ i: ITEM.ESP_NETHERITE, q: 1 });
  state.inv.adicionar({ i: ITEM.MACHADO_NETHERITE, q: 1 });
  state.inv.adicionar({ i: ITEM.CAP_NETHERITE, q: 1 });
  state.inv.adicionar({ i: ITEM.PEI_NETHERITE, q: 1 });
  state.inv.adicionar({ i: ITEM.PER_NETHERITE, q: 1 });
  state.inv.adicionar({ i: ITEM.BOT_NETHERITE, q: 1 });
  state.inv.adicionar({ i: ITEM.REDSTONE, q: 32 });
  state.inv.adicionar({ i: ITEM.PRISMARINE_SHARD, q: 16 });
  state.inv.adicionar({ b: BLOCO.BANDEIRA_R, q: 4 });
  state.inv.adicionar({ b: BLOCO.BANDEIRA_A, q: 4 });
  state.inv.adicionar({ b: BLOCO.BANDEIRA_V, q: 4 });
  state.inv.adicionar({ b: BLOCO.BANDEIRA_AM, q: 4 });

  const canvas = document.getElementById('game');
  // Lê escolha do boot screen: window._bootChoice = { worldName, isNew, playerName }
  // Fallback (dev/auto-init): primeiro mundo do index ou novo "Mundo 1".
  const choice = window._bootChoice || {};
  const playerName = choice.playerName || Save.getPlayer().name || 'Aventureiro';
  Save.setPlayer(playerName);
  state.playerName = playerName;
  let worldName = choice.worldName;
  let isNewWorld = choice.isNew;
  if (!worldName) {
    const idx = Save.listarMundos();
    if (idx.length) { worldName = idx[0].name; isNewWorld = false; }
    else { worldName = 'Meu Mundo'; isNewWorld = true; }
  }
  state.worldName = worldName;
  // Seed: se mundo novo, gera; se existente, virá do save
  const seed = isNewWorld ? (Math.floor(Math.random() * 1e9)) : 42;
  state.renderer = new Renderer(canvas);
  state.world = new World(seed);
  state.player = new Player(state.renderer.camera);
  state.player.controls = new PointerLockControls(state.renderer.camera, document.body);
  state.mobMgr = new MobManager(state.renderer.scene);
  state.particulas = new Particulas(state.renderer.scene);

  // Tenta carregar save (do mundo selecionado)
  const save = isNewWorld ? null : Save.carregarPorNome(worldName);
  if (save) {
    state.world.seed = save.seed;
    state.player.pos.set(save.p.x, save.p.y, save.p.z);
    state.player.spawn.copy(state.player.pos);
    state.player.hp = save.hp ?? 20;
    state.player.fome = save.fome ?? 20;
    state.player.modo = save.modo ?? 'creative';
    state.tempoDia = save.td ?? 0.25;
    state.inv.slots.fill(null);
    state.inv.slotSel = save.slot ?? 0;
    if (save.inv) {
      for (const s of save.inv) {
        if (s.sx === undefined) continue;
        state.inv.slots[s.sx] = { b: s.b, i: s.i, q: s.q, encant: s.encant, nomeCustom: s.nomeCustom };
      }
    }
    state.inv.armadura = { cabeca: null, torso: null, pernas: null, botas: null };
    if (save.arm) {
      for (const peca of Object.keys(save.arm)) {
        if (state.inv.armadura[peca] !== undefined) {
          state.inv.armadura[peca] = { ...save.arm[peca] };
        }
      }
    }
    state.player.xp = save.xp || 0;
    state.player.nivel = save.nivel || 0;
    if (save.baus) {
      for (const { k, slots } of save.baus) state.world.bauTesouros.set(k, slots);
    }
    if (save.forn) {
      for (const { k, input, combustivel, output } of save.forn) {
        state.world.fornalhaEstados.set(k, {
          input, combustivel, output, progresso: 0, ativa: false,
        });
      }
    }
    if (save.chunks) {
      for (const sc of save.chunks) {
        const c = state.world.getChunk(sc.cx, sc.cz);
        const arr = atob(sc.b);
        for (let i = 0; i < arr.length && i < c.blocks.length; i++) c.blocks[i] = arr.charCodeAt(i);
        c.modificado = true; c.dirty = true; c.luzDirty = true;
      }
    }
    state.ui.toast(`Mundo "${worldName}" carregado`);
  } else {
    const h = state.world.alturaTerreno(8, 8);
    state.player.pos.set(8.5, h + 2, 8.5);
    state.player.spawn.copy(state.player.pos);
    state.ui.toast(`Bem-vindo, ${playerName}! Mundo "${worldName}"`);
    Save.registrarMundo(worldName, seed, 'survival');
  }
  // Atualiza HUD com identidade
  const hudPid = document.getElementById('f3-player');
  if (hudPid) hudPid.textContent = `Player: ${playerName}  ·  Mundo: ${worldName}`;
  // Safe-spawn: se posição inicial colide com bloco (dungeon, caverna,
  // chunk não meshado), sobe até liberar (limite 40 blocos).
  let safety = 40;
  while (safety-- > 0 && state.player.colisaoBlocos(state.world, state.player.pos.x, state.player.pos.y, state.player.pos.z)) {
    state.player.pos.y += 1;
  }
  state.player.spawnY = state.player.pos.y;

  setActions({ atacarMob, soltarArco, comerSlot, abrirPainelBau, abrirPainelFornalha, dormir });
  setupInput();
  setupTouchControls();
  state.ui.atualizar();
  // Inicializa visual do botão de modo baseado no estado carregado
  // (alternar duas vezes restaura ao original mas dispara a estilização)
  const _btn = document.getElementById('btn-modo');
  if (_btn) {
    const eh = state.player.modo === 'creative';
    _btn.classList.toggle('modo-creative', eh);
    _btn.classList.toggle('modo-survival', !eh);
    _btn.textContent = eh ? '🦅' : '⚔';
    let lbl = document.getElementById('btn-modo-label');
    if (!lbl) {
      lbl = document.createElement('div');
      lbl.id = 'btn-modo-label';
      _btn.parentElement.appendChild(lbl);
    }
    lbl.textContent = eh ? 'CRIATIVO' : 'SOBREVIV.';
    lbl.style.color = eh ? '#FFD700' : '#FF5252';
  }
  Audio.musicaIniciar();
  Multiplayer.iniciar();

  // Autosave a cada 30s
  setInterval(() => Save.salvar(), 30_000);

  // Resize: dispara em mudança de janela E em orientação (mobile rotation).
  // O orientationchange precisa de delay porque o viewport ainda está se
  // ajustando quando o evento dispara — sem isso, o canvas fica com a
  // dimensão antiga.
  const resizeAll = () => {
    state.renderer.resize();
    // Reaplica fullscreen em mobile se saímos por algum motivo (gestos
    // do iOS/Android tendem a desativar)
    const isMobile = matchMedia('(pointer: coarse)').matches;
    if (isMobile && !document.fullscreenElement) {
      document.documentElement.requestFullscreen?.().catch(() => {});
    }
  };
  window.addEventListener('resize', resizeAll);
  window.addEventListener('orientationchange', () => {
    // Espera 2 ticks: 1 pra browser ajustar viewport, outro pra renderer
    setTimeout(resizeAll, 100);
    setTimeout(resizeAll, 400);
    // Re-tenta orientation lock landscape
    if (screen.orientation?.lock) {
      screen.orientation.lock('landscape').catch(() => {});
    }
  });
  ultimoT = performance.now();
  requestAnimationFrame(loop);
}

// === Loop principal ===
function loop(now) {
  const dt = Math.min(0.06, (now - ultimoT) / 1000);
  ultimoT = now;

  // Frame watchdog: se último frame foi pesado (> 50ms = abaixo de 20fps)
  // marca _heavyFrame=true pra pular trabalho não-essencial neste frame
  // (weather snow accumulate, ambient particles, breeding scan).
  state._heavyFrame = dt > 0.05;

  // FPS counter + adaptive quality monitor
  state.fpsAcc++;
  state.fpsTimer += dt;
  if (state.fpsTimer >= 1) {
    document.getElementById('fps').textContent = `${state.fpsAcc} FPS [${state.quality?.tier || '?'}]`;
    state.fpsAcc = 0; state.fpsTimer = 0;
    // Memory monitor (Chrome): warn se ultrapassar 80% do limite
    _checkMemory();
    // Stat de tempo jogado (1 sec por tick)
    if (!state.player?.morto) Save.incrementarStat('secondsPlayed');
    // Distância caminhada acumulada no último segundo (em blocos)
    if (state._distAcc) {
      Save.incrementarStat('distanceWalked', Math.round(state._distAcc));
      state._distAcc = 0;
    }
  }
  qualityTickFps(dt);

  const algumPainelAberto = document.querySelector('.painel:not(.hidden)') !== null;
  const pausado = !document.getElementById('pause-menu').classList.contains('hidden');
  let ray = null;
  if (algumPainelAberto || pausado || state.player.morto) {
    // Pausa lógica
  } else {
    // Acumula distância caminhada (apenas horizontal, ignora altura)
    if (state._lastPos) {
      const dxd = state.player.pos.x - state._lastPos.x;
      const dzd = state.player.pos.z - state._lastPos.z;
      const distFrame = Math.hypot(dxd, dzd);
      if (distFrame < 1.0) state._distAcc = (state._distAcc || 0) + distFrame;
    }
    state._lastPos = { x: state.player.pos.x, z: state.player.pos.z };
    state.player.atualizar(dt, state.world);
    // Portal: pisar dentro 1.5s → trocar dimensão
    const blockEm = state.world.get(
      Math.floor(state.player.pos.x),
      Math.floor(state.player.pos.y),
      Math.floor(state.player.pos.z)
    );
    const ehPortal = blockEm === BLOCO.PORTAL_NETHER || blockEm === BLOCO.PORTAL_END;
    if (ehPortal) {
      state._portalAcc = (state._portalAcc || 0) + dt;
      if (state._portalAcc >= 1.5) {
        state._portalAcc = 0;
        // Decide pra onde vai: nether → overworld; overworld via portal_nether → nether;
        // overworld via portal_end → end; end → overworld;
        let novaDim;
        if (state.world.dimensao === 'nether') novaDim = 'overworld';
        else if (state.world.dimensao === 'end') novaDim = 'overworld';
        else if (blockEm === BLOCO.PORTAL_NETHER) novaDim = 'nether';
        else if (blockEm === BLOCO.PORTAL_END) novaDim = 'end';
        else novaDim = 'overworld';
        state.world.trocarDimensao(novaDim);
        // Libera meshes de TODAS as dimensões
        for (const m of [state.world._chunksOverworld, state.world._chunksNether, state.world._chunksEnd]) {
          for (const c of m.values()) if (c.mesh) state.renderer.liberarChunkMesh(c);
        }
        for (const c of state.world.chunks.values()) c.dirty = true;
        for (const m of [...state.mobMgr.mobs]) state.mobMgr.remover(m);
        // Reposição: End spawna em y=34 (acima da plataforma central);
        // Nether y=32; Overworld y=32 (player escolhe local seguro depois)
        state.player.pos.set(0.5, novaDim === 'end' ? 34 : 32, 0.5);
        state.player.vel.set(0, 0, 0);
        const msgs = {
          nether: '🔥 Bem-vindo ao Nether!',
          end: '🌌 Bem-vindo ao End!',
          overworld: '🌍 De volta ao Overworld',
        };
        state.ui.toast(msgs[novaDim] || '✨ Dimensão trocada');
        if (novaDim === 'nether') Achievements.unlock('PORTAL_NETHER');
        if (novaDim === 'end') Achievements.unlock('PORTAL_END');
      }
    } else {
      state._portalAcc = 0;
    }
    // Tick do charge do arco
    if (state.player.bowCharging) state.player.bowCharge = (state.player.bowCharge || 0) + dt;
    // === Oxidação do cobre (tick lento — 60s) ===
    // A cada minuto, varre 12×12 ao redor do player e cada bloco de cobre
    // tem ~25% chance de avançar de estado (paridade Minecraft real).
    state._oxAcc = (state._oxAcc || 0) + dt;
    if (state._oxAcc >= 60 && !state._heavyFrame) {
      state._oxAcc = 0;
      const px = Math.floor(state.player.pos.x), pz = Math.floor(state.player.pos.z);
      for (let dx = -8; dx <= 8; dx++) for (let dz = -8; dz <= 8; dz++) {
        for (let dy = -2; dy <= 6; dy++) {
          const x = px + dx, y = Math.floor(state.player.pos.y) + dy, z = pz + dz;
          const b = state.world.get(x, y, z);
          if (b === BLOCO.COBRE && Math.random() < 0.25) {
            state.world.set(x, y, z, BLOCO.COBRE_GASTO);
          } else if (b === BLOCO.COBRE_GASTO && Math.random() < 0.25) {
            state.world.set(x, y, z, BLOCO.COBRE_OXIDADO);
          }
        }
      }
    }
    // === Fumaça acima de fornalhas ativas (visual de "queimando") ===
    state._fornAcc = (state._fornAcc || 0) + dt;
    if (state._fornAcc >= 0.6 && !state._heavyFrame) {
      state._fornAcc = 0;
      const px = state.player.pos.x, pz = state.player.pos.z;
      for (const [key, f] of state.world.fornalhaEstados) {
        if (!f.ativa) continue;
        const [fx, fy, fz] = key.split(',').map(Number);
        const dx = fx - px, dz = fz - pz;
        if (dx*dx + dz*dz > 24*24) continue; // só visíveis
        if (state.particulas?.spawnSmoke) {
          state.particulas.spawnSmoke(fx + 0.5, fy + 1.05, fz + 0.5);
        }
      }
    }
    // === Beacon: aplica buff se player a ≤16 blocos de algum beacon com
    // pirâmide debaixo. Rodar 1×/s pra economia. Pirâmide = 3×3 (Y-1) de
    // blocos preciosos (FERRO/OURO/DIAMANTE/ESMERALDA/EMERALDA proxy).
    state._beaconAcc = (state._beaconAcc || 0) + dt;
    if (state._beaconAcc >= 1.0) {
      state._beaconAcc = 0;
      if (state.beacons && state.beacons.size) {
        const px = state.player.pos.x, py = state.player.pos.y, pz = state.player.pos.z;
        for (const k of state.beacons) {
          const [sx, y, sz] = k.split(',').map(Number);
          const dx = sx - px, dy = y - py, dz = sz - pz;
          if (dx*dx + dy*dy + dz*dz > 16 * 16) continue;
          if (state.world.get(sx, y, sz) !== BLOCO.BEACON) {
            state.beacons.delete(k);
            state.renderer.removerBeaconBeam(sx, y, sz);
            continue;
          }
          let preciosos = 0;
          for (let ddx = -1; ddx <= 1; ddx++) for (let ddz = -1; ddz <= 1; ddz++) {
            const b = state.world.get(sx + ddx, y - 1, sz + ddz);
            if (b === BLOCO.FERRO || b === BLOCO.OURO || b === BLOCO.DIAMANTE) preciosos++;
          }
          if (preciosos >= 9) {
            state.player.efeitos = state.player.efeitos || {};
            state.player.efeitos.speed = Date.now() + 2200;
            state.player.efeitos.haste = Date.now() + 2200;
          } else if (preciosos >= 4) {
            state.player.efeitos = state.player.efeitos || {};
            state.player.efeitos.speed = Date.now() + 2200;
          }
        }
      }
    }
    // Tick de mudas → cresce em árvore após ~15-25s (skip em heavy frame)
    if (!state._heavyFrame) {
      const cresc = state.world.atualizarMudas();
      if (cresc > 0) state.ui.toast?.(`🌱 ${cresc > 1 ? cresc + ' mudas cresceram' : 'Muda cresceu em árvore'}`);
      // Tick de crops: maduros viram drops automaticamente no chão
      const maduros = state.world.atualizarCrops();
      for (const c of maduros) {
        const drops = state.world.colherCrop(c.x, c.y, c.z);
        if (drops) {
          for (const d of drops) spawnItemDrop(d, c.x + 0.5, c.y + 0.4, c.z + 0.5);
        }
      }
      if (maduros.length > 0) state.ui.toast?.(`🌾 ${maduros.length} planta(s) madura(s)!`);
      // Spread de grama: 1×/5s, ambient
      state._gramaAcc = (state._gramaAcc || 0) + dt;
      if (state._gramaAcc >= 5) {
        state._gramaAcc = 0;
        state.world.spreadGrama(state.player.pos.x, state.player.pos.z, 6);
      }
    }
    state.tempoDia = (state.tempoDia + dt / DIA_SEGUNDOS) % 1;
    const sun = Math.max(0.05, 0.5 + 0.5 * Math.sin(state.tempoDia * Math.PI * 2 - Math.PI / 2));
    state.mobMgr.atualizar(dt, state.world, state.player, sun);
    state.particulas.atualizar(dt);
    Multiplayer.atualizar(dt);

    const dirCamera = state.renderer.camera.getWorldDirection(_tmpVecAux);
    ray = raycastBloco(state.world, state.renderer.camera.position, dirCamera, ALCANCE_BLOCO);

    // Quebra contínua
    let progressoVisual = 0;
    if (state.player.holdE && ray) {
      const t = ray.hit;
      if (!state.player.alvoQuebra ||
          state.player.alvoQuebra.x !== t.x || state.player.alvoQuebra.y !== t.y || state.player.alvoQuebra.z !== t.z) {
        state.player.alvoQuebra = { x: t.x, y: t.y, z: t.z };
        state.player.progressoQuebra = 0;
      }
      const tier = state.inv.melhorPicareta();
      const sel = state.inv.itemSelecionado();
      const ferr = sel && sel.i !== undefined && ITEM_INFO[sel.i]?.ferramenta;
      let mult = (t.b === BLOCO.BEDROCK) ? 0 : Drops.velocidadeQuebra(t.b, tier, ferr);
      // Efficiency: +20%/+40%/+60% velocidade por nível
      if (sel?.encant?.efficiency) mult *= 1 + sel.encant.efficiency * 0.20;
      // Haste do beacon: +40% velocidade de quebra enquanto efeito ativo
      if (state.player.efeitos?.haste && Date.now() < state.player.efeitos.haste) mult *= 1.4;
      else if (state.player.efeitos?.haste) delete state.player.efeitos.haste;
      state.player.progressoQuebra += dt / TEMPO_QUEBRA_BASE * mult;
      progressoVisual = state.player.progressoQuebra;
      if (state.player.progressoQuebra >= 1) {
        state.player.progressoQuebra = 0;
        // Se bloco foi colocado pelo player, força drop do bloco original
        // (sem requisito de tier) — UX: jogador não perde o que colocou.
        const foiPlayer = state.world.foiColocadoPeloPlayer(t.x, t.y, t.z);
        const drops = foiPlayer
          ? [{ b: t.b, q: 1 }]
          : Drops.dropDeBloco(t.b, tier);
        if (foiPlayer) state.world.desmarcarColocadoPeloPlayer(t.x, t.y, t.z);
        // Fortune: ores ganham +1 drop por nível com chance 33%/66%/100%
        if (sel?.encant?.fortune && !foiPlayer &&
            (t.b === BLOCO.CARVAO || t.b === BLOCO.DIAMANTE)) {
          const chance = sel.encant.fortune * 0.33;
          if (Math.random() < chance) {
            const extra = [...drops];
            for (const d of extra) drops.push({ ...d, q: 1 });
          }
        }
        if (state.player.modo === 'creative') {
          for (const d of drops) state.inv.adicionar(d);
        } else {
          for (const d of drops) spawnItemDrop(d, t.x, t.y, t.z);
        }
        state.particulas.spawnQuebra(t.x, t.y, t.z, t.b);
        // Beacon quebrado: remove do tracking + mesh do beam
        if (t.b === BLOCO.BEACON) {
          state.beacons?.delete(World.keyXYZ(t.x, t.y, t.z));
          state.renderer.removerBeaconBeam(t.x, t.y, t.z);
        }
        if (t.b === BLOCO.BAU) {
          const bau = state.world.bauTesouros.get(World.keyXYZ(t.x, t.y, t.z));
          if (bau) for (const it of bau) if (it) {
            if (state.player.modo === 'creative') state.inv.adicionar({ ...it });
            else spawnItemDrop({ ...it }, t.x, t.y, t.z);
          }
          state.world.removerEstadoBloco(t.x, t.y, t.z);
        } else if (t.b === BLOCO.FORNALHA) {
          const f = state.world.fornalhaEstados.get(World.keyXYZ(t.x, t.y, t.z));
          if (f) {
            for (const it of [f.input, f.combustivel, f.output]) {
              if (it) {
                if (state.player.modo === 'creative') state.inv.adicionar({ ...it });
                else spawnItemDrop({ ...it }, t.x, t.y, t.z);
              }
            }
          }
          state.world.removerEstadoBloco(t.x, t.y, t.z);
        }
        const blocoQuebrado = t.b;
        // Hooks de achievement (block mining)
        if (blocoQuebrado === BLOCO.MADEIRA) Achievements.unlock('PRIMEIRA_MADEIRA');
        else if (blocoQuebrado === BLOCO.PEDRA) Achievements.unlock('PRIMEIRA_PEDRA');
        else if (blocoQuebrado === BLOCO.DIAMANTE) Achievements.unlock('PRIMEIRO_DIAMANTE');
        Save.incrementarStat('blocksBroken');
        state.world.set(t.x, t.y, t.z, BLOCO.AR);
        // Cascateia areia que estava em cima do bloco removido (gravity)
        // + tochas/velas sem apoio caem (paridade MC) — dropam o item.
        const cairam = state.world.aplicarGravidadeBlocos(t.x, t.y, t.z);
        if (cairam && cairam.length) {
          for (const c of cairam) {
            if (state.player.modo === 'creative') state.inv.adicionar({ b: c.b, q: 1 });
            else spawnItemDrop({ b: c.b, q: 1 }, c.x + 0.5, c.y + 0.4, c.z + 0.5);
          }
        }
        // Se foi madeira, agenda decay das folhas órfãs em volta
        if (blocoQuebrado === BLOCO.MADEIRA) {
          state.world.iniciarDecayFolhas(t.x, t.y, t.z);
        }
        Audio.quebrar();
        progressoVisual = 0;
        const xpGanho = (t.b === BLOCO.CARVAO) ? 1 :
                       (t.b === BLOCO.FERRO) ? 2 :
                       (t.b === BLOCO.OURO) ? 3 :
                       (t.b === BLOCO.DIAMANTE) ? 7 : 0;
        if (xpGanho > 0) spawnXPOrb(xpGanho, t.x, t.y, t.z);
      }
    } else if (!state.player.holdE) {
      state.player.progressoQuebra = 0;
      state.player.alvoQuebra = null;
    }

    // Click direito: interação ou colocar bloco
    if (state.player.cliqueD) {
      state.player.cliqueD = false;
      // Vara de Pesca: cast/reel — funciona em qualquer contexto.
      const selVara = state.inv.itemSelecionado();
      if (selVara?.i === ITEM.VARA_PESCA) {
        const dirCam = state.renderer.camera.getWorldDirection(_tmpVecAux).clone();
        castFishingLine(state.renderer.camera.position, dirCam);
        return;
      }
      // Tridente: arremessa projétil que volta — consome 1 do inv (volta ao bater/voltar)
      const selTri = state.inv.itemSelecionado();
      if (selTri?.i === ITEM.TRIDENTE) {
        const dirCam = state.renderer.camera.getWorldDirection(_tmpVecAux).clone();
        lancarTridente(state.renderer.camera.position, dirCam);
        state.inv.consumirAtual();
        state.ui.toast('🔱 Tridente arremessado!');
        return;
      }
      // Luneta: toggle zoom (FOV reduz pra 18° → ampliação ~4×)
      const selLun = state.inv.itemSelecionado();
      if (selLun?.i === ITEM.LUNETA) {
        state._zoomLuneta = !state._zoomLuneta;
        state.ui.toast(state._zoomLuneta ? '🔭 Zoom ativado' : '🔭 Zoom desativado');
        return;
      }
      // Foguete: lança projétil que sobe e explode — consome 1 unidade
      const selFog = state.inv.itemSelecionado();
      if (selFog?.i === ITEM.FOGUETE) {
        const dirCam = state.renderer.camera.getWorldDirection(_tmpVecAux).clone();
        lancarFoguete(state.renderer.camera.position, dirCam);
        state.inv.consumirAtual();
        state.ui.toast('🎆 Foguete!');
        return;
      }
      // Pérola do Ender: teleporta player ~6 blocos na direção da câmera
      // (paridade Minecraft real). Funciona em qualquer contexto.
      const selPearl = state.inv.itemSelecionado();
      if (selPearl?.i === ITEM.ENDER_PEARL) {
        const dirP = state.renderer.camera.getWorldDirection(_tmpVecAux);
        const dist = 6;
        const novoX = state.player.pos.x + dirP.x * dist;
        const novoY = state.player.pos.y + dirP.y * dist;
        const novoZ = state.player.pos.z + dirP.z * dist;
        // Verifica se destino é seguro (não dentro de bloco sólido)
        if (!state.player.colisaoBlocos(state.world, novoX, novoY, novoZ)) {
          state.player.pos.set(novoX, novoY, novoZ);
          state.player.vel.set(0, 0, 0);
          state.inv.consumirAtual();
          state.player.aplicarDano(2, 'teleport'); // self-damage MC
          Audio.endermanTeleport?.();
          state.ui.toast('🔮 Teleportado!');
        } else {
          state.ui.toast('⚠ Destino bloqueado');
        }
        return;
      }
      // Antes do raycast de bloco, tenta interação com mob mais próximo
      const mAlvo = state.mobMgr.maisProximo(state.player, ALCANCE_BLOCO);
      const sel = state.inv.itemSelecionado();
      // Villager OU Wandering Trader: abre painel de trades
      if (mAlvo && (mAlvo.tipo === 'villager' || mAlvo.tipo === 'wandering_trader')) {
        abrirTradeVillager(mAlvo);
        return;
      }
      // Ordenhar vaca: BUCKET vazio + vaca → BUCKET_LEITE
      if (mAlvo && sel?.i === ITEM.BUCKET && mAlvo.tipo === 'vaca') {
        state.inv.consumirAtual();
        state.inv.adicionar({ i: ITEM.BUCKET_LEITE, q: 1 });
        Audio.colocar?.();
        state.ui.toast('🥛 Balde de leite!');
        return;
      }
      // Mooshroom: TIGELA vazia + mooshroom → SOPA_COGUMELO direto
      if (mAlvo && sel?.i === ITEM.TIGELA && mAlvo.tipo === 'mooshroom') {
        state.inv.consumirAtual();
        state.inv.adicionar({ i: ITEM.SOPA_COGUMELO, q: 1 });
        Audio.colocar?.();
        state.ui.toast('🍲 Sopa de cogumelo direto da Mooshroom!');
        return;
      }
      // Cat: alimenta com peixe → fica domesticado e segue
      if (mAlvo && sel?.i === ITEM.PEIXE && mAlvo.tipo === 'cat' && !mAlvo.domesticado) {
        mAlvo.domesticado = true;
        state.inv.consumirAtual();
        state.ui.toast('Gato domesticado! 🐈');
        return;
      }
      if (mAlvo && sel?.i === ITEM.OSSO && mAlvo.tipo === 'lobo' && !mAlvo.domesticado) {
        mAlvo.domesticado = true;
        state.inv.consumirAtual();
        Audio.lobo();
        state.ui.toast('Lobo domesticado! 🐺');
        Achievements.unlock('DOMESTICAR_LOBO');
        return;
      }
      // Reprodução: alimentar mob passivo com pranchas → love mode
      if (mAlvo && sel?.i === ITEM.PRANCHAS &&
          ['vaca','porco','ovelha','galinha'].includes(mAlvo.tipo) &&
          mAlvo.loveTimer <= 0 && mAlvo.breedCooldown <= 0 && !mAlvo._cria) {
        mAlvo.loveTimer = 30;
        state.inv.consumirAtual();
        Audio.eatCrunch();
        state.ui.toast(`💕 ${mAlvo.tipo} foi alimentada (love mode 30s)`);
        return;
      }
      if (mAlvo && mAlvo.tipo === 'ovelha' && (!mAlvo._tosquiada || mAlvo._tosquiada < Date.now())) {
        // Tosquiar ovelha (sem tesoura — simplificado): pega 1-2 lã, ovelha fica "pelada" por 30s
        const q = 1 + (Math.random() < 0.5 ? 1 : 0);
        spawnItemDrop({ b: BLOCO.LA, q }, mAlvo.x, mAlvo.y + 0.5, mAlvo.z);
        mAlvo._tosquiada = Date.now() + 30000;
        Audio.ovelha();
        state.ui.toast(`Ovelha tosquiada (+${q} lã)`);
        return;
      }
      if (ray) {
        const t = ray.hit;
        const blocoAlvo = t.b;
        if (blocoAlvo === BLOCO.BAU) {
          abrirPainelBau(t.x, t.y, t.z);
          if (t.y < 28) Achievements.unlock('TANTO_FAZ');
        }
        else if (blocoAlvo === BLOCO.MESA_ENCANT) {
          encantarItemAtual();
        }
        else if (blocoAlvo === BLOCO.DOOR_MADEIRA) {
          state.world.set(t.x, t.y, t.z, BLOCO.DOOR_ABERTA);
          Audio.colocar?.();
        }
        // Acende portal: flint+obsidiana → PORTAL_NETHER
        else if (blocoAlvo === BLOCO.OBSIDIANA && state.inv.itemSelecionado()?.i === ITEM.FLINT_STEEL) {
          state.world.set(t.x, t.y, t.z, BLOCO.PORTAL_NETHER);
          Audio.fornalhaLit?.();
          state.ui.toast('🔥 Portal aceso! Pise dentro pra viajar.');
        }
        // Talhar pumpkin: flint em PUMPKIN → vira CARVED_PUMPKIN
        else if (blocoAlvo === BLOCO.PUMPKIN && state.inv.itemSelecionado()?.i === ITEM.FLINT_STEEL) {
          state.world.set(t.x, t.y, t.z, BLOCO.CARVED_PUMPKIN);
          Audio.colocar?.();
          state.ui.toast('🎃 Abóbora talhada!');
        }
        // Ativa portal End: eye_of_ender em qualquer END_STONE → vira portal
        else if (blocoAlvo === BLOCO.END_STONE && state.inv.itemSelecionado()?.i === ITEM.EYE_OF_ENDER) {
          state.world.set(t.x, t.y, t.z, BLOCO.PORTAL_END);
          state.inv.consumirAtual();
          Audio.endermanTeleport?.();
          state.ui.toast('👁 Portal do End ativado! Pise pra retornar.');
        }
        // Cria portal End no overworld: eye em qualquer ground → spawn 4 portals
        else if (state.inv.itemSelecionado()?.i === ITEM.EYE_OF_ENDER && blocoAlvo !== BLOCO.AR) {
          const a = ray.adj;
          // Spawn 1 bloco PORTAL_END no chão acima do bloco clicado
          state.world.set(a.x, a.y, a.z, BLOCO.PORTAL_END);
          state.inv.consumirAtual();
          Audio.endermanTeleport?.();
          state.ui.toast('👁 Portal do End criado! Pise dentro.');
        }
        else if (blocoAlvo === BLOCO.DOOR_ABERTA) {
          state.world.set(t.x, t.y, t.z, BLOCO.DOOR_MADEIRA);
          Audio.colocar?.();
        }
        else if (blocoAlvo === BLOCO.FORNALHA) abrirPainelFornalha(t.x, t.y, t.z);
        else if (blocoAlvo === BLOCO.BIGORNA) abrirPainelBigorna();
        else if (blocoAlvo === BLOCO.CAMA) dormir();
        else if (blocoAlvo === BLOCO.BOLO) {
          // Comer bolo: restaura fome (4) + 1 hp em survival, consome bloco.
          if (state.player.fome >= state.player.fomeMax && state.player.modo === 'survival') {
            state.ui.toast('Você está cheio');
          } else {
            state.player.fome = clamp(state.player.fome + 4, 0, state.player.fomeMax);
            state.player.saturation = Math.min(20, (state.player.saturation || 0) + 2);
            if (state.player.modo === 'survival') {
              state.player.hp = Math.min(state.player.hpMax, state.player.hp + 1);
            }
            state.world.set(t.x, t.y, t.z, BLOCO.AR);
            Audio.eatCrunch();
            state.ui.toast('🍰 Bolo delicioso! (+4 fome)');
          }
        }
        else if (blocoAlvo === BLOCO.WORKBENCH) {
          const el = document.getElementById('painel-craft');
          if (el.classList.contains('hidden')) {
            state.ui.renderCraft(state.ui.workbenchPerto());
            el.classList.remove('hidden');
            document.exitPointerLock?.();
          }
        } else {
          const sel = state.inv.itemSelecionado();
          // === Baldes (BUCKET) ===
          // Vazio em água/lava: pega o fluido. Cheio: deposita o fluido.
          if (sel && sel.i === ITEM.BUCKET && (t.b === BLOCO.AGUA || t.b === BLOCO.LAVA)) {
            const fluido = t.b;
            state.world.set(t.x, t.y, t.z, BLOCO.AR);
            state.inv.consumirAtual();
            state.inv.adicionar({ i: fluido === BLOCO.AGUA ? ITEM.BUCKET_AGUA : ITEM.BUCKET_LAVA, q: 1 });
            Audio.splash();
            state.ui.toast(`Balde cheio de ${fluido === BLOCO.AGUA ? 'água' : 'lava'}`);
          } else if (sel && (sel.i === ITEM.BUCKET_AGUA || sel.i === ITEM.BUCKET_LAVA)) {
            const a = ray.adj;
            const fluidoBloco = sel.i === ITEM.BUCKET_AGUA ? BLOCO.AGUA : BLOCO.LAVA;
            state.world.set(a.x, a.y, a.z, fluidoBloco);
            // Fluxo BFS: espalha 4 blocos (água) ou 2 (lava) + cai vertical
            state.world.espalharFluido(a.x, a.y, a.z, fluidoBloco);
            state.inv.consumirAtual();
            state.inv.adicionar({ i: ITEM.BUCKET, q: 1 });
            Audio.splash();
            state.ui.toast(`${fluidoBloco === BLOCO.AGUA ? 'Água' : 'Lava'} despejada`);
          }
          // Plantar muda: requer ground = GRAMA, posição AR
          else if (sel && sel.i === ITEM.SEMENTE) {
            const a = ray.adj;
            if (state.world.plantarSemente(a.x, a.y, a.z, 'trigo')) {
              state.inv.consumirAtual();
              Audio.colocar();
              state.ui.toast('Semente plantada — colha em ~30s');
            } else {
              state.ui.toast('Sementes só germinam em terra/grama');
            }
          }
          else if (sel && sel.i === ITEM.MUDA) {
            const a = ray.adj;
            if (state.world.plantarMuda(a.x, a.y, a.z)) {
              state.inv.consumirAtual();
              Audio.colocar();
              state.ui.toast('Muda plantada — vai crescer em ~20s');
              Achievements.unlock('PLANTAR_MUDA');
            } else {
              state.ui.toast('Mudas só crescem em grama');
            }
          } else if (sel && sel.b !== undefined) {
            const a = ray.adj;
            const px = Math.floor(state.player.pos.x);
            const py = Math.floor(state.player.pos.y);
            const pz = Math.floor(state.player.pos.z);
            // Não coloca bloco onde o player está (paridade Minecraft real)
            if (!(a.x === px && a.z === pz && (a.y === py || a.y === py + 1))) {
              // Tocha/Vela precisam de apoio em algum lado (paridade MC)
              const infoSel = BLOCO_INFO[sel.b];
              if (infoSel?.shape === 'torch' && !state.world._tochaTemApoio(a.x, a.y, a.z)) {
                state.ui.toast('⚠ Tocha precisa de apoio sólido (chão ou parede)');
              } else {
              state.world.setPeloPlayer(a.x, a.y, a.z, sel.b);
              // Beacon: ao colocar, registra no set ativo e cria beam visual
              if (sel.b === BLOCO.BEACON) {
                state.beacons = state.beacons || new Set();
                state.beacons.add(World.keyXYZ(a.x, a.y, a.z));
                state.renderer.criarBeaconBeam(a.x, a.y, a.z);
                state.ui.toast('🌟 Beacon ativo! Construa pirâmide debaixo pra buff.');
              }
              // Build Snow Golem: CARVED_PUMPKIN colocada sobre 2 NEVE
              // empilhadas → remove os 3 blocos + spawn snow_golem.
              if (sel.b === BLOCO.CARVED_PUMPKIN &&
                  state.world.get(a.x, a.y - 1, a.z) === BLOCO.NEVE &&
                  state.world.get(a.x, a.y - 2, a.z) === BLOCO.NEVE) {
                state.world.set(a.x, a.y, a.z, BLOCO.AR);
                state.world.set(a.x, a.y - 1, a.z, BLOCO.AR);
                state.world.set(a.x, a.y - 2, a.z, BLOCO.AR);
                state.mobMgr.spawn('snow_golem', a.x + 0.5, a.y - 1.5, a.z + 0.5);
                state.ui.toast('☃ Snow Golem invocado!');
              }
              // Areia colocada no ar cai na hora (gravidade)
              if (sel.b === BLOCO.AREIA) {
                state.world.aplicarGravidadeBlocos(a.x, a.y - 1, a.z);
              }
              state.inv.consumirAtual();
              Audio.colocar();
              state.particulas.spawnQuebra(a.x, a.y, a.z, sel.b);
              state.renderer.swingProgress = 0.01;
              Save.incrementarStat('blocksPlaced');
              } // fecha else do tochaTemApoio
            }
          }
        }
      }
    }

    state.renderer.atualizarAlvo(ray ? ray.hit : null, progressoVisual);
    const sel = state.inv.itemSelecionado();
    const ferr = sel && sel.i !== undefined && ITEM_INFO[sel.i]?.ferramenta;
    state.renderer.atualizarMao(dt, state.player.holdE && !!ray, ferr);
    // Crosshair muda de cor: vermelho se mira mob alcançável, amarelo se
    // mira bloco quebrável, branco padrão. Feedback de "tem como atacar".
    const cross = document.getElementById('crosshair');
    if (cross) {
      const mobMira = state.mobMgr.maisProximo(state.player, ALCANCE_BLOCO);
      cross.classList.toggle('alvo-mob', !!mobMira);
      cross.classList.toggle('alvo-bloco', !mobMira && !!ray);
    }
  }

  // === Chunk loading com priorização predictive ===
  // Ordena chunks faltantes por: distância ao player + alinhamento com
  // velocidade (chunks na direção que o player anda carregam primeiro).
  const pcx = Math.floor(state.player.pos.x / CHUNK_SIZE);
  const pcz = Math.floor(state.player.pos.z / CHUNK_SIZE);
  const VR = state.quality?.viewRadius ?? VIEW_RADIUS;
  const vx = state.player.vel?.x || 0, vz = state.player.vel?.z || 0;
  const speed = Math.hypot(vx, vz);
  const dirX = speed > 0.1 ? vx / speed : 0;
  const dirZ = speed > 0.1 ? vz / speed : 0;
  const faltantes = [];
  for (let dx = -VR; dx <= VR; dx++) {
    for (let dz = -VR; dz <= VR; dz++) {
      if (!state.world.hasChunk(pcx + dx, pcz + dz)) {
        // score: menor é mais prioritário. Distância + bônus pra direção
        // do movimento (predictive — antecipa o que o player vai ver).
        const dist = Math.hypot(dx, dz);
        const align = -(dx * dirX + dz * dirZ); // negativo = pro lado do movimento
        faltantes.push({ dx, dz, score: dist + align * 0.8 });
      }
    }
  }
  faltantes.sort((a, b) => a.score - b.score);
  let orcamento = state.chunkLoadOrcamento;
  for (const f of faltantes) {
    if (orcamento <= 0) break;
    // preloadChunk delega ao Worker (assíncrono, sem stutter). Se worker
    // indisponível, no-op silencioso e o sync fallback acontece na
    // primeira query (world.get → getChunk → gerarChunk sync).
    state.world.preloadChunk(pcx + f.dx, pcz + f.dz);
    orcamento--;
  }
  // === Build mesh dirty (também priorizado por distância ao player) ===
  let buildOrc = state.quality?.chunkMeshBudget ?? 4;
  const dirty = [];
  for (const c of state.world.chunks.values()) {
    if (!c.dirty) continue;
    const dx = c.cx - pcx, dz = c.cz - pcz;
    if (Math.abs(dx) > VR + 1 || Math.abs(dz) > VR + 1) continue;
    dirty.push({ c, score: Math.hypot(dx, dz) });
  }
  dirty.sort((a, b) => a.score - b.score);
  for (const d of dirty) {
    if (buildOrc <= 0) break;
    state.renderer.buildChunkMesh(state.world, d.c);
    buildOrc--;
  }
  // === Libera chunks fora de view ===
  for (const [k, c] of state.world.chunks) {
    const dx = c.cx - pcx, dz = c.cz - pcz;
    if (Math.abs(dx) > VR + 2 || Math.abs(dz) > VR + 2) {
      if (c.mesh) state.renderer.liberarChunkMesh(c);
      if (!c.modificado) state.world.chunks.delete(k);
    }
  }
  // === Spawn villagers de vilas geradas (deferido — após chunk loaded) ===
  if (state.world._vilasParaSpawnar?.length) {
    while (state.world._vilasParaSpawnar.length) {
      const v = state.world._vilasParaSpawnar.shift();
      state.mobMgr.spawn('villager', v.x, v.y, v.z);
    }
  }
  // === Spawn cave_spiders em mineshafts (deferido — só após chunk gen) ===
  if (state.world._mineshaftSpawns?.length) {
    while (state.world._mineshaftSpawns.length) {
      const s = state.world._mineshaftSpawns.shift();
      state.mobMgr.spawn('cave_spider', s.x, s.y, s.z);
    }
  }
  // === Loading overlay quando há backlog ===
  // Mostra "Carregando…" se >50% do view radius está faltando OU tem
  // muito mesh-dirty pendente. Esconde quando backlog < 25%.
  const totalView = (2 * VR + 1) ** 2;
  const aindaFaltam = faltantes.length;
  const aindaDirty = dirty.length;
  const carga = aindaFaltam + aindaDirty;
  const cargaRel = carga / totalView;
  if (cargaRel > 0.5) {
    state.ui.mostrarLoading('Carregando cenário…',
      `chunks: ${aindaFaltam} a gerar · ${aindaDirty} a montar`);
    state._busy = true;
  } else if (cargaRel < 0.15 && state._busy) {
    state.ui.esconderLoading();
    state._busy = false;
  }

  state.renderer.atualizarTexturasAnimadas(dt);
  state.renderer.atualizarCeu(state.tempoDia, state.player.pos);
  // === Overlays visuais (premium look) ===
  // Underwater tint: aparece quando player.naAgua
  const _under = document.getElementById('underwater-tint');
  if (_under) _under.classList.toggle('show', !!state.player.naAgua);
  // Visão noturna: overlay amarelo se efeito ativo
  const _night = document.getElementById('night-vision-overlay');
  if (_night) {
    const ativo = state.player.efeitos?.noite && Date.now() < state.player.efeitos.noite;
    _night.classList.toggle('show', !!ativo);
  }
  // Color grading: tint baseado na hora do dia
  const _grade = document.getElementById('color-grade');
  if (_grade) {
    const sun = Math.max(0.05, 0.5 + 0.5 * Math.sin(state.tempoDia * Math.PI * 2 - Math.PI / 2));
    let cor = 'rgba(0,0,0,0)';
    if (sun < 0.20) cor = 'rgba(80, 100, 180, 0.18)';      // noite: azul frio
    else if (sun < 0.42) cor = 'rgba(255, 140, 80, 0.20)'; // dawn/dusk: amber
    else if (sun < 0.55) cor = 'rgba(255, 200, 130, 0.10)'; // golden hour
    // Dia (sun >= 0.55): sem tint
    _grade.style.backgroundColor = cor;
  }
  // Boss HP bar (Ender Dragon)
  const boss = state.mobMgr.mobs.find(m => MOB_INFO[m.tipo]?.boss);
  const bossBar = document.getElementById('boss-bar');
  if (bossBar) {
    if (boss) {
      bossBar.classList.remove('hidden');
      const pct = Math.max(0, Math.min(1, boss.hp / MOB_INFO[boss.tipo].hp));
      const fill = document.getElementById('boss-bar-fill');
      if (fill) fill.style.width = `${pct * 100}%`;
    } else {
      bossBar.classList.add('hidden');
    }
  }
  // Luzes pontuais: throttle 4Hz (era cada frame). Varre 5×5 chunks
  // procurando lights — operação custosa que não precisa rodar 60Hz
  state._luzAcc = (state._luzAcc || 0) + dt;
  if (state._luzAcc >= 0.25) {
    state._luzAcc = 0;
    state.renderer.atualizarLuzesPontuais(state.world, state.player.pos);
  }
  state.renderer.atualizarSombraPlayer(state.world, state.player.pos);
  // Zoom: ativo se ITEM.LUNETA estiver selecionado E state._zoomLuneta=true
  const _selZoom = state.inv?.itemSelecionado?.();
  const zooming = !!state._zoomLuneta && _selZoom?.i === ITEM.LUNETA;
  state.renderer.atualizarFOV(dt, !!state.player.input.sprint &&
    (Math.abs(state.player.input.fwd) + Math.abs(state.player.input.side)) > 0, zooming);

  // HUD throttled (5Hz em vez de cada frame — economia significativa em
  // mobile sem prejuízo perceptível visualmente)
  state._hudAcc = (state._hudAcc || 0) + dt;
  if (state._hudAcc >= 0.20) {
    state._hudAcc = 0;
    const t = state.tempoDia * 24;
    const h = Math.floor(t), m = Math.floor((t - h) * 60);
    const glifo = (state.tempoDia >= 0.25 && state.tempoDia < 0.75) ? '☀' : '☾';
    document.getElementById('relogio').textContent =
      `${glifo} ${String(h).padStart(2, '0')}:${String(m).padStart(2, '0')}`;
    document.getElementById('coords').textContent =
      `X:${state.player.pos.x.toFixed(1)} Y:${state.player.pos.y.toFixed(1)} Z:${state.player.pos.z.toFixed(1)}`;
    state.ui.renderBars();
    state.ui.atualizarOverlays();
  }
  // Bússola HUD: aparece se ITEM.BUSSOLA está selecionado. Calcula direção
  // do player até o spawn em ângulo relativo ao yaw da câmera (0° = frente).
  {
    const selB = state.inv.itemSelecionado();
    const hud = document.getElementById('bussola-hud');
    if (hud) {
      if (selB?.i === ITEM.BUSSOLA) {
        hud.classList.remove('hidden');
        const sx = state.player.spawn?.x ?? state.player.pos.x;
        const sz = state.player.spawn?.z ?? state.player.pos.z;
        const dx = sx - state.player.pos.x;
        const dz = sz - state.player.pos.z;
        const dist = Math.hypot(dx, dz);
        // Ângulo absoluto do spawn (radianos, 0 = +X)
        const angSpawn = Math.atan2(-dz, dx);
        // Yaw da câmera (Three.js: -Z é frente, então yaw = atan2(dirCam.x, -dirCam.z))
        const dirCam = state.renderer.camera.getWorldDirection(_tmpVecAux);
        const angCam = Math.atan2(dirCam.x, -dirCam.z);
        // Rotação da seta = quanto girar pra apontar pro spawn em relação à frente
        const rel = angSpawn - (Math.PI / 2 - angCam);
        const seta = document.getElementById('bussola-seta');
        const distEl = document.getElementById('bussola-dist');
        if (seta) seta.style.transform = `rotate(${(-rel * 180 / Math.PI).toFixed(1)}deg)`;
        if (distEl) distEl.textContent = `${dist.toFixed(0)}m`;
      } else {
        hud.classList.add('hidden');
      }
    }
  }
  if (state.ui.f3Ativo) state.ui.atualizarF3({ targetBlock: ray ? ray.hit : null });
  state.ui.atualizarMinimap?.();
  atualizarItemDrops(dt);
  atualizarXpOrbs(dt, ganharXP);
  atualizarArrows(dt);
  atualizarFishingBobber(dt);
  atualizarFireworks(dt);
  atualizarTridents(dt);
  // Skip ambient triggers + clima em heavy frames pra dar prioridade a
  // chunk loading/mesh build (responsividade da movimentação).
  if (!state._heavyFrame || !state._busy) {
    atualizarAmbientTriggers(dt);
    atualizarAmbientBioma(dt);
    atualizarClima(dt);
  }
  // Atualiza damage numbers (projeção de coords 3D → 2D + fade)
  if (state.ui?.atualizarDamageNumbers) state.ui.atualizarDamageNumbers(dt);

  // Camera bobbing + shake
  const isMoving = state.player && state.player.noChao &&
    (Math.abs(state.player.input.fwd) + Math.abs(state.player.input.side)) > 0 &&
    !state.player.terceiraPessoa;
  const isRunning = isMoving && !!state.player.input.sprint;
  // Sprint dust: spawnar partículas a cada ~0.12s ao correr
  if (isRunning && state.player.noChao) {
    state._sprintDustAcc = (state._sprintDustAcc || 0) + dt;
    if (state._sprintDustAcc > 0.12) {
      state._sprintDustAcc = 0;
      state.particulas?.spawnSprintDust?.(state.player.pos.x, state.player.pos.y - 1.0, state.player.pos.z);
    }
  } else state._sprintDustAcc = 0;
  const bob = state.renderer.atualizarBobbing(dt, isMoving, isRunning);
  const shake = state.renderer.atualizarShake(dt);
  state.renderer.camera.position.x += bob.x + shake.x;
  state.renderer.camera.position.y += bob.y + shake.y;
  state.renderer.camera.position.z += shake.z;

  state.renderer.render();
  requestAnimationFrame(loop);
}

// === Boot screen: nome do player + lista de mundos + handlers ===
function _renderBoot() {
  const playerInput = document.getElementById('boot-player');
  const worldNameInput = document.getElementById('boot-world-name');
  const lista = document.getElementById('boot-worlds-list');
  if (!playerInput || !lista) return;

  // Restaura nome salvo do player
  const savedPlayer = Save.getPlayer();
  if (savedPlayer.name) playerInput.value = savedPlayer.name;
  playerInput.addEventListener('input', () => Save.setPlayer(playerInput.value.trim()));

  // Renderiza lista de mundos
  function refresh() {
    const mundos = Save.listarMundos();
    lista.innerHTML = '';
    if (!mundos.length) {
      const empty = document.createElement('div');
      empty.className = 'boot-world-item empty';
      empty.textContent = 'Nenhum mundo salvo — crie um novo abaixo';
      lista.appendChild(empty);
      return;
    }
    for (const w of mundos) {
      const div = document.createElement('div');
      div.className = 'boot-world-item';
      const data = w.lastPlayed ? new Date(w.lastPlayed).toLocaleString('pt-BR', { day: '2-digit', month: 'short', hour: '2-digit', minute: '2-digit' }) : 'nunca';
      div.innerHTML = `<div><div class="boot-world-name">${w.name}</div><div class="boot-world-meta">modo: ${w.modo} · jogado: ${data}</div></div><button class="boot-world-del" title="Excluir">✕</button>`;
      div.onclick = (e) => {
        if (e.target.classList.contains('boot-world-del')) {
          if (confirm(`Excluir "${w.name}"? Não pode desfazer.`)) {
            Save.apagarMundo(w.name);
            refresh();
          }
          return;
        }
        // Carrega mundo existente
        _entrarNoJogo({ playerName: playerInput.value.trim() || 'Aventureiro', worldName: w.name, isNew: false });
      };
      lista.appendChild(div);
    }
  }
  refresh();

  // Botão Jogar (mundo novo)
  document.getElementById('play').onclick = () => {
    const playerName = playerInput.value.trim() || 'Aventureiro';
    const worldName = worldNameInput.value.trim() || `Mundo ${Save.listarMundos().length + 1}`;
    _entrarNoJogo({ playerName, worldName, isNew: true });
  };

  // Botão Multiplayer → modal
  document.getElementById('boot-multi').onclick = () => {
    document.getElementById('multi-modal').classList.remove('hidden');
  };
  document.getElementById('multi-close').onclick = () => {
    document.getElementById('multi-modal').classList.add('hidden');
  };
  document.getElementById('multi-export').onclick = () => {
    if (!state.world) {
      // Exporta o último mundo do index sem precisar carregar
      const mundos = Save.listarMundos();
      if (!mundos.length) { alert('Nenhum mundo pra exportar.'); return; }
      const data = Save.carregarPorNome(mundos[0].name);
      if (!data) { alert('Mundo vazio.'); return; }
      const blob = new Blob([JSON.stringify(data)], { type: 'application/json' });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url; a.download = `${mundos[0].name.replace(/[^a-z0-9]/gi, '_')}.json`;
      a.click(); URL.revokeObjectURL(url);
    } else {
      Save.exportarMundoAtual();
    }
  };
  document.getElementById('multi-import').onclick = () => {
    document.getElementById('multi-import-file').click();
  };
  document.getElementById('multi-import-file').onchange = async (e) => {
    const f = e.target.files?.[0];
    if (!f) return;
    const txt = await f.text();
    const name = Save.importarMundo(txt);
    if (name) {
      alert(`Mundo "${name}" importado!`);
      document.getElementById('multi-modal').classList.add('hidden');
      refresh();
    } else alert('Arquivo inválido.');
  };
  // Online room handlers
  const roomInput = document.getElementById('multi-room');
  const status = document.getElementById('multi-status');
  const refreshStatus = () => {
    if (Multiplayer.isOnline()) status.textContent = `🌐 Online — sala "${Multiplayer.roomAtual()}"`;
    else status.textContent = 'Status: desconectado';
  };
  try { roomInput.value = localStorage.getItem('rebcm3d_mp_room') || ''; } catch (_) {}
  document.getElementById('multi-conectar').onclick = () => {
    const r = roomInput.value.trim();
    if (!r) { alert('Digite um nome de sala'); return; }
    Multiplayer.iniciar();
    Multiplayer.conectarOnline(r);
    setTimeout(refreshStatus, 800);
  };
  document.getElementById('multi-desconectar').onclick = () => {
    Multiplayer.desconectarOnline();
    setTimeout(refreshStatus, 200);
  };
  refreshStatus();
}

async function _entrarNoJogo(choice) {
  window._bootChoice = choice;
  try { window.rebcm?.desbloquearAudio?.(); } catch (_) {}
  try {
    await document.documentElement.requestFullscreen?.();
    if (screen.orientation && screen.orientation.lock) {
      try { await screen.orientation.lock('landscape'); } catch (_) {}
    }
  } catch (_) {}
  document.getElementById('boot').style.display = 'none';
  document.getElementById('hud').classList.remove('hidden');
  if (!state.renderer) init();
  try { state.player.controls.lock(); } catch (_) {}
}

// Inicializa boot screen ao carregar — com fallback hard-attached pro
// botão Jogar caso _renderBoot quebre (ex: localStorage corrompido).
function _renderBootSafe() {
  try { _renderBoot(); }
  catch (e) {
    console.error('[boot] erro renderizando boot screen:', e);
    // Fallback mínimo: botão Jogar funciona com defaults
    const playBtn = document.getElementById('play');
    if (playBtn) playBtn.onclick = () => _entrarNoJogo({
      playerName: document.getElementById('boot-player')?.value?.trim() || 'Aventureiro',
      worldName: document.getElementById('boot-world-name')?.value?.trim() || 'Mundo 1',
      isNew: true,
    });
  }
}
// === Cross-browser feature detection ===
// Verifica WebGL antes de renderizar boot. Se ausente, mostra tela
// amigável em vez de erro críptico no console.
function _checkBrowserSupport() {
  // WebGL
  let webgl = false;
  try {
    const cnv = document.createElement('canvas');
    webgl = !!(cnv.getContext('webgl2') || cnv.getContext('webgl') || cnv.getContext('experimental-webgl'));
  } catch (_) {}
  if (!webgl) {
    document.body.innerHTML =
      '<div style="padding:32px;color:#fff;font-family:sans-serif;text-align:center;max-width:600px;margin:80px auto">' +
      '<h1 style="color:#FFD700">⚠ WebGL não disponível</h1>' +
      '<p>Seu navegador não suporta WebGL — o jogo precisa dele pra renderizar 3D.</p>' +
      '<p>Tente:</p><ul style="text-align:left;display:inline-block">' +
      '<li>Chrome, Firefox, Safari ou Edge atualizados</li>' +
      '<li>Habilitar "Aceleração por hardware" nas configurações do navegador</li>' +
      '<li>Atualizar drivers da placa de vídeo</li>' +
      '</ul></div>';
    return false;
  }
  // localStorage (alguns browsers em modo privado bloqueiam)
  try { localStorage.setItem('_t', '1'); localStorage.removeItem('_t'); }
  catch (_) {
    console.warn('[boot] localStorage indisponível — saves não persistirão');
  }
  return true;
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => {
    if (_checkBrowserSupport()) _renderBootSafe();
  });
} else {
  if (_checkBrowserSupport()) _renderBootSafe();
}
