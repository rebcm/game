// =====================================================================
// multiplayer.js — Multiplayer LOCAL via BroadcastChannel.
//
// Funciona entre abas/janelas do mesmo navegador (mesma origem). Cada
// instância publica posição/nome a 5Hz; recebe broadcasts de outras
// abas e renderiza um cubo "ghost" pra cada player visível.
//
// Limitações conhecidas:
// - Só mesma origem (mesma URL/aba).
// - NÃO sincroniza chunks/blocos quebrados (apenas posição visual).
// - Pra cross-device real precisa Sprint 8.5 (WebSocket Worker + WebRTC).
// =====================================================================

import * as THREE from 'three';
import { state } from './state.js';

const CANAL = 'rebcm3d-multiplayer-v1';
const TICK_MS = 200;        // broadcast a cada 200ms (5 Hz)
const TIMEOUT_MS = 5000;    // ghost some se não receber por 5s

// Worker URL pra modo online (cross-device). null = só local.
const WS_URL_DEFAULT = 'wss://construcao-criativa-mp.rebcm-mp.workers.dev/ws';
const WS_STORAGE_KEY = 'rebcm3d_mp_room';

let ch = null;          // BroadcastChannel (local — mesmo browser)
let ws = null;          // WebSocket (online — cross-device)
let wsRoom = null;
let meuId = null;
const ghosts = new Map(); // playerId -> { mesh, label, name, lastSeen, x, y, z, rot }

function _gerarId() {
  return Math.random().toString(36).slice(2, 10);
}

function _criarGhost(scene, name, cor) {
  const grp = new THREE.Group();
  // Corpo principal cor única (hash do nome)
  const corpo = new THREE.Mesh(
    new THREE.BoxGeometry(0.6, 1.7, 0.4),
    new THREE.MeshLambertMaterial({ color: cor }),
  );
  corpo.position.y = 0.85;
  grp.add(corpo);
  // Cabeça
  const cabeca = new THREE.Mesh(
    new THREE.BoxGeometry(0.5, 0.5, 0.5),
    new THREE.MeshLambertMaterial({ color: 0xffe0b2 }),
  );
  cabeca.position.y = 1.95;
  grp.add(cabeca);
  // Olhos brancos
  const escleraMat = new THREE.MeshLambertMaterial({ color: 0xffffff });
  const pupMat = new THREE.MeshLambertMaterial({ color: 0x000000 });
  for (const sx of [-0.10, 0.10]) {
    const escl = new THREE.Mesh(new THREE.BoxGeometry(0.08, 0.08, 0.02), escleraMat);
    escl.position.set(sx, 1.98, 0.255); grp.add(escl);
    const pup = new THREE.Mesh(new THREE.BoxGeometry(0.04, 0.04, 0.025), pupMat);
    pup.position.set(sx, 1.98, 0.265); grp.add(pup);
  }
  scene.add(grp);
  // Nome flutuante via canvas → sprite
  const cnv = document.createElement('canvas');
  cnv.width = 256; cnv.height = 64;
  const ctx = cnv.getContext('2d');
  ctx.font = 'bold 28px monospace';
  ctx.textAlign = 'center';
  ctx.fillStyle = 'rgba(0,0,0,0.65)';
  ctx.fillRect(0, 0, 256, 64);
  ctx.fillStyle = '#fff';
  ctx.fillText(name, 128, 42);
  const tex = new THREE.CanvasTexture(cnv);
  const labelMat = new THREE.SpriteMaterial({ map: tex, depthTest: false });
  const label = new THREE.Sprite(labelMat);
  label.scale.set(1.2, 0.30, 1);
  label.position.y = 2.5;
  grp.add(label);
  return { mesh: grp, label };
}

function _hashCor(name) {
  let h = 5381;
  for (const c of name) h = ((h * 33) ^ c.charCodeAt(0)) >>> 0;
  return (h & 0xFFFFFF) | 0x808080; // garante cor não muito escura
}

export const Multiplayer = {
  iniciado: false,
  iniciar() {
    if (this.iniciado) return;
    if (typeof BroadcastChannel === 'undefined') {
      console.warn('[mp] BroadcastChannel não suportado — sem multiplayer local');
      return;
    }
    this.iniciado = true;
    meuId = _gerarId();
    ch = new BroadcastChannel(CANAL);
    ch.onmessage = (ev) => this._onMsg(ev.data);
    // Anuncia presença + tick periódico
    setInterval(() => this._broadcast(), TICK_MS);
    // Cleanup periódico de ghosts inativos
    setInterval(() => this._cleanup(), 1000);
    console.log(`[mp] iniciado id=${meuId}`);
    // Auto-reconnect se havia room online salva
    try {
      const saved = localStorage.getItem(WS_STORAGE_KEY);
      if (saved) setTimeout(() => this.conectarOnline(saved), 1500);
    } catch (_) {}
  },
  _broadcast() {
    if (!state.player) return;
    const msg = {
      tipo: 'pos',
      id: meuId,
      name: state.playerName || 'Aventureiro',
      mundo: state.worldName || '',
      x: state.player.pos.x,
      y: state.player.pos.y,
      z: state.player.pos.z,
      rot: state.renderer?.camera?.rotation?.y || 0,
      ts: Date.now(),
    };
    // Local (BroadcastChannel — mesmo browser)
    if (ch) ch.postMessage(msg);
    // Online (WebSocket — cross-device)
    if (ws && ws.readyState === WebSocket.OPEN) {
      try { ws.send(JSON.stringify(msg)); } catch (_) {}
    }
  },

  // Conecta a uma room online (WebSocket Worker). Persiste em localStorage.
  conectarOnline(roomName, urlBase) {
    if (!roomName) return false;
    if (ws) try { ws.close(); } catch (_) {}
    const url = (urlBase || WS_URL_DEFAULT) + '?room=' + encodeURIComponent(roomName);
    try {
      ws = new WebSocket(url);
    } catch (e) {
      console.error('[mp] WS error', e);
      return false;
    }
    wsRoom = roomName;
    try { localStorage.setItem(WS_STORAGE_KEY, roomName); } catch (_) {}
    ws.onopen = () => {
      state.ui?.toast?.(`🌐 Conectado à sala "${roomName}"`);
    };
    ws.onmessage = (ev) => {
      try { this._onMsg(JSON.parse(ev.data)); } catch (_) {}
    };
    ws.onclose = () => {
      ws = null; wsRoom = null;
      state.ui?.toast?.('🌐 Desconectado da sala');
    };
    ws.onerror = () => {
      state.ui?.toast?.('⚠ Erro ao conectar à sala (servidor pode estar inativo)');
    };
    return true;
  },
  desconectarOnline() {
    if (ws) try { ws.close(); } catch (_) {}
    try { localStorage.removeItem(WS_STORAGE_KEY); } catch (_) {}
  },
  isOnline() { return ws && ws.readyState === WebSocket.OPEN; },
  roomAtual() { return wsRoom; },
  _onMsg(msg) {
    if (!msg || !msg.id || msg.id === meuId) return;
    if (msg.tipo === 'pos') {
      let g = ghosts.get(msg.id);
      if (!g) {
        const cor = _hashCor(msg.name || msg.id);
        const made = _criarGhost(state.renderer.scene, msg.name || '?', cor);
        g = { ...made, name: msg.name, lastSeen: Date.now(), x: msg.x, y: msg.y, z: msg.z, rot: msg.rot };
        ghosts.set(msg.id, g);
        state.ui?.toast?.(`👤 ${msg.name} entrou`);
      }
      g.x = msg.x; g.y = msg.y; g.z = msg.z; g.rot = msg.rot;
      g.lastSeen = Date.now();
    }
  },
  // Tickado do main loop pra atualizar mesh dos ghosts (lerp suave)
  atualizar(dt) {
    if (!this.iniciado) return;
    for (const g of ghosts.values()) {
      // Lerp posição (suaviza jitter de rede)
      const k = Math.min(1, dt * 8);
      g.mesh.position.x += (g.x - g.mesh.position.x) * k;
      g.mesh.position.y += (g.y - 0.85 - g.mesh.position.y) * k; // y ajustado pra base do mesh
      g.mesh.position.z += (g.z - g.mesh.position.z) * k;
      g.mesh.rotation.y = -g.rot - Math.PI / 2;
    }
  },
  _cleanup() {
    const agora = Date.now();
    for (const [id, g] of ghosts) {
      if (agora - g.lastSeen > TIMEOUT_MS) {
        state.renderer.scene.remove(g.mesh);
        g.mesh.traverse((c) => {
          if (c.geometry) c.geometry.dispose();
          if (c.material) {
            if (c.material.map) c.material.map.dispose();
            c.material.dispose();
          }
        });
        ghosts.delete(id);
        state.ui?.toast?.(`👤 ${g.name} saiu`);
      }
    }
  },
  jogadoresOnline() { return ghosts.size; },
};
