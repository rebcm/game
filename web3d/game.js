// Construção Criativa 3D — Three.js voxel engine.
// Mundo infinito por chunks 16×16×64, controles teclado+mouse à la Minecraft,
// física com gravidade/pulo/colisão AABB, day/night, mobs, save/load.

import * as THREE from 'three';
import { PointerLockControls } from 'three/addons/controls/PointerLockControls.js';

// ===================================================================
// 1) Constantes
// ===================================================================
const CHUNK_SIZE = 16;
const WORLD_Y = 64;
const VIEW_RADIUS = 4;            // chunks ao redor do player
const TILE = 1.0;                 // tamanho do bloco em unidades world
const PLAYER_HEIGHT = 1.8;
const PLAYER_RADIUS = 0.3;
const GRAVIDADE = -28;
const VEL_TERM = -55;
const PULO_VEL = 9.0;
const VEL_ANDAR = 4.5;
const VEL_SPRINT = 7.0;
const VEL_AR = 4.0;
const MOUSE_SENS = 0.0022;
const ALCANCE_BLOCO = 6.0;
const TEMPO_QUEBRA_BASE = 0.45;   // segundos para quebrar com mão (ajustado por tier)
const DIA_SEGUNDOS = 240;         // 4 min = 1 dia
const SAVE_KEY = 'rebcm3d_save_v1';

const BLOCO = {
  AR:        0,
  GRAMA:     1,
  TERRA:     2,
  PEDRA:     3,
  AREIA:     4,
  MADEIRA:   5,
  FOLHA:     6,
  TIJOLO:    7,
  VIDRO:     8,
  OURO:      9,
  DIAMANTE:  10,
  LUZ:       11,
  NEVE:      12,
  CARVAO:    13,
  FERRO:     14,
  CACTO:     15,
  AGUA:      16,
  LAVA:      17,
  OBSIDIANA: 18,
  WORKBENCH: 19,
  LA:        20,
  TOCHA:     21,
  BAU:       22,
  FORNALHA:  23,
  CAMA:      24,
};
const N_BLOCOS = 25;

const BLOCO_INFO = {
  [BLOCO.AR]:        { nome: 'Ar',        solido: false, transp: true,  emiteLuz: 0,  cor: 0x000000, lateral: 0x000000 },
  [BLOCO.GRAMA]:     { nome: 'Grama',     solido: true,  transp: false, emiteLuz: 0,  cor: 0x4CAF50, lateral: 0x8D6E63 },
  [BLOCO.TERRA]:     { nome: 'Terra',     solido: true,  transp: false, emiteLuz: 0,  cor: 0x8D6E63, lateral: 0x6D4C41 },
  [BLOCO.PEDRA]:     { nome: 'Pedra',     solido: true,  transp: false, emiteLuz: 0,  cor: 0x9E9E9E, lateral: 0x757575 },
  [BLOCO.AREIA]:     { nome: 'Areia',     solido: true,  transp: false, emiteLuz: 0,  cor: 0xFFEB3B, lateral: 0xFDD835 },
  [BLOCO.MADEIRA]:   { nome: 'Madeira',   solido: true,  transp: false, emiteLuz: 0,  cor: 0xA1887F, lateral: 0x8D6E63 },
  [BLOCO.FOLHA]:     { nome: 'Folha',     solido: true,  transp: true,  emiteLuz: 0,  cor: 0x66BB6A, lateral: 0x66BB6A },
  [BLOCO.TIJOLO]:    { nome: 'Tijolo',    solido: true,  transp: false, emiteLuz: 0,  cor: 0xE57373, lateral: 0xC62828 },
  [BLOCO.VIDRO]:     { nome: 'Vidro',     solido: true,  transp: true,  emiteLuz: 0,  cor: 0xB3E5FC, lateral: 0xB3E5FC },
  [BLOCO.OURO]:      { nome: 'Ouro',      solido: true,  transp: false, emiteLuz: 0,  cor: 0xFFD54F, lateral: 0xFBC02D },
  [BLOCO.DIAMANTE]:  { nome: 'Diamante',  solido: true,  transp: false, emiteLuz: 0,  cor: 0x80DEEA, lateral: 0x4DD0E1 },
  [BLOCO.LUZ]:       { nome: 'Luz',       solido: true,  transp: false, emiteLuz: 14, cor: 0xFFF9C4, lateral: 0xFFEE58 },
  [BLOCO.NEVE]:      { nome: 'Neve',      solido: true,  transp: false, emiteLuz: 0,  cor: 0xECEFF1, lateral: 0xCFD8DC },
  [BLOCO.CARVAO]:    { nome: 'Carvão',    solido: true,  transp: false, emiteLuz: 0,  cor: 0x424242, lateral: 0x212121 },
  [BLOCO.FERRO]:     { nome: 'Ferro',     solido: true,  transp: false, emiteLuz: 0,  cor: 0xCFD8DC, lateral: 0xB0BEC5 },
  [BLOCO.CACTO]:     { nome: 'Cacto',     solido: true,  transp: false, emiteLuz: 0,  cor: 0x388E3C, lateral: 0x2E7D32 },
  [BLOCO.AGUA]:      { nome: 'Água',      solido: false, transp: true,  emiteLuz: 0,  cor: 0x2196F3, lateral: 0x1976D2 },
  [BLOCO.LAVA]:      { nome: 'Lava',      solido: true,  transp: false, emiteLuz: 15, cor: 0xFF5722, lateral: 0xBF360C },
  [BLOCO.OBSIDIANA]: { nome: 'Obsidiana', solido: true,  transp: false, emiteLuz: 0,  cor: 0x6e3a8c, lateral: 0x4e2a6c },
  [BLOCO.WORKBENCH]: { nome: 'Workbench', solido: true,  transp: false, emiteLuz: 0,  cor: 0x6D4C41, lateral: 0x4E342E },
  [BLOCO.LA]:        { nome: 'Lã',        solido: true,  transp: false, emiteLuz: 0,  cor: 0xFAFAFA, lateral: 0xEEEEEE },
  [BLOCO.TOCHA]:     { nome: 'Tocha',     solido: false, transp: true,  emiteLuz: 13, cor: 0xFFB300, lateral: 0xFF6F00 },
  [BLOCO.BAU]:       { nome: 'Baú',       solido: true,  transp: false, emiteLuz: 0,  cor: 0x8B5A2B, lateral: 0x6D4C41 },
  [BLOCO.FORNALHA]:  { nome: 'Fornalha',  solido: true,  transp: false, emiteLuz: 0,  cor: 0x6E6E6E, lateral: 0x424242 },
  [BLOCO.CAMA]:      { nome: 'Cama',      solido: true,  transp: false, emiteLuz: 0,  cor: 0xE53935, lateral: 0xC62828 },
};
const ICONE = {
  [BLOCO.GRAMA]: '🌿', [BLOCO.TERRA]: '🟫', [BLOCO.PEDRA]: '🪨',
  [BLOCO.AREIA]: '🏖', [BLOCO.MADEIRA]: '🪵', [BLOCO.FOLHA]: '🍃',
  [BLOCO.TIJOLO]: '🧱', [BLOCO.VIDRO]: '🔲', [BLOCO.OURO]: '🥇',
  [BLOCO.DIAMANTE]: '💎', [BLOCO.LUZ]: '💡', [BLOCO.NEVE]: '❄',
  [BLOCO.CARVAO]: '⬛', [BLOCO.FERRO]: '⚙', [BLOCO.CACTO]: '🌵',
  [BLOCO.AGUA]: '💧', [BLOCO.LAVA]: '🔥', [BLOCO.OBSIDIANA]: '⬣',
  [BLOCO.WORKBENCH]: '🪚', [BLOCO.LA]: '☁', [BLOCO.TOCHA]: '🕯',
  [BLOCO.BAU]: '📦', [BLOCO.FORNALHA]: '🔥', [BLOCO.CAMA]: '🛏',
};

// Tipos de item (não-bloco)
const ITEM = {
  CARNE_CRUA: 100, CARNE_COZIDA: 101, OVO: 102, CARNE_PODRE: 103,
  PRANCHAS: 110, PAU: 111, CARVAO: 112, FERRO: 113, OURO: 114, DIAMANTE: 115,
  COURO: 120,
  PIC_MADEIRA: 200, PIC_PEDRA: 201, PIC_FERRO: 202, PIC_DIAMANTE: 203,
  ESP_MADEIRA: 210, ESP_PEDRA: 211, ESP_FERRO: 212,
  // Armaduras: tier × peça
  CAP_COURO: 300, PEI_COURO: 301, PER_COURO: 302, BOT_COURO: 303,
  CAP_FERRO: 304, PEI_FERRO: 305, PER_FERRO: 306, BOT_FERRO: 307,
  CAP_DIAMANTE: 308, PEI_DIAMANTE: 309, PER_DIAMANTE: 310, BOT_DIAMANTE: 311,
};
const ITEM_INFO = {
  [ITEM.CARNE_CRUA]:   { nome: 'Carne crua',   icone: '🥩', nutricao: 3, suspeito: true },
  [ITEM.CARNE_COZIDA]: { nome: 'Carne cozida', icone: '🍖', nutricao: 8 },
  [ITEM.OVO]:          { nome: 'Ovo',          icone: '🥚', nutricao: 1 },
  [ITEM.CARNE_PODRE]:  { nome: 'Carne podre',  icone: '🦴', nutricao: 4, suspeito: true },
  [ITEM.PRANCHAS]:     { nome: 'Pranchas',     icone: '🟫' },
  [ITEM.PAU]:          { nome: 'Pau',          icone: '|'  },
  [ITEM.CARVAO]:       { nome: 'Carvão',       icone: '⬛' },
  [ITEM.FERRO]:        { nome: 'Ferro',        icone: '⚙'  },
  [ITEM.OURO]:         { nome: 'Ouro',         icone: '🥇' },
  [ITEM.DIAMANTE]:     { nome: 'Diamante',     icone: '💎' },
  [ITEM.COURO]:        { nome: 'Couro',        icone: '🟤' },
  [ITEM.PIC_MADEIRA]:  { nome: 'Picareta madeira',  icone: '⛏', tier: 1, ferramenta: 'pic' },
  [ITEM.PIC_PEDRA]:    { nome: 'Picareta pedra',    icone: '⛏', tier: 2, ferramenta: 'pic' },
  [ITEM.PIC_FERRO]:    { nome: 'Picareta ferro',    icone: '⛏', tier: 3, ferramenta: 'pic' },
  [ITEM.PIC_DIAMANTE]: { nome: 'Picareta diamante', icone: '⛏', tier: 4, ferramenta: 'pic' },
  [ITEM.ESP_MADEIRA]:  { nome: 'Espada madeira',   icone: '⚔', tier: 1, ferramenta: 'esp' },
  [ITEM.ESP_PEDRA]:    { nome: 'Espada pedra',     icone: '⚔', tier: 2, ferramenta: 'esp' },
  [ITEM.ESP_FERRO]:    { nome: 'Espada ferro',     icone: '⚔', tier: 3, ferramenta: 'esp' },
  // Armaduras (defesa em pontos; 4 pts ≈ 16% redução)
  [ITEM.CAP_COURO]:    { nome: 'Capacete couro',    icone: '🪖', armadura: 'cabeca',  defesa: 1 },
  [ITEM.PEI_COURO]:    { nome: 'Peitoral couro',    icone: '👕', armadura: 'torso',   defesa: 3 },
  [ITEM.PER_COURO]:    { nome: 'Perneiras couro',   icone: '👖', armadura: 'pernas',  defesa: 2 },
  [ITEM.BOT_COURO]:    { nome: 'Botas couro',       icone: '🥾', armadura: 'botas',   defesa: 1 },
  [ITEM.CAP_FERRO]:    { nome: 'Capacete ferro',    icone: '🪖', armadura: 'cabeca',  defesa: 2 },
  [ITEM.PEI_FERRO]:    { nome: 'Peitoral ferro',    icone: '👕', armadura: 'torso',   defesa: 6 },
  [ITEM.PER_FERRO]:    { nome: 'Perneiras ferro',   icone: '👖', armadura: 'pernas',  defesa: 5 },
  [ITEM.BOT_FERRO]:    { nome: 'Botas ferro',       icone: '🥾', armadura: 'botas',   defesa: 2 },
  [ITEM.CAP_DIAMANTE]: { nome: 'Capacete diamante', icone: '🪖', armadura: 'cabeca',  defesa: 3 },
  [ITEM.PEI_DIAMANTE]: { nome: 'Peitoral diamante', icone: '👕', armadura: 'torso',   defesa: 8 },
  [ITEM.PER_DIAMANTE]: { nome: 'Perneiras diamante',icone: '👖', armadura: 'pernas',  defesa: 6 },
  [ITEM.BOT_DIAMANTE]: { nome: 'Botas diamante',    icone: '🥾', armadura: 'botas',   defesa: 3 },
};

// Receitas (workbench=true exige workbench próximo)
const RECEITAS = [
  { custos: [{b: BLOCO.MADEIRA, q: 1}], saida: {i: ITEM.PRANCHAS, q: 4}, wb: false },
  { custos: [{i: ITEM.PRANCHAS, q: 2}], saida: {i: ITEM.PAU,      q: 4}, wb: false },
  { custos: [{i: ITEM.PRANCHAS, q: 4}], saida: {b: BLOCO.WORKBENCH, q: 1}, wb: false },
  { custos: [{i: ITEM.CARVAO, q: 1}, {i: ITEM.PAU, q: 1}], saida: {b: BLOCO.TOCHA, q: 4}, wb: false },
  { custos: [{i: ITEM.PRANCHAS, q: 3}, {i: ITEM.PAU, q: 2}], saida: {i: ITEM.PIC_MADEIRA, q: 1}, wb: true },
  { custos: [{b: BLOCO.PEDRA, q: 3},   {i: ITEM.PAU, q: 2}], saida: {i: ITEM.PIC_PEDRA,   q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 3},    {i: ITEM.PAU, q: 2}], saida: {i: ITEM.PIC_FERRO,   q: 1}, wb: true },
  { custos: [{i: ITEM.DIAMANTE, q: 3}, {i: ITEM.PAU, q: 2}], saida: {i: ITEM.PIC_DIAMANTE,q: 1}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 2}, {i: ITEM.PAU, q: 1}], saida: {i: ITEM.ESP_MADEIRA, q: 1}, wb: true },
  { custos: [{b: BLOCO.PEDRA, q: 2},   {i: ITEM.PAU, q: 1}], saida: {i: ITEM.ESP_PEDRA,   q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 2},    {i: ITEM.PAU, q: 1}], saida: {i: ITEM.ESP_FERRO,   q: 1}, wb: true },
  { custos: [{i: ITEM.CARNE_CRUA, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {i: ITEM.CARNE_COZIDA, q: 1}, wb: false },
  // === Armaduras ===
  // Couro
  { custos: [{i: ITEM.COURO, q: 5}], saida: {i: ITEM.CAP_COURO, q: 1}, wb: true },
  { custos: [{i: ITEM.COURO, q: 8}], saida: {i: ITEM.PEI_COURO, q: 1}, wb: true },
  { custos: [{i: ITEM.COURO, q: 7}], saida: {i: ITEM.PER_COURO, q: 1}, wb: true },
  { custos: [{i: ITEM.COURO, q: 4}], saida: {i: ITEM.BOT_COURO, q: 1}, wb: true },
  // Ferro
  { custos: [{i: ITEM.FERRO, q: 5}], saida: {i: ITEM.CAP_FERRO, q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 8}], saida: {i: ITEM.PEI_FERRO, q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 7}], saida: {i: ITEM.PER_FERRO, q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 4}], saida: {i: ITEM.BOT_FERRO, q: 1}, wb: true },
  // Diamante
  { custos: [{i: ITEM.DIAMANTE, q: 5}], saida: {i: ITEM.CAP_DIAMANTE, q: 1}, wb: true },
  { custos: [{i: ITEM.DIAMANTE, q: 8}], saida: {i: ITEM.PEI_DIAMANTE, q: 1}, wb: true },
  { custos: [{i: ITEM.DIAMANTE, q: 7}], saida: {i: ITEM.PER_DIAMANTE, q: 1}, wb: true },
  { custos: [{i: ITEM.DIAMANTE, q: 4}], saida: {i: ITEM.BOT_DIAMANTE, q: 1}, wb: true },
  // === Blocos funcionais ===
  // Baú: 8 pranchas
  { custos: [{i: ITEM.PRANCHAS, q: 8}], saida: {b: BLOCO.BAU, q: 1}, wb: true },
  // Fornalha: 8 pedras
  { custos: [{b: BLOCO.PEDRA, q: 8}], saida: {b: BLOCO.FORNALHA, q: 1}, wb: true },
  // Cama: 3 lã + 3 pranchas
  { custos: [{b: BLOCO.LA, q: 3}, {i: ITEM.PRANCHAS, q: 3}], saida: {b: BLOCO.CAMA, q: 1}, wb: true },
];

// ===================================================================
// 2) Utilitários
// ===================================================================
function hash2(x, z, salt) {
  let h = ((x | 0) * 73856093) ^ ((z | 0) * 19349663) ^ (salt | 0);
  h = (h ^ (h >>> 13)) >>> 0;
  h = Math.imul(h, 0x5bd1e995) >>> 0;
  h = (h ^ (h >>> 15)) >>> 0;
  return h;
}
function hash3(x, y, z, salt) { return hash2(x * 257 + y, z, salt); }
function clamp(v, lo, hi) { return v < lo ? lo : (v > hi ? hi : v); }
function chunkKey(cx, cz) { return ((cx & 0xFFFF) | ((cz & 0xFFFF) << 16)) >>> 0; }

// ===================================================================
// 3) Mundo / Chunk
// ===================================================================
class Chunk {
  constructor(cx, cz) {
    this.cx = cx; this.cz = cz;
    this.blocks = new Uint8Array(CHUNK_SIZE * CHUNK_SIZE * WORLD_Y);
    this.dirty = true;       // mesh precisa re-build
    this.modificado = false; // foi alterado pelo player (vai pro save)
    this.mesh = null;
    this.lights = [];
  }
  static idx(lx, y, lz) { return y * CHUNK_SIZE * CHUNK_SIZE + lx * CHUNK_SIZE + lz; }
  get(lx, y, lz) {
    if (lx < 0 || lx >= CHUNK_SIZE || lz < 0 || lz >= CHUNK_SIZE) return BLOCO.AR;
    if (y < 0 || y >= WORLD_Y) return BLOCO.AR;
    return this.blocks[Chunk.idx(lx, y, lz)];
  }
  set(lx, y, lz, t) {
    if (lx < 0 || lx >= CHUNK_SIZE || lz < 0 || lz >= CHUNK_SIZE) return;
    if (y < 0 || y >= WORLD_Y) return;
    const i = Chunk.idx(lx, y, lz);
    if (this.blocks[i] === t) return;
    this.blocks[i] = t;
    this.dirty = true;
  }
}

class World {
  constructor(seed = 42) {
    this.seed = seed;
    this.chunks = new Map(); // chunkKey -> Chunk
    // Estado de blocos funcionais. Chave = "x,y,z" string.
    // bauTesouros[chave] = array de 27 slots ({b/i/q})
    this.bauTesouros = new Map();
    // fornalhaEstados[chave] = { input, output, combustivel, progresso, ativa }
    this.fornalhaEstados = new Map();
  }
  static keyXYZ(x, y, z) { return `${x},${y},${z}`; }
  getBau(x, y, z) {
    const k = World.keyXYZ(x, y, z);
    if (!this.bauTesouros.has(k)) {
      this.bauTesouros.set(k, new Array(27).fill(null));
    }
    return this.bauTesouros.get(k);
  }
  getFornalha(x, y, z) {
    const k = World.keyXYZ(x, y, z);
    if (!this.fornalhaEstados.has(k)) {
      this.fornalhaEstados.set(k, {
        input: null, combustivel: null, output: null,
        progresso: 0, ativa: false,
      });
    }
    return this.fornalhaEstados.get(k);
  }
  removerEstadoBloco(x, y, z) {
    const k = World.keyXYZ(x, y, z);
    this.bauTesouros.delete(k);
    this.fornalhaEstados.delete(k);
  }
  alturaTerreno(x, z) {
    const nx = x / 32, nz = z / 32;
    let v = Math.sin(nx * Math.PI) * Math.cos(nz * Math.PI) * 0.45 +
            Math.sin(nx * Math.PI * 2.5 + 1.3) * Math.sin(nz * Math.PI * 1.7 + 0.8) * 0.30 +
            Math.sin(nx * Math.PI * 5.5 + 2.5) * Math.cos(nz * Math.PI * 3.5 + 1.9) * 0.15 +
            Math.sin(nx * Math.PI * 8.5 + 4.1) * Math.sin(nz * Math.PI * 6.5 + 3.3) * 0.10;
    v = (v + 1) / 2;
    return clamp(6 + Math.floor(v * 18), 2, WORLD_Y - 8);
  }
  topoBioma(x, z, h) {
    if (h <= 4) return BLOCO.AREIA;
    if (h >= 22) return BLOCO.NEVE;
    if (((z + this.seed) % 256 + 256) % 256 > 200) return BLOCO.NEVE;
    if (((z - this.seed) % 256 + 256) % 256 < 76)  return BLOCO.AREIA;
    return BLOCO.GRAMA;
  }
  gerarChunk(cx, cz) {
    const c = new Chunk(cx, cz);
    // 1) Terreno + minérios
    for (let lx = 0; lx < CHUNK_SIZE; lx++) {
      for (let lz = 0; lz < CHUNK_SIZE; lz++) {
        const gx = cx * CHUNK_SIZE + lx;
        const gz = cz * CHUNK_SIZE + lz;
        const h = this.alturaTerreno(gx, gz);
        for (let y = 0; y <= h; y++) {
          let b;
          if (y === 0) b = BLOCO.OBSIDIANA;
          else if (y <= 2) {
            const hh = hash2(gx, gz, this.seed ^ 0xfee10) & 0xFF;
            b = hh < 14 ? BLOCO.LAVA : BLOCO.PEDRA;
          } else if (y < h - 3) {
            const hh = hash3(gx, y, gz, this.seed ^ 0xa1b2) & 0xFF;
            if (y < 6 && hh < 3) b = BLOCO.DIAMANTE;
            else if (y < 10 && hh < 6) b = BLOCO.OURO;
            else if (y < 14 && hh < 14) b = BLOCO.FERRO;
            else if (hh < 26) b = BLOCO.CARVAO;
            else b = BLOCO.PEDRA;
          } else if (y < h) b = BLOCO.TERRA;
          else b = this.topoBioma(gx, gz, h);
          c.blocks[Chunk.idx(lx, y, lz)] = b;
        }
      }
    }
    // 2) Árvores em grama
    for (let lx = 0; lx < CHUNK_SIZE; lx++) {
      for (let lz = 0; lz < CHUNK_SIZE; lz++) {
        const gx = cx * CHUNK_SIZE + lx;
        const gz = cz * CHUNK_SIZE + lz;
        const h = this.alturaTerreno(gx, gz);
        if (h < 5 || h >= WORLD_Y - 8) continue;
        if (c.get(lx, h, lz) !== BLOCO.GRAMA) continue;
        if ((hash2(gx, gz, this.seed ^ 0xc1c2c3) & 0xFF) >= 12) continue;
        this.plantarArvore(c, lx, h + 1, lz);
      }
    }
    // 3) Cactos em areia
    for (let lx = 0; lx < CHUNK_SIZE; lx++) {
      for (let lz = 0; lz < CHUNK_SIZE; lz++) {
        const gx = cx * CHUNK_SIZE + lx;
        const gz = cz * CHUNK_SIZE + lz;
        const h = this.alturaTerreno(gx, gz);
        if (h >= WORLD_Y - 4) continue;
        if (c.get(lx, h, lz) !== BLOCO.AREIA) continue;
        if ((hash2(gx, gz, this.seed ^ 0xcac10) & 0xFF) >= 6) continue;
        const altCacto = 1 + ((hash2(gx, gz, this.seed ^ 0xcac20) >> 8) & 0x2);
        for (let i = 1; i <= altCacto; i++) {
          if (h + i < WORLD_Y) c.blocks[Chunk.idx(lx, h + i, lz)] = BLOCO.CACTO;
        }
      }
    }
    // 4) Cabana ocasional (~1.5%)
    if ((hash2(cx, cz, this.seed ^ 0xbe1a) & 0xFF) < 4) {
      this.construirCabana(c);
    }
    // 5) Cavernas: noise 3D escava blocos sólidos abaixo da superfície
    for (let lx = 0; lx < CHUNK_SIZE; lx++) {
      for (let lz = 0; lz < CHUNK_SIZE; lz++) {
        const gx = cx * CHUNK_SIZE + lx;
        const gz = cz * CHUNK_SIZE + lz;
        const hSurf = this.alturaTerreno(gx, gz);
        for (let y = 3; y < hSurf - 2; y++) {
          const atual = c.get(lx, y, lz);
          if (atual === BLOCO.AR || atual === BLOCO.LAVA) continue;
          if (this.caverna(gx, y, gz)) {
            c.blocks[Chunk.idx(lx, y, lz)] = BLOCO.AR;
          }
        }
      }
    }
    return c;
  }
  caverna(x, y, z) {
    const n1 = hash2((x / 3) | 0, (z / 3) | 0, this.seed ^ 0xc41e1) / 0xFFFFFFFF;
    const n2 = hash2((x / 4) | 0, y * 31, this.seed ^ 0xc41e2) / 0xFFFFFFFF;
    const n3 = hash2(y * 17, (z / 4) | 0, this.seed ^ 0xc41e3) / 0xFFFFFFFF;
    const v = (n1 + n2 + n3) / 3;
    // Threshold reduzido — gera cavernas mais raras e em sua maioria
    // profundas (não visíveis da superfície). Antes 0.34/0.30/0.24
    // gerava esponja com furos visíveis de cima.
    const yFactor = y < 6 ? 0.22 : (y < 12 ? 0.18 : 0.10);
    return v < yFactor;
  }
  plantarArvore(c, lx, y, lz) {
    const h = 4 + ((lx * 7 + lz * 3 + c.cx + c.cz) & 0x3);
    for (let i = 0; i < h; i++) {
      if (y + i < WORLD_Y) c.blocks[Chunk.idx(lx, y + i, lz)] = BLOCO.MADEIRA;
    }
    for (let dx = -2; dx <= 2; dx++) {
      for (let dz = -2; dz <= 2; dz++) {
        for (let dy = h - 2; dy <= h + 1; dy++) {
          if (dx === 0 && dz === 0 && dy < h) continue;
          if (dx * dx + dz * dz > 5) continue;
          const tx = lx + dx, tz = lz + dz, ty = y + dy;
          if (tx < 0 || tx >= CHUNK_SIZE) continue;
          if (tz < 0 || tz >= CHUNK_SIZE) continue;
          if (ty < 0 || ty >= WORLD_Y) continue;
          if (c.get(tx, ty, tz) === BLOCO.AR) {
            c.blocks[Chunk.idx(tx, ty, tz)] = BLOCO.FOLHA;
          }
        }
      }
    }
    if (y + h < WORLD_Y) c.blocks[Chunk.idx(lx, y + h, lz)] = BLOCO.FOLHA;
    if (y + h + 1 < WORLD_Y) c.blocks[Chunk.idx(lx, y + h + 1, lz)] = BLOCO.FOLHA;
  }
  construirCabana(c) {
    const cs = CHUNK_SIZE;
    const cx0 = 2 + ((hash2(c.cx, c.cz, this.seed ^ 0xb1) & 0xFF) % (cs - 4));
    const cz0 = 2 + ((hash2(c.cz, c.cx, this.seed ^ 0xb2) & 0xFF) % (cs - 4));
    const gx0 = c.cx * cs + cx0, gz0 = c.cz * cs + cz0;
    const base = this.alturaTerreno(gx0, gz0);
    if (base < 4 || base >= WORLD_Y - 6) return;
    // Piso
    for (let dx = -2; dx <= 2; dx++) for (let dz = -2; dz <= 2; dz++) {
      const lx = cx0 + dx, lz = cz0 + dz;
      if (lx < 0 || lx >= cs || lz < 0 || lz >= cs) continue;
      c.blocks[Chunk.idx(lx, base + 1, lz)] = BLOCO.MADEIRA;
    }
    // Paredes (com porta)
    for (let dx = -2; dx <= 2; dx++) for (let dz = -2; dz <= 2; dz++) {
      const lx = cx0 + dx, lz = cz0 + dz;
      if (lx < 0 || lx >= cs || lz < 0 || lz >= cs) continue;
      const isBorda = dx === -2 || dx === 2 || dz === -2 || dz === 2;
      if (!isBorda) continue;
      for (let dy = 1; dy <= 3; dy++) {
        if (dx === 2 && dz === 0 && dy <= 2) continue; // porta
        if (base + 1 + dy >= WORLD_Y) continue;
        c.blocks[Chunk.idx(lx, base + 1 + dy, lz)] = BLOCO.TIJOLO;
      }
    }
    // Telhado
    for (let dx = -2; dx <= 2; dx++) for (let dz = -2; dz <= 2; dz++) {
      const lx = cx0 + dx, lz = cz0 + dz;
      if (lx < 0 || lx >= cs || lz < 0 || lz >= cs) continue;
      if (base + 5 >= WORLD_Y) continue;
      c.blocks[Chunk.idx(lx, base + 5, lz)] = BLOCO.MADEIRA;
    }
    if (base + 2 < WORLD_Y) c.blocks[Chunk.idx(cx0, base + 2, cz0)] = BLOCO.TOCHA;
    if (base + 2 < WORLD_Y) c.blocks[Chunk.idx(cx0 + 1, base + 2, cz0 + 1)] = BLOCO.WORKBENCH;
  }
  getChunk(cx, cz) {
    const k = chunkKey(cx, cz);
    let c = this.chunks.get(k);
    if (!c) { c = this.gerarChunk(cx, cz); this.chunks.set(k, c); }
    return c;
  }
  hasChunk(cx, cz) { return this.chunks.has(chunkKey(cx, cz)); }
  // Coordenadas globais → bloco
  get(x, y, z) {
    if (y < 0 || y >= WORLD_Y) return BLOCO.AR;
    const cx = Math.floor(x / CHUNK_SIZE);
    const cz = Math.floor(z / CHUNK_SIZE);
    const lx = ((x % CHUNK_SIZE) + CHUNK_SIZE) % CHUNK_SIZE;
    const lz = ((z % CHUNK_SIZE) + CHUNK_SIZE) % CHUNK_SIZE;
    return this.getChunk(cx, cz).get(lx, y, lz);
  }
  set(x, y, z, t) {
    if (y < 0 || y >= WORLD_Y) return null;
    const cx = Math.floor(x / CHUNK_SIZE);
    const cz = Math.floor(z / CHUNK_SIZE);
    const lx = ((x % CHUNK_SIZE) + CHUNK_SIZE) % CHUNK_SIZE;
    const lz = ((z % CHUNK_SIZE) + CHUNK_SIZE) % CHUNK_SIZE;
    const c = this.getChunk(cx, cz);
    if (c.get(lx, y, lz) === t) return null;
    c.set(lx, y, lz, t);
    c.modificado = true;
    // marca chunks vizinhos como dirty também (faces de borda)
    const out = [c];
    if (lx === 0)               out.push(this.getChunk(cx - 1, cz));
    if (lx === CHUNK_SIZE - 1)  out.push(this.getChunk(cx + 1, cz));
    if (lz === 0)               out.push(this.getChunk(cx, cz - 1));
    if (lz === CHUNK_SIZE - 1)  out.push(this.getChunk(cx, cz + 1));
    for (const cc of out) cc.dirty = true;
    return c;
  }
  isSolido(x, y, z) {
    return BLOCO_INFO[this.get(x, y, z)].solido;
  }
}

// ===================================================================
// 4) Renderer Three.js
// ===================================================================

// Gera um atlas de texturas procedurais 16×16 por face, com ruído,
// para todos os 22 tipos de bloco. Cada bloco recebe 3 índices: top,
// side, bottom — assim grama/madeira têm faces distintas.
function criarAtlasTexturas() {
  const cellSize = 16;
  const cols = 8, rows = 8;
  const canvas = document.createElement('canvas');
  canvas.width = cols * cellSize;
  canvas.height = rows * cellSize;
  const ctx = canvas.getContext('2d');

  function bg(idx, r, g, b) {
    const col = idx % cols, row = Math.floor(idx / cols);
    const x0 = col * cellSize, y0 = row * cellSize;
    ctx.fillStyle = `rgb(${r},${g},${b})`;
    ctx.fillRect(x0, y0, cellSize, cellSize);
  }
  function ruido(idx, intensidade = 22) {
    const col = idx % cols, row = Math.floor(idx / cols);
    const x0 = col * cellSize, y0 = row * cellSize;
    const data = ctx.getImageData(x0, y0, cellSize, cellSize);
    for (let i = 0; i < data.data.length; i += 4) {
      const n = (Math.random() - 0.5) * intensidade;
      data.data[i]   = clamp(data.data[i]   + n | 0, 0, 255);
      data.data[i+1] = clamp(data.data[i+1] + n | 0, 0, 255);
      data.data[i+2] = clamp(data.data[i+2] + n | 0, 0, 255);
    }
    ctx.putImageData(data, x0, y0);
  }
  function pintar(idx, hex, ruidoAmt = 22, padraoExtra) {
    const r = (hex >> 16) & 0xFF, g = (hex >> 8) & 0xFF, b = hex & 0xFF;
    bg(idx, r, g, b);
    ruido(idx, ruidoAmt);
    if (padraoExtra) padraoExtra(idx, ctx, cellSize);
  }
  // Padrões úteis
  function listrasMadeira(idx, ctx, cs) {
    const col = idx % cols, row = Math.floor(idx / cols);
    const x0 = col * cs, y0 = row * cs;
    ctx.strokeStyle = 'rgba(80,55,40,0.5)';
    ctx.lineWidth = 1;
    for (let y = 2; y < cs; y += 4) {
      ctx.beginPath();
      ctx.moveTo(x0, y0 + y + 0.5);
      ctx.lineTo(x0 + cs, y0 + y + 0.5);
      ctx.stroke();
    }
  }
  function aneisMadeiraTopo(idx, ctx, cs) {
    const col = idx % cols, row = Math.floor(idx / cols);
    const cx = col * cs + cs / 2, cy = row * cs + cs / 2;
    ctx.strokeStyle = 'rgba(80,55,40,0.55)';
    ctx.lineWidth = 1;
    for (let r = 2; r < cs / 2; r += 3) {
      ctx.beginPath();
      ctx.arc(cx, cy, r, 0, Math.PI * 2);
      ctx.stroke();
    }
  }
  function texturaTijolo(idx, ctx, cs) {
    const col = idx % cols, row = Math.floor(idx / cols);
    const x0 = col * cs, y0 = row * cs;
    ctx.strokeStyle = 'rgba(60,30,30,0.7)';
    ctx.lineWidth = 1;
    // 4 fileiras de 2 tijolos, alternadas
    for (let i = 0; i < 4; i++) {
      const y = y0 + i * 4 + 0.5;
      ctx.beginPath(); ctx.moveTo(x0, y); ctx.lineTo(x0 + cs, y); ctx.stroke();
      const offset = (i % 2 === 0) ? 0 : cs / 2;
      ctx.beginPath();
      ctx.moveTo(x0 + offset, y); ctx.lineTo(x0 + offset, y + 4); ctx.stroke();
      ctx.beginPath();
      ctx.moveTo(x0 + offset + cs / 2, y); ctx.lineTo(x0 + offset + cs / 2, y + 4); ctx.stroke();
    }
  }
  function gramaTopoBordaSombra(idx, ctx, cs) {
    const col = idx % cols, row = Math.floor(idx / cols);
    const x0 = col * cs, y0 = row * cs;
    // Toques mais escuros aleatórios (tufos)
    ctx.fillStyle = 'rgba(20,80,30,0.4)';
    for (let i = 0; i < 6; i++) {
      const x = x0 + Math.floor(Math.random() * cs);
      const y = y0 + Math.floor(Math.random() * cs);
      ctx.fillRect(x, y, 1, 1);
    }
  }
  function gramaLateralFaixa(idx, ctx, cs) {
    const col = idx % cols, row = Math.floor(idx / cols);
    const x0 = col * cs, y0 = row * cs;
    // Faixa de grama no topo (5 px) por cima da textura terra.
    ctx.fillStyle = '#4CAF50';
    for (let x = 0; x < cs; x++) {
      const dy = Math.floor(Math.random() * 2) + 4;
      ctx.fillRect(x0 + x, y0, 1, dy);
    }
    // Pontilhado de transição
    ctx.fillStyle = '#388E3C';
    for (let i = 0; i < 8; i++) {
      const x = x0 + Math.floor(Math.random() * cs);
      const y = y0 + 4 + Math.floor(Math.random() * 2);
      ctx.fillRect(x, y, 1, 1);
    }
  }
  function vidroBorda(idx, ctx, cs) {
    const col = idx % cols, row = Math.floor(idx / cols);
    const x0 = col * cs, y0 = row * cs;
    ctx.strokeStyle = 'rgba(100,180,220,0.7)';
    ctx.lineWidth = 1;
    ctx.strokeRect(x0 + 0.5, y0 + 0.5, cs - 1, cs - 1);
  }
  function pontosOuro(idx, ctx, cs, cor) {
    const col = idx % cols, row = Math.floor(idx / cols);
    const x0 = col * cs, y0 = row * cs;
    ctx.fillStyle = cor;
    for (let i = 0; i < 8; i++) {
      const x = x0 + Math.floor(Math.random() * cs);
      const y = y0 + Math.floor(Math.random() * cs);
      ctx.fillRect(x, y, 2, 2);
    }
  }

  // === Mapa de TipoBloco → índices (top, side, bottom) ===
  // Reservamos um conjunto de índices contíguos (0..47).
  const mapa = {};
  let next = 0;
  function cell(top, side, bottom) {
    const r = { top: top, side: side, bottom: bottom ?? side };
    return r;
  }

  // Texturas individuais
  pintar(0, 0x4CAF50, 24, gramaTopoBordaSombra);                       // grama topo
  pintar(1, 0x8D6E63, 18, gramaLateralFaixa);                          // grama lateral
  pintar(2, 0x8D6E63, 18);                                             // terra
  pintar(3, 0x9E9E9E, 22);                                             // pedra
  pintar(4, 0xFFEB3B, 14);                                             // areia
  pintar(5, 0x6D4C41, 18, listrasMadeira);                             // madeira lateral
  pintar(6, 0x8D6E63, 18, aneisMadeiraTopo);                           // madeira topo
  pintar(7, 0x66BB6A, 22);                                             // folha
  pintar(8, 0xC62828, 14, texturaTijolo);                              // tijolo
  pintar(9, 0xB3E5FC, 8, vidroBorda);                                  // vidro
  pintar(10, 0xFBC02D, 18, (i, c, cs) => pontosOuro(i, c, cs, '#FFD54F'));   // ouro
  pintar(11, 0x4DD0E1, 18, (i, c, cs) => pontosOuro(i, c, cs, '#80DEEA'));   // diamante
  pintar(12, 0xFFF59D, 6);                                             // luz
  pintar(13, 0xECEFF1, 6);                                             // neve
  pintar(14, 0x9E9E9E, 22, (i, c, cs) => pontosOuro(i, c, cs, '#212121')); // carvão
  pintar(15, 0xCFD8DC, 18, (i, c, cs) => pontosOuro(i, c, cs, '#90A4AE')); // ferro
  pintar(16, 0x388E3C, 18);                                            // cacto
  pintar(17, 0x1976D2, 12);                                            // água
  pintar(18, 0xBF360C, 30);                                            // lava
  pintar(19, 0x6e3a8c, 22);                                            // obsidiana (roxo distintivo)
  pintar(20, 0x4E342E, 18, listrasMadeira);                            // workbench lateral
  pintar(21, 0x6D4C41, 18, (i, c, cs) => {                             // workbench topo
    aneisMadeiraTopo(i, c, cs);
    const col = i % cols, row = Math.floor(i / cols);
    const x0 = col * cs, y0 = row * cs;
    ctx.strokeStyle = 'rgba(60,40,30,0.8)';
    ctx.beginPath();
    ctx.moveTo(x0, y0 + cs / 2); ctx.lineTo(x0 + cs, y0 + cs / 2); ctx.stroke();
    ctx.beginPath();
    ctx.moveTo(x0 + cs / 2, y0); ctx.lineTo(x0 + cs / 2, y0 + cs); ctx.stroke();
  });
  pintar(22, 0xEEEEEE, 14);                                            // lã
  pintar(23, 0xFFB300, 6);                                             // tocha
  // Baú: lateral com fechadura central + bordas
  pintar(24, 0x8B5A2B, 18, (i, c, cs) => {
    const col = i % cols, row = Math.floor(i / cols);
    const x0 = col * cs, y0 = row * cs;
    ctx.strokeStyle = 'rgba(60,30,15,0.9)';
    ctx.lineWidth = 1;
    ctx.strokeRect(x0 + 0.5, y0 + 0.5, cs - 1, cs - 1);
    // fechadura
    ctx.fillStyle = '#FFD700';
    ctx.fillRect(x0 + 7, y0 + 6, 2, 4);
    // tampa (linha horizontal no meio)
    ctx.beginPath();
    ctx.moveTo(x0, y0 + 5.5);
    ctx.lineTo(x0 + cs, y0 + 5.5);
    ctx.stroke();
  });
  // Fornalha: face com "fogo"
  pintar(25, 0x6E6E6E, 22, (i, c, cs) => {
    const col = i % cols, row = Math.floor(i / cols);
    const x0 = col * cs, y0 = row * cs;
    // abertura preta retangular
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0 + 4, y0 + 6, 8, 8);
    // fogo laranja dentro
    ctx.fillStyle = '#FF6F00';
    ctx.fillRect(x0 + 5, y0 + 11, 6, 2);
    ctx.fillStyle = '#FFC107';
    ctx.fillRect(x0 + 6, y0 + 12, 4, 1);
    // moldura
    ctx.strokeStyle = 'rgba(20,20,20,0.7)';
    ctx.strokeRect(x0 + 0.5, y0 + 0.5, cs - 1, cs - 1);
  });
  // Fornalha topo (sem fogo)
  pintar(26, 0x6E6E6E, 22, (i, c, cs) => {
    const col = i % cols, row = Math.floor(i / cols);
    const x0 = col * cs, y0 = row * cs;
    ctx.strokeStyle = 'rgba(20,20,20,0.6)';
    ctx.strokeRect(x0 + 1.5, y0 + 1.5, cs - 3, cs - 3);
  });
  // Cama: vermelha com "lençol" branco
  pintar(27, 0xE53935, 14, (i, c, cs) => {
    const col = i % cols, row = Math.floor(i / cols);
    const x0 = col * cs, y0 = row * cs;
    // travesseiro branco no canto superior
    ctx.fillStyle = '#fafafa';
    ctx.fillRect(x0 + 1, y0 + 1, cs - 2, 5);
    // listra acolchoado
    ctx.strokeStyle = 'rgba(140,30,30,0.7)';
    ctx.beginPath();
    ctx.moveTo(x0, y0 + 6.5);
    ctx.lineTo(x0 + cs, y0 + 6.5);
    ctx.stroke();
  });
  // Cama lateral (madeira marrom)
  pintar(28, 0x8D6E63, 18, listrasMadeira);
  next = 29;

  const M = {};
  M[BLOCO.GRAMA]     = cell(0, 1, 2);
  M[BLOCO.TERRA]     = cell(2, 2, 2);
  M[BLOCO.PEDRA]     = cell(3, 3, 3);
  M[BLOCO.AREIA]     = cell(4, 4, 4);
  M[BLOCO.MADEIRA]   = cell(6, 5, 6);
  M[BLOCO.FOLHA]     = cell(7, 7, 7);
  M[BLOCO.TIJOLO]    = cell(8, 8, 8);
  M[BLOCO.VIDRO]     = cell(9, 9, 9);
  M[BLOCO.OURO]      = cell(10, 10, 10);
  M[BLOCO.DIAMANTE]  = cell(11, 11, 11);
  M[BLOCO.LUZ]       = cell(12, 12, 12);
  M[BLOCO.NEVE]      = cell(13, 13, 13);
  M[BLOCO.CARVAO]    = cell(14, 14, 14);
  M[BLOCO.FERRO]     = cell(15, 15, 15);
  M[BLOCO.CACTO]     = cell(16, 16, 16);
  M[BLOCO.AGUA]      = cell(17, 17, 17);
  M[BLOCO.LAVA]      = cell(18, 18, 18);
  M[BLOCO.OBSIDIANA] = cell(19, 19, 19);
  M[BLOCO.WORKBENCH] = cell(21, 20, 6);
  M[BLOCO.LA]        = cell(22, 22, 22);
  M[BLOCO.TOCHA]     = cell(23, 23, 23);
  M[BLOCO.BAU]       = cell(24, 24, 24);  // mesma textura todas faces
  M[BLOCO.FORNALHA]  = cell(26, 25, 26);  // topo limpo, lateral com fogo
  M[BLOCO.CAMA]      = cell(27, 28, 28);

  // === Força o atlas a ser 100% opaco ===
  // Vários padrões usam strokeStyle com rgba(...,0.5..0.9), o que deixa
  // alpha < 255 em alguns pixels do canvas. Quando essa textura
  // alimenta um material configurado como `transparent: false`, o
  // browser rasteriza esses pixels com fundo translúcido — gerando
  // artefatos de "blocos vazando" (especialmente face top vista de
  // cima, quando dois blocos sólidos opacos parecem deixar passar luz).
  // Solução: forçar todos os pixels a alpha = 255 antes de criar a
  // CanvasTexture.
  const dataAll = ctx.getImageData(0, 0, canvas.width, canvas.height);
  for (let i = 3; i < dataAll.data.length; i += 4) {
    dataAll.data[i] = 255;
  }
  ctx.putImageData(dataAll, 0, 0);

  const tex = new THREE.CanvasTexture(canvas);
  tex.magFilter = THREE.NearestFilter;
  tex.minFilter = THREE.NearestMipmapLinearFilter;
  tex.colorSpace = THREE.SRGBColorSpace;
  tex.generateMipmaps = true;
  return { texture: tex, mapa: M, cols, rows, cellSize };
}

// Gera uma textura única com 10 estágios de "cracks" lado-a-lado (16×16
// cada), idêntico ao Minecraft real (destroy_stage_0 a destroy_stage_9).
// Estágio 0 = sem cracks, 1..9 = cracks progressivamente mais densos
// até o bloco prestes a quebrar. Renderer escolhe estágio aplicando
// offset de UV.
function criarTexturaCracks() {
  const cell = 16, n = 10;
  const c = document.createElement('canvas');
  c.width = cell * n; c.height = cell;
  const ctx = c.getContext('2d');
  // Estágio 0: vazio
  // Estágios 1-9: linhas pretas aleatórias com densidade crescente +
  // pixels pretos espalhados (destroy_stage do Minecraft).
  for (let s = 1; s < n; s++) {
    const x0 = s * cell;
    // Seed determinística por estágio (mesma cada vez)
    let seed = s * 12345;
    const rng = () => { seed = (seed * 9301 + 49297) % 233280; return seed / 233280; };
    // Linhas (3 a 11 conforme estágio)
    ctx.strokeStyle = `rgba(0,0,0,${0.55 + s * 0.04})`;
    ctx.lineWidth = 1;
    const linhas = 2 + Math.ceil(s * 1.1);
    for (let i = 0; i < linhas; i++) {
      ctx.beginPath();
      ctx.moveTo(x0 + rng() * cell, rng() * cell);
      for (let j = 0; j < 2 + Math.ceil(s / 2); j++) {
        ctx.lineTo(x0 + rng() * cell, rng() * cell);
      }
      ctx.stroke();
    }
    // Pixels pretos espalhados (lascas)
    ctx.fillStyle = `rgba(0,0,0,${0.4 + s * 0.05})`;
    const pixels = s * 4;
    for (let i = 0; i < pixels; i++) {
      const px = x0 + Math.floor(rng() * cell);
      const py = Math.floor(rng() * cell);
      ctx.fillRect(px, py, 1, 1);
    }
  }
  const tex = new THREE.CanvasTexture(c);
  tex.magFilter = THREE.NearestFilter;
  tex.minFilter = THREE.NearestFilter;
  tex.wrapS = tex.wrapT = THREE.ClampToEdgeWrapping;
  tex.repeat.set(1 / n, 1);
  tex.offset.set(0, 0);
  tex.estagios = n;
  return tex;
}

// Retorna os 4 UVs (em CCW) para a célula [idx] do atlas, no plano
// (u: 0→u_max, v: 0→v_max). Coordenadas v invertidas (canvas top→bot).
function uvCelula(atlas, idx) {
  const col = idx % atlas.cols, row = Math.floor(idx / atlas.cols);
  const u0 = col * atlas.cellSize / (atlas.cols * atlas.cellSize);
  const u1 = (col + 1) * atlas.cellSize / (atlas.cols * atlas.cellSize);
  // canvas: y=0 no topo; texture UV: v=1 no topo. Inverter:
  const v0 = 1 - (row + 1) * atlas.cellSize / (atlas.rows * atlas.cellSize);
  const v1 = 1 - row * atlas.cellSize / (atlas.rows * atlas.cellSize);
  // 4 cantos: (u0,v0)(u1,v0)(u1,v1)(u0,v1) — mesmo CCW usado em addFace
  return [u0, v0, u1, v0, u1, v1, u0, v1];
}

class Renderer {
  constructor(canvas) {
    this.scene = new THREE.Scene();
    // Fog estilo Minecraft: cobre o último anel de chunks.
    this.scene.fog = new THREE.Fog(0x87CEEB, (VIEW_RADIUS - 1) * CHUNK_SIZE,
                                            (VIEW_RADIUS + 1) * CHUNK_SIZE);
    // FOV 70 (Minecraft default = 70).
    this.camera = new THREE.PerspectiveCamera(70, window.innerWidth / window.innerHeight, 0.1, 400);
    this.renderer = new THREE.WebGLRenderer({
      canvas,
      antialias: true,
      powerPreference: 'high-performance',
      alpha: false,
      stencil: false,
    });
    this.renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 3));
    this.renderer.setSize(window.innerWidth, window.innerHeight, false);
    this.renderer.setClearColor(0x87CEEB);
    this.renderer.outputColorSpace = THREE.SRGBColorSpace;
    // === Sem tone mapping ===
    // ACESFilmic comprime agressivamente valores baixos (sombras),
    // resultando em pretos absolutos em cavernas e faces opostas à
    // luz, mesmo com emissive ativo. Minecraft real renderiza sem
    // tone mapping (cores diretas da textura). Trocamos para
    // NoToneMapping com exposure 1.0 para preservar luminosidade
    // mínima nos pixels mais escuros.
    this.renderer.toneMapping = THREE.NoToneMapping;
    this.renderer.toneMappingExposure = 1.0;
    // Atlas de texturas procedurais 16×16 px por face, cor + ruído.
    this.atlas = criarAtlasTexturas();
    // Material de bloco com texture atlas + tinting por vertex colors
    // (vertex colors aplicam ambient-occlusion fake e tinting de bioma).
    //
    // === Luz mínima própria via emissiveMap ===
    // Sem emissive, faces opostas à luz direcional ficavam pretas em
    // cavernas e sombras pesadas. Aplicamos a própria textura também
    // como emissiveMap com intensidade ~0.55 — assim cada bloco "brilha"
    // 55% de sua cor original mesmo SEM nenhuma luz incidindo. PointLights
    // (tochas) ainda iluminam por cima; sol cria highlights visíveis.
    // Resultado: nenhum bloco fica preto, mas sombras ainda dão volume.
    // emissiveIntensity 0.30 (era 0.85 — overbright, blocos fundiam
    // visualmente, parecendo translúcidos perto de fontes de luz forte
    // como lava). Com 0.30, há piso visível em sombras MAS a iluminação
    // direcional (sol/PointLights) ainda cria contraste claro de volume.
    this.materialOpaco = new THREE.MeshLambertMaterial({
      map: this.atlas.texture,
      emissive: new THREE.Color(0xffffff),
      emissiveMap: this.atlas.texture,
      emissiveIntensity: 0.30,
      vertexColors: true,
      transparent: false,
      alphaTest: 0,
      depthWrite: true,
      side: THREE.FrontSide,
      toneMapped: false,
    });
    this.materialTransp = new THREE.MeshLambertMaterial({
      map: this.atlas.texture,
      emissive: new THREE.Color(0xffffff),
      emissiveMap: this.atlas.texture,
      emissiveIntensity: 0.30,
      vertexColors: true, transparent: true, opacity: 0.78,
      side: THREE.DoubleSide,
      toneMapped: false,
    });

    // === Iluminação ===
    // HemisphereLight em vez de AmbientLight: dá luz de cima (céu) com
    // cor diferente da luz de baixo (chão), resultando em faces
    // laterais bem mais legíveis mesmo sem iluminação direcional. Sem
    // isso, faces opostas ao sol ficavam quase pretas (Lambert puro).
    this.hemi = new THREE.HemisphereLight(0xbcd8ff, 0x6b5a3f, 0.55);
    this.scene.add(this.hemi);
    // Ambient extra de baixa intensidade — garante que NADA fique 100%
    // preto, nem mesmo de noite ou em cavernas profundas sem tochas.
    this.ambient = new THREE.AmbientLight(0xffffff, 0.35);
    this.scene.add(this.ambient);
    this.sol = new THREE.DirectionalLight(0xffffff, 0.85);
    this.sol.position.set(50, 100, 30);
    this.scene.add(this.sol);
    this.luaLuz = new THREE.DirectionalLight(0xb3c8ff, 0.0);
    this.luaLuz.position.set(-50, 100, -30);
    this.scene.add(this.luaLuz);

    // Skybox simples: MeshBasicMaterial em uma esfera grande dentro do fog
    // (uso apenas o background color via setClearColor + fog para simplicidade)

    // Sol e lua "discos" no céu — sprite simples
    this.discoSol = this.criarDisco(0xFFEE58, 6);
    this.discoLua = this.criarDisco(0xECEFF1, 4);
    this.scene.add(this.discoSol);
    this.scene.add(this.discoLua);

    // Pool de PointLights para tochas/lava (cap 8 — performance)
    this.poolLuzes = [];
    for (let i = 0; i < 8; i++) {
      const l = new THREE.PointLight(0xffaa44, 0.0, 12, 2);
      l.visible = false;
      this.scene.add(l);
      this.poolLuzes.push(l);
    }

    // === Highlight do bloco-alvo === (dupla borda preta + branca,
    // estilo Minecraft). Renderizado sempre por cima (depthTest=false)
    // pra ficar visível mesmo com bloco "atrás" no z-buffer.
    const hgEdges1 = new THREE.EdgesGeometry(new THREE.BoxGeometry(1.008, 1.008, 1.008));
    const hgPretoMat = new THREE.LineBasicMaterial({
      color: 0x000000,
      transparent: true, opacity: 0.95,
      depthTest: false, depthWrite: false,
      linewidth: 2, // só funciona em alguns browsers/desktops
    });
    this.highlightPreto = new THREE.LineSegments(hgEdges1, hgPretoMat);
    this.highlightPreto.renderOrder = 999;
    this.highlightPreto.visible = false;
    this.scene.add(this.highlightPreto);

    const hgEdges2 = new THREE.EdgesGeometry(new THREE.BoxGeometry(1.020, 1.020, 1.020));
    const hgBrancoMat = new THREE.LineBasicMaterial({
      color: 0xffffff,
      transparent: true, opacity: 0.55,
      depthTest: false, depthWrite: false,
    });
    this.highlight = new THREE.LineSegments(hgEdges2, hgBrancoMat);
    this.highlight.renderOrder = 998;
    this.highlight.visible = false;
    this.scene.add(this.highlight);

    // === Cracks progressivos === plano em cada face do bloco quebrando.
    // Gera 5 estágios (0..4) num atlas separado.
    this.crackTexture = criarTexturaCracks();
    this.crackMat = new THREE.MeshBasicMaterial({
      map: this.crackTexture, transparent: true, opacity: 1.0,
      polygonOffset: true, polygonOffsetFactor: -1, polygonOffsetUnits: -1,
    });
    // Cubo levemente maior pro overlay de cracks
    this.crackMesh = new THREE.Mesh(
      new THREE.BoxGeometry(1.004, 1.004, 1.004),
      this.crackMat
    );
    this.crackMesh.visible = false;
    this.scene.add(this.crackMesh);
    this.crackEstagioAtual = -1;

    // === Mão / ferramenta visual === anexada à câmera
    this.maoGroup = new THREE.Group();
    this.maoMesh = new THREE.Mesh(
      new THREE.BoxGeometry(0.12, 0.32, 0.12),
      new THREE.MeshLambertMaterial({ color: 0xFFCDA4 }) // pele
    );
    this.maoMesh.position.set(0, 0, 0);
    this.maoGroup.add(this.maoMesh);
    // Posição da mão em frente à câmera (canto inferior direito)
    this.maoGroup.position.set(0.32, -0.32, -0.55);
    this.maoGroup.rotation.set(-0.3, 0.2, -0.1);
    this.camera.add(this.maoGroup);
    this.scene.add(this.camera); // garantir que camera está na scene
    this.swingProgress = 0; // 0..1, animação de swing ao bater
    // Default: SÓLIDO (sem transparência). Usuário pode habilitar
    // transparência via botão 🪟. Aplicamos imediatamente:
    this.transparenciaAtiva = false;
    this.materialTransp.transparent = false;
    this.materialTransp.opacity = 1.0;
    this.materialTransp.depthWrite = true;
  }
  criarDisco(cor, raio) {
    const g = new THREE.SphereGeometry(raio, 16, 16);
    const m = new THREE.MeshBasicMaterial({ color: cor, fog: false });
    const mesh = new THREE.Mesh(g, m);
    return mesh;
  }
  resize() {
    this.camera.aspect = window.innerWidth / window.innerHeight;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(window.innerWidth, window.innerHeight, false);
  }
  // === Build mesh por chunk ===
  // Para cada bloco sólido, gera só faces visíveis (vizinho não-sólido).
  // Cada face usa UVs do atlas (textura procedural) e vertex colors com
  // ambient-occlusion fake direcional (top mais claro que side mais
  // claro que bottom), simulando profundidade.
  buildChunkMesh(world, chunk) {
    const positions = [], normals = [], colors = [], uvs = [], indices = [];
    const positionsT = [], normalsT = [], colorsT = [], uvsT = [], indicesT = [];
    chunk.lights = [];
    const cs = CHUNK_SIZE;
    const ox = chunk.cx * cs, oz = chunk.cz * cs;

    // SHADE com contraste maior agora que emissive caiu pra 0.30 — a
    // diferença entre top/side/bottom dá VOLUME visual aos blocos sem
    // o desbotamento causado pelo emissive antigo de 0.85. Mas ainda
    // mantemos bottom >= 0.70 pra que cavernas não fiquem pretas.
    const SHADE = {
      top:    1.00,
      sideX:  0.88,
      sideZ:  0.78,
      bottom: 0.70,
    };

    const addFace = (transp, faceShade, uvIdx, x, y, z, nx, ny, nz, ux, uy, uz, vx, vy, vz) => {
      const arrP = transp ? positionsT : positions;
      const arrN = transp ? normalsT  : normals;
      const arrC = transp ? colorsT   : colors;
      const arrU = transp ? uvsT      : uvs;
      const arrI = transp ? indicesT  : indices;
      const i0 = arrP.length / 3;
      arrP.push(x,           y,           z);
      arrP.push(x + ux,      y + uy,      z + uz);
      arrP.push(x + ux + vx, y + uy + vy, z + uz + vz);
      arrP.push(x + vx,      y + vy,      z + vz);
      for (let i = 0; i < 4; i++) arrN.push(nx, ny, nz);
      // Vertex color = shading fake (mesmo valor para os 4 cantos)
      for (let i = 0; i < 4; i++) arrC.push(faceShade, faceShade, faceShade);
      // UVs do atlas
      const cellUV = uvCelula(this.atlas, uvIdx);
      for (let i = 0; i < 8; i++) arrU.push(cellUV[i]);
      arrI.push(i0, i0 + 1, i0 + 2, i0, i0 + 2, i0 + 3);
    };

    for (let lx = 0; lx < cs; lx++) {
      for (let lz = 0; lz < cs; lz++) {
        for (let y = 0; y < WORLD_Y; y++) {
          const t = chunk.get(lx, y, lz);
          if (t === BLOCO.AR) continue;
          const info = BLOCO_INFO[t];
          if (!info.solido && t === BLOCO.TOCHA) {
            // Tocha: cruzeta visual + adiciona luz pontual
            this.adicionarTocha(chunk, ox + lx, y, oz + lz);
            continue;
          }
          if (info.emiteLuz) {
            chunk.lights.push({ x: ox + lx + 0.5, y: y + 0.5, z: oz + lz + 0.5, nivel: info.emiteLuz });
          }
          const x = ox + lx, z = oz + lz;
          const transp = info.transp;
          const cellMap = this.atlas.mapa[t];
          if (!cellMap) continue; // tipo desconhecido
          const idxTop = cellMap.top, idxSide = cellMap.side, idxBot = cellMap.bottom;
          // +Y top
          if (this.faceVisivel(world, x, y + 1, z, t))
            addFace(transp, SHADE.top, idxTop, x, y+1, z, 0,1,0, 1,0,0, 0,0,1);
          // -Y bottom
          if (this.faceVisivel(world, x, y - 1, z, t))
            addFace(transp, SHADE.bottom, idxBot, x, y, z+1, 0,-1,0, 1,0,0, 0,0,-1);
          // +X east
          if (this.faceVisivel(world, x + 1, y, z, t))
            addFace(transp, SHADE.sideX, idxSide, x+1, y, z, 1,0,0, 0,0,1, 0,1,0);
          // -X west
          if (this.faceVisivel(world, x - 1, y, z, t))
            addFace(transp, SHADE.sideX, idxSide, x, y, z+1, -1,0,0, 0,0,-1, 0,1,0);
          // +Z south
          if (this.faceVisivel(world, x, y, z + 1, t))
            addFace(transp, SHADE.sideZ, idxSide, x+1, y, z+1, 0,0,1, -1,0,0, 0,1,0);
          // -Z north
          if (this.faceVisivel(world, x, y, z - 1, t))
            addFace(transp, SHADE.sideZ, idxSide, x, y, z, 0,0,-1, 1,0,0, 0,1,0);
        }
      }
    }

    // Liberar mesh anterior
    if (chunk.mesh)  { this.scene.remove(chunk.mesh);  chunk.mesh.geometry.dispose();  chunk.mesh = null; }
    if (chunk.meshT) { this.scene.remove(chunk.meshT); chunk.meshT.geometry.dispose(); chunk.meshT = null; }
    if (chunk.meshTochas) {
      for (const m of chunk.meshTochas) { this.scene.remove(m); m.geometry.dispose(); }
      chunk.meshTochas = null;
    }

    if (positions.length > 0) {
      const g = new THREE.BufferGeometry();
      g.setAttribute('position', new THREE.Float32BufferAttribute(positions, 3));
      g.setAttribute('normal',   new THREE.Float32BufferAttribute(normals, 3));
      g.setAttribute('color',    new THREE.Float32BufferAttribute(colors, 3));
      g.setAttribute('uv',       new THREE.Float32BufferAttribute(uvs, 2));
      g.setIndex(indices);
      chunk.mesh = new THREE.Mesh(g, this.materialOpaco);
      chunk.mesh.frustumCulled = true;
      this.scene.add(chunk.mesh);
    }
    if (positionsT.length > 0) {
      const g = new THREE.BufferGeometry();
      g.setAttribute('position', new THREE.Float32BufferAttribute(positionsT, 3));
      g.setAttribute('normal',   new THREE.Float32BufferAttribute(normalsT, 3));
      g.setAttribute('color',    new THREE.Float32BufferAttribute(colorsT, 3));
      g.setAttribute('uv',       new THREE.Float32BufferAttribute(uvsT, 2));
      g.setIndex(indicesT);
      chunk.meshT = new THREE.Mesh(g, this.materialTransp);
      chunk.meshT.frustumCulled = true;
      this.scene.add(chunk.meshT);
    }
    chunk.dirty = false;
  }
  // Tocha: pequeno cubo amarelo + adiciona à lista de luzes do chunk
  adicionarTocha(chunk, x, y, z) {
    chunk.lights.push({ x: x + 0.5, y: y + 0.6, z: z + 0.5, nivel: 13 });
    // Visualmente, adicionamos um cubo pequeno como Mesh extra
    if (!chunk.meshTochas) {
      chunk.meshTochas = [];
    }
    const g = new THREE.BoxGeometry(0.18, 0.6, 0.18);
    const m = new THREE.MeshBasicMaterial({ color: 0xFFB300 });
    const mesh = new THREE.Mesh(g, m);
    mesh.position.set(x + 0.5, y + 0.4, z + 0.5);
    this.scene.add(mesh);
    chunk.meshTochas.push(mesh);
  }
  faceVisivel(world, nx, ny, nz, blocoSelf) {
    if (ny < 0 || ny >= WORLD_Y) return true;
    const t = world.get(nx, ny, nz);
    if (t === BLOCO.AR) return true;
    if (t === blocoSelf) return false; // mesma transparência: não desenha entre iguais
    return BLOCO_INFO[t].transp;
  }
  liberarChunkMesh(chunk) {
    if (chunk.mesh) { this.scene.remove(chunk.mesh); chunk.mesh.geometry.dispose(); chunk.mesh = null; }
    if (chunk.meshT) { this.scene.remove(chunk.meshT); chunk.meshT.geometry.dispose(); chunk.meshT = null; }
    if (chunk.meshTochas) {
      for (const m of chunk.meshTochas) { this.scene.remove(m); m.geometry.dispose(); }
      chunk.meshTochas = null;
    }
  }
  // Atualiza céu (sol/lua) e luzes pontuais
  atualizarCeu(tempoDia, playerPos) {
    // sun = sin(2π·t - π/2): pico em t=0.25 (meio-dia)
    const sun = Math.max(0.05, 0.5 + 0.5 * Math.sin(tempoDia * Math.PI * 2 - Math.PI / 2));
    // emissive agora é apenas 30% (não 85%), então as luzes ambientes
    // precisam carregar mais peso pra que blocos longe de fontes de luz
    // não fiquem escuros demais.
    this.hemi.intensity    = 0.55 + 0.50 * sun;    // 0.55 noite → 1.05 dia
    this.ambient.intensity = 0.40 + 0.35 * sun;    // 0.40 noite → 0.75 dia
    this.sol.intensity     = 0.20 + 0.80 * sun;    // 0.20 noite → 1.00 dia
    this.luaLuz.intensity  = 0.40 * (1 - sun);     // 0.40 noite → 0.0 dia
    // Cor do hemi muda também: noite tinge azulado, dia neutro.
    if (sun < 0.4) {
      this.hemi.color.setHex(0x4a6ba8); // azul-noite
      this.hemi.groundColor.setHex(0x2e2820);
    } else {
      this.hemi.color.setHex(0xbcd8ff);
      this.hemi.groundColor.setHex(0x6b5a3f);
    }

    // Cor do céu: noite escura → crepúsculo laranja → dia azul.
    // Piso noturno elevado pra que "ver o céu" através de buracos no
    // terreno nunca pareça uma região preta-vazia. Antes c1 era
    // 0x0B1430 (RGB 11/20/48) — perto do preto perceptual; agora
    // 0x4a5878 (RGB 74/88/120) — ainda noturno mas sempre visível.
    const c1 = new THREE.Color(0x4a5878);
    const c2 = new THREE.Color(0xFF8A65);
    const c3 = new THREE.Color(0x87CEEB);
    let bg;
    if (sun < 0.35) {
      bg = c1.clone().lerp(c2, sun / 0.35);
    } else {
      bg = c2.clone().lerp(c3, (sun - 0.35) / 0.65);
    }
    this.renderer.setClearColor(bg);
    if (this.scene.fog) this.scene.fog.color.copy(bg);

    // Posição dos discos sol/lua: arco em torno do player
    const ang = (tempoDia - 0.25) * Math.PI * 2;
    const r = 80;
    this.discoSol.position.set(
      playerPos.x + Math.sin(ang) * r,
      playerPos.y + Math.cos(ang) * r * 0.7,
      playerPos.z
    );
    this.discoLua.position.set(
      playerPos.x + Math.sin(ang + Math.PI) * r,
      playerPos.y + Math.cos(ang + Math.PI) * r * 0.7,
      playerPos.z
    );
    this.discoSol.visible = this.discoSol.position.y > playerPos.y - 30;
    this.discoLua.visible = this.discoLua.position.y > playerPos.y - 30;

    // Direção do sol/lua aponta para origem do mundo
    this.sol.position.copy(this.discoSol.position);
    this.luaLuz.position.copy(this.discoLua.position);
  }
  atualizarLuzesPontuais(world, playerPos) {
    // Coleta as luzes mais próximas do player (até 8)
    const cx = Math.floor(playerPos.x / CHUNK_SIZE);
    const cz = Math.floor(playerPos.z / CHUNK_SIZE);
    const candidatas = [];
    for (let dx = -2; dx <= 2; dx++) {
      for (let dz = -2; dz <= 2; dz++) {
        const c = world.chunks.get(chunkKey(cx + dx, cz + dz));
        if (!c) continue;
        for (const l of c.lights) {
          const ddx = l.x - playerPos.x, ddy = l.y - playerPos.y, ddz = l.z - playerPos.z;
          candidatas.push({ ...l, d2: ddx*ddx + ddy*ddy + ddz*ddz });
        }
      }
    }
    candidatas.sort((a, b) => a.d2 - b.d2);
    for (let i = 0; i < this.poolLuzes.length; i++) {
      const l = this.poolLuzes[i];
      const c = candidatas[i];
      if (c) {
        l.visible = true;
        l.position.set(c.x, c.y, c.z);
        // Intensity reduzida (1.4 → 0.8) pra evitar overbright que
        // saturava blocos próximos da lava, parecendo desbotamento.
        l.intensity = c.nivel / 15 * 0.8;
        l.distance = c.nivel + 1;
        l.color.setHex(c.nivel >= 15 ? 0xff6622 : 0xffaa55);
      } else {
        l.visible = false;
      }
    }
  }
  // === Alterna transparência global ===
  // ativa=true (default): folhas/vidro/água/tocha são semitransparentes
  // (mostram blocos atrás). ativa=false: tudo vira sólido (opaco), útil
  // quando o usuário acha que está vendo "transparência demais" e quer
  // o visual cheio Minecraft-style.
  setTransparenciaAtiva(ativa) {
    this.transparenciaAtiva = ativa;
    if (ativa) {
      this.materialTransp.transparent = true;
      this.materialTransp.opacity = 0.78;
      this.materialTransp.depthWrite = false;
    } else {
      this.materialTransp.transparent = false;
      this.materialTransp.opacity = 1.0;
      this.materialTransp.depthWrite = true;
    }
    this.materialTransp.needsUpdate = true;
  }

  // === Atualiza highlight, cracks e tremor com base no alvo do raycast ===
  atualizarAlvo(hit, progressoQuebra) {
    if (hit) {
      const cx = hit.x + 0.5, cy = hit.y + 0.5, cz = hit.z + 0.5;
      this.highlight.position.set(cx, cy, cz);
      this.highlight.visible = true;
      this.highlightPreto.position.set(cx, cy, cz);
      this.highlightPreto.visible = true;
      // Cracks: estágio 0..9 (10 estágios como Minecraft real)
      const estagio = Math.min(9, Math.floor(progressoQuebra * 10));
      if (estagio > 0) {
        // Tremor leve do bloco quebrando — translação aleatória
        // proporcional ao progresso. Em Minecraft o bloco "vibra" enquanto
        // quebra; aqui aplicamos pequeno offset randômico em x/y/z.
        const intensidade = 0.012 + progressoQuebra * 0.025;
        const tx = (Math.random() - 0.5) * intensidade;
        const ty = (Math.random() - 0.5) * intensidade;
        const tz = (Math.random() - 0.5) * intensidade;
        this.crackMesh.position.set(
          hit.x + 0.5 + tx, hit.y + 0.5 + ty, hit.z + 0.5 + tz);
        this.crackMesh.visible = true;
        if (estagio !== this.crackEstagioAtual) {
          this.crackTexture.offset.x = estagio / this.crackTexture.estagios;
          this.crackEstagioAtual = estagio;
        }
      } else {
        this.crackMesh.visible = false;
        this.crackEstagioAtual = -1;
      }
    } else {
      this.highlight.visible = false;
      this.highlightPreto.visible = false;
      this.crackMesh.visible = false;
      this.crackEstagioAtual = -1;
    }
  }

  // === Animação da mão === swing rápido ao quebrar/atacar.
  atualizarMao(dt, swinging, ferramenta) {
    // Cor/forma da mão muda conforme item segurado
    if (ferramenta) {
      // Empunhando ferramenta: cubo mais alongado e cinza
      this.maoMesh.material.color.setHex(0x9E9E9E);
      this.maoMesh.scale.set(1.0, 2.4, 1.0);
    } else {
      // Mão nua: pele
      this.maoMesh.material.color.setHex(0xFFCDA4);
      this.maoMesh.scale.set(1.0, 1.0, 1.0);
    }
    // Swing: progredir de 0→1 quando swinging, decair caso contrário
    const swingSpeed = 4.0;
    if (swinging) {
      this.swingProgress += dt * swingSpeed;
      if (this.swingProgress >= 1) this.swingProgress = 0; // loop contínuo
    } else {
      this.swingProgress = Math.max(0, this.swingProgress - dt * swingSpeed * 1.4);
    }
    // Função sine para movimento smooth (rotação no eixo X)
    const a = Math.sin(this.swingProgress * Math.PI);
    this.maoGroup.rotation.x = -0.3 - a * 1.1;       // bate para frente
    this.maoGroup.rotation.z = -0.1 + a * 0.4;       // gira levemente
    this.maoGroup.position.y = -0.32 + a * 0.06;     // sobe um pouco
  }

  render() { this.renderer.render(this.scene, this.camera); }
}

// ===================================================================
// 5) Player + Controles
// ===================================================================
// Vetores temporários reutilizados a cada frame (evita alocações GC).
const _tmpVecFwd = new THREE.Vector3();
const _tmpVecRight = new THREE.Vector3();
const _tmpVecAux = new THREE.Vector3();
const _yAxis = new THREE.Vector3(0, 1, 0);

class Player {
  constructor(camera) {
    this.pos = new THREE.Vector3(8, 30, 8);
    this.vel = new THREE.Vector3();
    this.noChao = false;
    this.modo = 'creative';   // 'creative' | 'survival'
    this.terceiraPessoa = false;
    this.hp = 20; this.hpMax = 20;
    this.fome = 20; this.fomeMax = 20;
    this.xp = 0; this.nivel = 0;
    this.morto = false;
    this.spawn = this.pos.clone();
    this.semDano = 99;
    this.accFome = 0;
    this.accRegen = 0;
    this.accDanoTerreno = 0;

    this.camera = camera;
    this.controls = null;

    this.input = { fwd: 0, side: 0, up: 0, sprint: false, jump: false };
    this.cliqueE = false; this.cliqueD = false; this.holdE = false;
    this.progressoQuebra = 0;
    this.alvoQuebra = null; // {x,y,z}
  }
  atualizar(dt, world) {
    if (this.morto) return;
    // === Input WASD relativo à direção real da câmera ===
    // camera.getWorldDirection() retorna a direção forward verdadeira
    // (após qualquer pitch/yaw aplicado pelos PointerLockControls), sem
    // depender da convenção de eixos de Three.js. Projetamos no plano
    // horizontal pra que olhar para cima/baixo não levante/abaixe ao
    // andar para frente.
    const fwd = _tmpVecFwd.set(0, 0, 0);
    this.camera.getWorldDirection(fwd);
    fwd.y = 0;
    if (fwd.lengthSq() > 1e-6) fwd.normalize();
    const right = _tmpVecRight.crossVectors(fwd, _yAxis).normalize();

    const speed = (this.input.sprint ? VEL_SPRINT : VEL_ANDAR);
    // W (fwd=1) → +forward, S (fwd=-1) → -forward
    // D (side=1) → +right, A (side=-1) → -right
    let dx = fwd.x * this.input.fwd + right.x * this.input.side;
    let dz = fwd.z * this.input.fwd + right.z * this.input.side;
    const len = Math.hypot(dx, dz);
    if (len > 0) { dx /= len; dz /= len; }
    const move = (this.modo === 'creative' || this.noChao) ? speed : VEL_AR;
    let vx = dx * move, vz = dz * move;
    let vy;
    if (this.modo === 'creative') {
      vy = this.input.up * speed;
      this.vel.y = vy;
      this.noChao = true;
    } else {
      // Gravidade
      this.vel.y += GRAVIDADE * dt;
      if (this.vel.y < VEL_TERM) this.vel.y = VEL_TERM;
      vy = this.vel.y;
      if (this.input.jump && this.noChao) {
        this.vel.y = PULO_VEL;
        vy = PULO_VEL;
        this.noChao = false;
      }
    }
    this.input.jump = false;

    // === Move com colisão por eixo (AABB) ===
    const yMaxAntes = Math.max(this.pos.y, this.spawnY || this.pos.y);
    this.spawnY = yMaxAntes;

    this.moverEixo(world, vx * dt, 0, 0);
    this.moverEixo(world, 0, vy * dt, 0);
    this.moverEixo(world, 0, 0, vz * dt);

    // === Câmera ===
    if (this.terceiraPessoa) {
      // Coloca câmera atrás/acima do player
      const back = new THREE.Vector3(-Math.sin(yaw), 0.5, -Math.cos(yaw)).multiplyScalar(-4);
      this.camera.position.copy(this.pos).add(back).add(new THREE.Vector3(0, PLAYER_HEIGHT * 0.85, 0));
    } else {
      this.camera.position.set(this.pos.x, this.pos.y + PLAYER_HEIGHT * 0.85, this.pos.z);
    }

    // === Sobrevivência ===
    this.semDano += dt;
    this.accDanoTerreno += dt;
    if (this.accDanoTerreno >= 0.5) {
      this.accDanoTerreno = 0;
      const bDentro = world.get(Math.floor(this.pos.x), Math.floor(this.pos.y + 0.5), Math.floor(this.pos.z));
      const bPe = world.get(Math.floor(this.pos.x), Math.floor(this.pos.y - 0.1), Math.floor(this.pos.z));
      if (bDentro === BLOCO.LAVA || bPe === BLOCO.LAVA) this.aplicarDano(3, 'lava');
      else if (bDentro === BLOCO.CACTO || bPe === BLOCO.CACTO) this.aplicarDano(1, 'cacto');
    }
    this.accFome += dt;
    if (this.accFome >= 30 && this.fome > 0) { this.accFome = 0; this.fome -= 1; }
    this.accRegen += dt;
    if (this.fome >= 18 && this.semDano >= 4 && this.hp < this.hpMax && this.accRegen >= 4) {
      this.accRegen = 0; this.hp += 1;
    }
  }
  moverEixo(world, dx, dy, dz) {
    if (dx === 0 && dy === 0 && dz === 0) return;
    const novoX = this.pos.x + dx;
    const novoY = this.pos.y + dy;
    const novoZ = this.pos.z + dz;
    if (this.colisaoBlocos(world, novoX, this.pos.y, this.pos.z, dx)) {
      // bloqueado em X
    } else { this.pos.x = novoX; }
    if (this.colisaoBlocos(world, this.pos.x, novoY, this.pos.z, dy)) {
      if (dy < 0) {
        // landed
        const queda = (this.spawnY || this.pos.y) - novoY;
        if (this.modo === 'survival' && queda > 4) {
          const dano = Math.round(queda - 3);
          if (dano > 0) this.aplicarDano(dano, `queda ${queda.toFixed(1)}`);
        }
        this.spawnY = this.pos.y;
        this.noChao = true;
      }
      this.vel.y = 0;
    } else {
      this.pos.y = novoY;
      if (dy > 0) this.spawnY = Math.max(this.spawnY || this.pos.y, this.pos.y);
      else this.noChao = false;
    }
    if (this.colisaoBlocos(world, this.pos.x, this.pos.y, novoZ, dz)) {
      // bloqueado em Z
    } else { this.pos.z = novoZ; }
  }
  // Verifica colisão da AABB do player com blocos sólidos.
  colisaoBlocos(world, px, py, pz) {
    const r = PLAYER_RADIUS;
    const x0 = Math.floor(px - r), x1 = Math.floor(px + r);
    const y0 = Math.floor(py),     y1 = Math.floor(py + PLAYER_HEIGHT - 0.05);
    const z0 = Math.floor(pz - r), z1 = Math.floor(pz + r);
    for (let x = x0; x <= x1; x++) for (let y = y0; y <= y1; y++) for (let z = z0; z <= z1; z++) {
      if (BLOCO_INFO[world.get(x, y, z)].solido) return true;
    }
    return false;
  }
  aplicarDano(d, fonte) {
    if (this.morto) return;
    // Aplica redução por armadura: cada ponto de defesa = 4% redução,
    // até o teto de 80% (clamp Minecraft-like). Dano mínimo é 1.
    const defesa = inv ? inv.defesaTotal() : 0;
    const reducao = Math.min(0.8, defesa * 0.04);
    const danoReal = Math.max(1, Math.round(d * (1 - reducao)));
    this.hp -= danoReal;
    this.semDano = 0;
    Audio.hit();
    if (this.hp <= 0) {
      this.hp = 0;
      this.morto = true;
      ui.toast(`Você morreu (${fonte})`);
      ui.mostrarMorte();
    } else {
      ui.toast(`-${danoReal} HP (${fonte})${defesa > 0 ? ` [armadura: -${d - danoReal}]` : ''}`);
    }
  }
  respawnar() {
    this.pos.copy(this.spawn);
    this.vel.set(0, 0, 0);
    this.hp = this.hpMax;
    this.fome = this.fomeMax;
    this.morto = false;
    this.spawnY = this.pos.y;
    Audio.respawn();
    ui.toast('Respawn');
    ui.esconderMorte();
  }
}

// ===================================================================
// 6) Inventário, Drops, Crafting
// ===================================================================
class Inventario {
  constructor() {
    this.slots = new Array(36).fill(null); // {b?, i?, q}
    this.slotSel = 0;
    // 4 slots de armadura (cabeca/torso/pernas/botas) — sempre 1 item cada.
    this.armadura = { cabeca: null, torso: null, pernas: null, botas: null };
  }
  // Defesa total (em pontos) = soma das defesas de cada peça equipada.
  defesaTotal() {
    let total = 0;
    for (const peca of Object.values(this.armadura)) {
      if (peca && peca.i !== undefined) {
        total += ITEM_INFO[peca.i]?.defesa || 0;
      }
    }
    return total;
  }
  // Tenta equipar item na peça correta. Se há armadura no slot, troca
  // (item retorna pro inventário no slot original). Retorna true se ok.
  equiparDoSlot(idx) {
    const it = this.slots[idx];
    if (!it || it.i === undefined) return false;
    const info = ITEM_INFO[it.i];
    if (!info?.armadura) return false;
    const peca = info.armadura;
    const anterior = this.armadura[peca];
    this.armadura[peca] = { ...it, q: 1 };
    this.slots[idx] = anterior; // pode ser null
    ui.atualizar();
    return true;
  }
  desequipar(peca) {
    const item = this.armadura[peca];
    if (!item) return false;
    if (this.adicionar(item)) {
      this.armadura[peca] = null;
      ui.atualizar();
      return true;
    }
    return false;
  }
  itemSelecionado() { return this.slots[this.slotSel]; }
  selecionar(idx) { this.slotSel = ((idx % 9) + 9) % 9; ui.atualizar(); }
  adicionar(item) {
    // empilhar em slots existentes
    for (let i = 0; i < this.slots.length; i++) {
      const s = this.slots[i];
      if (!s) continue;
      if (s.b === item.b && s.i === item.i) {
        const max = item.i !== undefined && item.i >= 200 ? 1 : 64;
        const cabe = max - s.q;
        if (cabe <= 0) continue;
        const mover = Math.min(cabe, item.q);
        s.q += mover;
        item.q -= mover;
        if (item.q <= 0) { ui.atualizar(); return true; }
      }
    }
    // novo slot
    for (let i = 0; i < this.slots.length; i++) {
      if (!this.slots[i]) {
        this.slots[i] = { ...item };
        ui.atualizar();
        return true;
      }
    }
    ui.atualizar();
    return false;
  }
  consumirAtual() {
    const s = this.slots[this.slotSel];
    if (!s) return;
    s.q -= 1;
    if (s.q <= 0) this.slots[this.slotSel] = null;
    ui.atualizar();
  }
  contar(b, i) {
    let total = 0;
    for (const s of this.slots) {
      if (s && s.b === b && s.i === i) total += s.q;
    }
    return total;
  }
  consumir(b, i, n) {
    let restante = n;
    for (let k = 0; k < this.slots.length && restante > 0; k++) {
      const s = this.slots[k];
      if (!s || s.b !== b || s.i !== i) continue;
      const m = Math.min(s.q, restante);
      s.q -= m; restante -= m;
      if (s.q <= 0) this.slots[k] = null;
    }
    ui.atualizar();
  }
  trocar(a, b) {
    const t = this.slots[a]; this.slots[a] = this.slots[b]; this.slots[b] = t;
    ui.atualizar();
  }
  melhorPicareta() {
    let melhor = 0;
    for (const s of this.slots) {
      if (!s || s.i === undefined) continue;
      const info = ITEM_INFO[s.i];
      if (info && info.ferramenta === 'pic' && info.tier > melhor) melhor = info.tier;
    }
    return melhor;
  }
  melhorEspada() {
    let melhor = 0;
    for (const s of this.slots) {
      if (!s || s.i === undefined) continue;
      const info = ITEM_INFO[s.i];
      if (info && info.ferramenta === 'esp' && info.tier > melhor) melhor = info.tier;
    }
    return melhor;
  }
}

const Drops = {
  podeMinerar(b, tier) {
    if ([BLOCO.DIAMANTE, BLOCO.OURO].includes(b)) return tier >= 3;
    if (b === BLOCO.FERRO) return tier >= 2;
    if ([BLOCO.PEDRA, BLOCO.CARVAO].includes(b)) return tier >= 1;
    if (b === BLOCO.OBSIDIANA) return tier >= 4;
    return ![BLOCO.AR, BLOCO.AGUA, BLOCO.LAVA].includes(b);
  },
  dropDeBloco(b, tier) {
    if (!Drops.podeMinerar(b, tier)) return [];
    switch (b) {
      case BLOCO.GRAMA:    return [{ b: BLOCO.TERRA, q: 1 }];
      case BLOCO.PEDRA:    return [{ b: BLOCO.PEDRA, q: 1 }];
      case BLOCO.OURO:     return [{ i: ITEM.OURO, q: 1 }];
      case BLOCO.DIAMANTE: return [{ i: ITEM.DIAMANTE, q: 1 }];
      case BLOCO.CARVAO:   return [{ i: ITEM.CARVAO, q: 1 }];
      case BLOCO.FERRO:    return [{ i: ITEM.FERRO, q: 1 }];
      case BLOCO.FOLHA:    return Math.random() < 0.05 ? [{ i: ITEM.PAU, q: 1 }] : [];
      case BLOCO.VIDRO:    return [];
      case BLOCO.AGUA: case BLOCO.LAVA: return [];
      case BLOCO.BAU: case BLOCO.FORNALHA: case BLOCO.CAMA:
        return [{ b, q: 1 }];
      default: return [{ b, q: 1 }];
    }
  },
  velocidadeQuebra(b, tier, ferr) {
    if (!Drops.podeMinerar(b, tier)) return 0.4;
    const cat = (() => {
      if ([BLOCO.PEDRA, BLOCO.CARVAO, BLOCO.FERRO, BLOCO.OURO, BLOCO.DIAMANTE, BLOCO.OBSIDIANA, BLOCO.TIJOLO].includes(b)) return 'pic';
      if ([BLOCO.MADEIRA, BLOCO.FOLHA].includes(b)) return 'machado';
      return 'pa';
    })();
    if (cat === 'pic' && ferr === 'pic') return 1.5 + tier * 0.4;
    return 1.0;
  },
};

const Crafting = {
  disponiveis(inv, perto) {
    return RECEITAS.filter(r => (perto || !r.wb) && r.custos.every(c =>
      (c.b !== undefined ? inv.contar(c.b, undefined) : inv.contar(undefined, c.i)) >= c.q
    ));
  },
  craftar(inv, r, perto) {
    if (r.wb && !perto) return false;
    if (!r.custos.every(c =>
      (c.b !== undefined ? inv.contar(c.b, undefined) : inv.contar(undefined, c.i)) >= c.q
    )) return false;
    for (const c of r.custos) {
      if (c.b !== undefined) inv.consumir(c.b, undefined, c.q);
      else inv.consumir(undefined, c.i, c.q);
    }
    inv.adicionar({ ...r.saida });
    Audio.colocar();
    return true;
  },
};

// ===================================================================
// 6.5) Sistema de partículas (faíscas ao quebrar bloco)
// ===================================================================
class Particulas {
  constructor(scene) {
    this.scene = scene;
    this.geo = new THREE.BoxGeometry(0.12, 0.12, 0.12);
    this.lista = [];
    this.materiaisCache = new Map(); // hex → MeshBasicMaterial
  }
  _matPara(corHex) {
    let m = this.materiaisCache.get(corHex);
    if (!m) {
      m = new THREE.MeshBasicMaterial({ color: corHex });
      this.materiaisCache.set(corHex, m);
    }
    return m;
  }
  // Spawna 10-14 partículas voando ao redor do ponto (x,y,z) com a cor
  // do bloco quebrado. Cada partícula tem velocidade + gravidade + life.
  spawnQuebra(cx, cy, cz, blocoTipo) {
    const cor = BLOCO_INFO[blocoTipo]?.cor ?? 0x888888;
    const mat = this._matPara(cor);
    const n = 10 + Math.floor(Math.random() * 5);
    for (let i = 0; i < n; i++) {
      const m = new THREE.Mesh(this.geo, mat);
      m.position.set(
        cx + 0.5 + (Math.random() - 0.5) * 0.6,
        cy + 0.5 + (Math.random() - 0.5) * 0.6,
        cz + 0.5 + (Math.random() - 0.5) * 0.6
      );
      m.userData = {
        vx: (Math.random() - 0.5) * 4.5,
        vy: 1.5 + Math.random() * 3.5,
        vz: (Math.random() - 0.5) * 4.5,
        life: 0.8 + Math.random() * 0.4,
        lifeMax: 1.0,
      };
      m.userData.lifeMax = m.userData.life;
      this.scene.add(m);
      this.lista.push(m);
    }
  }
  atualizar(dt) {
    for (let i = this.lista.length - 1; i >= 0; i--) {
      const p = this.lista[i];
      const u = p.userData;
      p.position.x += u.vx * dt;
      p.position.y += u.vy * dt;
      p.position.z += u.vz * dt;
      u.vy -= 14 * dt;
      // Atrito horizontal
      u.vx *= 0.92;
      u.vz *= 0.92;
      u.life -= dt;
      // Encolhe ao morrer
      const k = Math.max(0, u.life / u.lifeMax);
      p.scale.setScalar(0.6 + 0.5 * k);
      if (u.life <= 0) {
        this.scene.remove(p);
        this.lista.splice(i, 1);
      }
    }
  }
}

// ===================================================================
// 7) Mobs (versão simples 3D — cubos coloridos com AI)
// ===================================================================
const TIPO_MOB = {
  VACA: 'vaca', GALINHA: 'galinha', PORCO: 'porco', OVELHA: 'ovelha',
  ZUMBI: 'zumbi', ESQUELETO: 'esqueleto', ARANHA: 'aranha', CREEPER: 'creeper', LOBO: 'lobo',
};
const MOB_INFO = {
  vaca:      { hp: 8,  vel: 1.4, hostil: false,
               drops: () => [
                 { i: ITEM.CARNE_CRUA, q: 1 + (Math.random() < 0.5 ? 1 : 0) },
                 { i: ITEM.COURO, q: 1 + (Math.random() < 0.5 ? 1 : 0) },
               ],
               cor: 0xffffff, sec: 0x424242 },
  galinha:   { hp: 4,  vel: 1.7, hostil: false, drops: () => [{ i: ITEM.CARNE_CRUA, q: 1 }, ...(Math.random() < 0.5 ? [{ i: ITEM.OVO, q: 1 }] : [])], cor: 0xfff59d, sec: 0xff6f00 },
  porco:     { hp: 6,  vel: 1.5, hostil: false,
               drops: () => [
                 { i: ITEM.CARNE_CRUA, q: 1 + (Math.random() < 0.5 ? 1 : 0) },
                 ...(Math.random() < 0.4 ? [{ i: ITEM.COURO, q: 1 }] : []),
               ],
               cor: 0xf8bbd0, sec: 0xec407a },
  ovelha:    { hp: 8,  vel: 1.3, hostil: false, drops: () => [{ b: BLOCO.LA, q: 1 + (Math.random() < 0.5 ? 1 : 0) }], cor: 0xfafafa, sec: 0xeeeeee },
  zumbi:     { hp: 16, vel: 2.2, hostil: true, dano: 2, alcance: 1.6, drops: () => Math.random() < 0.6 ? [{ i: ITEM.CARNE_PODRE, q: 1 }] : [], cor: 0x4caf50, sec: 0x2e7d32 },
  esqueleto: { hp: 14, vel: 1.8, hostil: true, dano: 2, alcance: 6.0, drops: () => [{ i: ITEM.PAU, q: 1 }], cor: 0xe0e0e0, sec: 0x9e9e9e },
  aranha:    { hp: 12, vel: 2.6, hostil: true, dano: 3, alcance: 1.6, drops: () => Math.random() < 0.5 ? [{ b: BLOCO.LA, q: 1 }] : [], cor: 0x263238, sec: 0xb71c1c },
  creeper:   { hp: 10, vel: 1.9, hostil: true, dano: 8, alcance: 2.0, drops: () => Math.random() < 0.5 ? [{ i: ITEM.CARVAO, q: 1 }] : [], cor: 0x2e7d32, sec: 0x1b5e20, explode: true },
  lobo:      { hp: 12, vel: 2.4, hostil: false, amigavel: true, drops: () => [], cor: 0x9e9e9e, sec: 0xeeeeee },
};

// Constrói um Group de Three.js com o modelo geométrico do mob (cabeça,
// corpo, pernas, braços) estilo Minecraft. Preenche userData.partes com
// referências para que a animação consiga oscilar pernas/braços.
function construirModeloMob(tipo, info) {
  const matCor = (c) => new THREE.MeshLambertMaterial({ color: c });
  const cubo = (w, h, d, c) => new THREE.Mesh(new THREE.BoxGeometry(w, h, d), matCor(c));
  const grp = new THREE.Group();
  const partes = {};

  // Pivot trick: pra animar pernas oscilando, criamos um Group por
  // perna com pivot no topo dela, e o cubo da perna pendurado abaixo.
  const pernaComPivot = (w, h, d, cor, posY) => {
    const pivot = new THREE.Group();
    pivot.position.y = posY;
    const m = cubo(w, h, d, cor);
    m.position.y = -h / 2;
    pivot.add(m);
    return pivot;
  };

  switch (tipo) {
    case 'vaca':
    case 'porco':
    case 'ovelha':
    case 'lobo': {
      // Quadrupede
      const corpo = cubo(0.5, 0.5, 0.85, info.cor);
      corpo.position.y = 0.65;
      grp.add(corpo);
      const cabeca = cubo(0.4, 0.4, 0.4, info.cor);
      cabeca.position.set(0, 0.7, 0.55);
      grp.add(cabeca);
      // Detalhe: orelhas/manchas via cubo da cor secundária
      if (tipo === 'vaca') {
        const m1 = cubo(0.52, 0.05, 0.2, info.sec);
        m1.position.set(0.0, 0.92, 0.05); grp.add(m1);
        const m2 = cubo(0.52, 0.05, 0.18, info.sec);
        m2.position.set(0.0, 0.92, -0.25); grp.add(m2);
      }
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const dx = (i % 2 === 0 ? -0.15 : 0.15);
        const dz = (i < 2 ? 0.28 : -0.28);
        const p = pernaComPivot(0.16, 0.4, 0.16, info.sec, 0.4);
        p.position.x = dx;
        p.position.z = dz;
        grp.add(p);
        pernas.push(p);
      }
      partes.cabeca = cabeca;
      partes.pernas = pernas;
      partes.corpo = corpo;
      break;
    }
    case 'galinha': {
      const corpo = cubo(0.3, 0.35, 0.45, info.cor);
      corpo.position.y = 0.5;
      grp.add(corpo);
      const cabeca = cubo(0.22, 0.25, 0.22, info.cor);
      cabeca.position.set(0, 0.78, 0.22);
      grp.add(cabeca);
      // crista vermelha
      const crista = cubo(0.08, 0.08, 0.18, 0xC62828);
      crista.position.set(0, 0.95, 0.22); grp.add(crista);
      // bico
      const bico = cubo(0.1, 0.08, 0.12, info.sec);
      bico.position.set(0, 0.76, 0.4);
      grp.add(bico);
      const pernas = [];
      for (let i = 0; i < 2; i++) {
        const p = pernaComPivot(0.07, 0.28, 0.07, info.sec, 0.28);
        p.position.x = (i === 0 ? -0.1 : 0.1);
        grp.add(p);
        pernas.push(p);
      }
      partes.cabeca = cabeca;
      partes.pernas = pernas;
      partes.corpo = corpo;
      break;
    }
    case 'zumbi':
    case 'esqueleto': {
      // Humanoide: cabeça + corpo + 2 braços + 2 pernas
      const corpo = cubo(0.5, 0.7, 0.25, info.cor);
      corpo.position.y = 1.0;
      grp.add(corpo);
      const cabeca = cubo(0.45, 0.45, 0.45, info.sec);
      cabeca.position.set(0, 1.6, 0);
      grp.add(cabeca);
      // Olhos vermelhos pra hostis
      const oR = cubo(0.07, 0.07, 0.04, 0xff2222);
      oR.position.set(-0.1, 1.62, 0.23); grp.add(oR);
      const oL = cubo(0.07, 0.07, 0.04, 0xff2222);
      oL.position.set( 0.1, 1.62, 0.23); grp.add(oL);
      const bracos = [];
      for (let i = 0; i < 2; i++) {
        const b = pernaComPivot(0.18, 0.65, 0.18, info.cor, 1.3);
        b.position.x = (i === 0 ? -0.34 : 0.34);
        grp.add(b);
        bracos.push(b);
      }
      const pernas = [];
      for (let i = 0; i < 2; i++) {
        const p = pernaComPivot(0.2, 0.65, 0.2, info.sec, 0.65);
        p.position.x = (i === 0 ? -0.12 : 0.12);
        grp.add(p);
        pernas.push(p);
      }
      partes.cabeca = cabeca;
      partes.corpo = corpo;
      partes.bracos = bracos;
      partes.pernas = pernas;
      break;
    }
    case 'aranha': {
      const corpoTras = cubo(0.7, 0.45, 0.55, info.cor);
      corpoTras.position.set(0, 0.4, -0.15); grp.add(corpoTras);
      const cabeca = cubo(0.4, 0.35, 0.4, info.sec);
      cabeca.position.set(0, 0.4, 0.35); grp.add(cabeca);
      // Olhos vermelhos
      for (let i = 0; i < 4; i++) {
        const o = cubo(0.06, 0.06, 0.04, 0xff0000);
        const x = (i % 2 === 0 ? -0.12 : 0.12);
        const y = (i < 2 ? 0.5 : 0.4);
        o.position.set(x, y, 0.55); grp.add(o);
      }
      const pernas = [];
      for (let i = 0; i < 8; i++) {
        const angle = ((i / 8) - 0.5) * Math.PI;
        const lado = i < 4 ? -1 : 1;
        const ang2 = angle * lado;
        const p = pernaComPivot(0.07, 0.5, 0.07, 0x000000, 0.45);
        p.position.set(lado * 0.3, 0.45,
          (i < 4 ? i - 1.5 : (i - 5.5)) * 0.16);
        p.rotation.z = lado * (0.4 + (i % 4) * 0.05);
        grp.add(p);
        pernas.push(p);
      }
      partes.cabeca = cabeca;
      partes.pernas = pernas;
      break;
    }
    case 'creeper': {
      const corpo = cubo(0.4, 1.3, 0.4, info.cor);
      corpo.position.y = 0.95;
      grp.add(corpo);
      const cabeca = cubo(0.42, 0.42, 0.42, info.sec);
      cabeca.position.set(0, 1.7, 0); grp.add(cabeca);
      // Padrão de "rosto" do creeper
      const olhoE = cubo(0.1, 0.1, 0.04, 0x000000);
      olhoE.position.set(-0.1, 1.74, 0.22); grp.add(olhoE);
      const olhoD = cubo(0.1, 0.1, 0.04, 0x000000);
      olhoD.position.set( 0.1, 1.74, 0.22); grp.add(olhoD);
      const boca = cubo(0.14, 0.18, 0.04, 0x000000);
      boca.position.set(0, 1.62, 0.22); grp.add(boca);
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const dx = (i % 2 === 0 ? -0.1 : 0.1);
        const dz = (i < 2 ? 0.1 : -0.1);
        const p = pernaComPivot(0.18, 0.3, 0.18, info.cor, 0.3);
        p.position.x = dx; p.position.z = dz;
        grp.add(p);
        pernas.push(p);
      }
      partes.cabeca = cabeca;
      partes.pernas = pernas;
      partes.corpo = corpo;
      break;
    }
    default: {
      // Fallback: cubo + cabeça
      const corpo = cubo(0.6, 0.7, 0.4, info.cor);
      corpo.position.y = 0.45;
      grp.add(corpo);
      const cabeca = cubo(0.4, 0.4, 0.4, info.sec);
      cabeca.position.y = 1.0;
      grp.add(cabeca);
      partes.cabeca = cabeca;
      partes.corpo = corpo;
    }
  }

  grp.userData.partes = partes;
  return grp;
}

class Mob {
  constructor(tipo, x, y, z) {
    this.tipo = tipo;
    this.x = x; this.y = y; this.z = z;
    const info = MOB_INFO[tipo];
    this.hp = info.hp;
    this.dir = Math.random() * Math.PI * 2;
    this.proxMudanca = 0;
    this.cooldownAtaque = 0;
    this.fase = Math.random() * Math.PI * 2; // fase própria pra animação
    // Modelo Minecraft-like: cabeça + corpo + 4 (ou 2/8) pernas + braços
    this.mesh = construirModeloMob(tipo, info);
    this.mesh.position.set(x, y, z);
    // Cache das partes pra animação (preenchido por construirModeloMob)
    this.partes = this.mesh.userData.partes;
  }
  atualizar(dt, world, alvo) {
    const info = MOB_INFO[this.tipo];
    if (info.hostil && alvo) {
      this.dir = Math.atan2(alvo.z - this.z, alvo.x - this.x);
    } else {
      this.proxMudanca -= dt;
      if (this.proxMudanca <= 0) {
        this.dir = Math.random() * Math.PI * 2;
        this.proxMudanca = 1.5 + Math.random() * 3;
      }
    }
    const dx = Math.cos(this.dir) * info.vel * dt;
    const dz = Math.sin(this.dir) * info.vel * dt;
    let movendo = false;
    if (!world.isSolido(Math.floor(this.x + dx), Math.floor(this.y), Math.floor(this.z))) {
      this.x += dx; movendo = true;
    }
    if (!world.isSolido(Math.floor(this.x), Math.floor(this.y), Math.floor(this.z + dz))) {
      this.z += dz; movendo = true;
    }
    let h = WORLD_Y;
    while (h > 0 && !world.isSolido(Math.floor(this.x), h - 1, Math.floor(this.z))) h--;
    this.y = h;
    this.mesh.position.set(this.x, this.y, this.z);
    this.mesh.rotation.y = -this.dir + Math.PI / 2;
    this.cooldownAtaque -= dt;

    // === Animação ===
    this.fase += dt * (movendo ? 8 : 0);
    if (this.partes && this.partes.pernas) {
      const amp = movendo ? 0.55 : 0;
      for (let i = 0; i < this.partes.pernas.length; i++) {
        const sign = (i % 2 === 0) ? 1 : -1;
        const fase = this.fase + (i < 2 ? 0 : Math.PI);
        // pivots rotacionam em X (oscilação fwd/back)
        this.partes.pernas[i].rotation.x = Math.sin(fase) * amp * sign * 0.7;
      }
    }
    if (this.partes && this.partes.bracos) {
      const amp = movendo ? 0.5 : (info.hostil ? 0.3 : 0);
      // Braços oscilam em contrafase com pernas
      this.partes.bracos[0].rotation.x = Math.sin(this.fase + Math.PI) * amp;
      this.partes.bracos[1].rotation.x = Math.sin(this.fase) * amp;
      // Hostis com braços levantados (zumbi clássico)
      if (info.hostil) {
        this.partes.bracos[0].rotation.x -= 1.2;
        this.partes.bracos[1].rotation.x -= 1.2;
      }
    }
    if (this.partes && this.partes.cabeca) {
      // Leve oscilação da cabeça enquanto vagueia
      this.partes.cabeca.rotation.y = Math.sin(this.fase * 0.5) * 0.15;
    }
  }
  vivo() { return this.hp > 0; }
}

class MobManager {
  constructor(scene) {
    this.scene = scene;
    this.mobs = [];
    this.acc = 0;
    this.intervalo = 2.0;
  }
  spawn(tipo, x, y, z) {
    const m = new Mob(tipo, x, y, z);
    this.scene.add(m.mesh);
    this.mobs.push(m);
  }
  remover(m) {
    this.scene.remove(m.mesh);
    this.mobs.splice(this.mobs.indexOf(m), 1);
  }
  atualizar(dt, world, player, sun) {
    this.acc += dt;
    if (this.acc >= this.intervalo) {
      this.acc = 0;
      this.tentarSpawn(world, player, sun);
    }
    for (let i = this.mobs.length - 1; i >= 0; i--) {
      const m = this.mobs[i];
      if (!m.vivo()) { this.remover(m); continue; }
      const ddx = m.x - player.pos.x, ddz = m.z - player.pos.z;
      if (ddx*ddx + ddz*ddz > 900) { this.remover(m); continue; } // fora de view
      const info = MOB_INFO[m.tipo];
      if (info.amigavel) {
        // procura hostil próximo
        let hostil = null, melhor = 64;
        for (const o of this.mobs) {
          if (!MOB_INFO[o.tipo].hostil) continue;
          const d2 = (o.x - m.x)**2 + (o.z - m.z)**2;
          if (d2 < melhor) { melhor = d2; hostil = o; }
        }
        m.atualizar(dt, world, hostil ? { x: hostil.x, z: hostil.z } : null);
        if (hostil && melhor < 2.25 && m.cooldownAtaque <= 0) {
          hostil.hp -= 4; m.cooldownAtaque = 1.0;
        }
      } else if (info.hostil) {
        m.atualizar(dt, world, { x: player.pos.x, z: player.pos.z });
      } else {
        m.atualizar(dt, world, null);
      }
      // Atacar player se hostil + alcance + cooldown
      if (info.hostil && m.cooldownAtaque <= 0) {
        const ddy = m.y - player.pos.y;
        const d2 = ddx*ddx + ddy*ddy + ddz*ddz;
        if (d2 < info.alcance ** 2) {
          if (info.explode) {
            this.explosao(world, m.x, m.y, m.z, 2);
            player.aplicarDano(info.dano, 'creeper');
            m.hp = 0;
          } else {
            player.aplicarDano(info.dano, m.tipo);
          }
          m.cooldownAtaque = 1.2;
        }
      }
    }
  }
  tentarSpawn(world, player, sun) {
    if (this.mobs.length >= 14) return;
    const tipos = sun < 0.3
      ? ['zumbi', 'esqueleto', 'aranha', 'creeper', 'lobo']
      : ['vaca', 'galinha', 'porco', 'ovelha', 'lobo'];
    const tipo = tipos[Math.floor(Math.random() * tipos.length)];
    // posição aleatória ao redor do player
    const ang = Math.random() * Math.PI * 2;
    const dist = 12 + Math.random() * 8;
    const x = Math.floor(player.pos.x + Math.cos(ang) * dist);
    const z = Math.floor(player.pos.z + Math.sin(ang) * dist);
    let y = WORLD_Y;
    while (y > 0 && !world.isSolido(x, y - 1, z)) y--;
    if (y >= WORLD_Y - 1 || y <= 1) return;
    this.spawn(tipo, x, y, z);
  }
  maisProximo(player, alc) {
    let melhor = null, melhorD = alc * alc;
    for (const m of this.mobs) {
      const d2 = (m.x - player.pos.x)**2 + (m.y - player.pos.y)**2 + (m.z - player.pos.z)**2;
      if (d2 < melhorD) { melhorD = d2; melhor = m; }
    }
    return melhor;
  }
  explosao(world, cx, cy, cz, raio) {
    Audio.hit();
    for (let dx = -raio; dx <= raio; dx++) for (let dy = -raio; dy <= raio; dy++) for (let dz = -raio; dz <= raio; dz++) {
      if (dx*dx + dy*dy + dz*dz > raio*raio) continue;
      const x = Math.floor(cx + dx), y = Math.floor(cy + dy), z = Math.floor(cz + dz);
      const b = world.get(x, y, z);
      if (b === BLOCO.AR || b === BLOCO.OBSIDIANA) continue;
      world.set(x, y, z, BLOCO.AR);
    }
  }
}

// ===================================================================
// 8) Audio (window.rebcm.sfx do index.html)
// ===================================================================
const Audio = {
  _sfx() { return (window.rebcm && window.rebcm.sfx) || {}; },
  quebrar() { (this._sfx().quebrar || (() => {}))(); },
  colocar() { (this._sfx().colocar || (() => {}))(); },
  atacar()  { (this._sfx().atacar  || (() => {}))(); },
  hit()     { (this._sfx().hit     || (() => {}))(); },
  comer()   { (this._sfx().comer   || (() => {}))(); },
  respawn() { (this._sfx().respawn || (() => {}))(); },
};

// ===================================================================
// 9) UI (DOM)
// ===================================================================
class UI {
  constructor() {
    this.toastTimer = null;
    this.elHotbar = document.getElementById('hotbar');
    this.elBag = document.getElementById('bag-grid');
    this.elBagHot = document.getElementById('bag-hotbar');
    this.elCraftLista = document.getElementById('craft-lista');
    this.elCraftStatus = document.getElementById('craft-status');
  }
  atualizar() {
    this.renderHotbar();
    this.renderBars();
    this.atualizarXP();
  }
  atualizarXP() {
    if (!player) return;
    const nivel = player.nivel || 0;
    const cur = player.xp || 0;
    const max = (typeof xpProximoNivel === 'function') ? xpProximoNivel() : 7;
    const fill = document.getElementById('xp-fill');
    const lbl = document.getElementById('xp-nivel');
    if (fill) fill.style.width = `${Math.min(100, (cur / max) * 100)}%`;
    if (lbl)  lbl.textContent = `Nv.${nivel}  ${cur}/${max}`;
  }
  renderHotbar() {
    if (!inv) return;
    if (!this.elHotbar.children.length) {
      for (let i = 0; i < 9; i++) {
        const div = document.createElement('div');
        div.className = 'slot';
        div.dataset.idx = i;
        div.onclick = () => inv.selecionar(i);
        this.elHotbar.appendChild(div);
      }
    }
    for (let i = 0; i < 9; i++) {
      const s = inv.slots[i];
      const el = this.elHotbar.children[i];
      el.classList.toggle('sel', i === inv.slotSel);
      el.innerHTML = this._slotHTML(s);
    }
  }
  _slotHTML(s) {
    if (!s) return '';
    const ic = s.b !== undefined ? (ICONE[s.b] || '■') : (ITEM_INFO[s.i]?.icone || '?');
    const qtd = s.q > 1 ? `<span class="qtd">${s.q}</span>` : '';
    return `${ic}${qtd}`;
  }
  renderBars() {
    if (!player) return;
    const hp = player.hp, hpMax = player.hpMax, fome = player.fome, fomeMax = player.fomeMax;
    const barHTML = (icone, v, max, cor) => {
      const cheios = Math.ceil(v / 2), total = Math.ceil(max / 2);
      let h = '';
      for (let i = 0; i < total; i++) {
        h += `<span style="color:${i < cheios ? cor : '#ffffff22'}">${icone}</span>`;
      }
      return h;
    };
    document.getElementById('hp').innerHTML = barHTML('❤', hp, hpMax, '#e57373');
    document.getElementById('fome').innerHTML = barHTML('🍗', fome, fomeMax, '#ffb74d');
  }
  renderBag() {
    this.elBag.innerHTML = '';
    this.elBagHot.innerHTML = '';
    for (let i = 9; i < 36; i++) {
      const div = document.createElement('div');
      div.className = 'slot';
      div.innerHTML = this._slotHTML(inv.slots[i]);
      div.onclick = () => {
        // Se item da bag é armadura, equipa direto. Senão, troca pra hotbar.
        const it = inv.slots[i];
        if (it && it.i !== undefined && ITEM_INFO[it.i]?.armadura) {
          inv.equiparDoSlot(i);
        } else {
          inv.trocar(i, inv.slotSel);
        }
        this.renderBag(); // re-render porque equipar muda armadura também
      };
      this.elBag.appendChild(div);
    }
    for (let i = 0; i < 9; i++) {
      const div = document.createElement('div');
      div.className = 'slot' + (i === inv.slotSel ? ' sel' : '');
      div.innerHTML = this._slotHTML(inv.slots[i]);
      div.onclick = () => {
        const it = inv.slots[i];
        if (it && it.i !== undefined && ITEM_INFO[it.i]?.armadura) {
          inv.equiparDoSlot(i);
          this.renderBag();
        } else {
          inv.selecionar(i);
        }
      };
      this.elBagHot.appendChild(div);
    }
    this.renderArmaduraSlots();
  }

  // Atualiza os 4 slots visuais de armadura no painel da bag.
  renderArmaduraSlots() {
    document.querySelectorAll('.armor-slot').forEach(el => {
      const peca = el.dataset.peca;
      const item = inv.armadura[peca];
      const ic = el.querySelector('.armor-icon');
      let display = el.querySelector('.equip-display');
      let tierEl = el.querySelector('.equip-tier');
      if (item) {
        el.classList.add('equipado');
        if (ic) ic.style.display = 'none';
        if (!display) {
          display = document.createElement('div');
          display.className = 'equip-display';
          el.appendChild(display);
        }
        const info = ITEM_INFO[item.i];
        display.textContent = info?.icone ?? '?';
        display.style.display = 'block';
        if (!tierEl) {
          tierEl = document.createElement('div');
          tierEl.className = 'equip-tier';
          el.appendChild(tierEl);
        }
        // Tier visual: couro/ferro/diamante
        let tier = '';
        if (info.nome.toLowerCase().includes('diamante')) tier = '💎';
        else if (info.nome.toLowerCase().includes('ferro')) tier = '⚙';
        else if (info.nome.toLowerCase().includes('couro')) tier = '🟤';
        tierEl.textContent = tier;
        // Click → desequipa (volta pro inventário)
        el.onclick = () => {
          inv.desequipar(peca);
          this.renderBag();
        };
      } else {
        el.classList.remove('equipado');
        if (ic) ic.style.display = 'inline';
        if (display) display.style.display = 'none';
        if (tierEl) tierEl.textContent = '';
        el.onclick = () => ui.toast(`Equipe um ${peca === 'cabeca' ? 'capacete' : peca === 'torso' ? 'peitoral' : peca === 'pernas' ? 'perneiras' : 'botas'} clicando nele no inventário.`);
      }
    });
    const def = inv.defesaTotal();
    const elDef = document.getElementById('armor-defesa');
    if (elDef) elDef.textContent = String(def);
  }
  renderCraft(perto) {
    const disp = Crafting.disponiveis(inv, perto);
    this.elCraftStatus.innerHTML = perto
      ? '🪵 Workbench próximo — receitas avançadas habilitadas'
      : 'Sem workbench: só receitas básicas. Crie e coloque um workbench (4× pranchas).';
    this.elCraftLista.innerHTML = '';
    if (disp.length === 0) {
      this.elCraftLista.innerHTML = '<div class="dica">Sem receitas disponíveis. Junte mais materiais.</div>';
      return;
    }
    for (const r of disp) {
      const div = document.createElement('div');
      div.className = 'receita';
      const ic = r.saida.b !== undefined ? (ICONE[r.saida.b] || '■') : (ITEM_INFO[r.saida.i]?.icone || '?');
      const nome = r.saida.b !== undefined ? BLOCO_INFO[r.saida.b].nome : ITEM_INFO[r.saida.i].nome;
      const qtd = r.saida.q > 1 ? ` ×${r.saida.q}` : '';
      const custos = r.custos.map(c => {
        const n = c.b !== undefined ? BLOCO_INFO[c.b].nome : ITEM_INFO[c.i].nome;
        return `${c.q}× ${n}`;
      }).join(' + ');
      div.innerHTML = `<div class="icone">${ic}</div><div class="info"><div class="nome">${nome}${qtd}</div><div class="custo">${custos}</div></div>`;
      div.onclick = () => { Crafting.craftar(inv, r, perto); this.renderCraft(this.workbenchPerto()); };
      this.elCraftLista.appendChild(div);
    }
  }
  workbenchPerto() {
    if (!world || !player) return false;
    const px = Math.floor(player.pos.x), py = Math.floor(player.pos.y), pz = Math.floor(player.pos.z);
    for (let dx = -3; dx <= 3; dx++) for (let dy = -2; dy <= 2; dy++) for (let dz = -3; dz <= 3; dz++) {
      if (world.get(px + dx, py + dy, pz + dz) === BLOCO.WORKBENCH) return true;
    }
    return false;
  }
  toast(msg) {
    const el = document.getElementById('toast');
    el.textContent = msg;
    el.classList.add('show');
    if (this.toastTimer) clearTimeout(this.toastTimer);
    this.toastTimer = setTimeout(() => el.classList.remove('show'), 2000);
  }
  // === Painel do baú: 27 slots do baú + inventário (27) + hotbar (9) ===
  renderBauPainel() {
    if (!_bauAtivoCoords) return;
    const bau = world.getBau(_bauAtivoCoords.x, _bauAtivoCoords.y, _bauAtivoCoords.z);
    const elBau = document.getElementById('bau-grid');
    const elInv = document.getElementById('bau-inv');
    const elHot = document.getElementById('bau-hotbar');
    elBau.innerHTML = ''; elInv.innerHTML = ''; elHot.innerHTML = '';
    // 27 slots do baú
    for (let i = 0; i < 27; i++) {
      const div = document.createElement('div');
      div.className = 'slot';
      div.innerHTML = this._slotHTML(bau[i]);
      div.onclick = () => {
        // Move bau[i] para inv (primeiro slot livre)
        if (bau[i]) {
          if (inv.adicionar({ ...bau[i] })) bau[i] = null;
        }
        this.renderBauPainel();
      };
      elBau.appendChild(div);
    }
    // 27 slots do inv (bag)
    for (let i = 9; i < 36; i++) {
      const div = document.createElement('div');
      div.className = 'slot';
      div.innerHTML = this._slotHTML(inv.slots[i]);
      div.onclick = () => {
        if (inv.slots[i]) {
          // procura slot livre no baú
          for (let j = 0; j < 27; j++) {
            if (!bau[j]) { bau[j] = { ...inv.slots[i] }; inv.slots[i] = null; break; }
          }
        }
        this.renderBauPainel();
      };
      elInv.appendChild(div);
    }
    // 9 slots da hotbar
    for (let i = 0; i < 9; i++) {
      const div = document.createElement('div');
      div.className = 'slot' + (i === inv.slotSel ? ' sel' : '');
      div.innerHTML = this._slotHTML(inv.slots[i]);
      div.onclick = () => {
        if (inv.slots[i]) {
          for (let j = 0; j < 27; j++) {
            if (!bau[j]) { bau[j] = { ...inv.slots[i] }; inv.slots[i] = null; break; }
          }
        }
        this.renderBauPainel();
      };
      elHot.appendChild(div);
    }
  }

  // === Painel da fornalha: input/combustível/output + botão cozinhar ===
  renderFornalhaPainel() {
    if (!_fornAtivaCoords) return;
    const f = world.getFornalha(_fornAtivaCoords.x, _fornAtivaCoords.y, _fornAtivaCoords.z);
    const elIn  = document.getElementById('forn-input');
    const elFu  = document.getElementById('forn-fuel');
    const elOut = document.getElementById('forn-output');
    elIn.innerHTML  = this._slotHTML(f.input);
    elFu.innerHTML  = this._slotHTML(f.combustivel);
    elOut.innerHTML = this._slotHTML(f.output);
    elIn.classList.toggle('ativo', !!f.input);
    elFu.classList.toggle('ativo', !!f.combustivel);
    elOut.classList.toggle('ativo', !!f.output);

    // Click → trocar entre slot ativo da hotbar e o slot da fornalha
    const trocaSlot = (campo) => {
      const sel = inv.slots[inv.slotSel];
      const atual = f[campo];
      if (atual) {
        if (inv.adicionar({ ...atual })) f[campo] = null;
        else if (!sel) { f[campo] = null; inv.slots[inv.slotSel] = atual; }
      } else if (sel) {
        f[campo] = { ...sel };
        inv.slots[inv.slotSel] = null;
      }
      this.renderFornalhaPainel();
    };
    elIn.onclick  = () => trocaSlot('input');
    elFu.onclick  = () => trocaSlot('combustivel');
    elOut.onclick = () => {
      if (f.output) {
        if (inv.adicionar({ ...f.output })) f.output = null;
      }
      this.renderFornalhaPainel();
    };

    // Botão cozinhar como elemento extra: usar o ícone 🔥
    document.querySelector('.forn-fogo').onclick = () => cozinharFornalha(_fornAtivaCoords);

    // Hotbar
    const hot = document.getElementById('fornalha-hotbar');
    hot.innerHTML = '';
    for (let i = 0; i < 9; i++) {
      const div = document.createElement('div');
      div.className = 'slot' + (i === inv.slotSel ? ' sel' : '');
      div.innerHTML = this._slotHTML(inv.slots[i]);
      div.onclick = () => { inv.selecionar(i); this.renderFornalhaPainel(); };
      hot.appendChild(div);
    }
  }

  mostrarMorte() {
    // Libera o ponteiro ANTES de mostrar — sem isso, qualquer clique
    // continua sendo capturado pelo canvas (pointer lock) e nunca chega
    // ao overlay, fazendo a tela de morte parecer "travada".
    try { document.exitPointerLock?.(); } catch (_) {}
    document.getElementById('morte').classList.remove('hidden');
  }
  esconderMorte() {
    document.getElementById('morte').classList.add('hidden');
    // Re-lock após pequena pausa para o browser registrar o gesto.
    setTimeout(() => {
      try { player?.controls?.lock(); } catch (_) {}
    }, 80);
  }
  abrirPainel(id) { document.getElementById(id).classList.remove('hidden'); }
  fecharPainel(id) { document.getElementById(id).classList.add('hidden'); }
}

// ===================================================================
// 10) Save / Load via localStorage
// ===================================================================
const Save = {
  salvar() {
    try {
      const chunksMod = [];
      for (const [k, c] of world.chunks) {
        if (c.modificado) {
          chunksMod.push({ cx: c.cx, cz: c.cz, b: btoa(String.fromCharCode(...c.blocks)) });
        }
      }
      // Serializa cada slot preservando "b" (bloco), "i" (item) e "q",
      // junto do índice do slot (sx). Bug fixed: antes o índice pisava
      // sobre s.i de itens-tipo.
      const invSerializado = [];
      for (let k = 0; k < inv.slots.length; k++) {
        const s = inv.slots[k];
        if (!s) continue;
        invSerializado.push({ sx: k, b: s.b, i: s.i, q: s.q });
      }
      const armSerializada = {};
      for (const peca of Object.keys(inv.armadura)) {
        const a = inv.armadura[peca];
        if (a) armSerializada[peca] = { b: a.b, i: a.i, q: a.q };
      }
      // Estado de blocos funcionais (baú/fornalha)
      const bausSerializados = [];
      for (const [k, slots] of world.bauTesouros) {
        if (slots.some(s => s)) bausSerializados.push({ k, slots });
      }
      const fornsSerializadas = [];
      for (const [k, f] of world.fornalhaEstados) {
        if (f.input || f.combustivel || f.output) {
          fornsSerializadas.push({ k, input: f.input, combustivel: f.combustivel, output: f.output });
        }
      }
      const data = {
        v: 3, seed: world.seed,
        p: { x: player.pos.x, y: player.pos.y, z: player.pos.z },
        slot: inv.slotSel, hp: player.hp, fome: player.fome,
        xp: player.xp, nivel: player.nivel,
        td: tempoDia, modo: player.modo,
        inv: invSerializado,
        arm: armSerializada,
        baus: bausSerializados,
        forn: fornsSerializadas,
        chunks: chunksMod,
      };
      localStorage.setItem(SAVE_KEY, JSON.stringify(data));
      ui.toast('Salvo!');
      return true;
    } catch (e) { ui.toast('Erro ao salvar'); console.error(e); return false; }
  },
  carregar() {
    try {
      const raw = localStorage.getItem(SAVE_KEY);
      if (!raw) return null;
      return JSON.parse(raw);
    } catch (_) { return null; }
  },
  apagar() { localStorage.removeItem(SAVE_KEY); ui.toast('Save apagado'); },
};

// ===================================================================
// 11) Globals + bootstrap
// ===================================================================
let renderer, world, player, mobMgr, inv, ui, particulas;
let tempoDia = 0.25;
let chunkLoadOrcamento = 2; // chunks novos a carregar por frame
let frameCount = 0, fpsAcc = 0, fpsTimer = 0;

function init() {
  ui = new UI();
  inv = new Inventario();
  // Kit inicial
  inv.adicionar({ b: BLOCO.GRAMA, q: 32 });
  inv.adicionar({ b: BLOCO.TERRA, q: 32 });
  inv.adicionar({ b: BLOCO.PEDRA, q: 16 });
  inv.adicionar({ b: BLOCO.MADEIRA, q: 16 });
  inv.adicionar({ b: BLOCO.FOLHA, q: 16 });
  inv.adicionar({ b: BLOCO.TIJOLO, q: 8 });
  inv.adicionar({ b: BLOCO.VIDRO, q: 8 });
  inv.adicionar({ b: BLOCO.LUZ, q: 4 });
  inv.adicionar({ b: BLOCO.TOCHA, q: 16 });
  inv.adicionar({ i: ITEM.PIC_MADEIRA, q: 1 });

  const canvas = document.getElementById('game');
  renderer = new Renderer(canvas);
  world = new World(42);

  player = new Player(renderer.camera);
  player.controls = new PointerLockControls(renderer.camera, document.body);
  renderer.scene.add(player.controls.object);

  mobMgr = new MobManager(renderer.scene);
  particulas = new Particulas(renderer.scene);

  // Tenta carregar save
  const save = Save.carregar();
  if (save) {
    world.seed = save.seed;
    player.pos.set(save.p.x, save.p.y, save.p.z);
    player.spawn.copy(player.pos);
    player.hp = save.hp ?? 20;
    player.fome = save.fome ?? 20;
    player.modo = save.modo ?? 'creative';
    tempoDia = save.td ?? 0.25;
    inv.slots.fill(null);
    inv.slotSel = save.slot ?? 0;
    // Schema v2/v3: usa s.sx como índice do slot. v1 ignorado.
    if ((save.v === 2 || save.v === 3) && save.inv) {
      for (const s of save.inv) {
        if (s.sx === undefined) continue;
        inv.slots[s.sx] = { b: s.b, i: s.i, q: s.q };
      }
    }
    inv.armadura = { cabeca: null, torso: null, pernas: null, botas: null };
    if (save.arm) {
      for (const peca of Object.keys(save.arm)) {
        if (inv.armadura[peca] !== undefined) {
          inv.armadura[peca] = { ...save.arm[peca] };
        }
      }
    }
    // Schema v3: XP e estado de baús/fornalhas
    if (save.v === 3) {
      player.xp = save.xp || 0;
      player.nivel = save.nivel || 0;
      if (save.baus) {
        for (const { k, slots } of save.baus) {
          world.bauTesouros.set(k, slots);
        }
      }
      if (save.forn) {
        for (const { k, input, combustivel, output } of save.forn) {
          world.fornalhaEstados.set(k, {
            input, combustivel, output, progresso: 0, ativa: false,
          });
        }
      }
    }
    if (save.chunks) {
      for (const sc of save.chunks) {
        const c = world.getChunk(sc.cx, sc.cz);
        const arr = atob(sc.b);
        for (let i = 0; i < arr.length && i < c.blocks.length; i++) c.blocks[i] = arr.charCodeAt(i);
        c.modificado = true; c.dirty = true;
      }
    }
    ui.toast('Mundo carregado');
  } else {
    // Spawn no terreno
    const h = world.alturaTerreno(8, 8);
    player.pos.set(8.5, h + 2, 8.5);
    player.spawn.copy(player.pos);
    ui.toast('Bem-vinda ao mundo 3D!');
  }
  player.spawnY = player.pos.y;

  // Eventos
  setupInput();
  setupTouchControls();
  ui.atualizar();

  // Iniciar autosave a cada 30s
  setInterval(() => Save.salvar(), 30_000);

  // Loop
  window.addEventListener('resize', () => renderer.resize());
  ultimoT = performance.now();
  requestAnimationFrame(loop);
}

// === Touch Controls ===
// Joystick virtual + look-arrastar + botões touch para paridade com
// teclado/mouse em smartphones e tablets.
const isTouchDevice = (typeof window !== 'undefined') &&
  (('ontouchstart' in window) || (navigator.maxTouchPoints || 0) > 0);

function setupTouchControls() {
  if (!isTouchDevice) return;
  const tc = document.getElementById('touch-controls');
  tc.classList.remove('hidden');
  // Esconde a "mão" pra não ocupar espaço em mobile (a UI já cobre)
  if (renderer?.maoGroup) renderer.maoGroup.visible = false;

  // === Joystick ===
  const joy = document.getElementById('touch-joy');
  const joyBase = joy.querySelector('.joy-base');
  const joyKnob = joy.querySelector('.joy-knob');
  let joyTouchId = null;
  let joyCx = 0, joyCy = 0;
  const joyMaxR = 50;

  function joyAtualizar(x, y) {
    let dx = x - joyCx;
    let dy = y - joyCy;
    const dist = Math.hypot(dx, dy);
    if (dist > joyMaxR) { dx = dx / dist * joyMaxR; dy = dy / dist * joyMaxR; }
    joyKnob.style.transform =
      `translate(calc(-50% + ${dx}px), calc(-50% + ${dy}px))`;
    // Mapeia para input.fwd / input.side
    // - knob para cima (dy<0)  → fwd = +1 (avança)
    // - knob para baixo (dy>0) → fwd = -1 (recua)
    // - knob direita (dx>0)    → side = +1
    // - knob esquerda (dx<0)   → side = -1
    player.input.fwd  = -dy / joyMaxR;
    player.input.side =  dx / joyMaxR;
    // Auto-sprint quando knob bate na borda
    player.input.sprint = dist > joyMaxR * 0.85;
  }
  function joyResetar() {
    joyKnob.style.transform = 'translate(-50%, -50%)';
    joyKnob.classList.remove('ativo');
    player.input.fwd = 0;
    player.input.side = 0;
    player.input.sprint = false;
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
      if (t.identifier === joyTouchId) {
        joyAtualizar(t.clientX, t.clientY);
        return;
      }
    }
  }, { passive: false });
  const joyEnd = (e) => {
    for (const t of e.changedTouches) {
      if (t.identifier === joyTouchId) { joyResetar(); return; }
    }
  };
  document.addEventListener('touchend', joyEnd);
  document.addEventListener('touchcancel', joyEnd);

  // === Look (drag = girar câmera) ===
  // Em mobile não há pointer lock; manipulamos camera.rotation diretamente.
  const lookZone = document.getElementById('touch-look');
  let lookTouchId = null, lookLastX = 0, lookLastY = 0;
  const lookSens = 0.0035;
  const _euler = new THREE.Euler(0, 0, 0, 'YXZ');

  lookZone.addEventListener('touchstart', (e) => {
    e.preventDefault();
    if (lookTouchId !== null) return;
    const t = e.changedTouches[0];
    lookTouchId = t.identifier;
    lookLastX = t.clientX;
    lookLastY = t.clientY;
  }, { passive: false });
  lookZone.addEventListener('touchmove', (e) => {
    e.preventDefault();
    if (lookTouchId === null) return;
    for (const t of e.changedTouches) {
      if (t.identifier !== lookTouchId) continue;
      const dx = t.clientX - lookLastX;
      const dy = t.clientY - lookLastY;
      lookLastX = t.clientX;
      lookLastY = t.clientY;
      _euler.setFromQuaternion(renderer.camera.quaternion);
      _euler.y -= dx * lookSens;
      _euler.x -= dy * lookSens;
      // Clamp pitch entre -89° e +89°
      _euler.x = Math.max(-Math.PI / 2 + 0.01, Math.min(Math.PI / 2 - 0.01, _euler.x));
      renderer.camera.quaternion.setFromEuler(_euler);
      return;
    }
  }, { passive: false });
  const lookEnd = (e) => {
    for (const t of e.changedTouches) {
      if (t.identifier === lookTouchId) { lookTouchId = null; return; }
    }
  };
  lookZone.addEventListener('touchend', lookEnd);
  lookZone.addEventListener('touchcancel', lookEnd);

  // === Botões de ação ===
  const btn = (id, ondown, onup) => {
    const el = document.querySelector(`.t-btn[data-action="${id}"]`);
    if (!el) return;
    const bDown = (e) => { e.preventDefault(); el.classList.add('pressionado'); ondown && ondown(); };
    const bUp   = (e) => { e.preventDefault(); el.classList.remove('pressionado'); onup && onup(); };
    el.addEventListener('touchstart', bDown, { passive: false });
    el.addEventListener('touchend',   bUp,   { passive: false });
    el.addEventListener('touchcancel', bUp,  { passive: false });
    // Também aceita click (suporta navegadores que disparam click extra)
    el.addEventListener('mousedown', bDown);
    el.addEventListener('mouseup',   bUp);
    el.addEventListener('mouseleave', bUp);
  };
  btn('jump',
      () => { player.input.up = 1; player.input.jump = true; },
      () => { player.input.up = 0; });
  btn('down',
      () => { if (player.modo === 'creative') player.input.up = -1; },
      () => { if (player.modo === 'creative') player.input.up = 0; });
  btn('break',
      () => { player.holdE = true; },
      () => { player.holdE = false; player.progressoQuebra = 0; player.alvoQuebra = null; });
  btn('place',
      () => { player.cliqueD = true; });
  btn('attack',
      () => { atacarMob(); });

  // Esconde botão "down" em modo survival (não voa)
  const atualizarTouchVisibility = () => {
    const down = document.querySelector('.t-btn[data-action="down"]');
    if (down) down.style.display = player.modo === 'creative' ? 'flex' : 'none';
  };
  setInterval(atualizarTouchVisibility, 500);
}

function setupInput() {
  // Teclado
  document.addEventListener('keydown', (e) => {
    if (e.repeat) return;
    switch (e.code) {
      case 'KeyW': player.input.fwd = 1; break;
      case 'KeyS': player.input.fwd = -1; break;
      case 'KeyA': player.input.side = -1; break;
      case 'KeyD': player.input.side = 1; break;
      case 'Space': player.input.up = 1; player.input.jump = true; break;
      case 'ShiftLeft': case 'ShiftRight':
        if (player.modo === 'creative') player.input.up = -1;
        player.input.sprint = true; break;
      case 'KeyE': togglePainel('painel-bag'); break;
      case 'KeyC': togglePainel('painel-craft'); break;
      case 'KeyG': alternarModo(); break;
      case 'KeyF': atacarMob(); break;
      case 'KeyQ': comerSlot(); break;
      case 'F5': player.terceiraPessoa = !player.terceiraPessoa;
                 ui.toast(player.terceiraPessoa ? '3ª pessoa' : '1ª pessoa'); break;
      case 'KeyT': alternarTransparencia(); break;
    }
    if (e.code.startsWith('Digit')) {
      const n = parseInt(e.code.slice(5));
      if (n >= 1 && n <= 9) inv.selecionar(n - 1);
    }
  });
  document.addEventListener('keyup', (e) => {
    switch (e.code) {
      case 'KeyW': case 'KeyS': player.input.fwd = 0; break;
      case 'KeyA': case 'KeyD': player.input.side = 0; break;
      case 'Space': player.input.up = 0; break;
      case 'ShiftLeft': case 'ShiftRight':
        if (player.modo === 'creative') player.input.up = 0;
        player.input.sprint = false; break;
    }
  });
  // Mouse: roda no body para hover; click L = quebrar; click R = colocar.
  document.addEventListener('mousedown', (e) => {
    // Não disparar quando algum painel modal está aberto
    const algumPainelAberto = document.querySelector('.painel:not(.hidden)') !== null;
    if (algumPainelAberto) return;
    // === Re-lock automático ===
    // Quando usuário aperta ESC, pointer-lock é liberado pelo browser.
    // Aqui, qualquer clique no canvas re-trava o cursor — pra ele
    // continuar jogando sem ter que apertar JOGAR de novo.
    if (!isTouchDevice && !player.controls.isLocked && !player.morto) {
      try { player.controls.lock(); } catch (_) {}
      // Engole esse clique (não dispara quebra/colocar imediatamente).
      return;
    }
    if (!player.controls.isLocked) return;
    if (e.button === 0) { player.holdE = true; player.cliqueE = true; }
    else if (e.button === 2) { player.cliqueD = true; }
  });
  document.addEventListener('mouseup', (e) => {
    if (e.button === 0) { player.holdE = false; player.progressoQuebra = 0; player.alvoQuebra = null; }
  });
  document.addEventListener('contextmenu', (e) => e.preventDefault());
  // Scroll wheel para hotbar
  document.addEventListener('wheel', (e) => {
    if (!player.controls.isLocked) return;
    const dir = e.deltaY > 0 ? 1 : -1;
    inv.selecionar(inv.slotSel + dir);
  }, { passive: true });

  // Botões UI
  document.getElementById('btn-bag').onclick = () => togglePainel('painel-bag');
  document.getElementById('btn-craft').onclick = () => togglePainel('painel-craft');
  document.getElementById('btn-modo').onclick = () => alternarModo();
  document.getElementById('btn-save').onclick = () => Save.salvar();
  document.getElementById('btn-transp').onclick = () => alternarTransparencia();
  document.querySelectorAll('.fechar').forEach(b => {
    b.onclick = () => ui.fecharPainel(b.dataset.painel);
  });

  // Tela de morte: vários gestos disparam o respawn (mais robusto em
  // mobile e em browsers que tratam click/touch diferente).
  const morteEl = document.getElementById('morte');
  const respawnHandler = (e) => {
    if (!player.morto) return;
    e.preventDefault();
    e.stopPropagation();
    player.respawnar();
  };
  morteEl.addEventListener('pointerdown', respawnHandler);
  morteEl.addEventListener('click',       respawnHandler);
  morteEl.addEventListener('touchend',    respawnHandler);
  // Também aceita Space ou Enter no teclado.
  document.addEventListener('keydown', (e) => {
    if (player.morto && (e.code === 'Space' || e.code === 'Enter')) {
      e.preventDefault();
      player.respawnar();
    }
  });

  // Pointer lock: ao perder, mostra cursor; ao recuperar, esconde.
  document.addEventListener('pointerlockchange', () => {
    const locked = document.pointerLockElement === document.body;
    document.getElementById('game').style.cursor = locked ? 'none' : 'crosshair';
  });
}

function togglePainel(id) {
  const el = document.getElementById(id);
  if (el.classList.contains('hidden')) {
    if (id === 'painel-bag') ui.renderBag();
    if (id === 'painel-craft') ui.renderCraft(ui.workbenchPerto());
    el.classList.remove('hidden');
    document.exitPointerLock?.();
  } else {
    el.classList.add('hidden');
  }
}

function alternarModo() {
  player.modo = player.modo === 'creative' ? 'survival' : 'creative';
  player.vel.y = 0; player.spawnY = player.pos.y;
  document.getElementById('btn-modo').textContent = player.modo === 'creative' ? '🦅' : '⚔';
  document.getElementById('modo').textContent = player.modo === 'creative' ? 'Criativo' : 'Sobrevivência';
  ui.toast(player.modo === 'creative' ? 'Modo Criativo (voo livre)' : 'Modo Sobrevivência (gravidade)');
}

function alternarTransparencia() {
  const novo = !renderer.transparenciaAtiva;
  renderer.setTransparenciaAtiva(novo);
  const btn = document.getElementById('btn-transp');
  btn.textContent = novo ? '🪟' : '🧱';
  btn.title = novo
    ? 'Modo: transparente (folha/vidro/água semi-transp). Clique para sólido.'
    : 'Modo: sólido (tudo opaco). Clique para transparente.';
  btn.classList.toggle('solido', !novo);
  ui.toast(novo ? 'Blocos: transparentes' : 'Blocos: sólidos');
}

// === Sistema de XP ===
// Curva tipo Minecraft simplificada: nivel*nivel*4 pra subir.
function xpProximoNivel() {
  return Math.max(7, player.nivel * player.nivel * 4 + 7);
}
function ganharXP(pts) {
  player.xp += pts;
  while (player.xp >= xpProximoNivel()) {
    player.xp -= xpProximoNivel();
    player.nivel += 1;
    Audio.respawn();
    ui.toast(`⭐ Nível ${player.nivel}!`);
  }
  ui.atualizarXP();
}

// === Cama: pula pra manhã se for noite ===
function dormir() {
  // luzDia precisa estar baixa pra poder dormir
  const sun = Math.max(0.05, 0.5 + 0.5 * Math.sin(tempoDia * Math.PI * 2 - Math.PI / 2));
  if (sun > 0.4) {
    ui.toast('Você só pode dormir à noite');
    return;
  }
  const overlay = document.getElementById('dormindo-overlay');
  overlay.classList.remove('hidden');
  setTimeout(() => {
    tempoDia = 0.22;            // amanhecer
    player.hp = player.hpMax;   // restaura HP ao acordar (Minecraft-like)
    player.fome = Math.max(player.fome - 1, 0);
    overlay.classList.add('hidden');
    ui.toast('Bom dia! ☀️');
  }, 1200);
}

// === Painel do baú ===
let _bauAtivoCoords = null;
function abrirPainelBau(x, y, z) {
  _bauAtivoCoords = { x, y, z };
  ui.renderBauPainel();
  document.getElementById('painel-bau').classList.remove('hidden');
  try { document.exitPointerLock?.(); } catch (_) {}
}

// === Painel da fornalha ===
let _fornAtivaCoords = null;
function abrirPainelFornalha(x, y, z) {
  _fornAtivaCoords = { x, y, z };
  ui.renderFornalhaPainel();
  document.getElementById('painel-fornalha').classList.remove('hidden');
  try { document.exitPointerLock?.(); } catch (_) {}
}

// Receita de cozimento na fornalha: {input → output}
const RECEITAS_FORNALHA = [
  { entrada: { i: ITEM.CARNE_CRUA }, saida: { i: ITEM.CARNE_COZIDA, q: 1 } },
  // Ferro lingote → ferro lingote (já é "lingote") — pulamos
];
function cozinharFornalha(coords) {
  const f = world.getFornalha(coords.x, coords.y, coords.z);
  if (!f.input || !f.combustivel) return;
  // Encontra receita matching o input
  const r = RECEITAS_FORNALHA.find(x =>
    (x.entrada.i !== undefined && f.input.i === x.entrada.i) ||
    (x.entrada.b !== undefined && f.input.b === x.entrada.b));
  if (!r) { ui.toast('Item não pode ser cozido'); return; }
  // Saída precisa caber
  if (f.output && (f.output.i !== r.saida.i || f.output.b !== r.saida.b || f.output.q >= 64)) {
    ui.toast('Slot de saída cheio'); return;
  }
  // Consome 1 input + 1 combustível, produz 1 output
  f.input.q -= 1;
  if (f.input.q <= 0) f.input = null;
  f.combustivel.q -= 1;
  if (f.combustivel.q <= 0) f.combustivel = null;
  if (f.output) f.output.q += r.saida.q;
  else f.output = { ...r.saida };
  Audio.colocar();
  ganharXP(1);
  ui.renderFornalhaPainel();
}

function atacarMob() {
  if (player.morto) return;
  const m = mobMgr.maisProximo(player, ALCANCE_BLOCO);
  if (!m) return;
  Audio.atacar();
  const tier = inv.melhorEspada();
  const dano = 2 + tier * 2;
  m.hp -= dano;
  if (m.hp <= 0) {
    const drops = MOB_INFO[m.tipo].drops();
    for (const d of drops) inv.adicionar(d);
    const info = MOB_INFO[m.tipo];
    const xp = info.hostil ? 5 : 2;
    ganharXP(xp);
    ui.toast(`${m.tipo} derrotado! (+${xp} XP)`);
  } else {
    ui.toast(`Atingiu ${m.tipo} (-${dano})`);
  }
}

function comerSlot() {
  if (player.morto) return;
  const s = inv.itemSelecionado();
  if (!s || s.i === undefined) { ui.toast('Nada comestível selecionado'); return; }
  const info = ITEM_INFO[s.i];
  if (!info || !info.nutricao) { ui.toast('Não comestível'); return; }
  player.fome = clamp(player.fome + info.nutricao, 0, player.fomeMax);
  inv.consumirAtual();
  Audio.comer();
  if (info.suspeito && Math.random() < 0.15) player.aplicarDano(1, 'comida estragada');
  else ui.toast(`Comeu ${info.nome} (+${info.nutricao} fome)`);
}

// === Raycasting bloco-alvo ===
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
  let face = null; // último eixo atravessado
  while (t < alc) {
    if (tMaxX < tMaxY && tMaxX < tMaxZ) {
      x += stepX; t = tMaxX; tMaxX += tDeltaX; face = 'x';
    } else if (tMaxY < tMaxZ) {
      y += stepY; t = tMaxY; tMaxY += tDeltaY; face = 'y';
    } else {
      z += stepZ; t = tMaxZ; tMaxZ += tDeltaZ; face = 'z';
    }
    const b = world.get(x, y, z);
    const info = BLOCO_INFO[b];
    if (info.solido && b !== BLOCO.AR) {
      const adj = { x, y, z };
      if (face === 'x') adj.x -= stepX;
      else if (face === 'y') adj.y -= stepY;
      else adj.z -= stepZ;
      return { hit: { x, y, z, b }, adj };
    }
  }
  return null;
}

let ultimoT = 0;
function loop(now) {
  const dt = Math.min(0.06, (now - ultimoT) / 1000);
  ultimoT = now;

  // FPS counter
  fpsAcc++;
  fpsTimer += dt;
  if (fpsTimer >= 1) {
    document.getElementById('fps').textContent = `${fpsAcc} FPS`;
    fpsAcc = 0; fpsTimer = 0;
  }

  if (!document.getElementById('painel-bag').classList.contains('hidden') ||
      !document.getElementById('painel-craft').classList.contains('hidden') ||
      player.morto) {
    // Pausa lógica enquanto painel aberto / morto
  } else {
    player.atualizar(dt, world);

    // Tempo do dia
    tempoDia = (tempoDia + dt / DIA_SEGUNDOS) % 1;
    const sun = Math.max(0.05, 0.5 + 0.5 * Math.sin(tempoDia * Math.PI * 2 - Math.PI / 2));

    mobMgr.atualizar(dt, world, player, sun);
    particulas.atualizar(dt);

    // === Raycast a cada frame (para highlight e quebra/colocar) ===
    const dirCamera = renderer.camera.getWorldDirection(_tmpVecAux);
    const ray = raycastBloco(world, renderer.camera.position, dirCamera, ALCANCE_BLOCO);

    // Quebra contínua (hold click esquerdo)
    let progressoVisual = 0;
    if (player.holdE && ray) {
      const t = ray.hit;
      if (!player.alvoQuebra ||
          player.alvoQuebra.x !== t.x || player.alvoQuebra.y !== t.y || player.alvoQuebra.z !== t.z) {
        player.alvoQuebra = { x: t.x, y: t.y, z: t.z };
        player.progressoQuebra = 0;
      }
      const tier = inv.melhorPicareta();
      const sel = inv.itemSelecionado();
      const ferr = sel && sel.i !== undefined && ITEM_INFO[sel.i]?.ferramenta;
      const mult = Drops.velocidadeQuebra(t.b, tier, ferr);
      player.progressoQuebra += dt / TEMPO_QUEBRA_BASE * mult;
      progressoVisual = player.progressoQuebra;
      if (player.progressoQuebra >= 1) {
        player.progressoQuebra = 0;
        const drops = Drops.dropDeBloco(t.b, tier);
        for (const d of drops) inv.adicionar(d);
        // Spawn partículas ANTES de remover o bloco — usa o tipo dele
        particulas.spawnQuebra(t.x, t.y, t.z, t.b);
        // Se for bloco funcional, dropar também o conteúdo do estado.
        if (t.b === BLOCO.BAU) {
          const bau = world.bauTesouros.get(World.keyXYZ(t.x, t.y, t.z));
          if (bau) for (const it of bau) if (it) inv.adicionar({ ...it });
          world.removerEstadoBloco(t.x, t.y, t.z);
        } else if (t.b === BLOCO.FORNALHA) {
          const f = world.fornalhaEstados.get(World.keyXYZ(t.x, t.y, t.z));
          if (f) {
            for (const it of [f.input, f.combustivel, f.output]) {
              if (it) inv.adicionar({ ...it });
            }
          }
          world.removerEstadoBloco(t.x, t.y, t.z);
        }
        world.set(t.x, t.y, t.z, BLOCO.AR);
        Audio.quebrar();
        progressoVisual = 0;
        // Ganha XP ao minerar minério.
        const xpGanho = (t.b === BLOCO.CARVAO) ? 1 :
                       (t.b === BLOCO.FERRO) ? 2 :
                       (t.b === BLOCO.OURO) ? 3 :
                       (t.b === BLOCO.DIAMANTE) ? 7 : 0;
        if (xpGanho > 0) ganharXP(xpGanho);
      }
    } else if (!player.holdE) {
      player.progressoQuebra = 0;
      player.alvoQuebra = null;
    }

    // Click direito: interação (baú/fornalha/cama/workbench) ou colocar bloco
    if (player.cliqueD) {
      player.cliqueD = false;
      if (ray) {
        const t = ray.hit;
        const blocoAlvo = t.b;
        // 1) Interagir com baú
        if (blocoAlvo === BLOCO.BAU) {
          abrirPainelBau(t.x, t.y, t.z);
        }
        // 2) Interagir com fornalha
        else if (blocoAlvo === BLOCO.FORNALHA) {
          abrirPainelFornalha(t.x, t.y, t.z);
        }
        // 3) Cama: dormir se for noite
        else if (blocoAlvo === BLOCO.CAMA) {
          dormir();
        }
        // 4) Workbench: abre painel craft
        else if (blocoAlvo === BLOCO.WORKBENCH) {
          togglePainel('painel-craft');
        }
        // 5) Caso contrário, colocar bloco do slot atual
        else {
          const sel = inv.itemSelecionado();
          if (sel && sel.b !== undefined) {
            const a = ray.adj;
            const px = Math.floor(player.pos.x), py = Math.floor(player.pos.y), pz = Math.floor(player.pos.z);
            if (!(a.x === px && a.z === pz && (a.y === py || a.y === py + 1))) {
              world.set(a.x, a.y, a.z, sel.b);
              inv.consumirAtual();
              Audio.colocar();
              renderer.swingProgress = 0.01;
            }
          }
        }
      }
    }

    // Highlight + cracks visuais
    renderer.atualizarAlvo(ray ? ray.hit : null, progressoVisual);

    // Animação da mão
    const sel = inv.itemSelecionado();
    const ferr = sel && sel.i !== undefined && ITEM_INFO[sel.i]?.ferramenta;
    renderer.atualizarMao(dt, player.holdE && !!ray, ferr);
  }

  // Carregamento on-demand de chunks ao redor do player
  const pcx = Math.floor(player.pos.x / CHUNK_SIZE);
  const pcz = Math.floor(player.pos.z / CHUNK_SIZE);
  let orcamento = chunkLoadOrcamento;
  for (let dx = -VIEW_RADIUS; dx <= VIEW_RADIUS && orcamento > 0; dx++) {
    for (let dz = -VIEW_RADIUS; dz <= VIEW_RADIUS && orcamento > 0; dz++) {
      if (!world.hasChunk(pcx + dx, pcz + dz)) {
        world.getChunk(pcx + dx, pcz + dz);
        orcamento--;
      }
    }
  }
  // Build/rebuild meshes dirty
  let buildOrc = 2;
  for (const c of world.chunks.values()) {
    if (c.dirty && buildOrc > 0) {
      const dx = c.cx - pcx, dz = c.cz - pcz;
      if (Math.abs(dx) <= VIEW_RADIUS + 1 && Math.abs(dz) <= VIEW_RADIUS + 1) {
        renderer.buildChunkMesh(world, c);
        buildOrc--;
      }
    }
  }
  // Liberar chunks fora do view (>VIEW_RADIUS+2)
  for (const [k, c] of world.chunks) {
    const dx = c.cx - pcx, dz = c.cz - pcz;
    if (Math.abs(dx) > VIEW_RADIUS + 2 || Math.abs(dz) > VIEW_RADIUS + 2) {
      if (c.mesh || c.meshT) renderer.liberarChunkMesh(c);
      // Não removemos dados de chunks modificados (continua na memória)
      if (!c.modificado) world.chunks.delete(k);
    }
  }

  renderer.atualizarCeu(tempoDia, player.pos);
  renderer.atualizarLuzesPontuais(world, player.pos);

  // HUD
  const t = tempoDia * 24;
  const h = Math.floor(t), m = Math.floor((t - h) * 60);
  document.getElementById('relogio').textContent =
    `${String(h).padStart(2, '0')}:${String(m).padStart(2, '0')}`;
  document.getElementById('coords').textContent =
    `X:${player.pos.x.toFixed(1)} Y:${player.pos.y.toFixed(1)} Z:${player.pos.z.toFixed(1)}`;
  ui.renderBars();

  renderer.render();
  requestAnimationFrame(loop);
}

// ===================================================================
// 12) Boot — esconder splash + entrar fullscreen + lock pointer
// ===================================================================
document.getElementById('play').addEventListener('click', async () => {
  // Desbloqueia AudioContext IMEDIATAMENTE dentro do gesto do clique.
  // Em iOS Safari isto é obrigatório — qualquer await/setTimeout antes
  // do resume() faz o navegador invalidar o gesto e o som não toca.
  try { window.rebcm?.desbloquearAudio?.(); } catch (_) {}

  // Tela cheia
  try {
    await document.documentElement.requestFullscreen?.();
    if (screen.orientation && screen.orientation.lock) {
      try { await screen.orientation.lock('landscape'); } catch (_) {}
    }
  } catch (_) {/* engole */}

  // Iniciar engine se necessário
  if (!renderer) init();

  // Mostrar HUD, esconder boot
  document.getElementById('boot').classList.add('hidden');
  document.getElementById('hud').classList.remove('hidden');

  // Pointer lock só faz sentido em mouse/teclado (desktop). Em touch
  // devices o look é feito via drag — pulamos o lock para evitar que o
  // browser bloqueie a UI tentando capturar um cursor inexistente.
  if (!isTouchDevice) {
    setTimeout(() => player.controls.lock(), 100);
  }

  // Música ambient
  try { window.rebcm?.musica?.iniciar?.(); } catch (_) {}
}, { once: true });
