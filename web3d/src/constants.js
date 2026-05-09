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
  BLOCO_MEL:      75, // bloco de mel: decorativo dourado pegajoso
  GRANITO:        76, // pedra natural rosa-avermelhada
  DIORITO:        77, // pedra natural branca/preta manchada
  ANDESITO:       78, // pedra natural cinza-claro
  ARGILA:         79, // bloco cinza-azulado, smelt → tijolo
  BAMBU:          80, // tronco verde-claro fino (decoração)
  GRANITO_POL:    81,
  DIORITO_POL:    82,
  ANDESITO_POL:   83,
  PEDRA_LISA:     84, // smooth stone (smelt de pedra)
  TIJOLO_MUSGO:   85, // tijolo de pedra com musgo
  ARENITO:        86, // sandstone amarelo padrão
  ARENITO_LISO:   87, // smooth sandstone (sem grãos)
  ARENITO_CORTADO:88, // chiseled sandstone (com símbolos)
  TIJOLO_NETHER:  89, // nether brick (vermelho-escuro)
  NETHER_CORTADO: 90, // chiseled nether brick
  PAVIMENTO:      91, // cobblestone (pedras irregulares cinza)
  GELO:           92, // gelo translúcido (visualmente azul claro)
  GELO_EMPACOTADO:93, // packed ice (mais opaco, denso)
  GELO_AZUL:      94, // blue ice (intenso)
  BASALTO:        95, // basalto: rocha vulcânica escura
  BASALTO_POLIDO: 96, // basalto polido (smooth)
  SOUL_SAND:      97, // areia das almas (nether, faces tristes)
  SOUL_SOIL:      98, // terra das almas (nether, marrom-escuro)
  CRIMSON_STEM:   99, // tronco crimson (vermelho-rosa)
  WARPED_STEM:   100, // tronco warped (ciano-turquesa)
  BLACKSTONE:    101, // pedra preta vulcânica
  DEEPSLATE:     102, // ardósia profunda (cinza-escuro Y<0)
  AMETHYST:      103, // ametista (cristal roxo)
  CALCITE:       104, // calcita (branca lisa)
  DEEPSLATE_PAV: 105, // pavimento de deepslate (cobbled)
  DEEPSLATE_POL: 106, // deepslate polido
  BLACKSTONE_POL:107, // blackstone polido
  LAMA:          108, // lama / mud (marrom umedo)
  LAMA_COMPACTA: 109, // lama compactada
  TIJOLO_LAMA:   110, // tijolo de lama
  TUFF:          111, // tufo (cinza claro vulcânico)
  DRIPSTONE:     112, // pedra goteira (laranja)
  // Deepslate ores (Y < 0 paridade MC)
  DS_CARVAO:     113,
  DS_FERRO:      114,
  DS_OURO:       115,
  DS_DIAMANTE:   116,
  DS_COBRE:      117,
  // Blocos compactados (visual + storage)
  BLOCO_FERRO:   118,
  BLOCO_OURO:    119,
  BLOCO_DIAMANTE:120,
  BLOCO_CARVAO:  121,
  BLOCO_LAPIS:   122,
  // Esmeralda (3 variantes)
  ESMERALDA_MIN: 123, // minério em pedra
  DS_ESMERALDA:  124, // minério em deepslate
  BLOCO_ESMERALDA:125,
  // Redstone (3 variantes)
  REDSTONE_MIN:  126,
  DS_REDSTONE:   127,
  BLOCO_REDSTONE:128,
  // Prismarine (3 variantes)
  PRISMARINE:    129,
  PRISMARINE_BRK:130,
  SEA_LANTERN:   131,
  SLIME_BLOCK:   132,
  CRYING_OBSIDIAN:133,
  NETHER_WART_R: 134,
  NETHER_WART_A: 135,
  SHROOMLIGHT:   136,
  END_BRICK:     137,
  PURPUR_BLOCK:  138,
  PURPUR_PILLAR: 139,
  CRIMSON_PLANKS:140,
  WARPED_PLANKS: 141,
  SPONGE:        142,
  SPONGE_WET:    143,
  JACK_O_LANTERN:144, // pumpkin acesa (emiteLuz 15)
  TINTED_GLASS:  145, // vidro escurecido
  SNOW_BLOCK:    146, // neve compacta (3 layers)
  GLOW_LICHEN:   147, // líquen brilhante
  SPORE_BLOSSOM: 148, // flor cogumelo (decoração)
  POWDER_SNOW:   149, // neve em pó (player afunda)
  // Família Sculk (paridade Minecraft 1.19+)
  SCULK:         150, // bloco sculk (xp ao quebrar)
  SCULK_VEIN:    151, // veias sculk (decoração)
  SCULK_SHRIEKER:152, // shrieker (alarma warden)
  SCULK_SENSOR:  153, // sensor (detecta vibração)
  SCULK_CATALYST:154, // catalisador (gera sculk)
  // Camas coloridas (4 cores adicionais)
  CAMA_AZUL:     155,
  CAMA_VERDE:    156,
  CAMA_AMARELA:  157,
  CAMA_ROXA:     158,
};
export const N_BLOCOS = 159;

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
  [BLOCO.TOCHA]:     { nome: 'Tocha',     solido: false, emiteLuz: 13, cor: 0xFFB300, lateral: 0xFF6F00, shape: 'torch' },
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
  [BLOCO.VELA]:          { nome: 'Vela',             solido: false, emiteLuz: 8,  cor: 0xfafafa, lateral: 0xeeeeee, shape: 'torch' },
  [BLOCO.VELA_VERMELHA]: { nome: 'Vela Vermelha',    solido: false, emiteLuz: 8,  cor: 0xef5350, lateral: 0xc62828, shape: 'torch' },
  [BLOCO.VELA_AZUL]:     { nome: 'Vela Azul',        solido: false, emiteLuz: 8,  cor: 0x4fc3f7, lateral: 0x1565c0, shape: 'torch' },
  [BLOCO.MAGMA]:         { nome: 'Bloco de Magma',   solido: true,  emiteLuz: 3,  cor: 0xbf360c, lateral: 0x8b0000 },
  [BLOCO.LANTERNA]:      { nome: 'Lanterna',         solido: true,  emiteLuz: 15, cor: 0xffd54f, lateral: 0x424242 },
  [BLOCO.BANDEIRA_R]:    { nome: 'Bandeira Vermelha',solido: true,  emiteLuz: 0,  cor: 0xc62828, lateral: 0x8b0000 },
  [BLOCO.BANDEIRA_A]:    { nome: 'Bandeira Azul',    solido: true,  emiteLuz: 0,  cor: 0x1565c0, lateral: 0x0d47a1 },
  [BLOCO.BANDEIRA_V]:    { nome: 'Bandeira Verde',   solido: true,  emiteLuz: 0,  cor: 0x2e7d32, lateral: 0x1b5e20 },
  [BLOCO.BANDEIRA_AM]:   { nome: 'Bandeira Amarela', solido: true,  emiteLuz: 0,  cor: 0xf9a825, lateral: 0xf57f17 },
  [BLOCO.COBRE_MINERIO]: { nome: 'Minério de Cobre', solido: true,  emiteLuz: 0,  cor: 0x8e7060, lateral: 0x6b5448 },
  [BLOCO.COLMEIA]:       { nome: 'Colmeia',          solido: true,  emiteLuz: 0,  cor: 0xfdd835, lateral: 0xa1887f },
  [BLOCO.LILY_PAD]:      { nome: 'Vitória-régia',    solido: true,  emiteLuz: 0,  cor: 0x388e3c, lateral: 0x388e3c, shape: 'slab' },
  [BLOCO.BLOCO_MEL]:     { nome: 'Bloco de Mel',     solido: true,  emiteLuz: 1,  cor: 0xffc107, lateral: 0xff8f00 },
  [BLOCO.GRANITO]:       { nome: 'Granito',          solido: true,  emiteLuz: 0,  cor: 0xa66556, lateral: 0x8a4a3d },
  [BLOCO.DIORITO]:       { nome: 'Diorito',          solido: true,  emiteLuz: 0,  cor: 0xe0e0e0, lateral: 0xbdbdbd },
  [BLOCO.ANDESITO]:      { nome: 'Andesito',         solido: true,  emiteLuz: 0,  cor: 0x9e9e9e, lateral: 0x757575 },
  [BLOCO.ARGILA]:        { nome: 'Argila',           solido: true,  emiteLuz: 0,  cor: 0xa0a4b8, lateral: 0x8a8e9e },
  [BLOCO.BAMBU]:         { nome: 'Bambu',            solido: true,  emiteLuz: 0,  cor: 0x8bc34a, lateral: 0x689f38 },
  [BLOCO.GRANITO_POL]:   { nome: 'Granito Polido',   solido: true,  emiteLuz: 0,  cor: 0xc98575, lateral: 0xa66556 },
  [BLOCO.DIORITO_POL]:   { nome: 'Diorito Polido',   solido: true,  emiteLuz: 0,  cor: 0xeeeeee, lateral: 0xe0e0e0 },
  [BLOCO.ANDESITO_POL]:  { nome: 'Andesito Polido',  solido: true,  emiteLuz: 0,  cor: 0xb0b0b0, lateral: 0x9e9e9e },
  [BLOCO.PEDRA_LISA]:    { nome: 'Pedra Lisa',       solido: true,  emiteLuz: 0,  cor: 0xb8b8b8, lateral: 0xa0a0a0 },
  [BLOCO.TIJOLO_MUSGO]:  { nome: 'Tijolo c/ Musgo',  solido: true,  emiteLuz: 0,  cor: 0xc0d0a0, lateral: 0xa0b88a },
  [BLOCO.ARENITO]:       { nome: 'Arenito',          solido: true,  emiteLuz: 0,  cor: 0xfdd8a0, lateral: 0xe6c389 },
  [BLOCO.ARENITO_LISO]:  { nome: 'Arenito Liso',     solido: true,  emiteLuz: 0,  cor: 0xfde2b2, lateral: 0xfde2b2 },
  [BLOCO.ARENITO_CORTADO]:{nome:'Arenito Cortado',  solido: true,  emiteLuz: 0,  cor: 0xfdd8a0, lateral: 0xe6c389 },
  [BLOCO.TIJOLO_NETHER]: { nome: 'Tijolo do Nether', solido: true,  emiteLuz: 0,  cor: 0x4a0e0e, lateral: 0x2d0707 },
  [BLOCO.NETHER_CORTADO]:{ nome: 'Nether Cortado',  solido: true,  emiteLuz: 0,  cor: 0x4a0e0e, lateral: 0x2d0707 },
  [BLOCO.PAVIMENTO]:     { nome: 'Pavimento',        solido: true,  emiteLuz: 0,  cor: 0x7a7a7a, lateral: 0x5e5e5e },
  [BLOCO.GELO]:          { nome: 'Gelo',             solido: true,  emiteLuz: 0,  cor: 0xb3e5fc, lateral: 0x90caf9 },
  [BLOCO.GELO_EMPACOTADO]:{ nome: 'Gelo Empacotado', solido: true,  emiteLuz: 0,  cor: 0xc1d8ff, lateral: 0xa0c0ec },
  [BLOCO.GELO_AZUL]:     { nome: 'Gelo Azul',        solido: true,  emiteLuz: 1,  cor: 0x40c4ff, lateral: 0x0288d1 },
  [BLOCO.BASALTO]:       { nome: 'Basalto',          solido: true,  emiteLuz: 0,  cor: 0x424242, lateral: 0x2a2a2a },
  [BLOCO.BASALTO_POLIDO]:{ nome: 'Basalto Polido',   solido: true,  emiteLuz: 0,  cor: 0x5a5a5a, lateral: 0x3a3a3a },
  [BLOCO.SOUL_SAND]:     { nome: 'Areia das Almas',  solido: true,  emiteLuz: 0,  cor: 0x4e342e, lateral: 0x3e2723 },
  [BLOCO.SOUL_SOIL]:     { nome: 'Terra das Almas',  solido: true,  emiteLuz: 0,  cor: 0x3e2723, lateral: 0x2e1810 },
  [BLOCO.CRIMSON_STEM]:  { nome: 'Caule Crimson',    solido: true,  emiteLuz: 0,  cor: 0x8a3a4d, lateral: 0x5d2535 },
  [BLOCO.WARPED_STEM]:   { nome: 'Caule Warped',     solido: true,  emiteLuz: 0,  cor: 0x2c8a8a, lateral: 0x1d5d5d },
  [BLOCO.BLACKSTONE]:    { nome: 'Pedra Negra',      solido: true,  emiteLuz: 0,  cor: 0x1a1a1a, lateral: 0x0a0a0a },
  [BLOCO.DEEPSLATE]:     { nome: 'Ardósia',          solido: true,  emiteLuz: 0,  cor: 0x4a4a52, lateral: 0x35353d },
  [BLOCO.AMETHYST]:      { nome: 'Ametista',         solido: true,  emiteLuz: 4,  cor: 0xab47bc, lateral: 0x7b1fa2 },
  [BLOCO.CALCITE]:       { nome: 'Calcita',          solido: true,  emiteLuz: 0,  cor: 0xeceff1, lateral: 0xcfd8dc },
  [BLOCO.DEEPSLATE_PAV]: { nome: 'Pav. de Ardósia',  solido: true,  emiteLuz: 0,  cor: 0x4a4a52, lateral: 0x35353d },
  [BLOCO.DEEPSLATE_POL]: { nome: 'Ardósia Polida',   solido: true,  emiteLuz: 0,  cor: 0x55555f, lateral: 0x40404a },
  [BLOCO.BLACKSTONE_POL]:{ nome: 'Blackstone Polida',solido: true,  emiteLuz: 0,  cor: 0x2a2a2a, lateral: 0x1a1a1a },
  [BLOCO.LAMA]:          { nome: 'Lama',             solido: true,  emiteLuz: 0,  cor: 0x4d3826, lateral: 0x36281a },
  [BLOCO.LAMA_COMPACTA]: { nome: 'Lama Compacta',    solido: true,  emiteLuz: 0,  cor: 0x806746, lateral: 0x6b5337 },
  [BLOCO.TIJOLO_LAMA]:   { nome: 'Tijolo de Lama',   solido: true,  emiteLuz: 0,  cor: 0xa0855e, lateral: 0x856a48 },
  [BLOCO.TUFF]:          { nome: 'Tufo',             solido: true,  emiteLuz: 0,  cor: 0x6b6e6c, lateral: 0x55585a },
  [BLOCO.DRIPSTONE]:     { nome: 'Pedra Goteira',    solido: true,  emiteLuz: 0,  cor: 0xc28560, lateral: 0xa56a4c },
  // Deepslate ores (versão dark dos minérios — Y baixo)
  [BLOCO.DS_CARVAO]:     { nome: 'Carvão Profundo',  solido: true,  emiteLuz: 0,  cor: 0x4a4a52, lateral: 0x35353d },
  [BLOCO.DS_FERRO]:      { nome: 'Ferro Profundo',   solido: true,  emiteLuz: 0,  cor: 0x4a4a52, lateral: 0x35353d },
  [BLOCO.DS_OURO]:       { nome: 'Ouro Profundo',    solido: true,  emiteLuz: 0,  cor: 0x4a4a52, lateral: 0x35353d },
  [BLOCO.DS_DIAMANTE]:   { nome: 'Diamante Profundo',solido: true,  emiteLuz: 0,  cor: 0x4a4a52, lateral: 0x35353d },
  [BLOCO.DS_COBRE]:      { nome: 'Cobre Profundo',   solido: true,  emiteLuz: 0,  cor: 0x4a4a52, lateral: 0x35353d },
  // Blocos compactados (storage de 9 unidades + decoração)
  [BLOCO.BLOCO_FERRO]:   { nome: 'Bloco de Ferro',   solido: true,  emiteLuz: 0,  cor: 0xeceff1, lateral: 0xcfd8dc },
  [BLOCO.BLOCO_OURO]:    { nome: 'Bloco de Ouro',    solido: true,  emiteLuz: 0,  cor: 0xfdd835, lateral: 0xf9a825 },
  [BLOCO.BLOCO_DIAMANTE]:{ nome: 'Bloco de Diamante',solido: true,  emiteLuz: 0,  cor: 0x4dd0e1, lateral: 0x00838f },
  [BLOCO.BLOCO_CARVAO]:  { nome: 'Bloco de Carvão',  solido: true,  emiteLuz: 0,  cor: 0x212121, lateral: 0x000000 },
  [BLOCO.BLOCO_LAPIS]:   { nome: 'Bloco de Lápis',   solido: true,  emiteLuz: 0,  cor: 0x1565c0, lateral: 0x0d47a1 },
  [BLOCO.ESMERALDA_MIN]: { nome: 'Minério Esmeralda',solido: true,  emiteLuz: 0,  cor: 0x7E7E7E, lateral: 0x5E5E5E },
  [BLOCO.DS_ESMERALDA]:  { nome: 'Esmeralda Profunda',solido:true,  emiteLuz: 0,  cor: 0x4a4a52, lateral: 0x35353d },
  [BLOCO.BLOCO_ESMERALDA]:{nome:'Bloco de Esmeralda', solido:true, emiteLuz: 0,  cor: 0x00c853, lateral: 0x008c44 },
  [BLOCO.REDSTONE_MIN]:  { nome: 'Minério Redstone', solido: true,  emiteLuz: 4,  cor: 0x7E7E7E, lateral: 0x5E5E5E },
  [BLOCO.DS_REDSTONE]:   { nome: 'Redstone Profunda',solido: true,  emiteLuz: 4,  cor: 0x4a4a52, lateral: 0x35353d },
  [BLOCO.BLOCO_REDSTONE]:{ nome: 'Bloco de Redstone',solido: true,  emiteLuz: 7,  cor: 0xc62828, lateral: 0x8b0000 },
  [BLOCO.PRISMARINE]:    { nome: 'Prismarine',       solido: true,  emiteLuz: 0,  cor: 0x4db6ac, lateral: 0x00897b },
  [BLOCO.PRISMARINE_BRK]:{ nome: 'Tijolo Prismarine',solido: true,  emiteLuz: 0,  cor: 0x009688, lateral: 0x00695c },
  [BLOCO.SEA_LANTERN]:   { nome: 'Sea Lantern',      solido: true,  emiteLuz: 15, cor: 0xb2dfdb, lateral: 0x80cbc4 },
  [BLOCO.SLIME_BLOCK]:   { nome: 'Bloco de Slime',   solido: true,  emiteLuz: 0,  cor: 0x8bc34a, lateral: 0x558b2f },
  [BLOCO.CRYING_OBSIDIAN]:{nome:'Obsidiana Chorando',solido: true,  emiteLuz: 10, cor: 0x4a148c, lateral: 0x311b92 },
  [BLOCO.NETHER_WART_R]: { nome: 'Nether Wart Verm.',solido: true,  emiteLuz: 0,  cor: 0x6a0d0d, lateral: 0x4a0707 },
  [BLOCO.NETHER_WART_A]: { nome: 'Warped Wart Azul', solido: true,  emiteLuz: 0,  cor: 0x0d6a6a, lateral: 0x074a4a },
  [BLOCO.SHROOMLIGHT]:   { nome: 'Shroomlight',      solido: true,  emiteLuz: 15, cor: 0xff9800, lateral: 0xf57c00 },
  [BLOCO.END_BRICK]:     { nome: 'Tijolo do End',    solido: true,  emiteLuz: 0,  cor: 0xe8d886, lateral: 0xc0a866 },
  [BLOCO.PURPUR_BLOCK]:  { nome: 'Purpur',           solido: true,  emiteLuz: 0,  cor: 0xab47bc, lateral: 0x7b1fa2 },
  [BLOCO.PURPUR_PILLAR]: { nome: 'Pilar Purpur',     solido: true,  emiteLuz: 0,  cor: 0xab47bc, lateral: 0x7b1fa2 },
  [BLOCO.CRIMSON_PLANKS]:{ nome: 'Pranchas Crimson', solido: true,  emiteLuz: 0,  cor: 0x8a3a4d, lateral: 0x5d2535 },
  [BLOCO.WARPED_PLANKS]: { nome: 'Pranchas Warped',  solido: true,  emiteLuz: 0,  cor: 0x2c8a8a, lateral: 0x1d5d5d },
  [BLOCO.SPONGE]:        { nome: 'Esponja',          solido: true,  emiteLuz: 0,  cor: 0xfdd835, lateral: 0xf9a825 },
  [BLOCO.SPONGE_WET]:    { nome: 'Esponja Molhada',  solido: true,  emiteLuz: 0,  cor: 0xa1887f, lateral: 0x8d6e63 },
  [BLOCO.JACK_O_LANTERN]:{ nome: 'Jack-o-Lantern',   solido: true,  emiteLuz: 15, cor: 0xff9800, lateral: 0xe65100 },
  [BLOCO.TINTED_GLASS]:  { nome: 'Vidro Escuro',     solido: true,  emiteLuz: 0,  cor: 0x424242, lateral: 0x212121 },
  [BLOCO.SNOW_BLOCK]:    { nome: 'Bloco de Neve',    solido: true,  emiteLuz: 0,  cor: 0xfafafa, lateral: 0xeceff1 },
  [BLOCO.GLOW_LICHEN]:   { nome: 'Líquen Brilhante', solido: true,  emiteLuz: 7,  cor: 0xa5d6a7, lateral: 0x66bb6a },
  [BLOCO.SPORE_BLOSSOM]: { nome: 'Flor Cogumelo',    solido: true,  emiteLuz: 0,  cor: 0xf06292, lateral: 0xc2185b },
  [BLOCO.POWDER_SNOW]:   { nome: 'Neve em Pó',       solido: true,  emiteLuz: 0,  cor: 0xfafafa, lateral: 0xeceff1 },
  [BLOCO.SCULK]:         { nome: 'Sculk',            solido: true,  emiteLuz: 1,  cor: 0x0a1a2a, lateral: 0x051018 },
  [BLOCO.SCULK_VEIN]:    { nome: 'Veia Sculk',       solido: true,  emiteLuz: 1,  cor: 0x0a1a2a, lateral: 0x051018 },
  [BLOCO.SCULK_SHRIEKER]:{ nome: 'Shrieker',         solido: true,  emiteLuz: 5,  cor: 0x40c4ff, lateral: 0x0288d1 },
  [BLOCO.SCULK_SENSOR]:  { nome: 'Sensor Sculk',     solido: true,  emiteLuz: 4,  cor: 0x40c4ff, lateral: 0x0288d1 },
  [BLOCO.SCULK_CATALYST]:{ nome: 'Catalisador Sculk',solido: true,  emiteLuz: 6,  cor: 0x4dd0e1, lateral: 0x00838f },
  [BLOCO.CAMA_AZUL]:     { nome: 'Cama Azul',        solido: true,  emiteLuz: 0,  cor: 0x1565c0, lateral: 0x0d47a1 },
  [BLOCO.CAMA_VERDE]:    { nome: 'Cama Verde',       solido: true,  emiteLuz: 0,  cor: 0x2e7d32, lateral: 0x1b5e20 },
  [BLOCO.CAMA_AMARELA]:  { nome: 'Cama Amarela',     solido: true,  emiteLuz: 0,  cor: 0xf9a825, lateral: 0xf57f17 },
  [BLOCO.CAMA_ROXA]:     { nome: 'Cama Roxa',        solido: true,  emiteLuz: 0,  cor: 0x7b1fa2, lateral: 0x4a148c },
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
  TINTA_GLOW:    261, // tinta brilhante (drop do glow squid)
  REDSTONE:      262, // pó de redstone (drop do minério)
  PRISMARINE_SHARD:263, // shard de prismarine (drop)
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
  [ITEM.TINTA_GLOW]:    { nome: 'Tinta Brilhante',   icone: '💠' },
  [ITEM.REDSTONE]:      { nome: 'Pó de Redstone',    icone: '🔴' },
  [ITEM.PRISMARINE_SHARD]:{ nome: 'Shard Prismarine', icone: '🔷' },
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
  // Bloco de Mel: 4 mel = 1 bloco
  { custos: [{i: ITEM.MEL, q: 4}], saida: {b: BLOCO.BLOCO_MEL, q: 1}, wb: true },
  // Variantes polidas: 4 natural → 4 polido (paridade MC stonecutter)
  { custos: [{b: BLOCO.GRANITO,  q: 4}], saida: {b: BLOCO.GRANITO_POL,  q: 4}, wb: true },
  { custos: [{b: BLOCO.DIORITO,  q: 4}], saida: {b: BLOCO.DIORITO_POL,  q: 4}, wb: true },
  { custos: [{b: BLOCO.ANDESITO, q: 4}], saida: {b: BLOCO.ANDESITO_POL, q: 4}, wb: true },
  // Pedra Lisa: 4 pedra (proxy de smelt)
  { custos: [{b: BLOCO.PEDRA, q: 4}], saida: {b: BLOCO.PEDRA_LISA, q: 4}, wb: true },
  // Tijolo c/ musgo: 1 tijolo + 1 muda → 1 tijolo musgo (proxy mossy)
  { custos: [{b: BLOCO.TIJOLO, q: 1}, {i: ITEM.MUDA, q: 1}], saida: {b: BLOCO.TIJOLO_MUSGO, q: 1}, wb: true },
  // Arenito: 4 areia → 1 arenito (paridade MC)
  { custos: [{b: BLOCO.AREIA, q: 4}], saida: {b: BLOCO.ARENITO, q: 1}, wb: true },
  // Arenito Liso: smelt do arenito (proxy: 1 arenito + 1 carvão)
  { custos: [{b: BLOCO.ARENITO, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.ARENITO_LISO, q: 1}, wb: false },
  // Arenito Cortado: 4 arenito → 4 cortado
  { custos: [{b: BLOCO.ARENITO, q: 4}], saida: {b: BLOCO.ARENITO_CORTADO, q: 4}, wb: true },
  // Tijolo do Nether: 4 netherrack + 1 carvão → 4 tijolos
  { custos: [{b: BLOCO.NETHERRACK, q: 4}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.TIJOLO_NETHER, q: 4}, wb: true },
  // Nether Cortado: 4 tijolos do nether → 4 cortados
  { custos: [{b: BLOCO.TIJOLO_NETHER, q: 4}], saida: {b: BLOCO.NETHER_CORTADO, q: 4}, wb: true },
  // Pavimento: 4 pedras → 4 pavimento (cobblestone — paridade quase invertida MC)
  { custos: [{b: BLOCO.PEDRA, q: 4}], saida: {b: BLOCO.PAVIMENTO, q: 4}, wb: true },
  // Gelo: 9 neve → 1 gelo
  { custos: [{b: BLOCO.NEVE, q: 9}], saida: {b: BLOCO.GELO, q: 1}, wb: true },
  // Gelo Empacotado: 9 gelo → 1 empacotado (paridade MC)
  { custos: [{b: BLOCO.GELO, q: 9}], saida: {b: BLOCO.GELO_EMPACOTADO, q: 1}, wb: true },
  // Gelo Azul: 9 empacotado → 1 azul
  { custos: [{b: BLOCO.GELO_EMPACOTADO, q: 9}], saida: {b: BLOCO.GELO_AZUL, q: 1}, wb: true },
  // Basalto: 4 obsidiana + 1 carvão → 4 basalto
  { custos: [{b: BLOCO.OBSIDIANA, q: 4}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.BASALTO, q: 4}, wb: true },
  // Basalto Polido: 4 basalto → 4 polido
  { custos: [{b: BLOCO.BASALTO, q: 4}], saida: {b: BLOCO.BASALTO_POLIDO, q: 4}, wb: true },
  // Soul Sand: 1 areia + 1 carvão (proxy de soul sand do Nether)
  { custos: [{b: BLOCO.AREIA, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.SOUL_SAND, q: 1}, wb: false },
  // Soul Soil: 1 terra + 1 carvão
  { custos: [{b: BLOCO.TERRA, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.SOUL_SOIL, q: 1}, wb: false },
  // Crimson Stem: 4 madeira + 1 tijolo (proxy)
  { custos: [{b: BLOCO.MADEIRA, q: 4}, {b: BLOCO.TIJOLO, q: 1}], saida: {b: BLOCO.CRIMSON_STEM, q: 4}, wb: true },
  // Warped Stem: 4 madeira + 1 lápis (proxy)
  { custos: [{b: BLOCO.MADEIRA, q: 4}, {i: ITEM.LAPIS, q: 1}], saida: {b: BLOCO.WARPED_STEM, q: 4}, wb: true },
  // Blackstone: 4 obsidiana → 4 blackstone
  { custos: [{b: BLOCO.OBSIDIANA, q: 4}], saida: {b: BLOCO.BLACKSTONE, q: 4}, wb: true },
  // Deepslate: 4 pedra + 1 carvão → 4 deepslate (proxy)
  { custos: [{b: BLOCO.PEDRA, q: 4}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.DEEPSLATE, q: 4}, wb: true },
  // Ametista: 4 lápis + 1 diamante → 1 ametista
  { custos: [{i: ITEM.LAPIS, q: 4}, {i: ITEM.DIAMANTE, q: 1}], saida: {b: BLOCO.AMETHYST, q: 1}, wb: true },
  // Calcita: 4 neve + 1 ferro → 4 calcita
  { custos: [{b: BLOCO.NEVE, q: 4}, {i: ITEM.FERRO, q: 1}], saida: {b: BLOCO.CALCITE, q: 4}, wb: true },
  // Deepslate variants
  { custos: [{b: BLOCO.DEEPSLATE, q: 4}], saida: {b: BLOCO.DEEPSLATE_PAV, q: 4}, wb: true },
  { custos: [{b: BLOCO.DEEPSLATE_PAV, q: 4}], saida: {b: BLOCO.DEEPSLATE_POL, q: 4}, wb: true },
  // Blackstone polido: 4 blackstone → 4 polido
  { custos: [{b: BLOCO.BLACKSTONE, q: 4}], saida: {b: BLOCO.BLACKSTONE_POL, q: 4}, wb: true },
  // Lama: 1 terra + 1 água (proxy: balde água)
  { custos: [{b: BLOCO.TERRA, q: 1}, {i: ITEM.BUCKET_AGUA, q: 1}], saida: {b: BLOCO.LAMA, q: 1}, wb: false },
  // Lama Compacta: 1 lama + 1 trigo
  { custos: [{b: BLOCO.LAMA, q: 1}, {i: ITEM.TRIGO, q: 1}], saida: {b: BLOCO.LAMA_COMPACTA, q: 1}, wb: false },
  // Tijolo de Lama: 4 lama compacta → 4 tijolo lama
  { custos: [{b: BLOCO.LAMA_COMPACTA, q: 4}], saida: {b: BLOCO.TIJOLO_LAMA, q: 4}, wb: true },
  // Tufo: 4 pedra + 1 obsidiana
  { custos: [{b: BLOCO.PEDRA, q: 4}, {b: BLOCO.OBSIDIANA, q: 1}], saida: {b: BLOCO.TUFF, q: 4}, wb: true },
  // Dripstone: 4 areia + 1 lava bucket
  { custos: [{b: BLOCO.AREIA, q: 4}, {i: ITEM.BUCKET_LAVA, q: 1}], saida: {b: BLOCO.DRIPSTONE, q: 4}, wb: true },
  // Blocos compactados (paridade MC: 9 itens → 1 bloco, reversível)
  { custos: [{i: ITEM.FERRO,    q: 9}], saida: {b: BLOCO.BLOCO_FERRO,    q: 1}, wb: true },
  { custos: [{i: ITEM.OURO,     q: 9}], saida: {b: BLOCO.BLOCO_OURO,     q: 1}, wb: true },
  { custos: [{i: ITEM.DIAMANTE, q: 9}], saida: {b: BLOCO.BLOCO_DIAMANTE, q: 1}, wb: true },
  { custos: [{i: ITEM.CARVAO,   q: 9}], saida: {b: BLOCO.BLOCO_CARVAO,   q: 1}, wb: true },
  { custos: [{i: ITEM.LAPIS,    q: 9}], saida: {b: BLOCO.BLOCO_LAPIS,    q: 1}, wb: true },
  // Reversível
  { custos: [{b: BLOCO.BLOCO_FERRO,    q: 1}], saida: {i: ITEM.FERRO,    q: 9}, wb: true },
  { custos: [{b: BLOCO.BLOCO_OURO,     q: 1}], saida: {i: ITEM.OURO,     q: 9}, wb: true },
  { custos: [{b: BLOCO.BLOCO_DIAMANTE, q: 1}], saida: {i: ITEM.DIAMANTE, q: 9}, wb: true },
  { custos: [{b: BLOCO.BLOCO_CARVAO,   q: 1}], saida: {i: ITEM.CARVAO,   q: 9}, wb: true },
  { custos: [{b: BLOCO.BLOCO_LAPIS,    q: 1}], saida: {i: ITEM.LAPIS,    q: 9}, wb: true },
  // Esmeralda compactada (9 esmeraldas → 1 bloco) reversível
  { custos: [{i: ITEM.ESMERALDA, q: 9}], saida: {b: BLOCO.BLOCO_ESMERALDA, q: 1}, wb: true },
  { custos: [{b: BLOCO.BLOCO_ESMERALDA, q: 1}], saida: {i: ITEM.ESMERALDA, q: 9}, wb: true },
  // Redstone compactado
  { custos: [{i: ITEM.REDSTONE, q: 9}], saida: {b: BLOCO.BLOCO_REDSTONE, q: 1}, wb: true },
  { custos: [{b: BLOCO.BLOCO_REDSTONE, q: 1}], saida: {i: ITEM.REDSTONE, q: 9}, wb: true },
  // Prismarine: 4 shards → 1 prismarine
  { custos: [{i: ITEM.PRISMARINE_SHARD, q: 4}], saida: {b: BLOCO.PRISMARINE, q: 1}, wb: true },
  // Tijolo prismarine: 9 shards → 1 tijolo
  { custos: [{i: ITEM.PRISMARINE_SHARD, q: 9}], saida: {b: BLOCO.PRISMARINE_BRK, q: 1}, wb: true },
  // Sea Lantern: 4 prismarine + 5 tinta_glow → 1 sea lantern
  { custos: [{b: BLOCO.PRISMARINE, q: 4}, {i: ITEM.TINTA_GLOW, q: 5}], saida: {b: BLOCO.SEA_LANTERN, q: 1}, wb: true },
  // Slime block: 9 slimeballs (paridade MC)
  { custos: [{i: ITEM.SLIMEBALL, q: 9}], saida: {b: BLOCO.SLIME_BLOCK, q: 1}, wb: true },
  // Crying Obsidian: 1 obsidiana + 1 ender pearl
  { custos: [{b: BLOCO.OBSIDIANA, q: 1}, {i: ITEM.ENDER_PEARL, q: 1}], saida: {b: BLOCO.CRYING_OBSIDIAN, q: 1}, wb: true },
  // Nether Wart Block (vermelho): 9 favos de mel (proxy)
  { custos: [{i: ITEM.FAVO_MEL, q: 9}], saida: {b: BLOCO.NETHER_WART_R, q: 1}, wb: true },
  // Warped Wart Block (azul): 9 tinta glow
  { custos: [{i: ITEM.TINTA_GLOW, q: 9}], saida: {b: BLOCO.NETHER_WART_A, q: 1}, wb: true },
  // Shroomlight: 4 cogumelo vermelho + 4 brasa (carvao) → 1
  { custos: [{i: ITEM.COGUMELO_R, q: 4}, {i: ITEM.CARVAO, q: 4}], saida: {b: BLOCO.SHROOMLIGHT, q: 1}, wb: true },
  // End Brick: 4 end stone → 4 tijolos
  { custos: [{b: BLOCO.END_STONE, q: 4}], saida: {b: BLOCO.END_BRICK, q: 4}, wb: true },
  // Purpur: 4 ender pearl + 4 end stone → 4 purpur
  { custos: [{i: ITEM.ENDER_PEARL, q: 4}, {b: BLOCO.END_STONE, q: 4}], saida: {b: BLOCO.PURPUR_BLOCK, q: 4}, wb: true },
  // Purpur Pillar: 2 purpur → 2 pilares
  { custos: [{b: BLOCO.PURPUR_BLOCK, q: 2}], saida: {b: BLOCO.PURPUR_PILLAR, q: 2}, wb: true },
  // Crimson/Warped Planks: 1 stem → 4 pranchas (paridade MC)
  { custos: [{b: BLOCO.CRIMSON_STEM, q: 1}], saida: {b: BLOCO.CRIMSON_PLANKS, q: 4}, wb: false },
  { custos: [{b: BLOCO.WARPED_STEM, q: 1}], saida: {b: BLOCO.WARPED_PLANKS, q: 4}, wb: false },
  // Esponja: 9 favos de mel + 1 trigo → 1 esponja (proxy)
  { custos: [{i: ITEM.FAVO_MEL, q: 9}, {i: ITEM.TRIGO, q: 1}], saida: {b: BLOCO.SPONGE, q: 1}, wb: true },
  // Esponja Molhada: 1 esponja + 1 balde água
  { custos: [{b: BLOCO.SPONGE, q: 1}, {i: ITEM.BUCKET_AGUA, q: 1}], saida: {b: BLOCO.SPONGE_WET, q: 1}, wb: false },
  // Jack-o-Lantern: 1 carved pumpkin + 1 tocha
  { custos: [{b: BLOCO.CARVED_PUMPKIN, q: 1}, {b: BLOCO.TOCHA, q: 1}], saida: {b: BLOCO.JACK_O_LANTERN, q: 1}, wb: false },
  // Tinted Glass: 4 vidro + 1 carvão
  { custos: [{b: BLOCO.VIDRO, q: 4}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.TINTED_GLASS, q: 4}, wb: true },
  // Bloco de Neve: 4 bolas de neve (paridade MC) — usa BLOCO.NEVE como proxy
  { custos: [{b: BLOCO.NEVE, q: 4}], saida: {b: BLOCO.SNOW_BLOCK, q: 1}, wb: true },
  // Powder Snow: 9 neve → 1 powder
  { custos: [{b: BLOCO.NEVE, q: 9}], saida: {b: BLOCO.POWDER_SNOW, q: 1}, wb: true },
  // Glow Lichen: 1 muda + 5 tinta_glow
  { custos: [{i: ITEM.MUDA, q: 1}, {i: ITEM.TINTA_GLOW, q: 5}], saida: {b: BLOCO.GLOW_LICHEN, q: 1}, wb: true },
  // Spore Blossom: 4 cogumelo R + 1 muda
  { custos: [{i: ITEM.COGUMELO_R, q: 4}, {i: ITEM.MUDA, q: 1}], saida: {b: BLOCO.SPORE_BLOSSOM, q: 1}, wb: true },
  // Família Sculk (recipes proxy — MC normal são naturais do Deep Dark)
  { custos: [{i: ITEM.OSSO, q: 4}, {b: BLOCO.OBSIDIANA, q: 1}], saida: {b: BLOCO.SCULK, q: 4}, wb: true },
  { custos: [{b: BLOCO.SCULK, q: 1}], saida: {b: BLOCO.SCULK_VEIN, q: 4}, wb: true },
  { custos: [{b: BLOCO.SCULK, q: 4}, {i: ITEM.OSSO, q: 1}], saida: {b: BLOCO.SCULK_SHRIEKER, q: 1}, wb: true },
  { custos: [{b: BLOCO.SCULK, q: 4}, {i: ITEM.REDSTONE, q: 1}], saida: {b: BLOCO.SCULK_SENSOR, q: 1}, wb: true },
  { custos: [{b: BLOCO.SCULK, q: 4}, {i: ITEM.TINTA_GLOW, q: 1}], saida: {b: BLOCO.SCULK_CATALYST, q: 1}, wb: true },
  // Camas coloridas: 3 lã colorida + 3 pranchas (paridade MC)
  { custos: [{b: BLOCO.LA_AZUL,     q: 3}, {i: ITEM.PRANCHAS, q: 3}], saida: {b: BLOCO.CAMA_AZUL,    q: 1}, wb: true },
  { custos: [{b: BLOCO.LA_VERDE,    q: 3}, {i: ITEM.PRANCHAS, q: 3}], saida: {b: BLOCO.CAMA_VERDE,   q: 1}, wb: true },
  { custos: [{b: BLOCO.LA_AMARELA,  q: 3}, {i: ITEM.PRANCHAS, q: 3}], saida: {b: BLOCO.CAMA_AMARELA, q: 1}, wb: true },
  { custos: [{b: BLOCO.LA_VERMELHA, q: 3}, {i: ITEM.PRANCHAS, q: 3}], saida: {b: BLOCO.CAMA_ROXA,    q: 1}, wb: true },
  // Tijolo: 4 argila + 1 carvão (proxy de smelt fornalha) → 4 tijolos
  { custos: [{b: BLOCO.ARGILA, q: 4}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.TIJOLO, q: 4}, wb: false },
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
