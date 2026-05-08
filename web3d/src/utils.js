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

// =====================================================================
// Perlin Noise 2D + 3D (paridade Minecraft real para terreno orgânico)
//
// Implementação clássica de Ken Perlin. Determinística por seed via
// permutação e tabela de gradientes hashados. fade(t) = 6t⁵-15t⁴+10t³.
// =====================================================================

// Tabela de permutação (Ken Perlin original, 1983) duplicada para wrap.
const PERM_BASE = [
  151,160,137,91,90,15,131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,
  8,99,37,240,21,10,23,190,6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,
  35,11,32,57,177,33,88,237,149,56,87,174,20,125,136,171,168,68,175,74,165,71,
  134,139,48,27,166,77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,
  55,46,245,40,244,102,143,54,65,25,63,161,1,216,80,73,209,76,132,187,208,89,
  18,169,200,196,135,130,116,188,159,86,164,100,109,198,173,186,3,64,52,217,
  226,250,124,123,5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,
  17,182,189,28,42,223,183,170,213,119,248,152,2,44,154,163,70,221,153,101,155,
  167,43,172,9,129,22,39,253,19,98,108,110,79,113,224,232,178,185,112,104,218,
  246,97,228,251,34,242,193,238,210,144,12,191,179,162,241,81,51,145,235,249,
  14,239,107,49,192,214,31,181,199,106,157,184,84,204,176,115,121,50,45,127,4,
  150,254,138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,
  180,
];
let _perm = null;
let _permSeed = -1;

// Embaralha PERM_BASE com base num seed (Fisher-Yates determinístico).
function _ensurePerm(seed) {
  if (_perm && _permSeed === seed) return _perm;
  _permSeed = seed;
  const p = PERM_BASE.slice();
  let s = (seed | 0) >>> 0;
  for (let i = 255; i > 0; i--) {
    s = Math.imul(s, 1103515245) + 12345 | 0;
    const j = (s >>> 0) % (i + 1);
    const tmp = p[i]; p[i] = p[j]; p[j] = tmp;
  }
  _perm = new Array(512);
  for (let i = 0; i < 512; i++) _perm[i] = p[i & 255];
  return _perm;
}

function _fade(t) { return t * t * t * (t * (t * 6 - 15) + 10); }
function _lerp(a, b, t) { return a + t * (b - a); }
function _grad2(hash, x, y) {
  // 8 direções no plano 2D
  switch (hash & 7) {
    case 0: return  x + y;
    case 1: return -x + y;
    case 2: return  x - y;
    case 3: return -x - y;
    case 4: return  x;
    case 5: return -x;
    case 6: return  y;
    default:return -y;
  }
}
function _grad3(hash, x, y, z) {
  // 12 gradientes 3D do Perlin original
  const h = hash & 15;
  const u = h < 8 ? x : y;
  const v = h < 4 ? y : (h === 12 || h === 14 ? x : z);
  return ((h & 1) === 0 ? u : -u) + ((h & 2) === 0 ? v : -v);
}

// Perlin 2D em range ~[-1, 1].
export function perlin2(x, y, seed = 0) {
  const perm = _ensurePerm(seed);
  const X = Math.floor(x) & 255;
  const Y = Math.floor(y) & 255;
  const xf = x - Math.floor(x);
  const yf = y - Math.floor(y);
  const u = _fade(xf), v = _fade(yf);
  const aa = perm[perm[X] + Y];
  const ab = perm[perm[X] + Y + 1];
  const ba = perm[perm[X + 1] + Y];
  const bb = perm[perm[X + 1] + Y + 1];
  const x1 = _lerp(_grad2(aa, xf, yf),         _grad2(ba, xf - 1, yf),     u);
  const x2 = _lerp(_grad2(ab, xf, yf - 1),     _grad2(bb, xf - 1, yf - 1), u);
  return _lerp(x1, x2, v);
}

// Perlin 3D em range ~[-1, 1]. Útil para cavernas e cloud noise.
export function perlin3(x, y, z, seed = 0) {
  const perm = _ensurePerm(seed);
  const X = Math.floor(x) & 255;
  const Y = Math.floor(y) & 255;
  const Z = Math.floor(z) & 255;
  const xf = x - Math.floor(x);
  const yf = y - Math.floor(y);
  const zf = z - Math.floor(z);
  const u = _fade(xf), v = _fade(yf), w = _fade(zf);
  const A  = perm[X]     + Y;
  const AA = perm[A]     + Z;
  const AB = perm[A + 1] + Z;
  const B  = perm[X + 1] + Y;
  const BA = perm[B]     + Z;
  const BB = perm[B + 1] + Z;
  const x1 = _lerp(_grad3(perm[AA],     xf,     yf,     zf),
                   _grad3(perm[BA],     xf - 1, yf,     zf), u);
  const x2 = _lerp(_grad3(perm[AB],     xf,     yf - 1, zf),
                   _grad3(perm[BB],     xf - 1, yf - 1, zf), u);
  const y1 = _lerp(x1, x2, v);
  const x3 = _lerp(_grad3(perm[AA + 1], xf,     yf,     zf - 1),
                   _grad3(perm[BA + 1], xf - 1, yf,     zf - 1), u);
  const x4 = _lerp(_grad3(perm[AB + 1], xf,     yf - 1, zf - 1),
                   _grad3(perm[BB + 1], xf - 1, yf - 1, zf - 1), u);
  const y2 = _lerp(x3, x4, v);
  return _lerp(y1, y2, w);
}

// fBM (fractal Brownian motion): soma de N oitavas de Perlin com
// frequência dobrando e amplitude caindo. Dá relevo orgânico em escalas.
export function fbm2(x, y, octaves = 4, lacunarity = 2.0, persistence = 0.5, seed = 0) {
  let total = 0, freq = 1, amp = 1, max = 0;
  for (let i = 0; i < octaves; i++) {
    total += perlin2(x * freq, y * freq, seed) * amp;
    max += amp;
    amp *= persistence;
    freq *= lacunarity;
  }
  return total / max;
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

// === A* pathfinding 2D (top-down) ===
// Acha caminho de (sx, sz) até (gx, gz) num grid horizontal mantendo y
// constante, considerando bloco walkable se há ar em y + ar em y+1 +
// suporte sólido em y-1 (ou y-2 se step-up natural). Limite maxNodes
// pra cap de CPU. Retorna array de {x, z} (path), [] se já no goal,
// null se sem caminho.
export function aStarMob(world, sx, sy, sz, gx, gz, maxNodes = 100) {
  const start = { x: Math.floor(sx), z: Math.floor(sz) };
  const goal  = { x: Math.floor(gx), z: Math.floor(gz) };
  if (start.x === goal.x && start.z === goal.z) return [];
  const startNode = { x: start.x, z: start.z, g: 0, h: 0, parent: null };
  const open = [startNode];
  const closed = new Set();
  const best = new Map();
  best.set(`${start.x},${start.z}`, startNode);
  let nodes = 0;
  const walkable = (nx, nz) => {
    // Suporte sólido em y-1 (ou y-2 = jump-down 1 bloco), ar em y e y+1
    if (world.isSolido(nx, sy + 1, nz)) return false; // cabeça obstruída
    if (world.isSolido(nx, sy, nz)) {
      // step up de 1: ok se ar em sy+1 e sy+2
      if (world.isSolido(nx, sy + 2, nz)) return false;
      return true;
    }
    if (world.isSolido(nx, sy - 1, nz)) return true;        // mesmo nível
    if (world.isSolido(nx, sy - 2, nz)) return true;        // jump-down 1
    return false;
  };
  while (open.length > 0 && nodes < maxNodes) {
    // Pega menor f = g + h (sort caro mas nodes é pequeno)
    let bestIdx = 0;
    for (let i = 1; i < open.length; i++) {
      if ((open[i].g + open[i].h) < (open[bestIdx].g + open[bestIdx].h)) bestIdx = i;
    }
    const cur = open.splice(bestIdx, 1)[0];
    nodes++;
    if (cur.x === goal.x && cur.z === goal.z) {
      const path = [];
      let n = cur;
      while (n.parent) { path.unshift({ x: n.x, z: n.z }); n = n.parent; }
      return path;
    }
    closed.add(`${cur.x},${cur.z}`);
    for (const [dx, dz] of [[1,0],[-1,0],[0,1],[0,-1]]) {
      const nx = cur.x + dx, nz = cur.z + dz;
      const k = `${nx},${nz}`;
      if (closed.has(k)) continue;
      if (!walkable(nx, nz)) continue;
      const g = cur.g + 1;
      const h = Math.abs(nx - goal.x) + Math.abs(nz - goal.z);
      const ex = best.get(k);
      if (ex && ex.g <= g) continue;
      const node = { x: nx, z: nz, g, h, parent: cur };
      best.set(k, node);
      open.push(node);
    }
  }
  return null;
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
