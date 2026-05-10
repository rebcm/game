// =====================================================================
// input.js — Keyboard/mouse + touch controls (mobile)
// =====================================================================

import * as THREE from 'three';
import { state } from './state.js';
import { Audio } from './audio.js';
import { Save } from './save.js';
import { aplicarTier, salvarPreferencia, carregarPreferencia, detectarTier, PRESETS } from './quality.js';

export const isTouchDevice = (typeof window !== 'undefined') &&
  (('ontouchstart' in window) || (navigator.maxTouchPoints || 0) > 0);

// Funções definidas em main.js (passadas via setActions). Mantém input.js
// independente de circular imports.
let _actions = null;
export function setActions(actions) { _actions = actions; }

function togglePainel(id) {
  const el = document.getElementById(id);
  if (el.classList.contains('hidden')) {
    if (id === 'painel-bag') state.ui.renderBag();
    if (id === 'painel-craft') state.ui.renderCraft(state.ui.workbenchPerto());
    if (id === 'painel-criativo') state.ui.renderCriativo();
    if (id === 'painel-conquistas') state.ui.renderConquistas?.();
    if (id === 'painel-stats') state.ui.renderStats?.();
    el.classList.remove('hidden');
    document.exitPointerLock?.();
    Audio.pageFlip();
  } else {
    el.classList.add('hidden');
  }
}

function alternarModo() {
  state.player.modo = state.player.modo === 'creative' ? 'survival' : 'creative';
  state.player.vel.y = 0;
  state.player.spawnY = state.player.pos.y;
  const ehCreative = state.player.modo === 'creative';
  const btn = document.getElementById('btn-modo');
  btn.textContent = ehCreative ? '🦅' : '⚔';
  // Visual feedback claro: classe distinta + cor de borda + animação pulse
  btn.classList.toggle('modo-creative', ehCreative);
  btn.classList.toggle('modo-survival', !ehCreative);
  btn.classList.add('mode-flash');
  setTimeout(() => btn.classList.remove('mode-flash'), 600);
  // Label persistente sob o botão (visível em mobile)
  let label = document.getElementById('btn-modo-label');
  if (!label) {
    label = document.createElement('div');
    label.id = 'btn-modo-label';
    btn.parentElement.appendChild(label);
  }
  label.textContent = ehCreative ? 'CRIATIVO' : 'SOBREVIV.';
  label.style.color = ehCreative ? '#FFD700' : '#FF5252';
  document.getElementById('modo').textContent = ehCreative ? 'Criativo' : 'Sobrevivência';
  state.ui.toast(ehCreative ? '🦅 Modo Criativo (voo livre)' : '⚔ Modo Sobrevivência (HP/fome)');
}

export function setupInput() {
  document.addEventListener('keydown', (e) => {
    if (e.repeat) return;
    if (e.code === 'F3') { e.preventDefault(); state.ui.toggleF3(); return; }
    if (e.code === 'F1') { e.preventDefault(); state.ui.toggleHud(); return; }
    // F2: photo mode. Esconde HUD, renderiza 1 frame, baixa PNG, mostra HUD.
    if (e.code === 'F2') {
      e.preventDefault();
      const hud = document.getElementById('hud');
      const wasHidden = hud.classList.contains('hidden');
      hud.classList.add('hidden');
      // Espera 1 frame pra HUD sumir
      requestAnimationFrame(() => {
        try { state.renderer.render(); } catch (_) {}
        const dataURL = state.renderer.renderer.domElement.toDataURL('image/png');
        const a = document.createElement('a');
        const ts = new Date().toISOString().replace(/[:.]/g, '-').slice(0, 19);
        a.href = dataURL;
        a.download = `construcao-criativa-${ts}.png`;
        a.click();
        if (!wasHidden) hud.classList.remove('hidden');
        state.ui.toast('📸 Screenshot salvo');
      });
      return;
    }
    // Tab: solta o mouse SEM abrir menu/pause. Útil pra inspecionar HUD,
    // mover janela, ou sair do tela cheia sem perder o estado do jogo.
    if (e.code === 'Tab') {
      e.preventDefault();
      try { state.player.controls.unlock(); } catch (_) {}
      state.ui.toast?.('Mouse liberado — clique no jogo pra travar de novo');
      return;
    }
    if (e.code === 'Escape') {
      const painel = document.querySelector('.painel:not(.hidden)');
      if (painel) {
        painel.classList.add('hidden');
      } else {
        const pause = document.getElementById('pause-menu');
        if (pause.classList.contains('hidden')) state.ui.mostrarPause();
        else state.ui.esconderPause();
      }
      return;
    }
    const p = state.player, inv = state.inv;
    // Double-tap W = sprint (paridade Minecraft)
    if (e.code === 'KeyW') {
      const agora = performance.now();
      if (p._lastWTime && agora - p._lastWTime < 300) p.input.sprint = true;
      p._lastWTime = agora;
    }
    switch (e.code) {
      case 'KeyW': p.input.fwd = 1; break;
      case 'KeyS': p.input.fwd = -1; break;
      case 'KeyA': p.input.side = -1; break;
      case 'KeyD': p.input.side = 1; break;
      case 'Space': {
        p.input.up = 1; p.input.jump = true;
        // Tap-Space durante glide com elytra → trigger firework boost
        if (!e.repeat && p._elytraEquipada && !p.noChao) p._fireworkTrigger = true;
        break;
      }
      case 'ShiftLeft': case 'ShiftRight':
        if (p.modo === 'creative') p.input.up = -1;
        else p.input.sprint = true;
        break;
      case 'ControlLeft': case 'ControlRight':
        e.preventDefault();
        p.sneak = true;
        break;
      case 'KeyE':
        if (p.modo === 'creative') togglePainel('painel-criativo');
        else togglePainel('painel-bag');
        break;
      case 'KeyC': togglePainel('painel-craft'); break;
      case 'KeyL': togglePainel('painel-conquistas'); break;
      case 'KeyJ': togglePainel('painel-stats'); break;
      case 'KeyG': alternarModo(); break;
      case 'KeyF': _actions?.atacarMob(); break;
      case 'KeyQ': _actions?.comerSlot(); break;
      case 'F5':
        p.terceiraPessoa = !p.terceiraPessoa;
        state.ui.toast(p.terceiraPessoa ? '3ª pessoa' : '1ª pessoa');
        break;
    }
    if (e.code.startsWith('Digit')) {
      const n = parseInt(e.code.slice(5));
      if (n >= 1 && n <= 9) inv.selecionar(n - 1);
    }
  });
  document.addEventListener('keyup', (e) => {
    const p = state.player;
    switch (e.code) {
      case 'KeyW': case 'KeyS': p.input.fwd = 0; break;
      case 'KeyA': case 'KeyD': p.input.side = 0; break;
      case 'Space': p.input.up = 0; break;
      case 'ShiftLeft': case 'ShiftRight':
        if (p.modo === 'creative') p.input.up = 0;
        else p.input.sprint = false;
        break;
      case 'ControlLeft': case 'ControlRight': p.sneak = false; break;
      // Soltar F = libera flecha (se estava carregando o arco)
      case 'KeyF': _actions?.soltarArco?.(); break;
    }
  });
  // Mouse
  document.addEventListener('mousedown', (e) => {
    const algumPainelAberto = document.querySelector('.painel:not(.hidden)') !== null;
    if (algumPainelAberto) return;
    if (!isTouchDevice && !state.player.controls.isLocked && !state.player.morto) {
      try { state.player.controls.lock(); } catch (_) {}
      return;
    }
    if (!state.player.controls.isLocked) return;
    if (e.button === 0) { state.player.holdE = true; state.player.cliqueE = true; }
    else if (e.button === 2) { state.player.cliqueD = true; }
  });
  document.addEventListener('mouseup', (e) => {
    if (e.button === 0) {
      state.player.holdE = false;
      state.player.progressoQuebra = 0;
      state.player.alvoQuebra = null;
    }
  });
  document.addEventListener('contextmenu', (e) => e.preventDefault());
  document.addEventListener('wheel', (e) => {
    if (!state.player.controls.isLocked) return;
    const dir = e.deltaY > 0 ? 1 : -1;
    state.inv.selecionar(state.inv.slotSel + dir);
  }, { passive: true });

  // Botões UI
  document.getElementById('btn-bag').onclick = () => {
    if (state.player.modo === 'creative') togglePainel('painel-criativo');
    else togglePainel('painel-bag');
  };
  document.getElementById('btn-craft').onclick = () => togglePainel('painel-craft');
  document.getElementById('btn-modo').onclick = () => alternarModo();
  document.getElementById('btn-save').onclick = () => Save.salvar();
  document.getElementById('btn-fullscreen').onclick = async () => {
    try {
      if (document.fullscreenElement) await document.exitFullscreen();
      else await document.documentElement.requestFullscreen();
      if (screen.orientation?.lock) {
        try { await screen.orientation.lock('landscape'); } catch (_) {}
      }
    } catch (_) {}
  };
  document.querySelectorAll('.fechar').forEach(b => {
    b.onclick = () => state.ui.fecharPainel(b.dataset.painel);
  });

  // Tela de morte: respawn
  const morteEl = document.getElementById('morte');
  const respawnHandler = (e) => {
    if (!state.player.morto) return;
    e.preventDefault();
    e.stopPropagation();
    state.player.respawnar();
  };
  morteEl.addEventListener('pointerdown', respawnHandler);
  morteEl.addEventListener('click',       respawnHandler);
  morteEl.addEventListener('touchend',    respawnHandler);
  document.addEventListener('keydown', (e) => {
    if (state.player.morto && (e.code === 'Space' || e.code === 'Enter')) {
      e.preventDefault();
      state.player.respawnar();
    }
  });
  const btnResp = document.getElementById('morte-respawn');
  if (btnResp) {
    btnResp.addEventListener('click', (e) => {
      e.preventDefault(); e.stopPropagation();
      if (state.player.morto) state.player.respawnar();
    });
  }

  // Pause menu botões
  document.querySelectorAll('.pause-btn').forEach(btn => {
    btn.onclick = () => {
      const a = btn.dataset.action;
      if (a === 'voltar') state.ui.esconderPause();
      else if (a === 'salvar') Save.salvar();
      else if (a === 'modo') { alternarModo(); state.ui.esconderPause(); }
      else if (a === 'sair') {
        Save.salvar();
        state.ui.esconderPause();
        document.getElementById('hud').classList.add('hidden');
        document.getElementById('boot').style.display = 'flex';
        try { state.player.controls.unlock(); } catch (_) {}
      }
    };
  });
  // Quality selector
  const refreshQualityUI = () => {
    const pref = carregarPreferencia();
    const cur = state.quality?.tier;
    document.querySelectorAll('.quality-btn').forEach(b => {
      b.classList.toggle('active', b.dataset.quality === pref);
    });
    const info = document.getElementById('pause-quality-info');
    if (info) {
      const det = detectarTier();
      info.textContent = pref === 'auto'
        ? `Auto: ${cur} (detectado: ${det.tier}, ${det.info.gpuInfo.slice(0, 32)})`
        : `Fixo em ${cur}`;
    }
  };
  document.querySelectorAll('.quality-btn').forEach(btn => {
    btn.onclick = () => {
      const q = btn.dataset.quality;
      salvarPreferencia(q);
      const tier = q === 'auto' ? detectarTier().tier : q;
      aplicarTier(tier);
      state.ui.toast(`Qualidade: ${q === 'auto' ? `auto (${tier})` : tier}`);
      refreshQualityUI();
    };
  });
  // Atualiza UI sempre que pause é mostrado
  const observer = new MutationObserver(refreshQualityUI);
  const pauseEl = document.getElementById('pause-menu');
  if (pauseEl) observer.observe(pauseEl, { attributes: true, attributeFilter: ['class'] });
  refreshQualityUI();

  // === Settings sliders (FOV, mouse sens, volume) ===
  // Persistidos em localStorage. Aplicados em runtime na movimentação.
  const settings = (() => {
    try { return JSON.parse(localStorage.getItem('rebcm3d_settings_v1') || '{}'); }
    catch (_) { return {}; }
  })();
  const saveSettings = () => {
    try { localStorage.setItem('rebcm3d_settings_v1', JSON.stringify(settings)); } catch (_) {}
  };
  const fovEl = document.getElementById('set-fov');
  const fovVal = document.getElementById('set-fov-val');
  const sensEl = document.getElementById('set-sens');
  const sensVal = document.getElementById('set-sens-val');
  const volEl = document.getElementById('set-vol');
  const volVal = document.getElementById('set-vol-val');
  // Aplica estado salvo
  if (settings.fov)  { fovEl.value = settings.fov; }
  if (settings.sens) { sensEl.value = settings.sens; }
  if (settings.vol !== undefined) { volEl.value = settings.vol; }
  const applyFov = () => {
    const fov = parseInt(fovEl.value);
    fovVal.textContent = fov;
    settings.fov = fov;
    if (state.renderer?.camera) {
      state.renderer.camera.fov = fov;
      state.renderer.camera.updateProjectionMatrix();
      state.renderer.fovBase = fov; // pra atualizarFOV não sobrescrever
    }
    saveSettings();
  };
  const applySens = () => {
    const v = parseInt(sensEl.value);
    sensVal.textContent = (v / 10).toFixed(1);
    settings.sens = v;
    // PointerLockControls usa pointerSpeed (default 1). Mapeia 5..60 → 0.3..3.5
    if (state.player?.controls) {
      state.player.controls.pointerSpeed = v / 18;
    }
    saveSettings();
  };
  const applyVol = () => {
    const v = parseInt(volEl.value);
    volVal.textContent = `${v}%`;
    settings.vol = v;
    if (window.rebcm?.setMasterVolume) window.rebcm.setMasterVolume(v / 100);
    saveSettings();
  };
  fovEl.addEventListener('input', applyFov);
  sensEl.addEventListener('input', applySens);
  volEl.addEventListener('input', applyVol);
  // Aplica os valores iniciais
  setTimeout(() => { applyFov(); applySens(); applyVol(); }, 100);

  // Abas + busca do criativo
  document.querySelectorAll('.criativo-aba').forEach(aba => {
    aba.onclick = () => {
      document.querySelectorAll('.criativo-aba').forEach(a => a.classList.remove('ativa'));
      aba.classList.add('ativa');
      state.ui.criativoAbaAtual = aba.dataset.aba;
      state.ui.renderCriativo();
    };
  });
  const buscaEl = document.getElementById('criativo-busca');
  if (buscaEl) {
    buscaEl.addEventListener('input', (e) => {
      state.ui.criativoFiltro = e.target.value;
      state.ui.renderCriativo();
    });
  }

  // Pointer lock event
  document.addEventListener('pointerlockchange', () => {
    const locked = document.pointerLockElement === document.body;
    document.getElementById('game').style.cursor = locked ? 'none' : 'crosshair';
  });
}

export function setupTouchControls() {
  if (!isTouchDevice) return;
  const tc = document.getElementById('touch-controls');
  tc.classList.remove('hidden');
  if (state.renderer?.maoGroup) state.renderer.maoGroup.visible = false;

  // Joystick
  const joy = document.getElementById('touch-joy');
  const joyBase = joy.querySelector('.joy-base');
  const joyKnob = joy.querySelector('.joy-knob');
  let joyTouchId = null, joyCx = 0, joyCy = 0;
  const joyMaxR = 50;
  function joyAtualizar(x, y) {
    let dx = x - joyCx, dy = y - joyCy;
    const dist = Math.hypot(dx, dy);
    if (dist > joyMaxR) { dx = dx / dist * joyMaxR; dy = dy / dist * joyMaxR; }
    joyKnob.style.transform = `translate(calc(-50% + ${dx}px), calc(-50% + ${dy}px))`;
    state.player.input.fwd  = -dy / joyMaxR;
    state.player.input.side =  dx / joyMaxR;
    state.player.input.sprint = dist > joyMaxR * 0.85;
  }
  function joyResetar() {
    joyKnob.style.transform = 'translate(-50%, -50%)';
    joyKnob.classList.remove('ativo');
    state.player.input.fwd = 0;
    state.player.input.side = 0;
    state.player.input.sprint = false;
    joyTouchId = null;
  }
  joy.addEventListener('touchstart', (e) => {
    e.preventDefault();
    if (joyTouchId !== null) return;
    const t = e.changedTouches[0];
    joyTouchId = t.identifier;
    const r = joyBase.getBoundingClientRect();
    joyCx = r.left + r.width / 2;
    joyCy = r.top + r.height / 2;
    joyKnob.classList.add('ativo');
    joyAtualizar(t.clientX, t.clientY);
  }, { passive: false });
  document.addEventListener('touchmove', (e) => {
    if (joyTouchId === null) return;
    for (const t of e.changedTouches) {
      if (t.identifier === joyTouchId) { joyAtualizar(t.clientX, t.clientY); return; }
    }
  }, { passive: false });
  const joyEnd = (e) => {
    for (const t of e.changedTouches) {
      if (t.identifier === joyTouchId) { joyResetar(); return; }
    }
  };
  document.addEventListener('touchend',   joyEnd);
  document.addEventListener('touchcancel', joyEnd);

  // Look (drag)
  const lookZone = document.getElementById('touch-look');
  let lookTouchId = null, lookLastX = 0, lookLastY = 0;
  const lookSens = 0.0035;
  const _euler = new THREE.Euler(0, 0, 0, 'YXZ');
  lookZone.addEventListener('touchstart', (e) => {
    e.preventDefault();
    if (lookTouchId !== null) return;
    const t = e.changedTouches[0];
    lookTouchId = t.identifier;
    lookLastX = t.clientX; lookLastY = t.clientY;
  }, { passive: false });
  lookZone.addEventListener('touchmove', (e) => {
    e.preventDefault();
    if (lookTouchId === null) return;
    for (const t of e.changedTouches) {
      if (t.identifier !== lookTouchId) continue;
      const dx = t.clientX - lookLastX;
      const dy = t.clientY - lookLastY;
      lookLastX = t.clientX; lookLastY = t.clientY;
      _euler.setFromQuaternion(state.renderer.camera.quaternion);
      _euler.y -= dx * lookSens;
      _euler.x -= dy * lookSens;
      const lim = Math.PI / 2 - 0.05;
      _euler.x = Math.max(-lim, Math.min(lim, _euler.x));
      state.renderer.camera.quaternion.setFromEuler(_euler);
    }
  }, { passive: false });
  const lookEnd = (e) => {
    for (const t of e.changedTouches) {
      if (t.identifier === lookTouchId) { lookTouchId = null; return; }
    }
  };
  document.addEventListener('touchend',   lookEnd);
  document.addEventListener('touchcancel', lookEnd);

  // Botões touch
  const btn = (id, ondown, onup) => {
    const el = document.querySelector(`.t-btn[data-action="${id}"]`);
    if (!el) return;
    const bDown = (e) => { e.preventDefault(); el.classList.add('pressionado'); ondown && ondown(); };
    const bUp   = (e) => { e.preventDefault(); el.classList.remove('pressionado'); onup && onup(); };
    el.addEventListener('touchstart', bDown, { passive: false });
    el.addEventListener('touchend',   bUp,   { passive: false });
    el.addEventListener('touchcancel', bUp,  { passive: false });
    el.addEventListener('mousedown', bDown);
    el.addEventListener('mouseup',   bUp);
    el.addEventListener('mouseleave', bUp);
  };
  btn('jump',   () => {
    const p = state.player;
    p.input.up = 1; p.input.jump = true;
    if (p._elytraEquipada && !p.noChao) p._fireworkTrigger = true;
  }, () => { state.player.input.up = 0; });
  btn('down',   () => { if (state.player.modo === 'creative') state.player.input.up = -1; },
                () => { if (state.player.modo === 'creative') state.player.input.up = 0; });
  btn('break',  () => { state.player.holdE = true; },
                () => { state.player.holdE = false; state.player.progressoQuebra = 0; state.player.alvoQuebra = null; });
  btn('place',  () => { state.player.cliqueD = true; });
  btn('attack', () => { _actions?.atacarMob(); });

  // Esconde botão "down" em sobrevivência
  setInterval(() => {
    const down = document.querySelector('.t-btn[data-action="down"]');
    if (down) down.style.display = state.player.modo === 'creative' ? 'flex' : 'none';
  }, 500);
}
