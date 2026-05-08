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
  spawnArrow, atualizarArrows,
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
  const kbForca = isCrit ? 8.5 : 6.0;
  m.tomarDano(dano, dirCam.x * kbForca, dirCam.z * kbForca);
  if (m.hp <= 0) {
    const drops = MOB_INFO[m.tipo].drops();
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

// === Encantar item ativo na mesa de encantamento ===
// Custa 10/20/30 XP por nível 1/2/3. Tipo do enchant é determinado
// pelo item (espada=sharpness, picareta=efficiency, armadura=protection).
// Requer ITEM.LAPIS na hotbar (consume 1 por enchant).
function encantarItemAtual() {
  const sel = state.inv.itemSelecionado();
  if (!sel || sel.i === undefined) {
    state.ui.toast('Selecione um item pra encantar');
    return;
  }
  const info = ITEM_INFO[sel.i];
  let tipoEnch = null;
  if (info?.ferramenta === 'esp') tipoEnch = 'sharpness';
  else if (info?.ferramenta === 'pic') tipoEnch = 'efficiency';
  else if (info?.armadura) tipoEnch = 'protection';
  if (!tipoEnch) {
    state.ui.toast('Item não encantável (use espada/picareta/armadura)');
    return;
  }
  if (sel.encant?.[tipoEnch] >= 3) {
    state.ui.toast('Item já no nível máximo');
    return;
  }
  if (state.inv.contar(undefined, ITEM.LAPIS) <= 0) {
    state.ui.toast('Precisa de Lápis Lazuli (drop raro de pedra)');
    return;
  }
  const proxNivel = (sel.encant?.[tipoEnch] || 0) + 1;
  const custoXP = proxNivel * 10;
  if ((state.player.xp || 0) < custoXP) {
    state.ui.toast(`Precisa de ${custoXP} XP (você tem ${state.player.xp})`);
    return;
  }
  state.player.xp -= custoXP;
  state.inv.consumir(undefined, ITEM.LAPIS, 1);
  sel.encant = sel.encant || {};
  sel.encant[tipoEnch] = proxNivel;
  Audio.levelUp?.();
  state.ui.toast(`✨ ${info.nome} +${tipoEnch} ${proxNivel}!`);
  state.ui.atualizarXP?.();
  state.ui.renderHotbar?.();
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
  } else {
    p.efeitos[tipo] = Date.now() + 30000; // 30s
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
    if (BLOCO_INFO[b].solido && b !== BLOCO.AR) {
      const adj = { x, y, z };
      if (face === 'x') adj.x -= stepX;
      else if (face === 'y') adj.y -= stepY;
      else                   adj.z -= stepZ;
      return { hit: { x, y, z, b }, adj };
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
        state.inv.slots[s.sx] = { b: s.b, i: s.i, q: s.q };
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
  Audio.musicaIniciar();
  Multiplayer.iniciar();

  // Autosave a cada 30s
  setInterval(() => Save.salvar(), 30_000);

  window.addEventListener('resize', () => state.renderer.resize());
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
  }
  qualityTickFps(dt);

  const algumPainelAberto = document.querySelector('.painel:not(.hidden)') !== null;
  const pausado = !document.getElementById('pause-menu').classList.contains('hidden');
  let ray = null;
  if (algumPainelAberto || pausado || state.player.morto) {
    // Pausa lógica
  } else {
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
        if (state.player.modo === 'creative') {
          for (const d of drops) state.inv.adicionar(d);
        } else {
          for (const d of drops) spawnItemDrop(d, t.x, t.y, t.z);
        }
        state.particulas.spawnQuebra(t.x, t.y, t.z, t.b);
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
        state.world.aplicarGravidadeBlocos(t.x, t.y, t.z);
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
        else if (blocoAlvo === BLOCO.CAMA) dormir();
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
              state.world.setPeloPlayer(a.x, a.y, a.z, sel.b);
              // Areia colocada no ar cai na hora (gravidade)
              if (sel.b === BLOCO.AREIA) {
                state.world.aplicarGravidadeBlocos(a.x, a.y - 1, a.z);
              }
              state.inv.consumirAtual();
              Audio.colocar();
              state.particulas.spawnQuebra(a.x, a.y, a.z, sel.b);
              state.renderer.swingProgress = 0.01;
              Save.incrementarStat('blocksPlaced');
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
  state.renderer.atualizarLuzesPontuais(state.world, state.player.pos);
  state.renderer.atualizarFOV(dt, !!state.player.input.sprint &&
    (Math.abs(state.player.input.fwd) + Math.abs(state.player.input.side)) > 0);

  // HUD
  const t = state.tempoDia * 24;
  const h = Math.floor(t), m = Math.floor((t - h) * 60);
  const glifo = (state.tempoDia >= 0.25 && state.tempoDia < 0.75) ? '☀' : '☾';
  document.getElementById('relogio').textContent =
    `${glifo} ${String(h).padStart(2, '0')}:${String(m).padStart(2, '0')}`;
  document.getElementById('coords').textContent =
    `X:${state.player.pos.x.toFixed(1)} Y:${state.player.pos.y.toFixed(1)} Z:${state.player.pos.z.toFixed(1)}`;
  state.ui.renderBars();
  state.ui.atualizarOverlays();
  if (state.ui.f3Ativo) state.ui.atualizarF3({ targetBlock: ray ? ray.hit : null });
  state.ui.atualizarMinimap?.();
  atualizarItemDrops(dt);
  atualizarXpOrbs(dt, ganharXP);
  atualizarArrows(dt);
  // Skip ambient triggers + clima em heavy frames pra dar prioridade a
  // chunk loading/mesh build (responsividade da movimentação).
  if (!state._heavyFrame || !state._busy) {
    atualizarAmbientTriggers(dt);
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
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', _renderBootSafe);
} else {
  _renderBootSafe();
}
