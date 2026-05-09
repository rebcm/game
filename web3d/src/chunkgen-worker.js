// =====================================================================
// chunkgen-worker.js — Worker dedicado pra geração de chunks (terreno
// base + minérios + cavernas + árvores + cactos).
//
// Roda fora da main thread → não causa stutter durante exploração.
// Self-contained: duplica Perlin/hash/constantes pra evitar imports
// (workers em alguns browsers ainda têm restrições de import).
//
// Post-processing (dungeons, vilas, ravinas, icebergs) fica na main
// thread porque envolve world.bauTesouros / spawn deferido de mobs.
// =====================================================================

// ===== Constantes (devem bater com constants.js) =====
const CHUNK_SIZE = 16;
const WORLD_Y = 64;
const NIVEL_AGUA = 8;

const BLOCO = {
  AR: 0, GRAMA: 1, TERRA: 2, PEDRA: 3, AREIA: 4, MADEIRA: 5, FOLHA: 6,
  TIJOLO: 7, VIDRO: 8, OURO: 9, DIAMANTE: 10, LUZ: 11, NEVE: 12,
  CARVAO: 13, FERRO: 14, CACTO: 15, AGUA: 16, LAVA: 17, OBSIDIANA: 18,
  WORKBENCH: 19, LA: 20, TOCHA: 21, BAU: 22, FORNALHA: 23, CAMA: 24,
  BEDROCK: 25,
  COBRE_MINERIO: 72,
  GRANITO: 76, DIORITO: 77, ANDESITO: 78,
};

// ===== Hashes (idem utils.js) =====
function hash2(x, z, salt) {
  let h = ((x | 0) * 73856093) ^ ((z | 0) * 19349663) ^ (salt | 0);
  h = (h ^ (h >>> 13)) >>> 0;
  h = Math.imul(h, 0x5bd1e995) >>> 0;
  h = (h ^ (h >>> 15)) >>> 0;
  return h;
}
function hash3(x, y, z, salt) { return hash2(x * 257 + y, z, salt); }

// ===== Perlin noise (idem utils.js) =====
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
let _perm = null, _permSeed = -1;
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
function _grad2(h, x, y) {
  switch (h & 7) {
    case 0: return  x + y; case 1: return -x + y;
    case 2: return  x - y; case 3: return -x - y;
    case 4: return  x;     case 5: return -x;
    case 6: return  y;     default: return -y;
  }
}
function _grad3(h, x, y, z) {
  const k = h & 15;
  const u = k < 8 ? x : y;
  const v = k < 4 ? y : (k === 12 || k === 14 ? x : z);
  return ((k & 1) === 0 ? u : -u) + ((k & 2) === 0 ? v : -v);
}
function perlin2(x, y, seed) {
  const perm = _ensurePerm(seed);
  const X = Math.floor(x) & 255, Y = Math.floor(y) & 255;
  const xf = x - Math.floor(x), yf = y - Math.floor(y);
  const u = _fade(xf), v = _fade(yf);
  const aa = perm[perm[X] + Y];
  const ab = perm[perm[X] + Y + 1];
  const ba = perm[perm[X + 1] + Y];
  const bb = perm[perm[X + 1] + Y + 1];
  const x1 = _lerp(_grad2(aa, xf, yf),     _grad2(ba, xf - 1, yf),     u);
  const x2 = _lerp(_grad2(ab, xf, yf - 1), _grad2(bb, xf - 1, yf - 1), u);
  return _lerp(x1, x2, v);
}
function perlin3(x, y, z, seed) {
  const perm = _ensurePerm(seed);
  const X = Math.floor(x) & 255, Y = Math.floor(y) & 255, Z = Math.floor(z) & 255;
  const xf = x - Math.floor(x), yf = y - Math.floor(y), zf = z - Math.floor(z);
  const u = _fade(xf), v = _fade(yf), w = _fade(zf);
  const A = perm[X] + Y, AA = perm[A] + Z, AB = perm[A + 1] + Z;
  const B = perm[X + 1] + Y, BA = perm[B] + Z, BB = perm[B + 1] + Z;
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
function fbm2(x, y, octaves, lacunarity, persistence, seed) {
  let total = 0, freq = 1, amp = 1, max = 0;
  for (let i = 0; i < octaves; i++) {
    total += perlin2(x * freq, y * freq, seed) * amp;
    max += amp; amp *= persistence; freq *= lacunarity;
  }
  return total / max;
}
function clamp(v, lo, hi) { return v < lo ? lo : (v > hi ? hi : v); }

// ===== Geração (idem world.js gerarChunk, mas standalone) =====
function alturaTerreno(x, z, seed) {
  const v = fbm2(x / 64, z / 64, 4, 2.0, 0.5, seed);
  const n = (v + 1) * 0.5;
  return clamp(20 + Math.floor(n * 22), 2, WORLD_Y - 8);
}
function biomaEm(x, z, seed) {
  if (alturaTerreno(x, z, seed) >= 38) return 'taiga';
  const temp = perlin2(x / 220, z / 220, seed ^ 0x7E11);
  const umid = perlin2(x / 180, z / 180, seed ^ 0x9999);
  if (temp > 0.25) return umid < -0.10 ? 'deserto' : 'planicies';
  return umid > 0.10 ? 'floresta' : 'taiga';
}
function topoBioma(x, z, h, seed) {
  const b = biomaEm(x, z, seed);
  if (b === 'deserto') return BLOCO.AREIA;
  if (b === 'taiga')   return BLOCO.NEVE;
  return BLOCO.GRAMA;
}
function caverna(x, y, z, seed) {
  if (y <= 4 || y >= WORLD_Y - 4) return false;
  return perlin3(x / 18, y / 14, z / 18, seed ^ 0xCAFE) > 0.58;
}

function gerarChunkBase(cx, cz, seed) {
  const idx = (lx, y, lz) => y * CHUNK_SIZE * CHUNK_SIZE + lx * CHUNK_SIZE + lz;
  const blocks = new Uint8Array(CHUNK_SIZE * CHUNK_SIZE * WORLD_Y);
  // 1. Terreno + minérios
  for (let lx = 0; lx < CHUNK_SIZE; lx++) {
    for (let lz = 0; lz < CHUNK_SIZE; lz++) {
      const gx = cx * CHUNK_SIZE + lx, gz = cz * CHUNK_SIZE + lz;
      const h = alturaTerreno(gx, gz, seed);
      for (let y = 0; y <= Math.max(h, NIVEL_AGUA); y++) {
        let b;
        if (y <= 2) b = BLOCO.BEDROCK;
        else if (y <= 4) {
          const hh = hash2(gx, gz + y * 31, seed ^ 0xfee10) & 0xFF;
          b = hh < 14 ? BLOCO.LAVA : BLOCO.PEDRA;
        } else if (y > h && y <= NIVEL_AGUA) {
          b = BLOCO.AGUA;
        } else if (y > h) {
          continue;
        } else if (y < h - 3) {
          if (caverna(gx, y, gz, seed)) continue; // ar caverna
          const hh = hash3(gx, y, gz, seed ^ 0xa1b2) & 0xFF;
          if (y < 6 && hh < 3) b = BLOCO.DIAMANTE;
          else if (y < 10 && hh < 6) b = BLOCO.OURO;
          else if (y < 14 && hh < 14) b = BLOCO.FERRO;
          else if (y >= 8 && y <= 30 && hh < 28) b = BLOCO.COBRE_MINERIO;
          else if (hh < 26) b = BLOCO.CARVAO;
          // Variantes naturais de pedra
          else {
            const vh = hash3(gx, y, gz, seed ^ 0x6E33) & 0xFF;
            if (vh < 14) b = BLOCO.GRANITO;
            else if (vh < 28) b = BLOCO.DIORITO;
            else if (vh < 42) b = BLOCO.ANDESITO;
            else b = BLOCO.PEDRA;
          }
        } else if (y < h) {
          b = BLOCO.TERRA;
        } else {
          b = topoBioma(gx, gz, h, seed);
        }
        if (b !== undefined) blocks[idx(lx, y, lz)] = b;
      }
    }
  }
  // 2. Árvores (densidade por bioma)
  for (let lx = 0; lx < CHUNK_SIZE; lx++) {
    for (let lz = 0; lz < CHUNK_SIZE; lz++) {
      const gx = cx * CHUNK_SIZE + lx, gz = cz * CHUNK_SIZE + lz;
      const h = alturaTerreno(gx, gz, seed);
      if (blocks[idx(lx, h, lz)] !== BLOCO.GRAMA) continue;
      const bioma = biomaEm(gx, gz, seed);
      const limiar = bioma === 'floresta' ? 36 : (bioma === 'planicies' ? 8 : 0);
      if (limiar === 0) continue;
      const hh = hash2(gx, gz, seed ^ 0xA75) & 0xFF;
      if (hh > limiar) continue;
      const altura = 4 + (hh & 0x3);
      for (let y = 1; y <= altura; y++) {
        if (h + y < WORLD_Y) blocks[idx(lx, h + y, lz)] = BLOCO.MADEIRA;
      }
      // Copa esférica
      for (let dx = -2; dx <= 2; dx++) {
        for (let dz = -2; dz <= 2; dz++) {
          for (let dy = 0; dy <= 2; dy++) {
            if (dx*dx + dz*dz + dy*dy > 5) continue;
            const fx = lx + dx, fz = lz + dz, fy = h + altura + dy;
            if (fx < 0 || fx >= CHUNK_SIZE || fz < 0 || fz >= CHUNK_SIZE || fy >= WORLD_Y) continue;
            if (blocks[idx(fx, fy, fz)] === BLOCO.AR) blocks[idx(fx, fy, fz)] = BLOCO.FOLHA;
          }
        }
      }
    }
  }
  // 3. Cactos no deserto
  for (let lx = 0; lx < CHUNK_SIZE; lx++) {
    for (let lz = 0; lz < CHUNK_SIZE; lz++) {
      const gx = cx * CHUNK_SIZE + lx, gz = cz * CHUNK_SIZE + lz;
      const h = alturaTerreno(gx, gz, seed);
      if (blocks[idx(lx, h, lz)] !== BLOCO.AREIA) continue;
      const hh = hash2(gx, gz, seed ^ 0xCAC) & 0xFF;
      if (hh > 6) continue;
      const altura = 1 + (hh & 0x2);
      for (let y = 1; y <= altura; y++) {
        if (h + y < WORLD_Y) blocks[idx(lx, h + y, lz)] = BLOCO.CACTO;
      }
    }
  }
  return blocks;
}

self.onmessage = (e) => {
  const { cx, cz, seed } = e.data;
  const blocks = gerarChunkBase(cx, cz, seed);
  self.postMessage({ cx, cz, blocks }, [blocks.buffer]);
};
