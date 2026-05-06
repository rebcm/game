// =====================================================================
// utils.js — Funções utilitárias puras
// =====================================================================

import { BLOCO, BLOCO_INFO, CHUNK_SIZE } from './constants.js';

// === Hashes determinísticos para geração de mundo ===
export function hash2(x, z, salt) {
  let h = ((x | 0) * 73856093) ^ ((z | 0) * 19349663) ^ (salt | 0);
  h = (h ^ (h >>> 13)) >>> 0;
  h = Math.imul(h, 0x5bd1e995) >>> 0;
  h = (h ^ (h >>> 15)) >>> 0;
  return h;
}
export function hash3(x, y, z, salt) {
  return hash2(x * 257 + y, z, salt);
}

// Clamp valor entre lo e hi.
export function clamp(v, lo, hi) {
  return v < lo ? lo : (v > hi ? hi : v);
}

// Chave única por chunk (usada como key no Map de chunks).
export function chunkKey(cx, cz) {
  return ((cx & 0xFFFF) | ((cz & 0xFFFF) << 16)) >>> 0;
}

// Categoria de material — usado para escolher SFX de passo.
export function materialDeBloco(b) {
  switch (b) {
    case BLOCO.GRAMA: case BLOCO.TERRA: return 'grama';
    case BLOCO.PEDRA: case BLOCO.TIJOLO: case BLOCO.OBSIDIANA: case BLOCO.BEDROCK: case BLOCO.CARVAO:
      return 'pedra';
    case BLOCO.MADEIRA: case BLOCO.WORKBENCH: case BLOCO.BAU: case BLOCO.CAMA:
      return 'madeira';
    case BLOCO.AREIA: return 'areia';
    case BLOCO.AGUA:  return 'agua';
    case BLOCO.FOLHA: case BLOCO.LA: return 'folha';
    case BLOCO.NEVE:  return 'neve';
    case BLOCO.OURO: case BLOCO.FERRO: case BLOCO.DIAMANTE: case BLOCO.FORNALHA:
      return 'metal';
    case BLOCO.VIDRO: return 'vidro';
    default: return 'grama';
  }
}

// Tabelas de offsets para Ambient Occlusion por face.
// Index = [face][vertex 0..3] → offset (lx, ly, lz) do vizinho.
export const AO_OFFSETS = [
  // Top (+Y): 4 vértices percorridos no sentido add
  [
    [[-1,1,-1],[0,1,-1],[-1,1,0]],   // v0
    [[1,1,-1],[0,1,-1],[1,1,0]],     // v1
    [[1,1,1],[0,1,1],[1,1,0]],       // v2
    [[-1,1,1],[0,1,1],[-1,1,0]],     // v3
  ],
  // Bottom (-Y)
  [
    [[-1,-1,1],[0,-1,1],[-1,-1,0]],
    [[1,-1,1],[0,-1,1],[1,-1,0]],
    [[1,-1,-1],[0,-1,-1],[1,-1,0]],
    [[-1,-1,-1],[0,-1,-1],[-1,-1,0]],
  ],
  // East (+X)
  [
    [[1,-1,-1],[1,0,-1],[1,-1,0]],
    [[1,-1,1],[1,0,1],[1,-1,0]],
    [[1,1,1],[1,0,1],[1,1,0]],
    [[1,1,-1],[1,0,-1],[1,1,0]],
  ],
  // West (-X)
  [
    [[-1,-1,1],[-1,0,1],[-1,-1,0]],
    [[-1,-1,-1],[-1,0,-1],[-1,-1,0]],
    [[-1,1,-1],[-1,0,-1],[-1,1,0]],
    [[-1,1,1],[-1,0,1],[-1,1,0]],
  ],
  // South (+Z)
  [
    [[1,-1,1],[0,-1,1],[1,0,1]],
    [[-1,-1,1],[0,-1,1],[-1,0,1]],
    [[-1,1,1],[0,1,1],[-1,0,1]],
    [[1,1,1],[0,1,1],[1,0,1]],
  ],
  // North (-Z)
  [
    [[-1,-1,-1],[0,-1,-1],[-1,0,-1]],
    [[1,-1,-1],[0,-1,-1],[1,0,-1]],
    [[1,1,-1],[0,1,-1],[1,0,-1]],
    [[-1,1,-1],[0,1,-1],[-1,0,-1]],
  ],
];

// Calcula o valor de AO (0..3) para um vértice a partir de 3 vizinhos.
// Regras: se 2 dos 3 vizinhos são opacos → AO=0 (canto fechado).
// Se nenhum → AO=3 (sem oclusão). Lerp para os intermediários.
export function vertexAOValor(world, sx, sy, sz, off3) {
  const a = world.isSolido(sx + off3[0][0], sy + off3[0][1], sz + off3[0][2]) ? 1 : 0;
  const b = world.isSolido(sx + off3[1][0], sy + off3[1][1], sz + off3[1][2]) ? 1 : 0;
  const c = world.isSolido(sx + off3[2][0], sy + off3[2][1], sz + off3[2][2]) ? 1 : 0;
  if (a && b) return 0;
  return 3 - (a + b + c);
}

// UV de uma célula no atlas 32×16 (8 colunas × 4 linhas de células).
// O atlas tem 32 células totais (linhas 4 × cols 8).
// Aplica inset de 0.5 pixel para evitar bleed entre células adjacentes.
export function uvCelula(atlas, idx) {
  const col = idx % atlas.cols;
  const row = (idx / atlas.cols) | 0;
  const uw = 1 / atlas.cols;
  const vh = 1 / atlas.rows;
  const inset = 0.0015;
  const u0 = col * uw + inset;
  const u1 = (col + 1) * uw - inset;
  const v0 = 1 - (row + 1) * vh + inset;
  const v1 = 1 - row * vh - inset;
  // Ordem: (u0,v0) (u1,v0) (u1,v1) (u0,v1) — 4 vértices da face
  return [u0, v0, u1, v0, u1, v1, u0, v1];
}
