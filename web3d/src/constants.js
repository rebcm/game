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
  DOOR_MADEIRA:  31, // porta fechada (full cube com forma 'door')
  // === Sprint 3 ===
  MESA_ENCANT:   32, // mesa de encantamento (right-click pra spend XP)
  // === Sprint 4 ===
  DOOR_ABERTA:   33, // porta aberta (chapinha lateral, passável)
  // === Sprint 9: Nether ===
  NETHERRACK:    34, // pedra vermelha do Nether
  PORTAL_NETHER: 35, // bloco de portal (emissive roxo)
  // === Sprint End ===
  END_STONE:     36, // pedra amarelo claro da dimensão End
  PORTAL_END:    37, // portal verde escuro (emissive)
  DRAGON_EGG:    38, // ovo do dragon (drop boss, decoração emissive)
  END_CRYSTAL:   39, // cristal no End que cura o dragon (destruir antes!)
  PUMPKIN:       40, // abóbora natural (decoração)
  CARVED_PUMPKIN:41, // abóbora talhada (cabeça do snow golem + helmet)
  BOLO:          42, // bolo: comestível ao right-click (restaura fome, consome bloco)
  BIGORNA:       43, // bigorna: renomeia item ativo (right-click → painel)
  BEACON:        44, // farol: emite feixe vertical + buffs sobre pirâmide
  RAIL:          45, // trilho: chapinha fina decorativa no chão (shape slab)
  TEIA:          46, // teia de aranha: bloco macio em mineshafts (lenta player)
  ESTANTE:       47, // estante de livros: dá bônus de XP em mesa de encantamento
  LA_VERMELHA:   48,
  LA_AZUL:       49,
  LA_VERDE:      50,
  LA_AMARELA:    51,
  VIDRO_VERMELHO: 52,
  VIDRO_AZUL:     53,
  VIDRO_VERDE:    54,
  VIDRO_AMARELO:  55,
  QUARTZO:        56, // bloco branco elegante (drop do Nether ou crafting)
  QUARTZO_POLIDO: 57, // versão polida (mais clara, sem grão)
  COGUMELO_VERM:  58, // bloco gigante de cogumelo vermelho com bolinhas brancas
  COGUMELO_MARROM:59, // bloco gigante de cogumelo marrom (chapéu liso)
  COBRE:          60, // cobre novo (laranja-avermelhado)
  COBRE_GASTO:    61, // cobre exposto (rosa-marrom)
  COBRE_OXIDADO:  62, // cobre oxidado (verde-azulado, MC verdigris)
  VELA:           63, // vela branca (luz 8, decoração)
  VELA_VERMELHA:  64,
  VELA_AZUL:      65,
  MAGMA:          66, // bloco de magma: dá dano ao pisar (não em sneak)
  LANTERNA:       67, // lanterna: luz forte (15) brilhante
  BANDEIRA_R:     68, // bandeira vermelha (decoração com mastro)
  BANDEIRA_A:     69, // bandeira azul
  BANDEIRA_V:     70, // bandeira verde
  BANDEIRA_AM:    71, // bandeira amarela
  COBRE_MINERIO:  72, // minério de cobre (gera em pedra, smelt → lingote)
  COLMEIA:        73, // colmeia: gera mel ao longo do tempo, decoração
  LILY_PAD:       74, // vitória-régia: decoração flutuante na água
};
export const N_BLOCOS = 75;

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
  [BLOCO.MESA_ENCANT]:   { nome: 'Mesa de Encantamento', solido: true, emiteLuz: 7, cor: 0x4527A0, lateral: 0x311B92 },
  // Porta aberta: solido false (passa por dentro), shape 'door_open'
  [BLOCO.DOOR_ABERTA]:   { nome: 'Porta (Aberta)',   solido: false, emiteLuz: 0, cor: 0xA1887F, lateral: 0x8D6E63, shape: 'door_open' },
  [BLOCO.NETHERRACK]:    { nome: 'Netherrack',       solido: true,  emiteLuz: 0,  cor: 0x6e2a1a, lateral: 0x4d1a10 },
  [BLOCO.PORTAL_NETHER]: { nome: 'Portal do Nether', solido: false, emiteLuz: 11, cor: 0x6a1b9a, lateral: 0x6a1b9a },
  [BLOCO.END_STONE]:     { nome: 'Pedra do End',     solido: true,  emiteLuz: 0,  cor: 0xe8d886, lateral: 0xc0a866 },
  [BLOCO.PORTAL_END]:    { nome: 'Portal do End',    solido: false, emiteLuz: 9,  cor: 0x004d40, lateral: 0x004d40 },
  [BLOCO.DRAGON_EGG]:    { nome: 'Ovo do Dragon',    solido: true,  emiteLuz: 8,  cor: 0x1a1a1a, lateral: 0x000000 },
  [BLOCO.END_CRYSTAL]:   { nome: 'Cristal do End',   solido: true,  emiteLuz: 13, cor: 0xfff59d, lateral: 0xfff176 },
  [BLOCO.PUMPKIN]:       { nome: 'Abóbora',          solido: true,  emiteLuz: 0,  cor: 0xff9800, lateral: 0xe65100 },
  [BLOCO.CARVED_PUMPKIN]:{ nome: 'Abóbora Talhada',  solido: true,  emiteLuz: 0,  cor: 0xff9800, lateral: 0xe65100 },
  [BLOCO.BOLO]:          { nome: 'Bolo',             solido: true,  emiteLuz: 0,  cor: 0xfaf3e0, lateral: 0xb98860 },
  [BLOCO.BIGORNA]:       { nome: 'Bigorna',          solido: true,  emiteLuz: 0,  cor: 0x424242, lateral: 0x212121 },
  [BLOCO.BEACON]:        { nome: 'Farol',            solido: true,  emiteLuz: 15, cor: 0x80deea, lateral: 0x4dd0e1 },
  [BLOCO.RAIL]:          { nome: 'Trilho',           solido: true,  emiteLuz: 0,  cor: 0x9E9E9E, lateral: 0x757575, shape: 'slab' },
  [BLOCO.TEIA]:          { nome: 'Teia de Aranha',   solido: true,  emiteLuz: 0,  cor: 0xfafafa, lateral: 0xeeeeee },
  [BLOCO.ESTANTE]:       { nome: 'Estante de Livros',solido: true,  emiteLuz: 0,  cor: 0xa1887f, lateral: 0xa1887f },
  [BLOCO.LA_VERMELHA]:   { nome: 'Lã Vermelha',      solido: true,  emiteLuz: 0,  cor: 0xc62828, lateral: 0xb71c1c },
  [BLOCO.LA_AZUL]:       { nome: 'Lã Azul',          solido: true,  emiteLuz: 0,  cor: 0x1565c0, lateral: 0x0d47a1 },
  [BLOCO.LA_VERDE]:      { nome: 'Lã Verde',         solido: true,  emiteLuz: 0,  cor: 0x2e7d32, lateral: 0x1b5e20 },
  [BLOCO.LA_AMARELA]:    { nome: 'Lã Amarela',       solido: true,  emiteLuz: 0,  cor: 0xf9a825, lateral: 0xf57f17 },
  [BLOCO.VIDRO_VERMELHO]:{ nome: 'Vidro Vermelho',   solido: true,  emiteLuz: 0,  cor: 0xef5350, lateral: 0xef5350 },
  [BLOCO.VIDRO_AZUL]:    { nome: 'Vidro Azul',       solido: true,  emiteLuz: 0,  cor: 0x4fc3f7, lateral: 0x4fc3f7 },
  [BLOCO.VIDRO_VERDE]:   { nome: 'Vidro Verde',      solido: true,  emiteLuz: 0,  cor: 0x66bb6a, lateral: 0x66bb6a },
  [BLOCO.VIDRO_AMARELO]: { nome: 'Vidro Amarelo',    solido: true,  emiteLuz: 0,  cor: 0xffeb3b, lateral: 0xffeb3b },
  [BLOCO.QUARTZO]:       { nome: 'Quartzo',          solido: true,  emiteLuz: 0,  cor: 0xfafafa, lateral: 0xeeeeee },
  [BLOCO.QUARTZO_POLIDO]:{ nome: 'Quartzo Polido',   solido: true,  emiteLuz: 0,  cor: 0xfff8e1, lateral: 0xfff8e1 },
  [BLOCO.COGUMELO_VERM]: { nome: 'Cogumelo Vermelho',solido: true,  emiteLuz: 1,  cor: 0xc62828, lateral: 0xc62828 },
  [BLOCO.COGUMELO_MARROM]:{nome: 'Cogumelo Marrom', solido: true,  emiteLuz: 1,  cor: 0x6d4c41, lateral: 0x6d4c41 },
  [BLOCO.COBRE]:         { nome: 'Cobre',            solido: true,  emiteLuz: 0,  cor: 0xe07a3b, lateral: 0xc56226 },
  [BLOCO.COBRE_GASTO]:   { nome: 'Cobre Gasto',      solido: true,  emiteLuz: 0,  cor: 0xb47366, lateral: 0x8d5e54 },
  [BLOCO.COBRE_OXIDADO]: { nome: 'Cobre Oxidado',    solido: true,  emiteLuz: 0,  cor: 0x5fb89e, lateral: 0x4a9b82 },
  [BLOCO.VELA]:          { nome: 'Vela',             solido: true,  emiteLuz: 8,  cor: 0xfafafa, lateral: 0xeeeeee },
  [BLOCO.VELA_VERMELHA]: { nome: 'Vela Vermelha',    solido: true,  emiteLuz: 8,  cor: 0xef5350, lateral: 0xc62828 },
  [BLOCO.VELA_AZUL]:     { nome: 'Vela Azul',        solido: true,  emiteLuz: 8,  cor: 0x4fc3f7, lateral: 0x1565c0 },
  [BLOCO.MAGMA]:         { nome: 'Bloco de Magma',   solido: true,  emiteLuz: 3,  cor: 0xbf360c, lateral: 0x8b0000 },
  [BLOCO.LANTERNA]:      { nome: 'Lanterna',         solido: true,  emiteLuz: 15, cor: 0xffd54f, lateral: 0x424242 },
  [BLOCO.BANDEIRA_R]:    { nome: 'Bandeira Vermelha',solido: true,  emiteLuz: 0,  cor: 0xc62828, lateral: 0x8b0000 },
  [BLOCO.BANDEIRA_A]:    { nome: 'Bandeira Azul',    solido: true,  emiteLuz: 0,  cor: 0x1565c0, lateral: 0x0d47a1 },
  [BLOCO.BANDEIRA_V]:    { nome: 'Bandeira Verde',   solido: true,  emiteLuz: 0,  cor: 0x2e7d32, lateral: 0x1b5e20 },
  [BLOCO.BANDEIRA_AM]:   { nome: 'Bandeira Amarela', solido: true,  emiteLuz: 0,  cor: 0xf9a825, lateral: 0xf57f17 },
  [BLOCO.COBRE_MINERIO]: { nome: 'Minério de Cobre', solido: true,  emiteLuz: 0,  cor: 0x8e7060, lateral: 0x6b5448 },
  [BLOCO.COLMEIA]:       { nome: 'Colmeia',          solido: true,  emiteLuz: 0,  cor: 0xfdd835, lateral: 0xa1887f },
  [BLOCO.LILY_PAD]:      { nome: 'Vitória-régia',    solido: true,  emiteLuz: 0,  cor: 0x388e3c, lateral: 0x388e3c, shape: 'slab' },
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
  // === Sprint 3: progressão endgame ===
  LIVRO: 260, LAPIS: 261,
  POCAO_HEAL: 270, POCAO_SPEED: 271, POCAO_STRENGTH: 272, POCAO_REGEN: 273,
  // Sprint 4: moeda dos villagers + comida pra domesticar cat
  ESMERALDA: 280, PEIXE: 281,
  // Sprint 9: acende portal
  SILEX: 290, FLINT_STEEL: 291,
  ENDER_PEARL: 295, // teleport on right-click (drop de enderman)
  EYE_OF_ENDER: 296, // ativa portal End (ender_pearl + carvao)
  SLIMEBALL:    297, // drop de slime (futuro: pistão/grude)
  VARA_PESCA:   298, // vara de pesca: cast em água, espera bite, reel pra peixe
  BUCKET_LEITE: 243, // balde de leite: ordenha vaca + cura debuffs ao beber
  BUSSOLA:      299, // bússola: aponta pro spawn (HUD com seta)
  FOGUETE:      244, // foguete: right-click lança, sobe, explode em cores
  LUNETA:       245, // luneta: right-click toggle zoom (FOV reduzido)
  TRIDENTE:     246, // tridente: arremessa, atinge mob, volta ao player
  CARNE_COELHO: 247, // drop do coelho, comestível
  PE_COELHO:    248, // raro drop do coelho, ingrediente de poção (futuro)
  QUARTZO_BRUTO:249, // shard de quartzo (drop de netherrack ou crafting)
  CASCO_TARTARUGA:250, // drop raro da tartaruga, futuro: capacete
  COGUMELO_R:    251, // cogumelo vermelho coletável
  COGUMELO_M:    252, // cogumelo marrom coletável
  SOPA_COGUMELO: 253, // sopa: cura 6 fome (paridade MC)
  TIGELA:        254, // bowl/cup vazia, deixada após comer sopa
  COBRE_LINGOTE: 255, // lingote de cobre (smelt de minério)
  MACA:          256, // maçã: comida normal + drop raro de folha
  MACA_DOURADA:  257, // maçã dourada: regen + absorption (paridade MC real)
  SALMAO:        258, // salmão: pesca alternativa, mais nutritivo que peixe
  MEL:           259, // mel: comida da colmeia, restaura fome
  FAVO_MEL:      260, // favo de mel: ingrediente futuro
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
  [ITEM.LIVRO]:        { nome: 'Livro',            icone: '📕' },
  [ITEM.LAPIS]:        { nome: 'Lápis Lazuli',     icone: '🔷' },
  [ITEM.POCAO_HEAL]:    { nome: 'Poção de Cura',     icone: '🧪', pocao: 'heal' },
  [ITEM.POCAO_SPEED]:   { nome: 'Poção de Velocidade', icone: '🧪', pocao: 'speed' },
  [ITEM.POCAO_STRENGTH]:{ nome: 'Poção de Força',   icone: '🧪', pocao: 'strength' },
  [ITEM.POCAO_REGEN]:   { nome: 'Poção de Regen.',  icone: '🧪', pocao: 'regen' },
  [ITEM.ESMERALDA]:     { nome: 'Esmeralda',         icone: '💚' },
  [ITEM.PEIXE]:         { nome: 'Peixe',             icone: '🐟', nutricao: 4 },
  [ITEM.SILEX]:         { nome: 'Sílex',             icone: '🪨' },
  [ITEM.FLINT_STEEL]:   { nome: 'Isqueiro',          icone: '🔥', ferramenta: 'isqueiro' },
  [ITEM.ENDER_PEARL]:   { nome: 'Pérola do Ender',   icone: '🔮' },
  [ITEM.EYE_OF_ENDER]:  { nome: 'Olho do Ender',     icone: '👁' },
  [ITEM.SLIMEBALL]:     { nome: 'Bola de Slime',     icone: '🟢' },
  [ITEM.VARA_PESCA]:    { nome: 'Vara de Pesca',     icone: '🎣', ferramenta: 'vara' },
  [ITEM.BUCKET_LEITE]:  { nome: 'Balde de Leite',    icone: '🥛' },
  [ITEM.BUSSOLA]:       { nome: 'Bússola',           icone: '🧭' },
  [ITEM.FOGUETE]:       { nome: 'Foguete',           icone: '🎆' },
  [ITEM.LUNETA]:        { nome: 'Luneta',            icone: '🔭', ferramenta: 'luneta' },
  [ITEM.TRIDENTE]:      { nome: 'Tridente',          icone: '🔱', ferramenta: 'tridente' },
  [ITEM.CARNE_COELHO]:  { nome: 'Carne de Coelho',   icone: '🍗', nutricao: 3 },
  [ITEM.PE_COELHO]:     { nome: 'Pé de Coelho',      icone: '🐾' },
  [ITEM.QUARTZO_BRUTO]: { nome: 'Quartzo Bruto',     icone: '✨' },
  [ITEM.CASCO_TARTARUGA]:{ nome: 'Casco de Tartaruga', icone: '🛡' },
  [ITEM.COGUMELO_R]:    { nome: 'Cogumelo Vermelho', icone: '🍄' },
  [ITEM.COGUMELO_M]:    { nome: 'Cogumelo Marrom',   icone: '🍄' },
  [ITEM.SOPA_COGUMELO]: { nome: 'Sopa de Cogumelo',  icone: '🍲', nutricao: 6 },
  [ITEM.TIGELA]:        { nome: 'Tigela',            icone: '🥣' },
  [ITEM.COBRE_LINGOTE]: { nome: 'Lingote de Cobre',  icone: '🟧' },
  [ITEM.MACA]:          { nome: 'Maçã',              icone: '🍎', nutricao: 4 },
  [ITEM.MACA_DOURADA]:  { nome: 'Maçã Dourada',      icone: '🍏', nutricao: 4, dourada: true },
  [ITEM.SALMAO]:        { nome: 'Salmão',            icone: '🐟', nutricao: 5 },
  [ITEM.MEL]:           { nome: 'Mel',               icone: '🍯', nutricao: 6 },
  [ITEM.FAVO_MEL]:      { nome: 'Favo de Mel',       icone: '🟨' },
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
  // Sprint 3: items de progressão (lapis dropa de PEDRA com 2% chance — fix em inventory)
  { custos: [{i: ITEM.PRANCHAS, q: 3}, {b: BLOCO.LA, q: 1}], saida: {i: ITEM.LIVRO, q: 1}, wb: true },
  { custos: [{i: ITEM.LIVRO, q: 1}, {i: ITEM.DIAMANTE, q: 2}, {b: BLOCO.OBSIDIANA, q: 4}], saida: {b: BLOCO.MESA_ENCANT, q: 1}, wb: true },
  // Poções via crafting direto (simplificação — sem brewing stand)
  { custos: [{b: BLOCO.AGUA, q: 1}, {i: ITEM.LAPIS, q: 1}, {i: ITEM.OURO, q: 1}], saida: {i: ITEM.POCAO_HEAL, q: 1}, wb: true },
  { custos: [{b: BLOCO.AGUA, q: 1}, {i: ITEM.LAPIS, q: 1}, {i: ITEM.PAU, q: 2}], saida: {i: ITEM.POCAO_SPEED, q: 1}, wb: true },
  { custos: [{b: BLOCO.AGUA, q: 1}, {i: ITEM.LAPIS, q: 1}, {i: ITEM.FERRO, q: 2}], saida: {i: ITEM.POCAO_STRENGTH, q: 1}, wb: true },
  { custos: [{b: BLOCO.AGUA, q: 1}, {i: ITEM.LAPIS, q: 1}, {i: ITEM.TRIGO, q: 2}], saida: {i: ITEM.POCAO_REGEN, q: 1}, wb: true },
  // Sprint 9: isqueiro pra acender portal
  { custos: [{i: ITEM.FERRO, q: 1}, {i: ITEM.SILEX, q: 1}], saida: {i: ITEM.FLINT_STEEL, q: 1}, wb: true },
  // Sprint End: olho do ender abre portal pra dimensão End
  { custos: [{i: ITEM.ENDER_PEARL, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {i: ITEM.EYE_OF_ENDER, q: 1}, wb: true },
  { custos: [{b: BLOCO.PEDRA, q: 8}], saida: {b: BLOCO.FORNALHA, q: 1}, wb: true },
  { custos: [{b: BLOCO.LA, q: 3}, {i: ITEM.PRANCHAS, q: 3}], saida: {b: BLOCO.CAMA, q: 1}, wb: true },
  // Vara de pesca: 3 paus + 2 lã (proxy de cordel/string)
  { custos: [{i: ITEM.PAU, q: 3}, {b: BLOCO.LA, q: 2}], saida: {i: ITEM.VARA_PESCA, q: 1}, wb: true },
  // Bússola: 4 ferro + 1 ouro (proxy de redstone) — aponta pro spawn
  { custos: [{i: ITEM.FERRO, q: 4}, {i: ITEM.OURO, q: 1}], saida: {i: ITEM.BUSSOLA, q: 1}, wb: true },
  // Bigorna: 8 ferro (proxy de bloco de ferro × 3 + 4 lingotes — simplificado)
  { custos: [{i: ITEM.FERRO, q: 8}], saida: {b: BLOCO.BIGORNA, q: 1}, wb: true },
  // Foguete: 1 lã (proxy de papel) + 1 carvão (proxy de pólvora) → 4 foguetes
  { custos: [{b: BLOCO.LA, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {i: ITEM.FOGUETE, q: 4}, wb: false },
  // Beacon (Farol): 5 vidro + 3 obsidiana + 1 diamante (proxy de Nether Star)
  { custos: [{b: BLOCO.VIDRO, q: 5}, {b: BLOCO.OBSIDIANA, q: 3}, {i: ITEM.DIAMANTE, q: 1}], saida: {b: BLOCO.BEACON, q: 1}, wb: true },
  // Luneta: 2 ferro + 1 diamante (proxy de copper+amethyst) — zoom 4×
  { custos: [{i: ITEM.FERRO, q: 2}, {i: ITEM.DIAMANTE, q: 1}], saida: {i: ITEM.LUNETA, q: 1}, wb: true },
  // Tridente: 4 ferro + 2 diamante (proxy de prismarine — endgame)
  { custos: [{i: ITEM.FERRO, q: 4}, {i: ITEM.DIAMANTE, q: 2}, {i: ITEM.PAU, q: 2}], saida: {i: ITEM.TRIDENTE, q: 1}, wb: true },
  // Trilho: 6 ferro + 1 pau → 16 trilhos (paridade Minecraft)
  { custos: [{i: ITEM.FERRO, q: 6}, {i: ITEM.PAU, q: 1}], saida: {b: BLOCO.RAIL, q: 16}, wb: true },
  // Estante: 6 pranchas + 3 livros (paridade MC)
  { custos: [{i: ITEM.PRANCHAS, q: 6}, {i: ITEM.LIVRO, q: 3}], saida: {b: BLOCO.ESTANTE, q: 1}, wb: true },
  // Lãs coloridas: 1 lã + 1 corante proxy (tijolo/lapis/muda/trigo)
  { custos: [{b: BLOCO.LA, q: 1}, {b: BLOCO.TIJOLO, q: 1}], saida: {b: BLOCO.LA_VERMELHA, q: 1}, wb: false },
  { custos: [{b: BLOCO.LA, q: 1}, {i: ITEM.LAPIS,    q: 1}], saida: {b: BLOCO.LA_AZUL,     q: 1}, wb: false },
  { custos: [{b: BLOCO.LA, q: 1}, {i: ITEM.MUDA,     q: 1}], saida: {b: BLOCO.LA_VERDE,    q: 1}, wb: false },
  { custos: [{b: BLOCO.LA, q: 1}, {i: ITEM.TRIGO,    q: 1}], saida: {b: BLOCO.LA_AMARELA,  q: 1}, wb: false },
  // Vidros coloridos (mesmo padrão de corante)
  { custos: [{b: BLOCO.VIDRO, q: 1}, {b: BLOCO.TIJOLO, q: 1}], saida: {b: BLOCO.VIDRO_VERMELHO, q: 1}, wb: false },
  { custos: [{b: BLOCO.VIDRO, q: 1}, {i: ITEM.LAPIS,    q: 1}], saida: {b: BLOCO.VIDRO_AZUL,     q: 1}, wb: false },
  { custos: [{b: BLOCO.VIDRO, q: 1}, {i: ITEM.MUDA,     q: 1}], saida: {b: BLOCO.VIDRO_VERDE,    q: 1}, wb: false },
  { custos: [{b: BLOCO.VIDRO, q: 1}, {i: ITEM.TRIGO,    q: 1}], saida: {b: BLOCO.VIDRO_AMARELO,  q: 1}, wb: false },
  // Quartzo: 4 shards = 1 bloco. Polido = 4 quartzo = 4 polido.
  { custos: [{i: ITEM.QUARTZO_BRUTO, q: 4}],     saida: {b: BLOCO.QUARTZO,        q: 1}, wb: true },
  { custos: [{b: BLOCO.QUARTZO, q: 4}],          saida: {b: BLOCO.QUARTZO_POLIDO, q: 4}, wb: true },
  // Tigela: 3 pranchas → 4 tigelas (paridade MC)
  { custos: [{i: ITEM.PRANCHAS, q: 3}], saida: {i: ITEM.TIGELA, q: 4}, wb: false },
  // Sopa de Cogumelo: 1 vermelho + 1 marrom + 1 tigela (paridade MC)
  { custos: [{i: ITEM.COGUMELO_R, q: 1}, {i: ITEM.COGUMELO_M, q: 1}, {i: ITEM.TIGELA, q: 1}], saida: {i: ITEM.SOPA_COGUMELO, q: 1}, wb: false },
  // Cobre: 9 lingotes → 1 bloco (paridade MC)
  { custos: [{i: ITEM.COBRE_LINGOTE, q: 9}], saida: {b: BLOCO.COBRE, q: 1}, wb: true },
  // Maçã Dourada: 8 ouro + 1 maçã (paridade MC real, item endgame)
  { custos: [{i: ITEM.OURO, q: 8}, {i: ITEM.MACA, q: 1}], saida: {i: ITEM.MACA_DOURADA, q: 1}, wb: true },
  // Colmeia: 6 pranchas + 3 favos de mel (paridade MC)
  { custos: [{i: ITEM.PRANCHAS, q: 6}, {i: ITEM.FAVO_MEL, q: 3}], saida: {b: BLOCO.COLMEIA, q: 1}, wb: true },
  // Magma: 4 obsidiana + 1 carvão (proxy de magma cream — sem magma cream)
  { custos: [{b: BLOCO.OBSIDIANA, q: 4}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.MAGMA, q: 4}, wb: true },
  // Lanterna: 8 ferro + 1 tocha → 1 lanterna (paridade MC: nuggets, simplificado)
  { custos: [{i: ITEM.FERRO, q: 8}, {b: BLOCO.TOCHA, q: 1}], saida: {b: BLOCO.LANTERNA, q: 1}, wb: true },
  // Bandeiras: 6 lã colorida + 1 pau (paridade MC com banner)
  { custos: [{b: BLOCO.LA_VERMELHA, q: 6}, {i: ITEM.PAU, q: 1}], saida: {b: BLOCO.BANDEIRA_R,  q: 1}, wb: true },
  { custos: [{b: BLOCO.LA_AZUL,     q: 6}, {i: ITEM.PAU, q: 1}], saida: {b: BLOCO.BANDEIRA_A,  q: 1}, wb: true },
  { custos: [{b: BLOCO.LA_VERDE,    q: 6}, {i: ITEM.PAU, q: 1}], saida: {b: BLOCO.BANDEIRA_V,  q: 1}, wb: true },
  { custos: [{b: BLOCO.LA_AMARELA,  q: 6}, {i: ITEM.PAU, q: 1}], saida: {b: BLOCO.BANDEIRA_AM, q: 1}, wb: true },
  // Velas: lã + carvão → vela. Lã colorida → vela colorida.
  { custos: [{b: BLOCO.LA, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.VELA, q: 1}, wb: false },
  { custos: [{b: BLOCO.LA_VERMELHA, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.VELA_VERMELHA, q: 1}, wb: false },
  { custos: [{b: BLOCO.LA_AZUL, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.VELA_AZUL, q: 1}, wb: false },
  // Bolo: 3 trigo + 1 ovo + 1 carvao (proxy de açúcar) + 1 lã (proxy de leite)
  { custos: [{i: ITEM.TRIGO, q: 3}, {i: ITEM.OVO, q: 1}, {i: ITEM.CARVAO, q: 1}, {b: BLOCO.LA, q: 1}], saida: {b: BLOCO.BOLO, q: 1}, wb: true },
];
