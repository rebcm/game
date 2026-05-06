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
import { MobManager, MOB_INFO } from './mobs.js';
import {
  Particulas, spawnItemDrop, atualizarItemDrops,
  spawnXPOrb, atualizarXpOrbs, atualizarAmbientTriggers,
} from './particles.js';
import { UI } from './ui.js';
import { Save } from './save.js';
import { setupInput, setupTouchControls, setActions } from './input.js';

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

// === Atacar mob ===
function atacarMob() {
  if (state.player.morto) return;
  const m = state.mobMgr.maisProximo(state.player, ALCANCE_BLOCO);
  if (!m) return;
  // Critical hit — atacar enquanto cai (paridade Minecraft)
  const isCrit = !state.player.noChao && state.player.vel.y < -0.3 && state.player.modo === 'survival';
  Audio.atacar();
  if (isCrit) Audio.critical();
  const tier = state.inv.melhorEspada();
  let dano = 2 + tier * 2;
  if (isCrit) dano = Math.round(dano * 1.5);
  m.hp -= dano;
  if (m.tipo === 'zumbi') Audio.zumbiHit();
  else Audio.hit();
  // Knockback no mob
  const dirCam = state.renderer.camera.getWorldDirection(_tmpVecAux);
  m.x += dirCam.x * 0.8;
  m.z += dirCam.z * 0.8;
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
  } else {
    state.ui.toast(`Atingiu ${m.tipo}${isCrit ? ' ⚡' : ''} (-${dano})`);
  }
}

// === Comer item da hotbar ===
function comerSlot() {
  if (state.player.morto) return;
  const s = state.inv.itemSelecionado();
  if (!s || s.i === undefined) { state.ui.toast('Nada comestível selecionado'); return; }
  const info = ITEM_INFO[s.i];
  if (!info || !info.nutricao) { state.ui.toast('Não comestível'); return; }
  state.player.fome = clamp(state.player.fome + info.nutricao, 0, state.player.fomeMax);
  state.player.saturation = Math.min(20, state.player.saturation + info.nutricao * 0.6);
  state.inv.consumirAtual();
  Audio.eatCrunch();
  if (info.suspeito && Math.random() < 0.15) state.player.aplicarDano(1, 'comida estragada');
  else state.ui.toast(`Comeu ${info.nome} (+${info.nutricao} fome)`);
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
  state.renderer = new Renderer(canvas);
  state.world = new World(42);
  state.player = new Player(state.renderer.camera);
  state.player.controls = new PointerLockControls(state.renderer.camera, document.body);
  state.renderer.scene.add(state.player.controls.object);
  state.mobMgr = new MobManager(state.renderer.scene);
  state.particulas = new Particulas(state.renderer.scene);

  // Tenta carregar save
  const save = Save.carregar();
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
    state.ui.toast('Mundo carregado');
  } else {
    const h = state.world.alturaTerreno(8, 8);
    state.player.pos.set(8.5, h + 2, 8.5);
    state.player.spawn.copy(state.player.pos);
    state.ui.toast('Bem-vinda ao mundo 3D!');
  }
  state.player.spawnY = state.player.pos.y;

  setActions({ atacarMob, comerSlot, abrirPainelBau, abrirPainelFornalha, dormir });
  setupInput();
  setupTouchControls();
  state.ui.atualizar();
  Audio.musicaIniciar();

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

  // FPS counter
  state.fpsAcc++;
  state.fpsTimer += dt;
  if (state.fpsTimer >= 1) {
    document.getElementById('fps').textContent = `${state.fpsAcc} FPS`;
    state.fpsAcc = 0; state.fpsTimer = 0;
  }

  const algumPainelAberto = document.querySelector('.painel:not(.hidden)') !== null;
  const pausado = !document.getElementById('pause-menu').classList.contains('hidden');
  let ray = null;
  if (algumPainelAberto || pausado || state.player.morto) {
    // Pausa lógica
  } else {
    state.player.atualizar(dt, state.world);
    state.tempoDia = (state.tempoDia + dt / DIA_SEGUNDOS) % 1;
    const sun = Math.max(0.05, 0.5 + 0.5 * Math.sin(state.tempoDia * Math.PI * 2 - Math.PI / 2));
    state.mobMgr.atualizar(dt, state.world, state.player, sun);
    state.particulas.atualizar(dt);

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
      const mult = (t.b === BLOCO.BEDROCK) ? 0 : Drops.velocidadeQuebra(t.b, tier, ferr);
      state.player.progressoQuebra += dt / TEMPO_QUEBRA_BASE * mult;
      progressoVisual = state.player.progressoQuebra;
      if (state.player.progressoQuebra >= 1) {
        state.player.progressoQuebra = 0;
        const drops = Drops.dropDeBloco(t.b, tier);
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
        state.world.set(t.x, t.y, t.z, BLOCO.AR);
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
      if (ray) {
        const t = ray.hit;
        const blocoAlvo = t.b;
        if (blocoAlvo === BLOCO.BAU) abrirPainelBau(t.x, t.y, t.z);
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
          if (sel && sel.b !== undefined) {
            const a = ray.adj;
            const px = Math.floor(state.player.pos.x);
            const py = Math.floor(state.player.pos.y);
            const pz = Math.floor(state.player.pos.z);
            // Não coloca bloco onde o player está (paridade Minecraft real)
            if (!(a.x === px && a.z === pz && (a.y === py || a.y === py + 1))) {
              state.world.set(a.x, a.y, a.z, sel.b);
              state.inv.consumirAtual();
              Audio.colocar();
              state.particulas.spawnQuebra(a.x, a.y, a.z, sel.b);
              state.renderer.swingProgress = 0.01;
            }
          }
        }
      }
    }

    state.renderer.atualizarAlvo(ray ? ray.hit : null, progressoVisual);
    const sel = state.inv.itemSelecionado();
    const ferr = sel && sel.i !== undefined && ITEM_INFO[sel.i]?.ferramenta;
    state.renderer.atualizarMao(dt, state.player.holdE && !!ray, ferr);
  }

  // Carrega chunks faltantes
  const pcx = Math.floor(state.player.pos.x / CHUNK_SIZE);
  const pcz = Math.floor(state.player.pos.z / CHUNK_SIZE);
  let orcamento = state.chunkLoadOrcamento;
  for (let dx = -VIEW_RADIUS; dx <= VIEW_RADIUS && orcamento > 0; dx++) {
    for (let dz = -VIEW_RADIUS; dz <= VIEW_RADIUS && orcamento > 0; dz++) {
      if (!state.world.hasChunk(pcx + dx, pcz + dz)) {
        state.world.getChunk(pcx + dx, pcz + dz);
        orcamento--;
      }
    }
  }
  // Build mesh dirty
  let buildOrc = 2;
  for (const c of state.world.chunks.values()) {
    if (c.dirty && buildOrc > 0) {
      const dx = c.cx - pcx, dz = c.cz - pcz;
      if (Math.abs(dx) <= VIEW_RADIUS + 1 && Math.abs(dz) <= VIEW_RADIUS + 1) {
        state.renderer.buildChunkMesh(state.world, c);
        buildOrc--;
      }
    }
  }
  // Libera chunks fora de view
  for (const [k, c] of state.world.chunks) {
    const dx = c.cx - pcx, dz = c.cz - pcz;
    if (Math.abs(dx) > VIEW_RADIUS + 2 || Math.abs(dz) > VIEW_RADIUS + 2) {
      if (c.mesh) state.renderer.liberarChunkMesh(c);
      if (!c.modificado) state.world.chunks.delete(k);
    }
  }

  state.renderer.atualizarCeu(state.tempoDia, state.player.pos);
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
  atualizarItemDrops(dt);
  atualizarXpOrbs(dt, ganharXP);
  atualizarAmbientTriggers(dt);

  // Camera shake
  const shake = state.renderer.atualizarShake(dt);
  if (shake.x || shake.y || shake.z) {
    state.renderer.camera.position.x += shake.x;
    state.renderer.camera.position.y += shake.y;
    state.renderer.camera.position.z += shake.z;
  }

  state.renderer.render();
  requestAnimationFrame(loop);
}

// === Boot — handler do botão JOGAR ===
document.getElementById('play').addEventListener('click', async () => {
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
});
