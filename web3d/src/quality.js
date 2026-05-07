// =====================================================================
// quality.js — Sistema adaptativo de qualidade gráfica.
//
// 1. Detecta capacidade do dispositivo (RAM, CPU, GPU, mobile).
// 2. Aplica preset (low/medium/high/ultra) ao renderer + budgets de
//    chunk + max mobs + partículas + weather.
// 3. Monitora FPS continuamente: se cair por 5s, baixa tier; se subir
//    estável por 30s, sobe tier (até o teto preferido pelo usuário).
// 4. Permite override manual via UI (salvo em localStorage).
// =====================================================================

import { state } from './state.js';

const STORAGE_KEY = 'rebcm3d_quality_v1';

// Presets ordenados por carga crescente. Cada nível ~30-60% mais pesado
// que o anterior. View radius é o que mais impacta GPU + memória.
export const PRESETS = {
  low:    { viewRadius: 4,  pixelRatio: 1.0, antialias: false, maxMobs: 8,  maxParticles: 60,  chunkLoadBudget: 1, chunkMeshBudget: 2, enableSnow: false, enableEmissive: false, fovBase: 70 },
  medium: { viewRadius: 6,  pixelRatio: 1.5, antialias: true,  maxMobs: 14, maxParticles: 120, chunkLoadBudget: 2, chunkMeshBudget: 3, enableSnow: true,  enableEmissive: true,  fovBase: 70 },
  high:   { viewRadius: 8,  pixelRatio: 2.0, antialias: true,  maxMobs: 20, maxParticles: 250, chunkLoadBudget: 3, chunkMeshBudget: 5, enableSnow: true,  enableEmissive: true,  fovBase: 75 },
  ultra:  { viewRadius: 10, pixelRatio: 4.0, antialias: true,  maxMobs: 30, maxParticles: 500, chunkLoadBudget: 4, chunkMeshBudget: 7, enableSnow: true,  enableEmissive: true,  fovBase: 75 },
};

const ORDEM = ['low', 'medium', 'high', 'ultra'];

// Detecta tier baseado em mobile, RAM, CPU, GPU.
// Score 1-12: <5=low, 5-7=medium, 8-9=high, 10+=ultra.
export function detectarTier() {
  const ua = navigator.userAgent || '';
  const isMobile = /Mobi|Android|iPhone|iPad|Tablet/i.test(ua);
  const mem = navigator.deviceMemory || (isMobile ? 2 : 4);
  const cpu = navigator.hardwareConcurrency || (isMobile ? 4 : 4);
  // GPU via WebGL UNMASKED_RENDERER_WEBGL
  let gpuInfo = '';
  try {
    const cnv = document.createElement('canvas');
    const gl = cnv.getContext('webgl2') || cnv.getContext('webgl');
    if (gl) {
      const ext = gl.getExtension('WEBGL_debug_renderer_info');
      if (ext) gpuInfo = String(gl.getParameter(ext.UNMASKED_RENDERER_WEBGL) || '').toLowerCase();
    }
  } catch (_) {}

  let score = 0;
  // RAM (1-4 pts)
  if (mem >= 16) score += 4;
  else if (mem >= 8) score += 3;
  else if (mem >= 4) score += 2;
  else score += 1;
  // CPU cores (1-3 pts)
  if (cpu >= 12) score += 3;
  else if (cpu >= 6) score += 2;
  else score += 1;
  // GPU heuristic (0-3 pts)
  if (/rtx|radeon rx|apple m[1-9]|m[1-9] (pro|max|ultra)/.test(gpuInfo)) score += 3;
  else if (/gtx|radeon|apple/.test(gpuInfo)) score += 2;
  else if (/intel|uhd|iris/.test(gpuInfo)) score += 1;
  else if (/mali|adreno|powervr/.test(gpuInfo)) score += 0;
  else score += 1;
  // Desktop bonus (0-2 pts)
  if (!isMobile) score += 2;

  let tier = 'low';
  if (score >= 10) tier = 'ultra';
  else if (score >= 8) tier = 'high';
  else if (score >= 5) tier = 'medium';

  return { tier, score, info: { isMobile, mem, cpu, gpuInfo: gpuInfo || 'desconhecida' } };
}

// Carrega preferência manual do usuário (ou null = auto)
export function carregarPreferencia() {
  try {
    return localStorage.getItem(STORAGE_KEY) || 'auto';
  } catch (_) { return 'auto'; }
}
export function salvarPreferencia(modo) {
  try { localStorage.setItem(STORAGE_KEY, modo); } catch (_) {}
}

// Aplica um tier (string: 'low'|'medium'|'high'|'ultra'). Atualiza
// state.quality + renderer.setPixelRatio em runtime.
export function aplicarTier(tier) {
  const p = PRESETS[tier] || PRESETS.medium;
  state.quality = { tier, ...p };
  // Renderer pode ainda não existir (chamado pré-init) — ok.
  if (state.renderer?.renderer) {
    state.renderer.renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, p.pixelRatio));
    state.renderer.renderer.setSize(window.innerWidth, window.innerHeight, false);
  }
  state.chunkLoadOrcamento = p.chunkLoadBudget;
  return p;
}

// Inicialização: lê preferência, detecta tier (se auto), aplica.
// Retorna info pra mostrar no toast.
export function inicializar() {
  const det = detectarTier();
  const pref = carregarPreferencia();
  const tier = pref === 'auto' ? det.tier : pref;
  const preset = aplicarTier(tier);
  return { tier, detectado: det.tier, modo: pref, info: det.info, preset };
}

// === Adaptive FPS monitor ===
// Mede FPS médio e baixa tier se ficar abaixo de 30 por 5s contínuos.
// NÃO sobe tier sozinho (só baixa) — evita yo-yo. User pode subir manual.
let _fpsAmostras = [];
let _ultimaTrocaMs = 0;

export function tickFps(dt) {
  if (state.quality?.tier === undefined) return;
  if (carregarPreferencia() !== 'auto') return; // user fixou tier
  const fps = 1 / Math.max(0.001, dt);
  _fpsAmostras.push(fps);
  if (_fpsAmostras.length > 120) _fpsAmostras.shift(); // ~2s @ 60fps
  // Só avalia depois de ter pelo menos 60 amostras (~1s)
  if (_fpsAmostras.length < 60) return;
  // Throttle: 1 troca a cada 8s no máximo
  if (Date.now() - _ultimaTrocaMs < 8000) return;
  const media = _fpsAmostras.reduce((a, b) => a + b, 0) / _fpsAmostras.length;
  const idx = ORDEM.indexOf(state.quality.tier);
  if (media < 28 && idx > 0) {
    const novo = ORDEM[idx - 1];
    aplicarTier(novo);
    _ultimaTrocaMs = Date.now();
    _fpsAmostras = [];
    state.ui?.toast?.(`⚙ Performance baixa — qualidade reduzida para ${novo} (${media.toFixed(0)} fps)`);
  }
}
