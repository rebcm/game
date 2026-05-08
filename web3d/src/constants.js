// =====================================================================
// constants.js — Constantes do mundo, blocos, itens, receitas
//
// Todos os blocos são SÓLIDOS e OPACOS. Não existe mais transparência
// no jogo: vidro, folha, água e tocha viram blocos opacos.
// =====================================================================

// Dimensões do mundo
export const CHUNK_SIZE = 16;
export const WORLD_Y = 64;
export const VIEW_RADIUS = 6;            // chunks ao redor do player
export const TILE = 1.0;
export const PLAYER_HEIGHT = 1.8;
export const PLAYER_RADIUS = 0.3;
// Constantes de física calibradas para paridade com Minecraft real:
// - GRAVIDADE -27 dá queda perceptível mas não brusca.
// - PULO_VEL 8.4 produz altura de pulo ~1.25 blocos (Minecraft Java).
// - VEL_TERM -65 evita explosão de fall damage em quedas livres longas.
export const GRAVIDADE = -27;
export const VEL_TERM = -65;
export const PULO_VEL = 8.4;
export const VEL_ANDAR = 4.3;
export const VEL_SPRINT = 5.6;   // Minecraft real: andar 4.3 → sprint ~5.6 (1.3×)
export const VEL_SNEAK = 1.3;    // 30% da andar (paridade MC)
export const VEL_AR = 3.6;       // Controle aéreo reduzido (MC real)
export const MOUSE_SENS = 0.0022;
export const ALCANCE_BLOCO = 6.0;
export const TEMPO_QUEBRA_BASE = 0.45;
export const DIA_SEGUNDOS = 240;         // 4 minutos por dia
export const SAVE_KEY = 'rebcm3d_save_v4';

// IDs de bloco
export const BLOCO = {
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
  BEDROCK:   25,
  // === Sprint 2: building vocabulary ===
  // Blocos com forma customizada (não-cubo). Renderização especial no
  // mesh builder + colisão modificada no player/mob.
  SLAB_PEDRA:    26, // meia altura
  SLAB_MADEIRA:  27,
  SLAB_TIJOLO:   28,
  FENCE_MADEIRA: 29, // pillar fino + braços
  LADDER:        30, // escada (climb)
  DOOR_MADEIRA:  31, // porta (open/close por right-click)
};
export const N_BLOCOS = 32;

// Metadata de cada bloco. NENHUM bloco é transparente neste jogo.
// `solido` controla colisão. `emiteLuz` 0..15 (paridade Minecraft).
// `cor` é a cor da face superior; `lateral` é a cor das laterais.
export const BLOCO_INFO = {
  [BLOCO.AR]:        { nome: 'Ar',        solido: false, emiteLuz: 0,  cor: 0x000000, lateral: 0x000000 },
  [BLOCO.GRAMA]:     { nome: 'Grama',     solido: true,  emiteLuz: 0,  cor: 0x4CAF50, lateral: 0x8D6E63 },
  [BLOCO.TERRA]:     { nome: 'Terra',     solido: true,  emiteLuz: 0,  cor: 0x8D6E63, lateral: 0x6D4C41 },
  [BLOCO.PEDRA]:     { nome: 'Pedra',     solido: true,  emiteLuz: 0,  cor: 0x9E9E9E, lateral: 0x757575 },
  [BLOCO.AREIA]:     { nome: 'Areia',     solido: true,  emiteLuz: 0,  cor: 0xFFEB3B, lateral: 0xFDD835 },
  [BLOCO.MADEIRA]:   { nome: 'Madeira',   solido: true,  emiteLuz: 0,  cor: 0xA1887F, lateral: 0x8D6E63 },
  [BLOCO.FOLHA]:     { nome: 'Folha',     solido: true,  emiteLuz: 0,  cor: 0x66BB6A, lateral: 0x66BB6A },
  [BLOCO.TIJOLO]:    { nome: 'Tijolo',    solido: true,  emiteLuz: 0,  cor: 0xE57373, lateral: 0xC62828 },
  [BLOCO.VIDRO]:     { nome: 'Vidro',     solido: true,  emiteLuz: 0,  cor: 0xB3E5FC, lateral: 0xB3E5FC },
  [BLOCO.OURO]:      { nome: 'Ouro',      solido: true,  emiteLuz: 0,  cor: 0xFFD54F, lateral: 0xFBC02D },
  [BLOCO.DIAMANTE]:  { nome: 'Diamante',  solido: true,  emiteLuz: 0,  cor: 0x80DEEA, lateral: 0x4DD0E1 },
  [BLOCO.LUZ]:       { nome: 'Luz',       solido: true,  emiteLuz: 14, cor: 0xFFF9C4, lateral: 0xFFEE58 },
  [BLOCO.NEVE]:      { nome: 'Neve',      solido: true,  emiteLuz: 0,  cor: 0xECEFF1, lateral: 0xCFD8DC },
  [BLOCO.CARVAO]:    { nome: 'Carvão',    solido: true,  emiteLuz: 0,  cor: 0x424242, lateral: 0x212121 },
  [BLOCO.FERRO]:     { nome: 'Ferro',     solido: true,  emiteLuz: 0,  cor: 0xCFD8DC, lateral: 0xB0BEC5 },
  [BLOCO.CACTO]:     { nome: 'Cacto',     solido: true,  emiteLuz: 0,  cor: 0x388E3C, lateral: 0x2E7D32 },
  [BLOCO.AGUA]:      { nome: 'Água',      solido: true,  emiteLuz: 0,  cor: 0x2196F3, lateral: 0x1976D2 },
  [BLOCO.LAVA]:      { nome: 'Lava',      solido: true,  emiteLuz: 15, cor: 0xFF5722, lateral: 0xBF360C },
  [BLOCO.OBSIDIANA]: { nome: 'Obsidiana', solido: true,  emiteLuz: 0,  cor: 0x4d3e5e, lateral: 0x3a2c4a },
  [BLOCO.WORKBENCH]: { nome: 'Workbench', solido: true,  emiteLuz: 0,  cor: 0x6D4C41, lateral: 0x4E342E },
  [BLOCO.LA]:        { nome: 'Lã',        solido: true,  emiteLuz: 0,  cor: 0xFAFAFA, lateral: 0xEEEEEE },
  [BLOCO.TOCHA]:     { nome: 'Tocha',     solido: true,  emiteLuz: 13, cor: 0xFFB300, lateral: 0xFF6F00 },
  [BLOCO.BAU]:       { nome: 'Baú',       solido: true,  emiteLuz: 0,  cor: 0x8B5A2B, lateral: 0x6D4C41 },
  [BLOCO.FORNALHA]:  { nome: 'Fornalha',  solido: true,  emiteLuz: 0,  cor: 0x6E6E6E, lateral: 0x424242 },
  [BLOCO.CAMA]:      { nome: 'Cama',      solido: true,  emiteLuz: 0,  cor: 0xE53935, lateral: 0xC62828 },
  [BLOCO.BEDROCK]:   { nome: 'Bedrock',   solido: true,  emiteLuz: 0,  cor: 0x555555, lateral: 0x4a4a4a },
  // shape='slab' = meia altura inferior; 'fence' = pillar central; 'ladder'
  // = chapinha vertical (não-bloqueante); 'door' = chapinha vertical (toggle).
  [BLOCO.SLAB_PEDRA]:    { nome: 'Laje de Pedra',     solido: true,  emiteLuz: 0, cor: 0x9E9E9E, lateral: 0x757575, shape: 'slab' },
  [BLOCO.SLAB_MADEIRA]:  { nome: 'Laje de Madeira',   solido: true,  emiteLuz: 0, cor: 0xA1887F, lateral: 0x8D6E63, shape: 'slab' },
  [BLOCO.SLAB_TIJOLO]:   { nome: 'Laje de Tijolo',    solido: true,  emiteLuz: 0, cor: 0xE57373, lateral: 0xC62828, shape: 'slab' },
  [BLOCO.FENCE_MADEIRA]: { nome: 'Cerca de Madeira',  solido: true,  emiteLuz: 0, cor: 0xA1887F, lateral: 0x8D6E63, shape: 'fence' },
  [BLOCO.LADDER]:        { nome: 'Escada (ladder)',   solido: false, emiteLuz: 0, cor: 0xA1887F, lateral: 0x8D6E63, shape: 'ladder' },
  [BLOCO.DOOR_MADEIRA]:  { nome: 'Porta de Madeira',  solido: true,  emiteLuz: 0, cor: 0xA1887F, lateral: 0x8D6E63, shape: 'door' },
};

export const ICONE = {
  [BLOCO.GRAMA]: '🌿', [BLOCO.TERRA]: '🟫', [BLOCO.PEDRA]: '🪨',
  [BLOCO.AREIA]: '🏖', [BLOCO.MADEIRA]: '🪵', [BLOCO.FOLHA]: '🍃',
  [BLOCO.TIJOLO]: '🧱', [BLOCO.VIDRO]: '🔲', [BLOCO.OURO]: '🥇',
  [BLOCO.DIAMANTE]: '💎', [BLOCO.LUZ]: '💡', [BLOCO.NEVE]: '❄',
  [BLOCO.CARVAO]: '⬛', [BLOCO.FERRO]: '⚙', [BLOCO.CACTO]: '🌵',
  [BLOCO.AGUA]: '💧', [BLOCO.LAVA]: '🔥', [BLOCO.OBSIDIANA]: '⬣',
  [BLOCO.WORKBENCH]: '🪚', [BLOCO.LA]: '☁', [BLOCO.TOCHA]: '🕯',
  [BLOCO.BAU]: '📦', [BLOCO.FORNALHA]: '🔥', [BLOCO.CAMA]: '🛏',
  [BLOCO.BEDROCK]: '⬛',
};

// Tipos de item (não-bloco). IDs >= 100 para não colidir com BLOCO.*
export const ITEM = {
  CARNE_CRUA: 100, CARNE_COZIDA: 101, OVO: 102, CARNE_PODRE: 103,
  PRANCHAS: 110, PAU: 111, CARVAO: 112, FERRO: 113, OURO: 114, DIAMANTE: 115,
  COURO: 120,
  PIC_MADEIRA: 200, PIC_PEDRA: 201, PIC_FERRO: 202, PIC_DIAMANTE: 203,
  ESP_MADEIRA: 210, ESP_PEDRA: 211, ESP_FERRO: 212,
  ARCO: 220, FLECHA: 221,
  OSSO: 230, MUDA: 231,
  BUCKET: 240, BUCKET_AGUA: 241, BUCKET_LAVA: 242,
  SEMENTE: 250, TRIGO: 251, PAO: 252,
  // Armaduras: tier × peça
  CAP_COURO: 300, PEI_COURO: 301, PER_COURO: 302, BOT_COURO: 303,
  CAP_FERRO: 304, PEI_FERRO: 305, PER_FERRO: 306, BOT_FERRO: 307,
  CAP_DIAMANTE: 308, PEI_DIAMANTE: 309, PER_DIAMANTE: 310, BOT_DIAMANTE: 311,
};

export const ITEM_INFO = {
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
  [ITEM.ARCO]:         { nome: 'Arco',             icone: '🏹', ferramenta: 'arco' },
  [ITEM.FLECHA]:       { nome: 'Flecha',           icone: '➹' },
  [ITEM.OSSO]:         { nome: 'Osso',             icone: '🦴', ferramenta: 'osso' },
  [ITEM.MUDA]:         { nome: 'Muda de Carvalho', icone: '🌱', plantavel: true },
  [ITEM.BUCKET]:       { nome: 'Balde',            icone: '🪣' },
  [ITEM.BUCKET_AGUA]:  { nome: 'Balde de Água',    icone: '💧' },
  [ITEM.BUCKET_LAVA]:  { nome: 'Balde de Lava',    icone: '🔥' },
  [ITEM.SEMENTE]:      { nome: 'Sementes',         icone: '🌾', plantavel: true },
  [ITEM.TRIGO]:        { nome: 'Trigo',            icone: '🌾' },
  [ITEM.PAO]:          { nome: 'Pão',              icone: '🍞', nutricao: 5 },
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

// Receitas de crafting. wb=true exige workbench próximo.
export const RECEITAS = [
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
  // Arco: 3 paus + 3 lã (proxy de corda). Flechas: 1 pau + 1 lã = 4.
  { custos: [{i: ITEM.PAU, q: 3}, {b: BLOCO.LA, q: 3}], saida: {i: ITEM.ARCO,   q: 1}, wb: true },
  { custos: [{i: ITEM.PAU, q: 1}, {b: BLOCO.LA, q: 1}], saida: {i: ITEM.FLECHA, q: 4}, wb: false },
  { custos: [{i: ITEM.CARNE_CRUA, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {i: ITEM.CARNE_COZIDA, q: 1}, wb: false },
  { custos: [{i: ITEM.COURO, q: 5}], saida: {i: ITEM.CAP_COURO, q: 1}, wb: true },
  { custos: [{i: ITEM.COURO, q: 8}], saida: {i: ITEM.PEI_COURO, q: 1}, wb: true },
  { custos: [{i: ITEM.COURO, q: 7}], saida: {i: ITEM.PER_COURO, q: 1}, wb: true },
  { custos: [{i: ITEM.COURO, q: 4}], saida: {i: ITEM.BOT_COURO, q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 5}], saida: {i: ITEM.CAP_FERRO, q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 8}], saida: {i: ITEM.PEI_FERRO, q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 7}], saida: {i: ITEM.PER_FERRO, q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 4}], saida: {i: ITEM.BOT_FERRO, q: 1}, wb: true },
  { custos: [{i: ITEM.DIAMANTE, q: 5}], saida: {i: ITEM.CAP_DIAMANTE, q: 1}, wb: true },
  { custos: [{i: ITEM.DIAMANTE, q: 8}], saida: {i: ITEM.PEI_DIAMANTE, q: 1}, wb: true },
  { custos: [{i: ITEM.DIAMANTE, q: 7}], saida: {i: ITEM.PER_DIAMANTE, q: 1}, wb: true },
  { custos: [{i: ITEM.DIAMANTE, q: 4}], saida: {i: ITEM.BOT_DIAMANTE, q: 1}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 8}], saida: {b: BLOCO.BAU, q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 3}], saida: {i: ITEM.BUCKET, q: 1}, wb: true },
  { custos: [{i: ITEM.TRIGO, q: 3}], saida: {i: ITEM.PAO, q: 1}, wb: false },
  // Building vocabulary (Sprint 2)
  { custos: [{b: BLOCO.PEDRA, q: 3}],    saida: {b: BLOCO.SLAB_PEDRA,    q: 6}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 3}],  saida: {b: BLOCO.SLAB_MADEIRA,  q: 6}, wb: true },
  { custos: [{b: BLOCO.TIJOLO, q: 3}],   saida: {b: BLOCO.SLAB_TIJOLO,   q: 6}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 4}, {i: ITEM.PAU, q: 2}], saida: {b: BLOCO.FENCE_MADEIRA, q: 3}, wb: true },
  { custos: [{i: ITEM.PAU, q: 7}],       saida: {b: BLOCO.LADDER,        q: 3}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 6}],  saida: {b: BLOCO.DOOR_MADEIRA,  q: 1}, wb: true },
  { custos: [{b: BLOCO.PEDRA, q: 8}], saida: {b: BLOCO.FORNALHA, q: 1}, wb: true },
  { custos: [{b: BLOCO.LA, q: 3}, {i: ITEM.PRANCHAS, q: 3}], saida: {b: BLOCO.CAMA, q: 1}, wb: true },
];
