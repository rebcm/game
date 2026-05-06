// =====================================================================
// weather.js — Sistema de clima: chuva (e nevasca em biomas frios)
//
// Estado em state.weather: 'clear' | 'rain'.
// A cada N segundos sorteia mudança. Chuva spawna 80–150 gotinhas
// caindo num cubo ao redor do player + ruído ambient + raros trovões.
// =====================================================================

import * as THREE from 'three';
import { state } from './state.js';
import { Audio } from './audio.js';
import { BLOCO } from './constants.js';

// Estado de clima persistido em state.
function _initEstado() {
  if (state.weather === undefined) state.weather = 'clear';
  if (state.weatherTimer === undefined) state.weatherTimer = 60 + Math.random() * 120;
  if (state.chuvaAcc === undefined) state.chuvaAcc = 0;
  if (state.trovaoAcc === undefined) state.trovaoAcc = 0;
}

let _rainGroup = null;        // THREE.Group com partículas de chuva
let _rainGotas = [];          // referências individuais para reuso
let _rainMatCache = null;

function _criarMaterialChuva() {
  if (_rainMatCache) return _rainMatCache;
  _rainMatCache = new THREE.MeshBasicMaterial({
    color: 0x6699cc,
    transparent: true,
    opacity: 0.55,
    depthWrite: false,
  });
  return _rainMatCache;
}

function _ensureRainGroup(scene) {
  if (_rainGroup) return _rainGroup;
  _rainGroup = new THREE.Group();
  // Pre-spawn de N=120 gotinhas reaproveitáveis. Cada uma é um plano
  // pequeno semi-transparente; reusamos posição em vez de recriar.
  const N = 120;
  const geo = new THREE.BoxGeometry(0.04, 0.4, 0.04);
  const mat = _criarMaterialChuva();
  for (let i = 0; i < N; i++) {
    const m = new THREE.Mesh(geo, mat);
    m.visible = false;
    _rainGroup.add(m);
    _rainGotas.push({ mesh: m, vy: -22 });
  }
  scene.add(_rainGroup);
  return _rainGroup;
}

function _resetGota(gota, playerPos) {
  // Spawn 8m acima do player, dentro de raio 14m horizontal.
  const ang = Math.random() * Math.PI * 2;
  const r = Math.random() * 14;
  gota.mesh.position.set(
    playerPos.x + Math.cos(ang) * r,
    playerPos.y + 8 + Math.random() * 4,
    playerPos.z + Math.sin(ang) * r,
  );
  gota.vy = -22 - Math.random() * 4;
  gota.mesh.visible = true;
}

// Atualiza chuva visual: move gotas, recicla ao bater no chão.
function _atualizarChuva(dt) {
  if (!state.player || !state.world) return;
  for (const g of _rainGotas) {
    if (!g.mesh.visible) {
      _resetGota(g, state.player.pos);
      continue;
    }
    g.mesh.position.y += g.vy * dt;
    // Reseta quando passa do chão ou muito longe do player
    const dx = g.mesh.position.x - state.player.pos.x;
    const dz = g.mesh.position.z - state.player.pos.z;
    if (g.mesh.position.y < state.player.pos.y - 4 || dx*dx + dz*dz > 196) {
      _resetGota(g, state.player.pos);
    }
  }
}

function _esconderChuva() {
  if (!_rainGroup) return;
  for (const g of _rainGotas) g.mesh.visible = false;
}

// === API pública ===

// Tenta mudar o clima. Chamada a cada frame; ignora se timer não venceu.
export function atualizarClima(dt) {
  _initEstado();
  if (!state.renderer) return;
  state.weatherTimer -= dt;
  if (state.weatherTimer <= 0) {
    // 70% clear, 30% rain (paridade Minecraft cycles ~5–60 min)
    state.weather = Math.random() < 0.30 ? 'rain' : 'clear';
    state.weatherTimer = state.weather === 'rain'
      ? 60 + Math.random() * 90    // 1–2.5 min de chuva
      : 180 + Math.random() * 240; // 3–7 min de céu limpo
    if (state.weather === 'rain') {
      state.ui?.toast('🌧 Começou a chover');
      state.ui?.subtitle('Chuva começou');
    } else {
      state.ui?.toast('☀ A chuva passou');
    }
  }
  if (state.weather === 'rain') {
    _ensureRainGroup(state.renderer.scene);
    _atualizarChuva(dt);
    // Ruído ambient da chuva
    state.chuvaAcc += dt;
    if (state.chuvaAcc >= 1.6) { state.chuvaAcc = 0; Audio.chuva(); }
    // Trovão raro
    state.trovaoAcc += dt;
    if (state.trovaoAcc >= 25) {
      state.trovaoAcc = 0;
      if (Math.random() < 0.20) {
        Audio.trovao();
        state.ui?.subtitle('⚡ Trovão distante');
      }
    }
  } else {
    _esconderChuva();
  }
}

// Modula nuvens/sky baseado no clima.
// Chamado por render.atualizarCeu.
export function corCeuComClima(cor, sun) {
  _initEstado();
  if (state.weather !== 'rain') return cor;
  // Tinge o céu mais cinza/escuro durante a chuva
  const cinza = new THREE.Color(0x6f7f8a);
  return cor.clone().lerp(cinza, 0.55);
}
