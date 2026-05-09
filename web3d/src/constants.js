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
  PORTA_CRIMSON: 159,
  PORTA_WARPED:  160,
  PORTA_FERRO:   161,
  TRAPDOOR_M:    162, // trapdoor de madeira
  TRAPDOOR_F:    163, // trapdoor de ferro
  PORTAO_M:      164, // fence gate de madeira
  PORTAO_C:      165, // fence gate crimson
  SIGN_MADEIRA:  166, // placa
  // Escadas (shape 'stairs') — reusam textura de blocos existentes
  ESCADA_PEDRA:   167,
  ESCADA_MADEIRA: 168,
  ESCADA_TIJOLO:  169,
  // Paredes (shape 'wall') — paredes baixinhas (cobblestone/brick)
  PAREDE_PEDRA:   170,
  PAREDE_TIJOLO:  171,
  PAREDE_PAVIMENTO:172,
  // Botões (shape 'button' = cubinho fino 0.25x0.125x0.375)
  BTN_PEDRA:      173,
  BTN_MADEIRA:    174,
  BTN_OURO:       175,
  // Placas de pressão (shape 'plate' = chapinha fina horizontal)
  PLATE_PEDRA:    176,
  PLATE_MADEIRA:  177,
  // Alavanca (shape 'lever' = pequeno toggle)
  ALAVANCA:       178,
  TNT:            179, // explosivo (decoração visual; explode ao quebrar)
  FLOR_VERMELHA:  180,
  FLOR_AMARELA:   181,
  FLOR_AZUL:      182,
  FLOR_BRANCA:    183,
  FLOR_ROXA:      184,
  VASO_FLOR:      185,
  GRADE_FERRO:    186,
  HOPPER:         187, // funil
  DISPENSER:      188, // despachador
  OBSERVER:       189, // observador
  TOCHA_REDSTONE: 190, // tocha vermelha redstone
  COGUMELO_VERM_P:191, // cogumelo vermelho pequeno (decoração)
  COGUMELO_MARROM_P:192,
  CAVEIRA:        193, // caveira de esqueleto
  CRANIO_WITHER:  194, // crânio do wither
  CONDUIT:        195, // conduit (oceano, dá water breathing)
  HEAD_CREEPER:   196,
  HEAD_ZUMBI:     197,
  HEAD_DRAGON:    198,
  SOUL_TORCH:     199, // tocha azul (soul fire)
  SOUL_LANTERN:   200,
  LAMPADA_RED:    201, // lâmpada de redstone (acesa)
  BLAZE_BLOCK:    202, // bloco de blaze rod (ouro infernal)
  LA_LARANJA:     203,
  LA_ROSA:        204,
  LA_CIANO:       205,
  LA_MARROM:      206,
  LA_PRETA:       207,
  LA_CINZA:       208,
  CONCRETO_R:     209, // concreto vermelho
  CONCRETO_A:     210, // concreto azul
  CONCRETO_V:     211,
  CONCRETO_AM:    212,
  CONCRETO_BR:    213,
  CONCRETO_PR:    214,
  TERRACOTA_R:    215,
  TERRACOTA_A:    216,
  TERRACOTA_AM:   217,
  TERRACOTA_BR:   218,
  CONCRETO_LR:    219, // laranja
  CONCRETO_RS:    220, // rosa
  CONCRETO_CN:    221, // ciano
  CONCRETO_MR:    222, // marrom
  TERRACOTA_V:    223, // verde
  TERRACOTA_RX:   224, // roxa
  TERRACOTA_LR:   225, // laranja
  TERRACOTA_PR:   226, // preta
  PAINEL_VIDRO_R: 227, // painel de vidro vermelho (shape bars)
  PAINEL_VIDRO_A: 228, // azul
  PAINEL_VIDRO_V: 229, // verde
  PAINEL_VIDRO_AM:230, // amarelo
  GLAZED_R:       231, // glazed terracota vermelha
  GLAZED_A:       232, // azul
  GLAZED_V:       233, // verde
  GLAZED_AM:      234, // amarela
  GLAZED_LR:      235, // laranja
  GLAZED_RS:      236, // rosa
  GLAZED_BR:      237, // branca
  GLAZED_PR:      238, // preta
  // Lajes (slabs) de pedras especiais
  SLAB_ARENITO:   239,
  SLAB_QUARTZO:   240,
  SLAB_DEEPSLATE: 241,
  SLAB_BLACKSTONE:242,
  ESCADA_ARENITO: 243,
  ESCADA_QUARTZO: 244,
  ESCADA_DEEPSLATE:245,
  ESCADA_BLACKSTONE:246,
  PAREDE_ANDESITO:247,
  PAREDE_BLACKSTONE:248,
  BONE_BLOCK:     249, // bloco de osso (decoração branca com listras)
  ROOTED_DIRT:    250, // terra com raízes (drylands)
  // Pedras esculpidas (chiseled — paridade MC)
  CHISELED_STONE: 251,
  CHISELED_QUARTZO:252,
  CHISELED_DEEPSLATE:253,
  CHISELED_BLACKSTONE:254,
  // Hyphae nether (caules sem casca)
  CRIMSON_HYPHAE: 255,
  WARPED_HYPHAE:  256,
  // Froglights (luzes orgânicas dos sapos)
  FROGLIGHT_VERDE:257, // verdant froglight
  FROGLIGHT_ROXO: 258, // pearlescent froglight
  MELANCIA:       259, // melancia (top + lado verde + interior vermelho)
  MELANCIA_GLISTER:260, // melancia dourada (cura mais)
  GIRASSOL:       261, // girassol (decoração) - shape flower
  ABACAXI:        262, // abacaxi (decoração)
  PAINEL_VIDRO_LR:263, // painel laranja
  PAINEL_VIDRO_RS:264, // painel rosa
  PAINEL_VIDRO_CN:265, // painel ciano
  PAINEL_VIDRO_BR:266, // painel branco
  PAINEL_VIDRO_PR:267, // painel preto
  PAINEL_VIDRO_CZ:268, // painel cinza
  BAMBU_BLOCO:    269, // bambu compactado (4 bambus)
  CACTO_BLOCO:    270, // cacto compactado (sem dano)
  // 4 escadas adicionais
  ESCADA_COBRE:   271,
  ESCADA_NETHER:  272,
  ESCADA_PAVIMENTO:273,
  ESCADA_LAMA:    274,
  // 2 paredes adicionais
  PAREDE_ARENITO: 275,
  PAREDE_LAMA:    276,
  // 2 lajes adicionais
  SLAB_PAVIMENTO: 277,
  SLAB_CALCITE:   278,
  ESCADA_GRANITO: 279,
  ESCADA_DIORITO: 280,
  ESCADA_ANDESITO:281,
  ESCADA_PRISMARINE:282,
  PAREDE_GRANITO: 283,
  PAREDE_DIORITO: 284,
  SLAB_GRANITO:   285,
  SLAB_DIORITO:   286,
  ESCADA_GRANITO_POL: 287,
  ESCADA_DIORITO_POL: 288,
  ESCADA_ANDESITO_POL:289,
  ESCADA_PEDRA_LISA:  290,
  PAREDE_ANDESITO_POL:291,
  PAREDE_BLACKSTONE_POL:292,
  SLAB_ANDESITO_POL:  293,
  SLAB_BLACKSTONE_POL:294,
  ESCADA_END_BRICK:   295,
  ESCADA_PURPUR:      296,
  ESCADA_NETHER_BRICK:297,
  ESCADA_MUSGO:       298,
  PAREDE_END_BRICK:   299,
  PAREDE_NETHER_BRICK:300,
  SLAB_END_BRICK:     301,
  SLAB_PURPUR:        302,
  ESCADA_DEEPSLATE_PAV:303,
  ESCADA_DEEPSLATE_POL:304,
  ESCADA_OBSIDIANA:    305,
  ESCADA_BASALTO:      306,
  PAREDE_DEEPSLATE_POL:307,
  PAREDE_BASALTO:      308,
  SLAB_DEEPSLATE_PAV:  309,
  SLAB_BASALTO:        310,
  ESCADA_CRIMSON:      311,
  ESCADA_WARPED:       312,
  ESCADA_BAMBU:        313,
  ESCADA_COBRE_GASTO:  314,
  PAREDE_COBRE:        315,
  PAREDE_COBRE_OXIDADO:316,
  SLAB_CRIMSON:        317,
  SLAB_WARPED:         318,
  ESCADA_CONCRETO_R:   319,
  ESCADA_CONCRETO_A:   320,
  ESCADA_CONCRETO_V:   321,
  ESCADA_CONCRETO_BR:  322,
  PAREDE_CONCRETO_R:   323,
  PAREDE_CONCRETO_PR:  324,
  SLAB_CONCRETO_R:     325,
  SLAB_CONCRETO_A:     326,
  COBRE_CORTADO:       327,
  COBRE_GASTO_CORTADO: 328,
  COBRE_OXIDADO_CORTADO:329,
  COBRE_LISO:          330,
  ESCADA_PURPUR_PILLAR:331,
  PAREDE_PURPUR:       332,
  SLAB_PURPUR_PILLAR:  333,
  PURPUR_LIMPO:        334,
  // Workstations
  SMITHING_TABLE:      335,
  BREWING_STAND:       336,
  BLAST_FURNACE:       337,
  SMOKER:              338,
  CARTOGRAPHY:         339,
  FLETCHING:           340,
  LOOM:                341,
  STONECUTTER:         342,
  TARGET_BLOCK:        343,
  ANCIENT_DEBRIS:      344,
  HONEYCOMB_BLOCK:     345,
  COMPOSTER:           346,
  LECTERN:             347,
  BARREL:              348,
  CAMPFIRE:            349,
  DRIED_KELP_BLOCK:    350,
  BOOKSHELF_CHISELED:  351,
  JUKEBOX:             352,
  END_ROD:             353,
  LIGHT_BLOCK:         354,
  DAYLIGHT_DETECTOR:   355,
  NOTE_BLOCK:          356,
  BELL:                357,
  SEA_PICKLE:          358,
  ENDER_CHEST:         359,
  SHULKER_BOX:         360,
  ANVIL_DAMAGED:       361,
  DECORATED_POT:       362,
  ESCADA_PRISMARINE_BRK:363,
  SLAB_PRISMARINE:     364,
  SLAB_PRISMARINE_BRK: 365,
  PAREDE_PRISMARINE:   366,
  SHULKER_R:           367,
  SHULKER_A:           368,
  SHULKER_V:           369,
  SHULKER_AM:          370,
  ESCADA_ARENITO_LISO: 371,
  SLAB_ARENITO_LISO:   372,
  PAREDE_ARENITO_LISO: 373,
  ESCADA_ARENITO_CORT: 374,
  SHULKER_BR:          375,
  SHULKER_PR:          376,
  SHULKER_LR:          377,
  SHULKER_RS:          378,
  ESCADA_TERRACOTA_R:  379,
  SLAB_TERRACOTA_R:    380,
  PAREDE_TERRACOTA_R:  381,
  ESCADA_TERRACOTA_A:  382,
  SLAB_NETHER:         383,
  PAREDE_NETHER:       384,
  ESCADA_GLAZED_R:     385,
  SLAB_GLAZED_R:       386,
  ESCADA_GLAZED_A:     387,
  SLAB_GLAZED_A:       388,
  ESCADA_GLAZED_V:     389,
  ESCADA_GLAZED_AM:    390,
  SLAB_BAMBU:          391,
  PAREDE_BAMBU:        392,
  ESCADA_DRIED_KELP:   393,
  SLAB_DRIED_KELP:     394,
  ESCADA_QUARTZO_POL:  395,
  SLAB_QUARTZO_POL:    396,
  PAREDE_QUARTZO:      397,
  ESCADA_BLOCO_OURO:   398,
  COMMAND_BLOCK:       399, // marco 400! command block icônico
  ESCADA_BLOCO_FERRO:  400,
  SLAB_BLOCO_FERRO:    401,
  ESCADA_BLOCO_DIAMANTE:402,
  SLAB_BLOCO_DIAMANTE: 403,
  ESCADA_BLOCO_LAPIS:  404,
  SLAB_BLOCO_LAPIS:    405,
  ESCADA_BLOCO_REDSTONE:406,
  // Sprint paridade Minecraft (407-414)
  RESPAWN_ANCHOR:      407, // respawn no Nether (obsidiana + glowstone)
  LODESTONE:           408, // bússola aponta pra ele (deepslate liso central + bordas chiseled)
  REINFORCED_DS:       409, // reinforced deepslate (bloco do Warden)
  MOSS_BLOCK:          410, // bloco musgo (verde)
  MOSS_CARPET:         411, // tapete musgo (slab)
  BIG_DRIPLEAF:        412, // dripleaf grande (planta tropical)
  CHORUS_FLOWER:       413, // flor do End
  PISTON:              414, // pistão (madeira + ferro central)
  // Sprint redstone + madeiras 1.20+ (415-422)
  STICKY_PISTON:       415, // pistão pegajoso (verde)
  REPEATER:            416, // repetidor (delay redstone)
  COMPARATOR:          417, // comparador (medidor sinal)
  CRAFTER:             418, // crafter (auto-craft 1.21)
  TRAPPED_CHEST:       419, // baú armadilha (vermelho)
  MANGROVE_LOG:        420, // tronco mangrove (vermelho)
  MANGROVE_PRANCHA:    421, // pranchas mangrove
  CHERRY_LOG:          422, // tronco cerejeira (rosa)
  // Sprint 4: madeiras+plantas 1.20+ (423-430)
  CHERRY_PRANCHA:      423, // pranchas cerejeira
  CHERRY_FOLHA:        424, // folhas rosa cerejeira
  MANGROVE_FOLHA:      425, // folhas verdes mangrove
  MANGROVE_RAIZ:       426, // raízes aéreas (haste)
  AZALEA:              427, // planta azaléia (verde)
  AZALEA_FLOWER:       428, // azaléia florida (rosa)
  PINK_PETALS:         429, // pétalas rosa (carpet floral)
  CACTUS_FLOWER:       430, // flor cacto 1.20
  // Sprint 5: Nether plants + cipós + andaime (431-438)
  BAMBOO_MOSAIC:       431, // mosaico de bambu (1.20)
  CRIMSON_ROOTS:       432, // raízes vermelhas crimson
  WARPED_ROOTS:        433, // raízes verdes warped
  FROSTED_ICE:         434, // gelo congelado (frostwalker)
  VINE:                435, // cipó vertical
  TWISTING_VINES:      436, // cipó torcido azul (Nether)
  WEEPING_VINES:       437, // cipó pendente vermelho (Nether)
  SCAFFOLDING:         438, // andaime de bambu
};
export const N_BLOCOS = 439;

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
  // Portas coloridas (shape 'door' reusado)
  [BLOCO.PORTA_CRIMSON]: { nome: 'Porta Crimson',    solido: true,  emiteLuz: 0, cor: 0x8a3a4d, lateral: 0x5d2535, shape: 'door' },
  [BLOCO.PORTA_WARPED]:  { nome: 'Porta Warped',     solido: true,  emiteLuz: 0, cor: 0x2c8a8a, lateral: 0x1d5d5d, shape: 'door' },
  [BLOCO.PORTA_FERRO]:   { nome: 'Porta de Ferro',   solido: true,  emiteLuz: 0, cor: 0xcfd8dc, lateral: 0x90a4ae, shape: 'door' },
  // Trapdoors (shape 'slab' meia altura)
  [BLOCO.TRAPDOOR_M]:    { nome: 'Trapdoor Madeira', solido: false, emiteLuz: 0, cor: 0xa1887f, lateral: 0x8d6e63, shape: 'slab' },
  [BLOCO.TRAPDOOR_F]:    { nome: 'Trapdoor Ferro',   solido: false, emiteLuz: 0, cor: 0xcfd8dc, lateral: 0x90a4ae, shape: 'slab' },
  // Portões (fence gate, shape 'fence' reusado)
  [BLOCO.PORTAO_M]:      { nome: 'Portão Madeira',   solido: true,  emiteLuz: 0, cor: 0xa1887f, lateral: 0x8d6e63, shape: 'fence' },
  [BLOCO.PORTAO_C]:      { nome: 'Portão Crimson',   solido: true,  emiteLuz: 0, cor: 0x8a3a4d, lateral: 0x5d2535, shape: 'fence' },
  // Placa
  [BLOCO.SIGN_MADEIRA]:  { nome: 'Placa',            solido: false, emiteLuz: 0, cor: 0xa1887f, lateral: 0x8d6e63, shape: 'ladder' },
  // Escadas (shape 'stairs' = slab inferior + meio cubo superior atrás)
  [BLOCO.ESCADA_PEDRA]:   { nome: 'Escada Pedra',    solido: true,  emiteLuz: 0, cor: 0x9E9E9E, lateral: 0x757575, shape: 'stairs' },
  [BLOCO.ESCADA_MADEIRA]: { nome: 'Escada Madeira',  solido: true,  emiteLuz: 0, cor: 0xA1887F, lateral: 0x8D6E63, shape: 'stairs' },
  [BLOCO.ESCADA_TIJOLO]:  { nome: 'Escada Tijolo',   solido: true,  emiteLuz: 0, cor: 0xE57373, lateral: 0xC62828, shape: 'stairs' },
  // Paredes (shape 'wall' = pillar central mais alto que fence)
  [BLOCO.PAREDE_PEDRA]:    { nome: 'Parede Pedra',    solido: true, emiteLuz: 0, cor: 0x9E9E9E, lateral: 0x757575, shape: 'wall' },
  [BLOCO.PAREDE_TIJOLO]:   { nome: 'Parede Tijolo',   solido: true, emiteLuz: 0, cor: 0xE57373, lateral: 0xC62828, shape: 'wall' },
  [BLOCO.PAREDE_PAVIMENTO]:{ nome: 'Parede Pavimento',solido: true, emiteLuz: 0, cor: 0x7a7a7a, lateral: 0x5e5e5e, shape: 'wall' },
  // Botões (shape button = cubinho fino na parede)
  [BLOCO.BTN_PEDRA]:    { nome: 'Botão de Pedra',   solido: false, emiteLuz: 0, cor: 0x9E9E9E, lateral: 0x757575, shape: 'button' },
  [BLOCO.BTN_MADEIRA]:  { nome: 'Botão de Madeira', solido: false, emiteLuz: 0, cor: 0xA1887F, lateral: 0x8D6E63, shape: 'button' },
  [BLOCO.BTN_OURO]:     { nome: 'Botão de Ouro',    solido: false, emiteLuz: 0, cor: 0xFDD835, lateral: 0xF9A825, shape: 'button' },
  // Placas de pressão (shape plate = chapinha fina horizontal)
  [BLOCO.PLATE_PEDRA]:  { nome: 'Placa de Pedra',   solido: false, emiteLuz: 0, cor: 0x9E9E9E, lateral: 0x757575, shape: 'plate' },
  [BLOCO.PLATE_MADEIRA]:{ nome: 'Placa de Madeira', solido: false, emiteLuz: 0, cor: 0xA1887F, lateral: 0x8D6E63, shape: 'plate' },
  // Alavanca (shape lever = base pequena + cabo vertical)
  [BLOCO.ALAVANCA]:     { nome: 'Alavanca',         solido: false, emiteLuz: 0, cor: 0xA1887F, lateral: 0x8D6E63, shape: 'lever' },
  [BLOCO.TNT]:          { nome: 'TNT',              solido: true,  emiteLuz: 0, cor: 0xc62828, lateral: 0x8b0000 },
  // Flores: shape 'flower' (haste fina + pétalas no topo, similar a torch)
  [BLOCO.FLOR_VERMELHA]:{ nome: 'Rosa',             solido: false, emiteLuz: 0, cor: 0xc62828, lateral: 0x2e7d32, shape: 'flower' },
  [BLOCO.FLOR_AMARELA]: { nome: 'Dente-leão',       solido: false, emiteLuz: 0, cor: 0xfdd835, lateral: 0x2e7d32, shape: 'flower' },
  [BLOCO.FLOR_AZUL]:    { nome: 'Cornflower',       solido: false, emiteLuz: 0, cor: 0x42a5f5, lateral: 0x2e7d32, shape: 'flower' },
  [BLOCO.FLOR_BRANCA]:  { nome: 'Margarida',        solido: false, emiteLuz: 0, cor: 0xfafafa, lateral: 0x2e7d32, shape: 'flower' },
  [BLOCO.FLOR_ROXA]:    { nome: 'Allium',           solido: false, emiteLuz: 0, cor: 0xab47bc, lateral: 0x2e7d32, shape: 'flower' },
  [BLOCO.VASO_FLOR]:    { nome: 'Vaso',             solido: false, emiteLuz: 0, cor: 0xa1887f, lateral: 0x6d4c41, shape: 'pot' },
  [BLOCO.GRADE_FERRO]:  { nome: 'Grade de Ferro',   solido: true,  emiteLuz: 0, cor: 0xcfd8dc, lateral: 0x90a4ae, shape: 'bars' },
  [BLOCO.HOPPER]:       { nome: 'Funil',            solido: true,  emiteLuz: 0, cor: 0x424242, lateral: 0x212121 },
  [BLOCO.DISPENSER]:    { nome: 'Despachador',      solido: true,  emiteLuz: 0, cor: 0x6E6E6E, lateral: 0x424242 },
  [BLOCO.OBSERVER]:     { nome: 'Observador',       solido: true,  emiteLuz: 0, cor: 0x4a4a4a, lateral: 0x2a2a2a },
  [BLOCO.TOCHA_REDSTONE]:{ nome: 'Tocha Redstone', solido: false, emiteLuz: 7, cor: 0xc62828, lateral: 0x8b0000, shape: 'torch' },
  [BLOCO.COGUMELO_VERM_P]:{nome:'Cogumelo Vermelho',solido: false, emiteLuz: 1, cor: 0xc62828, lateral: 0xfafafa, shape: 'flower' },
  [BLOCO.COGUMELO_MARROM_P]:{nome:'Cogumelo Marrom',solido: false, emiteLuz: 1, cor: 0x6d4c41, lateral: 0xa1887f, shape: 'flower' },
  [BLOCO.CAVEIRA]:      { nome: 'Caveira',          solido: false, emiteLuz: 0, cor: 0xeceff1, lateral: 0xbdbdbd, shape: 'pot' },
  [BLOCO.CRANIO_WITHER]:{ nome: 'Crânio Wither',    solido: false, emiteLuz: 2, cor: 0x424242, lateral: 0x212121, shape: 'pot' },
  [BLOCO.CONDUIT]:      { nome: 'Conduit',          solido: true,  emiteLuz: 15, cor: 0x4dd0e1, lateral: 0x00838f },
  [BLOCO.HEAD_CREEPER]: { nome: 'Cabeça Creeper',   solido: false, emiteLuz: 0, cor: 0x2e7d32, lateral: 0x1b5e20, shape: 'pot' },
  [BLOCO.HEAD_ZUMBI]:   { nome: 'Cabeça Zumbi',     solido: false, emiteLuz: 0, cor: 0x4caf50, lateral: 0x2e7d32, shape: 'pot' },
  [BLOCO.HEAD_DRAGON]:  { nome: 'Cabeça Dragon',    solido: false, emiteLuz: 4, cor: 0x121212, lateral: 0x000000, shape: 'pot' },
  [BLOCO.SOUL_TORCH]:   { nome: 'Tocha das Almas',  solido: false, emiteLuz: 10, cor: 0x40c4ff, lateral: 0x0288d1, shape: 'torch' },
  [BLOCO.SOUL_LANTERN]: { nome: 'Lanterna das Almas',solido: true, emiteLuz: 10, cor: 0x40c4ff, lateral: 0x0288d1 },
  [BLOCO.LAMPADA_RED]:  { nome: 'Lâmpada Redstone', solido: true,  emiteLuz: 15, cor: 0xfdd835, lateral: 0xa1887f },
  [BLOCO.BLAZE_BLOCK]:  { nome: 'Bloco de Blaze',   solido: true,  emiteLuz: 8, cor: 0xff9800, lateral: 0xe65100 },
  [BLOCO.LA_LARANJA]:   { nome: 'Lã Laranja',       solido: true,  emiteLuz: 0, cor: 0xff9800, lateral: 0xe65100 },
  [BLOCO.LA_ROSA]:      { nome: 'Lã Rosa',          solido: true,  emiteLuz: 0, cor: 0xf06292, lateral: 0xc2185b },
  [BLOCO.LA_CIANO]:     { nome: 'Lã Ciano',         solido: true,  emiteLuz: 0, cor: 0x4dd0e1, lateral: 0x00838f },
  [BLOCO.LA_MARROM]:    { nome: 'Lã Marrom',        solido: true,  emiteLuz: 0, cor: 0x6d4c41, lateral: 0x4e342e },
  [BLOCO.LA_PRETA]:     { nome: 'Lã Preta',         solido: true,  emiteLuz: 0, cor: 0x424242, lateral: 0x212121 },
  [BLOCO.LA_CINZA]:     { nome: 'Lã Cinza',         solido: true,  emiteLuz: 0, cor: 0x9e9e9e, lateral: 0x616161 },
  [BLOCO.CONCRETO_R]:   { nome: 'Concreto Vermelho',solido: true,  emiteLuz: 0, cor: 0xc62828, lateral: 0x8b0000 },
  [BLOCO.CONCRETO_A]:   { nome: 'Concreto Azul',    solido: true,  emiteLuz: 0, cor: 0x1565c0, lateral: 0x0d47a1 },
  [BLOCO.CONCRETO_V]:   { nome: 'Concreto Verde',   solido: true,  emiteLuz: 0, cor: 0x2e7d32, lateral: 0x1b5e20 },
  [BLOCO.CONCRETO_AM]:  { nome: 'Concreto Amarelo', solido: true,  emiteLuz: 0, cor: 0xf9a825, lateral: 0xf57f17 },
  [BLOCO.CONCRETO_BR]:  { nome: 'Concreto Branco',  solido: true,  emiteLuz: 0, cor: 0xfafafa, lateral: 0xeceff1 },
  [BLOCO.CONCRETO_PR]:  { nome: 'Concreto Preto',   solido: true,  emiteLuz: 0, cor: 0x212121, lateral: 0x000000 },
  [BLOCO.TERRACOTA_R]:  { nome: 'Terracota Vermelha',solido: true, emiteLuz: 0, cor: 0xb55a3a, lateral: 0x8b3e23 },
  [BLOCO.TERRACOTA_A]:  { nome: 'Terracota Azul',   solido: true,  emiteLuz: 0, cor: 0x4a5e9a, lateral: 0x2c3d6c },
  [BLOCO.TERRACOTA_AM]: { nome: 'Terracota Amarela',solido: true,  emiteLuz: 0, cor: 0xc9a05a, lateral: 0xa67d3a },
  [BLOCO.TERRACOTA_BR]: { nome: 'Terracota Branca', solido: true,  emiteLuz: 0, cor: 0xd6c8b8, lateral: 0xb09f88 },
  [BLOCO.CONCRETO_LR]:  { nome: 'Concreto Laranja', solido: true,  emiteLuz: 0, cor: 0xff9800, lateral: 0xe65100 },
  [BLOCO.CONCRETO_RS]:  { nome: 'Concreto Rosa',    solido: true,  emiteLuz: 0, cor: 0xf06292, lateral: 0xc2185b },
  [BLOCO.CONCRETO_CN]:  { nome: 'Concreto Ciano',   solido: true,  emiteLuz: 0, cor: 0x4dd0e1, lateral: 0x00838f },
  [BLOCO.CONCRETO_MR]:  { nome: 'Concreto Marrom',  solido: true,  emiteLuz: 0, cor: 0x6d4c41, lateral: 0x4e342e },
  [BLOCO.TERRACOTA_V]:  { nome: 'Terracota Verde',  solido: true,  emiteLuz: 0, cor: 0x4d6233, lateral: 0x344020 },
  [BLOCO.TERRACOTA_RX]: { nome: 'Terracota Roxa',   solido: true,  emiteLuz: 0, cor: 0x764467, lateral: 0x5a3050 },
  [BLOCO.TERRACOTA_LR]: { nome: 'Terracota Laranja',solido: true,  emiteLuz: 0, cor: 0xa05a30, lateral: 0x7d3e1c },
  [BLOCO.TERRACOTA_PR]: { nome: 'Terracota Preta',  solido: true,  emiteLuz: 0, cor: 0x251610, lateral: 0x150a05 },
  [BLOCO.PAINEL_VIDRO_R]: { nome: 'Painel Vidro Verm', solido: true, emiteLuz: 0, cor: 0xef5350, lateral: 0xc62828, shape: 'bars' },
  [BLOCO.PAINEL_VIDRO_A]: { nome: 'Painel Vidro Azul', solido: true, emiteLuz: 0, cor: 0x4fc3f7, lateral: 0x1565c0, shape: 'bars' },
  [BLOCO.PAINEL_VIDRO_V]: { nome: 'Painel Vidro Verde',solido: true, emiteLuz: 0, cor: 0x66bb6a, lateral: 0x2e7d32, shape: 'bars' },
  [BLOCO.PAINEL_VIDRO_AM]:{ nome: 'Painel Vidro Amar', solido: true, emiteLuz: 0, cor: 0xffeb3b, lateral: 0xf9a825, shape: 'bars' },
  [BLOCO.GLAZED_R]:       { nome: 'Glazed Vermelha',  solido: true, emiteLuz: 0, cor: 0xc62828, lateral: 0x8b0000 },
  [BLOCO.GLAZED_A]:       { nome: 'Glazed Azul',      solido: true, emiteLuz: 0, cor: 0x1565c0, lateral: 0x0d47a1 },
  [BLOCO.GLAZED_V]:       { nome: 'Glazed Verde',     solido: true, emiteLuz: 0, cor: 0x2e7d32, lateral: 0x1b5e20 },
  [BLOCO.GLAZED_AM]:      { nome: 'Glazed Amarela',   solido: true, emiteLuz: 0, cor: 0xf9a825, lateral: 0xf57f17 },
  [BLOCO.GLAZED_LR]:      { nome: 'Glazed Laranja',   solido: true, emiteLuz: 0, cor: 0xff9800, lateral: 0xe65100 },
  [BLOCO.GLAZED_RS]:      { nome: 'Glazed Rosa',      solido: true, emiteLuz: 0, cor: 0xf06292, lateral: 0xc2185b },
  [BLOCO.GLAZED_BR]:      { nome: 'Glazed Branca',    solido: true, emiteLuz: 0, cor: 0xfafafa, lateral: 0xeceff1 },
  [BLOCO.GLAZED_PR]:      { nome: 'Glazed Preta',     solido: true, emiteLuz: 0, cor: 0x424242, lateral: 0x212121 },
  // Lajes de pedras especiais (shape='slab')
  [BLOCO.SLAB_ARENITO]:   { nome: 'Laje de Arenito',  solido: true, emiteLuz: 0, cor: 0xfdd8a0, lateral: 0xe6c389, shape: 'slab' },
  [BLOCO.SLAB_QUARTZO]:   { nome: 'Laje de Quartzo',  solido: true, emiteLuz: 0, cor: 0xfafafa, lateral: 0xeeeeee, shape: 'slab' },
  [BLOCO.SLAB_DEEPSLATE]: { nome: 'Laje de Ardósia',  solido: true, emiteLuz: 0, cor: 0x4a4a52, lateral: 0x35353d, shape: 'slab' },
  [BLOCO.SLAB_BLACKSTONE]:{ nome: 'Laje Blackstone',  solido: true, emiteLuz: 0, cor: 0x1a1a1a, lateral: 0x0a0a0a, shape: 'slab' },
  [BLOCO.ESCADA_ARENITO]:  { nome: 'Escada Arenito',   solido: true, emiteLuz: 0, cor: 0xfdd8a0, lateral: 0xe6c389, shape: 'stairs' },
  [BLOCO.ESCADA_QUARTZO]:  { nome: 'Escada Quartzo',   solido: true, emiteLuz: 0, cor: 0xfafafa, lateral: 0xeeeeee, shape: 'stairs' },
  [BLOCO.ESCADA_DEEPSLATE]:{ nome: 'Escada Ardósia',   solido: true, emiteLuz: 0, cor: 0x4a4a52, lateral: 0x35353d, shape: 'stairs' },
  [BLOCO.ESCADA_BLACKSTONE]:{nome: 'Escada Blackstone',solido: true, emiteLuz: 0, cor: 0x1a1a1a, lateral: 0x0a0a0a, shape: 'stairs' },
  [BLOCO.PAREDE_ANDESITO]: { nome: 'Parede Andesito',  solido: true, emiteLuz: 0, cor: 0x9e9e9e, lateral: 0x757575, shape: 'wall' },
  [BLOCO.PAREDE_BLACKSTONE]:{nome: 'Parede Blackstone',solido: true, emiteLuz: 0, cor: 0x1a1a1a, lateral: 0x0a0a0a, shape: 'wall' },
  [BLOCO.BONE_BLOCK]:      { nome: 'Bloco de Osso',    solido: true, emiteLuz: 0, cor: 0xeceff1, lateral: 0xbdbdbd },
  [BLOCO.ROOTED_DIRT]:     { nome: 'Terra com Raízes', solido: true, emiteLuz: 0, cor: 0x8d6e63, lateral: 0x5d4037 },
  [BLOCO.CHISELED_STONE]:    { nome: 'Pedra Esculpida',  solido: true, emiteLuz: 0, cor: 0x9E9E9E, lateral: 0x757575 },
  [BLOCO.CHISELED_QUARTZO]:  { nome: 'Quartzo Esculpido',solido: true, emiteLuz: 0, cor: 0xfafafa, lateral: 0xeeeeee },
  [BLOCO.CHISELED_DEEPSLATE]:{ nome: 'Ardósia Esculpida',solido: true, emiteLuz: 0, cor: 0x4a4a52, lateral: 0x35353d },
  [BLOCO.CHISELED_BLACKSTONE]:{nome:'Blackstone Esculp.',solido: true, emiteLuz: 0, cor: 0x1a1a1a, lateral: 0x0a0a0a },
  [BLOCO.CRIMSON_HYPHAE]:    { nome: 'Hifa Crimson',     solido: true, emiteLuz: 0, cor: 0x8a3a4d, lateral: 0x5d2535 },
  [BLOCO.WARPED_HYPHAE]:     { nome: 'Hifa Warped',      solido: true, emiteLuz: 0, cor: 0x2c8a8a, lateral: 0x1d5d5d },
  [BLOCO.FROGLIGHT_VERDE]:   { nome: 'Froglight Verde',  solido: true, emiteLuz: 15, cor: 0xa5d6a7, lateral: 0x66bb6a },
  [BLOCO.FROGLIGHT_ROXO]:    { nome: 'Froglight Roxo',   solido: true, emiteLuz: 15, cor: 0xce93d8, lateral: 0xab47bc },
  [BLOCO.MELANCIA]:        { nome: 'Melancia',         solido: true, emiteLuz: 0, cor: 0x4caf50, lateral: 0x2e7d32 },
  [BLOCO.MELANCIA_GLISTER]:{ nome: 'Melancia Dourada', solido: true, emiteLuz: 4, cor: 0xffd54f, lateral: 0xf9a825 },
  [BLOCO.GIRASSOL]:        { nome: 'Girassol',         solido: false,emiteLuz: 0, cor: 0xffeb3b, lateral: 0x2e7d32, shape: 'flower' },
  [BLOCO.ABACAXI]:         { nome: 'Abacaxi',          solido: true, emiteLuz: 0, cor: 0xfdd835, lateral: 0x2e7d32 },
  [BLOCO.PAINEL_VIDRO_LR]: { nome: 'Painel Vidro Lar', solido: true, emiteLuz: 0, cor: 0xff9800, lateral: 0xe65100, shape: 'bars' },
  [BLOCO.PAINEL_VIDRO_RS]: { nome: 'Painel Vidro Rosa', solido: true, emiteLuz: 0, cor: 0xf06292, lateral: 0xc2185b, shape: 'bars' },
  [BLOCO.PAINEL_VIDRO_CN]: { nome: 'Painel Vidro Cian', solido: true, emiteLuz: 0, cor: 0x4dd0e1, lateral: 0x00838f, shape: 'bars' },
  [BLOCO.PAINEL_VIDRO_BR]: { nome: 'Painel Vidro Branco',solido: true, emiteLuz: 0, cor: 0xfafafa, lateral: 0xeceff1, shape: 'bars' },
  [BLOCO.PAINEL_VIDRO_PR]: { nome: 'Painel Vidro Preto',solido: true, emiteLuz: 0, cor: 0x424242, lateral: 0x212121, shape: 'bars' },
  [BLOCO.PAINEL_VIDRO_CZ]: { nome: 'Painel Vidro Cinza',solido: true, emiteLuz: 0, cor: 0x9e9e9e, lateral: 0x616161, shape: 'bars' },
  [BLOCO.BAMBU_BLOCO]:     { nome: 'Bloco de Bambu',   solido: true, emiteLuz: 0, cor: 0x8bc34a, lateral: 0x689f38 },
  [BLOCO.CACTO_BLOCO]:     { nome: 'Bloco de Cacto',   solido: true, emiteLuz: 0, cor: 0x388E3C, lateral: 0x2E7D32 },
  [BLOCO.ESCADA_COBRE]:    { nome: 'Escada Cobre',     solido: true, emiteLuz: 0, cor: 0xe07a3b, lateral: 0xc56226, shape: 'stairs' },
  [BLOCO.ESCADA_NETHER]:   { nome: 'Escada Nether',    solido: true, emiteLuz: 0, cor: 0x4a0e0e, lateral: 0x2d0707, shape: 'stairs' },
  [BLOCO.ESCADA_PAVIMENTO]:{ nome: 'Escada Pavimento', solido: true, emiteLuz: 0, cor: 0x7a7a7a, lateral: 0x5e5e5e, shape: 'stairs' },
  [BLOCO.ESCADA_LAMA]:     { nome: 'Escada Lama',      solido: true, emiteLuz: 0, cor: 0xa0855e, lateral: 0x856a48, shape: 'stairs' },
  [BLOCO.PAREDE_ARENITO]:  { nome: 'Parede Arenito',   solido: true, emiteLuz: 0, cor: 0xfdd8a0, lateral: 0xe6c389, shape: 'wall' },
  [BLOCO.PAREDE_LAMA]:     { nome: 'Parede Lama',      solido: true, emiteLuz: 0, cor: 0xa0855e, lateral: 0x856a48, shape: 'wall' },
  [BLOCO.SLAB_PAVIMENTO]:  { nome: 'Laje Pavimento',   solido: true, emiteLuz: 0, cor: 0x7a7a7a, lateral: 0x5e5e5e, shape: 'slab' },
  [BLOCO.SLAB_CALCITE]:    { nome: 'Laje Calcita',     solido: true, emiteLuz: 0, cor: 0xeceff1, lateral: 0xcfd8dc, shape: 'slab' },
  [BLOCO.ESCADA_GRANITO]:   { nome: 'Escada Granito',   solido: true, emiteLuz: 0, cor: 0xa66556, lateral: 0x8a4a3d, shape: 'stairs' },
  [BLOCO.ESCADA_DIORITO]:   { nome: 'Escada Diorito',   solido: true, emiteLuz: 0, cor: 0xe0e0e0, lateral: 0xbdbdbd, shape: 'stairs' },
  [BLOCO.ESCADA_ANDESITO]:  { nome: 'Escada Andesito',  solido: true, emiteLuz: 0, cor: 0x9e9e9e, lateral: 0x757575, shape: 'stairs' },
  [BLOCO.ESCADA_PRISMARINE]:{ nome: 'Escada Prismarine',solido: true, emiteLuz: 0, cor: 0x4db6ac, lateral: 0x00897b, shape: 'stairs' },
  [BLOCO.PAREDE_GRANITO]:   { nome: 'Parede Granito',   solido: true, emiteLuz: 0, cor: 0xa66556, lateral: 0x8a4a3d, shape: 'wall' },
  [BLOCO.PAREDE_DIORITO]:   { nome: 'Parede Diorito',   solido: true, emiteLuz: 0, cor: 0xe0e0e0, lateral: 0xbdbdbd, shape: 'wall' },
  [BLOCO.SLAB_GRANITO]:     { nome: 'Laje Granito',     solido: true, emiteLuz: 0, cor: 0xa66556, lateral: 0x8a4a3d, shape: 'slab' },
  [BLOCO.SLAB_DIORITO]:     { nome: 'Laje Diorito',     solido: true, emiteLuz: 0, cor: 0xe0e0e0, lateral: 0xbdbdbd, shape: 'slab' },
  [BLOCO.ESCADA_GRANITO_POL]: { nome: 'Escada Granito Pol.', solido: true, emiteLuz: 0, cor: 0xc98575, lateral: 0xa66556, shape: 'stairs' },
  [BLOCO.ESCADA_DIORITO_POL]: { nome: 'Escada Diorito Pol.', solido: true, emiteLuz: 0, cor: 0xeeeeee, lateral: 0xe0e0e0, shape: 'stairs' },
  [BLOCO.ESCADA_ANDESITO_POL]:{ nome: 'Escada Andesito Pol.',solido: true, emiteLuz: 0, cor: 0xb0b0b0, lateral: 0x9e9e9e, shape: 'stairs' },
  [BLOCO.ESCADA_PEDRA_LISA]:  { nome: 'Escada Pedra Lisa',   solido: true, emiteLuz: 0, cor: 0xb8b8b8, lateral: 0xa0a0a0, shape: 'stairs' },
  [BLOCO.PAREDE_ANDESITO_POL]:{ nome: 'Parede Andesito Pol.', solido: true,emiteLuz: 0, cor: 0xb0b0b0, lateral: 0x9e9e9e, shape: 'wall' },
  [BLOCO.PAREDE_BLACKSTONE_POL]:{nome: 'Parede Blackstone Pol.',solido: true,emiteLuz: 0, cor: 0x2a2a2a, lateral: 0x1a1a1a, shape: 'wall' },
  [BLOCO.SLAB_ANDESITO_POL]:  { nome: 'Laje Andesito Pol.',  solido: true, emiteLuz: 0, cor: 0xb0b0b0, lateral: 0x9e9e9e, shape: 'slab' },
  [BLOCO.SLAB_BLACKSTONE_POL]:{ nome: 'Laje Blackstone Pol.',solido: true, emiteLuz: 0, cor: 0x2a2a2a, lateral: 0x1a1a1a, shape: 'slab' },
  [BLOCO.ESCADA_END_BRICK]:    { nome: 'Escada End Brick',    solido: true, emiteLuz: 0, cor: 0xe8d886, lateral: 0xc0a866, shape: 'stairs' },
  [BLOCO.ESCADA_PURPUR]:       { nome: 'Escada Purpur',       solido: true, emiteLuz: 0, cor: 0xab47bc, lateral: 0x7b1fa2, shape: 'stairs' },
  [BLOCO.ESCADA_NETHER_BRICK]: { nome: 'Escada Nether Brick', solido: true, emiteLuz: 0, cor: 0x4a0e0e, lateral: 0x2d0707, shape: 'stairs' },
  [BLOCO.ESCADA_MUSGO]:        { nome: 'Escada c/ Musgo',     solido: true, emiteLuz: 0, cor: 0xc0d0a0, lateral: 0xa0b88a, shape: 'stairs' },
  [BLOCO.PAREDE_END_BRICK]:    { nome: 'Parede End Brick',    solido: true, emiteLuz: 0, cor: 0xe8d886, lateral: 0xc0a866, shape: 'wall' },
  [BLOCO.PAREDE_NETHER_BRICK]: { nome: 'Parede Nether Brick', solido: true, emiteLuz: 0, cor: 0x4a0e0e, lateral: 0x2d0707, shape: 'wall' },
  [BLOCO.SLAB_END_BRICK]:      { nome: 'Laje End Brick',      solido: true, emiteLuz: 0, cor: 0xe8d886, lateral: 0xc0a866, shape: 'slab' },
  [BLOCO.SLAB_PURPUR]:         { nome: 'Laje Purpur',         solido: true, emiteLuz: 0, cor: 0xab47bc, lateral: 0x7b1fa2, shape: 'slab' },
  [BLOCO.ESCADA_DEEPSLATE_PAV]:{ nome: 'Escada Pav. Ardósia', solido: true, emiteLuz: 0, cor: 0x4a4a52, lateral: 0x35353d, shape: 'stairs' },
  [BLOCO.ESCADA_DEEPSLATE_POL]:{ nome: 'Escada Ardósia Pol.', solido: true, emiteLuz: 0, cor: 0x55555f, lateral: 0x40404a, shape: 'stairs' },
  [BLOCO.ESCADA_OBSIDIANA]:    { nome: 'Escada Obsidiana',    solido: true, emiteLuz: 0, cor: 0x4d3e5e, lateral: 0x3a2c4a, shape: 'stairs' },
  [BLOCO.ESCADA_BASALTO]:      { nome: 'Escada Basalto',      solido: true, emiteLuz: 0, cor: 0x424242, lateral: 0x2a2a2a, shape: 'stairs' },
  [BLOCO.PAREDE_DEEPSLATE_POL]:{ nome: 'Parede Ardósia Pol.', solido: true, emiteLuz: 0, cor: 0x55555f, lateral: 0x40404a, shape: 'wall' },
  [BLOCO.PAREDE_BASALTO]:      { nome: 'Parede Basalto',      solido: true, emiteLuz: 0, cor: 0x424242, lateral: 0x2a2a2a, shape: 'wall' },
  [BLOCO.SLAB_DEEPSLATE_PAV]:  { nome: 'Laje Pav. Ardósia',   solido: true, emiteLuz: 0, cor: 0x4a4a52, lateral: 0x35353d, shape: 'slab' },
  [BLOCO.SLAB_BASALTO]:        { nome: 'Laje Basalto',        solido: true, emiteLuz: 0, cor: 0x424242, lateral: 0x2a2a2a, shape: 'slab' },
  [BLOCO.ESCADA_CRIMSON]:      { nome: 'Escada Crimson',      solido: true, emiteLuz: 0, cor: 0x8a3a4d, lateral: 0x5d2535, shape: 'stairs' },
  [BLOCO.ESCADA_WARPED]:       { nome: 'Escada Warped',       solido: true, emiteLuz: 0, cor: 0x2c8a8a, lateral: 0x1d5d5d, shape: 'stairs' },
  [BLOCO.ESCADA_BAMBU]:        { nome: 'Escada Bambu',        solido: true, emiteLuz: 0, cor: 0x8bc34a, lateral: 0x689f38, shape: 'stairs' },
  [BLOCO.ESCADA_COBRE_GASTO]:  { nome: 'Escada Cobre Gasto',  solido: true, emiteLuz: 0, cor: 0xb47366, lateral: 0x8d5e54, shape: 'stairs' },
  [BLOCO.PAREDE_COBRE]:        { nome: 'Parede Cobre',        solido: true, emiteLuz: 0, cor: 0xe07a3b, lateral: 0xc56226, shape: 'wall' },
  [BLOCO.PAREDE_COBRE_OXIDADO]:{ nome: 'Parede Cobre Oxid.',  solido: true, emiteLuz: 0, cor: 0x5fb89e, lateral: 0x4a9b82, shape: 'wall' },
  [BLOCO.SLAB_CRIMSON]:        { nome: 'Laje Crimson',        solido: true, emiteLuz: 0, cor: 0x8a3a4d, lateral: 0x5d2535, shape: 'slab' },
  [BLOCO.SLAB_WARPED]:         { nome: 'Laje Warped',         solido: true, emiteLuz: 0, cor: 0x2c8a8a, lateral: 0x1d5d5d, shape: 'slab' },
  [BLOCO.ESCADA_CONCRETO_R]:   { nome: 'Escada Concr. Verm.', solido: true, emiteLuz: 0, cor: 0xc62828, lateral: 0x8b0000, shape: 'stairs' },
  [BLOCO.ESCADA_CONCRETO_A]:   { nome: 'Escada Concr. Azul',  solido: true, emiteLuz: 0, cor: 0x1565c0, lateral: 0x0d47a1, shape: 'stairs' },
  [BLOCO.ESCADA_CONCRETO_V]:   { nome: 'Escada Concr. Verde', solido: true, emiteLuz: 0, cor: 0x2e7d32, lateral: 0x1b5e20, shape: 'stairs' },
  [BLOCO.ESCADA_CONCRETO_BR]:  { nome: 'Escada Concr. Branc', solido: true, emiteLuz: 0, cor: 0xfafafa, lateral: 0xeceff1, shape: 'stairs' },
  [BLOCO.PAREDE_CONCRETO_R]:   { nome: 'Parede Concr. Verm.', solido: true, emiteLuz: 0, cor: 0xc62828, lateral: 0x8b0000, shape: 'wall' },
  [BLOCO.PAREDE_CONCRETO_PR]:  { nome: 'Parede Concr. Preto', solido: true, emiteLuz: 0, cor: 0x212121, lateral: 0x000000, shape: 'wall' },
  [BLOCO.SLAB_CONCRETO_R]:     { nome: 'Laje Concr. Verm.',   solido: true, emiteLuz: 0, cor: 0xc62828, lateral: 0x8b0000, shape: 'slab' },
  [BLOCO.SLAB_CONCRETO_A]:     { nome: 'Laje Concr. Azul',    solido: true, emiteLuz: 0, cor: 0x1565c0, lateral: 0x0d47a1, shape: 'slab' },
  [BLOCO.COBRE_CORTADO]:       { nome: 'Cobre Cortado',       solido: true, emiteLuz: 0, cor: 0xe07a3b, lateral: 0xc56226 },
  [BLOCO.COBRE_GASTO_CORTADO]: { nome: 'Cobre Gasto Cortado', solido: true, emiteLuz: 0, cor: 0xb47366, lateral: 0x8d5e54 },
  [BLOCO.COBRE_OXIDADO_CORTADO]:{nome:'Cobre Oxid. Cortado', solido: true, emiteLuz: 0, cor: 0x5fb89e, lateral: 0x4a9b82 },
  [BLOCO.COBRE_LISO]:          { nome: 'Cobre Liso',          solido: true, emiteLuz: 0, cor: 0xff9d5e, lateral: 0xe07a3b },
  [BLOCO.ESCADA_PURPUR_PILLAR]:{ nome: 'Escada Pilar Purpur', solido: true, emiteLuz: 0, cor: 0xab47bc, lateral: 0x7b1fa2, shape: 'stairs' },
  [BLOCO.PAREDE_PURPUR]:       { nome: 'Parede Purpur',       solido: true, emiteLuz: 0, cor: 0xab47bc, lateral: 0x7b1fa2, shape: 'wall' },
  [BLOCO.SLAB_PURPUR_PILLAR]:  { nome: 'Laje Pilar Purpur',   solido: true, emiteLuz: 0, cor: 0xab47bc, lateral: 0x7b1fa2, shape: 'slab' },
  [BLOCO.PURPUR_LIMPO]:        { nome: 'Purpur Limpo',        solido: true, emiteLuz: 0, cor: 0xce93d8, lateral: 0xab47bc },
  [BLOCO.SMITHING_TABLE]: { nome: 'Mesa Smithing',  solido: true, emiteLuz: 0, cor: 0x424242, lateral: 0x212121 },
  [BLOCO.BREWING_STAND]:  { nome: 'Brewing Stand',  solido: true, emiteLuz: 1, cor: 0xa1887f, lateral: 0x8d6e63 },
  [BLOCO.BLAST_FURNACE]:  { nome: 'Blast Furnace',  solido: true, emiteLuz: 0, cor: 0x424242, lateral: 0x212121 },
  [BLOCO.SMOKER]:         { nome: 'Smoker',         solido: true, emiteLuz: 0, cor: 0x6d4c41, lateral: 0x4e342e },
  [BLOCO.CARTOGRAPHY]:    { nome: 'Mesa Cartografia',solido: true,emiteLuz: 0, cor: 0xa1887f, lateral: 0x8d6e63 },
  [BLOCO.FLETCHING]:      { nome: 'Mesa Fletching', solido: true, emiteLuz: 0, cor: 0xa1887f, lateral: 0x8d6e63 },
  [BLOCO.LOOM]:           { nome: 'Tear (Loom)',    solido: true, emiteLuz: 0, cor: 0xa1887f, lateral: 0x8d6e63 },
  [BLOCO.STONECUTTER]:    { nome: 'Stonecutter',    solido: true, emiteLuz: 0, cor: 0x9e9e9e, lateral: 0x757575 },
  [BLOCO.TARGET_BLOCK]:   { nome: 'Target Block',   solido: true, emiteLuz: 0, cor: 0xfafafa, lateral: 0xc62828 },
  [BLOCO.ANCIENT_DEBRIS]: { nome: 'Ancient Debris', solido: true, emiteLuz: 0, cor: 0x6d4c41, lateral: 0x4e342e },
  [BLOCO.HONEYCOMB_BLOCK]:{ nome: 'Bloco Favo Mel', solido: true, emiteLuz: 0, cor: 0xff9800, lateral: 0xe65100 },
  [BLOCO.COMPOSTER]:      { nome: 'Compostador',    solido: true, emiteLuz: 0, cor: 0xa1887f, lateral: 0x8d6e63 },
  [BLOCO.LECTERN]:        { nome: 'Atril',          solido: true, emiteLuz: 0, cor: 0xa1887f, lateral: 0x8d6e63 },
  [BLOCO.BARREL]:         { nome: 'Barril',         solido: true, emiteLuz: 0, cor: 0xa1887f, lateral: 0x6d4c41 },
  [BLOCO.CAMPFIRE]:       { nome: 'Acampamento',    solido: true, emiteLuz: 14, cor: 0xff9800, lateral: 0x6d4c41 },
  [BLOCO.DRIED_KELP_BLOCK]:{ nome: 'Bloco Alga Seca',solido: true, emiteLuz: 0, cor: 0x33691e, lateral: 0x1b5e20 },
  [BLOCO.BOOKSHELF_CHISELED]:{ nome:'Estante Esculp.', solido: true, emiteLuz: 0, cor: 0xa1887f, lateral: 0xa1887f },
  [BLOCO.JUKEBOX]:        { nome: 'Jukebox',          solido: true, emiteLuz: 0, cor: 0x6d4c41, lateral: 0x4e342e },
  [BLOCO.END_ROD]:        { nome: 'Haste do End',     solido: false,emiteLuz: 14, cor: 0xfafafa, lateral: 0xeceff1, shape: 'torch' },
  [BLOCO.LIGHT_BLOCK]:    { nome: 'Bloco de Luz',     solido: false,emiteLuz: 15, cor: 0xfff59d, lateral: 0xfff59d },
  [BLOCO.DAYLIGHT_DETECTOR]:{ nome:'Detector de Luz',  solido: true, emiteLuz: 0, cor: 0xa1887f, lateral: 0x6d4c41 },
  [BLOCO.NOTE_BLOCK]:     { nome: 'Bloco de Nota',    solido: true, emiteLuz: 0, cor: 0xa1887f, lateral: 0x8d6e63 },
  [BLOCO.BELL]:           { nome: 'Sino',             solido: true, emiteLuz: 0, cor: 0xfdd835, lateral: 0xf9a825 },
  [BLOCO.SEA_PICKLE]:     { nome: 'Pepino-do-mar',    solido: false,emiteLuz: 6,  cor: 0x558b2f, lateral: 0x33691e, shape: 'pot' },
  [BLOCO.ENDER_CHEST]:    { nome: 'Baú do Ender',     solido: true, emiteLuz: 7, cor: 0x004d40, lateral: 0x00251f },
  [BLOCO.SHULKER_BOX]:    { nome: 'Shulker Box',      solido: true, emiteLuz: 0, cor: 0x9c27b0, lateral: 0x6a1b9a },
  [BLOCO.ANVIL_DAMAGED]:  { nome: 'Bigorna Danific.', solido: true, emiteLuz: 0, cor: 0x424242, lateral: 0x212121 },
  [BLOCO.DECORATED_POT]:  { nome: 'Vaso Decorado',    solido: false,emiteLuz: 0, cor: 0xa1887f, lateral: 0x6d4c41, shape: 'pot' },
  [BLOCO.ESCADA_PRISMARINE_BRK]:{ nome:'Escada Prismarine Brk',solido: true,emiteLuz: 0, cor: 0x009688, lateral: 0x00695c, shape: 'stairs' },
  [BLOCO.SLAB_PRISMARINE]:     { nome: 'Laje Prismarine',     solido: true,emiteLuz: 0, cor: 0x4db6ac, lateral: 0x00897b, shape: 'slab' },
  [BLOCO.SLAB_PRISMARINE_BRK]: { nome: 'Laje Prismarine Brk', solido: true,emiteLuz: 0, cor: 0x009688, lateral: 0x00695c, shape: 'slab' },
  [BLOCO.PAREDE_PRISMARINE]:   { nome: 'Parede Prismarine',   solido: true,emiteLuz: 0, cor: 0x4db6ac, lateral: 0x00897b, shape: 'wall' },
  [BLOCO.SHULKER_R]:           { nome: 'Shulker Vermelho',    solido: true, emiteLuz: 0, cor: 0xc62828, lateral: 0x8b0000 },
  [BLOCO.SHULKER_A]:           { nome: 'Shulker Azul',        solido: true, emiteLuz: 0, cor: 0x1565c0, lateral: 0x0d47a1 },
  [BLOCO.SHULKER_V]:           { nome: 'Shulker Verde',       solido: true, emiteLuz: 0, cor: 0x2e7d32, lateral: 0x1b5e20 },
  [BLOCO.SHULKER_AM]:          { nome: 'Shulker Amarelo',     solido: true, emiteLuz: 0, cor: 0xf9a825, lateral: 0xf57f17 },
  [BLOCO.ESCADA_ARENITO_LISO]: { nome: 'Escada Arenito Liso', solido: true, emiteLuz: 0, cor: 0xfde2b2, lateral: 0xfde2b2, shape: 'stairs' },
  [BLOCO.SLAB_ARENITO_LISO]:   { nome: 'Laje Arenito Liso',   solido: true, emiteLuz: 0, cor: 0xfde2b2, lateral: 0xfde2b2, shape: 'slab' },
  [BLOCO.PAREDE_ARENITO_LISO]: { nome: 'Parede Arenito Liso', solido: true, emiteLuz: 0, cor: 0xfde2b2, lateral: 0xfde2b2, shape: 'wall' },
  [BLOCO.ESCADA_ARENITO_CORT]: { nome: 'Escada Arenito Cort.',solido: true, emiteLuz: 0, cor: 0xfdd8a0, lateral: 0xe6c389, shape: 'stairs' },
  [BLOCO.SHULKER_BR]:          { nome: 'Shulker Branco',      solido: true, emiteLuz: 0, cor: 0xfafafa, lateral: 0xeceff1 },
  [BLOCO.SHULKER_PR]:          { nome: 'Shulker Preto',       solido: true, emiteLuz: 0, cor: 0x424242, lateral: 0x212121 },
  [BLOCO.SHULKER_LR]:          { nome: 'Shulker Laranja',     solido: true, emiteLuz: 0, cor: 0xff9800, lateral: 0xe65100 },
  [BLOCO.SHULKER_RS]:          { nome: 'Shulker Rosa',        solido: true, emiteLuz: 0, cor: 0xf06292, lateral: 0xc2185b },
  [BLOCO.ESCADA_TERRACOTA_R]:  { nome: 'Escada Terracota V',  solido: true, emiteLuz: 0, cor: 0xb55a3a, lateral: 0x8b3e23, shape: 'stairs' },
  [BLOCO.SLAB_TERRACOTA_R]:    { nome: 'Laje Terracota V',    solido: true, emiteLuz: 0, cor: 0xb55a3a, lateral: 0x8b3e23, shape: 'slab' },
  [BLOCO.PAREDE_TERRACOTA_R]:  { nome: 'Parede Terracota V',  solido: true, emiteLuz: 0, cor: 0xb55a3a, lateral: 0x8b3e23, shape: 'wall' },
  [BLOCO.ESCADA_TERRACOTA_A]:  { nome: 'Escada Terracota A',  solido: true, emiteLuz: 0, cor: 0x4a5e9a, lateral: 0x2c3d6c, shape: 'stairs' },
  [BLOCO.SLAB_NETHER]:         { nome: 'Laje Tijolo Nether',  solido: true, emiteLuz: 0, cor: 0x4a0e0e, lateral: 0x2d0707, shape: 'slab' },
  [BLOCO.PAREDE_NETHER]:       { nome: 'Parede Tijolo Nether',solido: true, emiteLuz: 0, cor: 0x4a0e0e, lateral: 0x2d0707, shape: 'wall' },
  [BLOCO.ESCADA_GLAZED_R]:     { nome: 'Escada Glazed Verm.', solido: true, emiteLuz: 0, cor: 0xc62828, lateral: 0x8b0000, shape: 'stairs' },
  [BLOCO.SLAB_GLAZED_R]:       { nome: 'Laje Glazed Verm.',   solido: true, emiteLuz: 0, cor: 0xc62828, lateral: 0x8b0000, shape: 'slab' },
  [BLOCO.ESCADA_GLAZED_A]:     { nome: 'Escada Glazed Azul',  solido: true, emiteLuz: 0, cor: 0x1565c0, lateral: 0x0d47a1, shape: 'stairs' },
  [BLOCO.SLAB_GLAZED_A]:       { nome: 'Laje Glazed Azul',    solido: true, emiteLuz: 0, cor: 0x1565c0, lateral: 0x0d47a1, shape: 'slab' },
  [BLOCO.ESCADA_GLAZED_V]:     { nome: 'Escada Glazed Verde', solido: true, emiteLuz: 0, cor: 0x2e7d32, lateral: 0x1b5e20, shape: 'stairs' },
  [BLOCO.ESCADA_GLAZED_AM]:    { nome: 'Escada Glazed Amare.',solido: true, emiteLuz: 0, cor: 0xf9a825, lateral: 0xf57f17, shape: 'stairs' },
  [BLOCO.SLAB_BAMBU]:          { nome: 'Laje Bambu',         solido: true, emiteLuz: 0, cor: 0x8bc34a, lateral: 0x689f38, shape: 'slab' },
  [BLOCO.PAREDE_BAMBU]:        { nome: 'Parede Bambu',       solido: true, emiteLuz: 0, cor: 0x8bc34a, lateral: 0x689f38, shape: 'wall' },
  [BLOCO.ESCADA_DRIED_KELP]:   { nome: 'Escada Alga Seca',   solido: true, emiteLuz: 0, cor: 0x33691e, lateral: 0x1b5e20, shape: 'stairs' },
  [BLOCO.SLAB_DRIED_KELP]:     { nome: 'Laje Alga Seca',     solido: true, emiteLuz: 0, cor: 0x33691e, lateral: 0x1b5e20, shape: 'slab' },
  [BLOCO.ESCADA_QUARTZO_POL]:  { nome: 'Escada Quartzo Pol.',solido: true, emiteLuz: 0, cor: 0xfff8e1, lateral: 0xfff8e1, shape: 'stairs' },
  [BLOCO.SLAB_QUARTZO_POL]:    { nome: 'Laje Quartzo Pol.',  solido: true, emiteLuz: 0, cor: 0xfff8e1, lateral: 0xfff8e1, shape: 'slab' },
  [BLOCO.PAREDE_QUARTZO]:      { nome: 'Parede Quartzo',     solido: true, emiteLuz: 0, cor: 0xfafafa, lateral: 0xeeeeee, shape: 'wall' },
  [BLOCO.ESCADA_BLOCO_OURO]:   { nome: 'Escada Bl. Ouro',    solido: true, emiteLuz: 0, cor: 0xfdd835, lateral: 0xf9a825, shape: 'stairs' },
  [BLOCO.COMMAND_BLOCK]:       { nome: 'Command Block',      solido: true, emiteLuz: 4, cor: 0xa05a30, lateral: 0x7d3e1c },
  [BLOCO.ESCADA_BLOCO_FERRO]:  { nome: 'Escada Bl. Ferro',   solido: true, emiteLuz: 0, cor: 0xeceff1, lateral: 0xcfd8dc, shape: 'stairs' },
  [BLOCO.SLAB_BLOCO_FERRO]:    { nome: 'Laje Bl. Ferro',     solido: true, emiteLuz: 0, cor: 0xeceff1, lateral: 0xcfd8dc, shape: 'slab' },
  [BLOCO.ESCADA_BLOCO_DIAMANTE]:{nome: 'Escada Bl. Diamante',solido: true, emiteLuz: 0, cor: 0x4dd0e1, lateral: 0x00838f, shape: 'stairs' },
  [BLOCO.SLAB_BLOCO_DIAMANTE]: { nome: 'Laje Bl. Diamante',  solido: true, emiteLuz: 0, cor: 0x4dd0e1, lateral: 0x00838f, shape: 'slab' },
  [BLOCO.ESCADA_BLOCO_LAPIS]:  { nome: 'Escada Bl. Lápis',   solido: true, emiteLuz: 0, cor: 0x1565c0, lateral: 0x0d47a1, shape: 'stairs' },
  [BLOCO.SLAB_BLOCO_LAPIS]:    { nome: 'Laje Bl. Lápis',     solido: true, emiteLuz: 0, cor: 0x1565c0, lateral: 0x0d47a1, shape: 'slab' },
  [BLOCO.ESCADA_BLOCO_REDSTONE]:{nome:'Escada Bl. Redstone', solido: true, emiteLuz: 7, cor: 0xc62828, lateral: 0x8b0000, shape: 'stairs' },
  // Sprint paridade MC (407-414)
  [BLOCO.RESPAWN_ANCHOR]:    { nome: 'Respawn Anchor',     solido: true, emiteLuz: 15, cor: 0x4a148c, lateral: 0x311b92 },
  [BLOCO.LODESTONE]:         { nome: 'Lodestone',          solido: true, emiteLuz: 0,  cor: 0x9e9e9e, lateral: 0x616161 },
  [BLOCO.REINFORCED_DS]:     { nome: 'Ardósia Reforçada',  solido: true, emiteLuz: 0,  cor: 0x2a2a2a, lateral: 0x1a1a1a },
  [BLOCO.MOSS_BLOCK]:        { nome: 'Bloco Musgo',        solido: true, emiteLuz: 0,  cor: 0x558b2f, lateral: 0x33691e },
  [BLOCO.MOSS_CARPET]:       { nome: 'Tapete Musgo',       solido: true, emiteLuz: 0,  cor: 0x558b2f, lateral: 0x33691e, shape: 'slab' },
  [BLOCO.BIG_DRIPLEAF]:      { nome: 'Dripleaf Grande',    solido: true, emiteLuz: 0,  cor: 0x66bb6a, lateral: 0x388e3c, shape: 'flower' },
  [BLOCO.CHORUS_FLOWER]:     { nome: 'Flor Chorus',        solido: true, emiteLuz: 0,  cor: 0xab47bc, lateral: 0x6a1b9a, shape: 'flower' },
  [BLOCO.PISTON]:            { nome: 'Pistão',             solido: true, emiteLuz: 0,  cor: 0xa1887f, lateral: 0x8d6e63 },
  // Sprint redstone + madeiras 1.20+ (415-422)
  [BLOCO.STICKY_PISTON]:     { nome: 'Pistão Pegajoso',    solido: true, emiteLuz: 0,  cor: 0x66bb6a, lateral: 0x388e3c },
  [BLOCO.REPEATER]:          { nome: 'Repetidor',          solido: true, emiteLuz: 0,  cor: 0xbcaaa4, lateral: 0x8d6e63, shape: 'plate' },
  [BLOCO.COMPARATOR]:        { nome: 'Comparador',         solido: true, emiteLuz: 0,  cor: 0xbcaaa4, lateral: 0x6d4c41, shape: 'plate' },
  [BLOCO.CRAFTER]:           { nome: 'Crafter',            solido: true, emiteLuz: 0,  cor: 0x9e9e9e, lateral: 0x424242 },
  [BLOCO.TRAPPED_CHEST]:     { nome: 'Baú Armadilha',      solido: true, emiteLuz: 0,  cor: 0xa1887f, lateral: 0x8d6e63 },
  [BLOCO.MANGROVE_LOG]:      { nome: 'Tronco Mangrove',    solido: true, emiteLuz: 0,  cor: 0x6d4c41, lateral: 0x4e342e },
  [BLOCO.MANGROVE_PRANCHA]:  { nome: 'Pranchas Mangrove',  solido: true, emiteLuz: 0,  cor: 0x8d6e63, lateral: 0x6d4c41 },
  [BLOCO.CHERRY_LOG]:        { nome: 'Tronco Cerejeira',   solido: true, emiteLuz: 0,  cor: 0xf48fb1, lateral: 0xc2185b },
  // Sprint 4: madeiras+plantas 1.20+ (423-430)
  [BLOCO.CHERRY_PRANCHA]:    { nome: 'Pranchas Cerejeira', solido: true, emiteLuz: 0,  cor: 0xf8bbd0, lateral: 0xec407a },
  [BLOCO.CHERRY_FOLHA]:      { nome: 'Folhas Cerejeira',   solido: true, emiteLuz: 0,  cor: 0xf48fb1, lateral: 0xf06292 },
  [BLOCO.MANGROVE_FOLHA]:    { nome: 'Folhas Mangrove',    solido: true, emiteLuz: 0,  cor: 0x558b2f, lateral: 0x33691e },
  [BLOCO.MANGROVE_RAIZ]:     { nome: 'Raiz Mangrove',      solido: true, emiteLuz: 0,  cor: 0x6d4c41, lateral: 0x4e342e, shape: 'fence' },
  [BLOCO.AZALEA]:            { nome: 'Azaléia',            solido: true, emiteLuz: 0,  cor: 0x66bb6a, lateral: 0x388e3c, shape: 'flower' },
  [BLOCO.AZALEA_FLOWER]:     { nome: 'Azaléia Florida',    solido: true, emiteLuz: 0,  cor: 0xf06292, lateral: 0x66bb6a, shape: 'flower' },
  [BLOCO.PINK_PETALS]:       { nome: 'Pétalas Rosa',       solido: true, emiteLuz: 0,  cor: 0xf48fb1, lateral: 0xf48fb1, shape: 'plate' },
  [BLOCO.CACTUS_FLOWER]:     { nome: 'Flor de Cacto',      solido: true, emiteLuz: 0,  cor: 0xfdd835, lateral: 0x388e3c, shape: 'flower' },
  // Sprint 5: Nether plants + cipós + andaime (431-438)
  [BLOCO.BAMBOO_MOSAIC]:     { nome: 'Mosaico Bambu',      solido: true, emiteLuz: 0,  cor: 0xc8a951, lateral: 0xa0863e },
  [BLOCO.CRIMSON_ROOTS]:     { nome: 'Raízes Crimson',     solido: true, emiteLuz: 0,  cor: 0x8a3a4d, lateral: 0x5d2535, shape: 'flower' },
  [BLOCO.WARPED_ROOTS]:      { nome: 'Raízes Warped',      solido: true, emiteLuz: 0,  cor: 0x2c8a8a, lateral: 0x1d5d5d, shape: 'flower' },
  [BLOCO.FROSTED_ICE]:       { nome: 'Gelo Congelado',     solido: true, emiteLuz: 0,  cor: 0xb3e5fc, lateral: 0x81d4fa },
  [BLOCO.VINE]:              { nome: 'Cipó',               solido: true, emiteLuz: 0,  cor: 0x33691e, lateral: 0x1b5e20, shape: 'flower' },
  [BLOCO.TWISTING_VINES]:    { nome: 'Cipó Torcido',       solido: true, emiteLuz: 0,  cor: 0x00bcd4, lateral: 0x00838f, shape: 'flower' },
  [BLOCO.WEEPING_VINES]:     { nome: 'Cipó Pendente',      solido: true, emiteLuz: 0,  cor: 0xc62828, lateral: 0x8b0000, shape: 'flower' },
  [BLOCO.SCAFFOLDING]:       { nome: 'Andaime',            solido: true, emiteLuz: 0,  cor: 0xc8a951, lateral: 0x6d4c41, shape: 'fence' },
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
  ESP_MADEIRA: 210, ESP_PEDRA: 211, ESP_FERRO: 212, ESP_DIAMANTE: 213,
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
  // Ferramentas: machados (chop wood mais rápido)
  MACHADO_MADEIRA:264,
  MACHADO_PEDRA:  265,
  MACHADO_FERRO:  266,
  MACHADO_DIAMANTE:267,
  // Pás (digging)
  PA_MADEIRA:     268,
  PA_PEDRA:       269,
  PA_FERRO:       270,
  PA_DIAMANTE:    271,
  // Enxadas (farming)
  ENXADA_MADEIRA: 272,
  ENXADA_PEDRA:   273,
  ENXADA_FERRO:   274,
  ENXADA_DIAMANTE:275,
  // Utilitários
  TESOURA:        276, // tosquiar ovelha + cortar folha
  SELA:           277, // saddle pra montar mobs
  CORDA:          278, // lead pra puxar mobs
  RELOGIO:        279, // mostra hora exata
  ESPELHO:        280, // espelho mágico
  RECOVERY_COMPASS:281, // bússola de recuperação (aponta morte)
  // Ingredientes de poção
  BLAZE_POWDER:    282,
  GHAST_TEAR:      283,
  MAGMA_CREAM:     284,
  FERMENTED_EYE:   285, // fermented spider eye
  GLISTERING_SLICE:286, // golden melon slice
  RABBIT_FOOT:     287, // mesma coisa que PE_COELHO mas dedicado
  GLOWSTONE_DUST:  288,
  GUNPOWDER:       289,
  // Outros
  GARRAFA_VIDRO:   290,
  BLAZE_ROD:       291, // bastão de blaze
  NETHER_STAR:     292, // estrela do nether (drop wither)
  POTE_AGUA:       293, // garrafa com água (pre-poção)
  // Poções novas
  POCAO_INVISIVEL: 294,
  POCAO_NOITE:     295, // night vision
  POCAO_LEVITACAO: 296,
  POCAO_RESISTENCIA:297,
  POCAO_SLOW_FALL: 298,
  POCAO_FIRE_RES:  299,
  // Music discs
  MUSIC_DISC_13:   300,
  MUSIC_DISC_CAT:  301,
  MUSIC_DISC_BLOCKS:302,
  MUSIC_DISC_CHIRP:303,
  MUSIC_DISC_FAR:  304,
  // Foods novas
  COOKIE:          305, // biscoito
  PUMPKIN_PIE:     306, // torta de abóbora
  BEETROOT:        307, // beterraba (vegetal)
  SOPA_BEETROOT:   308, // sopa de beterraba
  // Tier Netherite (mais alto que diamante)
  NETHERITE:       309, // lingote
  PIC_NETHERITE:   310,
  ESP_NETHERITE:   311,
  MACHADO_NETHERITE:312,
  PA_NETHERITE:    313,
  ENXADA_NETHERITE:314,
  CAP_NETHERITE:   315,
  PEI_NETHERITE:   316,
  PER_NETHERITE:   317,
  BOT_NETHERITE:   318,
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
  [ITEM.ESP_DIAMANTE]: { nome: 'Espada diamante',  icone: '⚔', tier: 4, ferramenta: 'esp' },
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
  // Machados
  [ITEM.MACHADO_MADEIRA]:  { nome: 'Machado madeira',  icone: '🪓', tier: 1, ferramenta: 'machado' },
  [ITEM.MACHADO_PEDRA]:    { nome: 'Machado pedra',    icone: '🪓', tier: 2, ferramenta: 'machado' },
  [ITEM.MACHADO_FERRO]:    { nome: 'Machado ferro',    icone: '🪓', tier: 3, ferramenta: 'machado' },
  [ITEM.MACHADO_DIAMANTE]: { nome: 'Machado diamante', icone: '🪓', tier: 4, ferramenta: 'machado' },
  // Pás
  [ITEM.PA_MADEIRA]:       { nome: 'Pá madeira',       icone: '⛓', tier: 1, ferramenta: 'pa' },
  [ITEM.PA_PEDRA]:         { nome: 'Pá pedra',         icone: '⛓', tier: 2, ferramenta: 'pa' },
  [ITEM.PA_FERRO]:         { nome: 'Pá ferro',         icone: '⛓', tier: 3, ferramenta: 'pa' },
  [ITEM.PA_DIAMANTE]:      { nome: 'Pá diamante',      icone: '⛓', tier: 4, ferramenta: 'pa' },
  // Enxadas
  [ITEM.ENXADA_MADEIRA]:   { nome: 'Enxada madeira',   icone: '🌾', tier: 1, ferramenta: 'enxada' },
  [ITEM.ENXADA_PEDRA]:     { nome: 'Enxada pedra',     icone: '🌾', tier: 2, ferramenta: 'enxada' },
  [ITEM.ENXADA_FERRO]:     { nome: 'Enxada ferro',     icone: '🌾', tier: 3, ferramenta: 'enxada' },
  [ITEM.ENXADA_DIAMANTE]:  { nome: 'Enxada diamante',  icone: '🌾', tier: 4, ferramenta: 'enxada' },
  // Utilitários
  [ITEM.TESOURA]:          { nome: 'Tesoura',          icone: '✂', ferramenta: 'tesoura' },
  [ITEM.SELA]:             { nome: 'Sela',             icone: '🐎' },
  [ITEM.CORDA]:            { nome: 'Corda',            icone: '➰' },
  [ITEM.RELOGIO]:          { nome: 'Relógio',          icone: '⏰' },
  [ITEM.ESPELHO]:          { nome: 'Espelho Mágico',   icone: '🪞' },
  [ITEM.RECOVERY_COMPASS]: { nome: 'Bússola Recovery', icone: '🧭' },
  // Ingredientes de poção
  [ITEM.BLAZE_POWDER]:     { nome: 'Pó de Blaze',       icone: '🟡' },
  [ITEM.GHAST_TEAR]:       { nome: 'Lágrima de Ghast',  icone: '💧' },
  [ITEM.MAGMA_CREAM]:      { nome: 'Creme de Magma',    icone: '🟠' },
  [ITEM.FERMENTED_EYE]:    { nome: 'Olho Fermentado',   icone: '👁' },
  [ITEM.GLISTERING_SLICE]: { nome: 'Fatia Dourada',     icone: '🍈' },
  [ITEM.RABBIT_FOOT]:      { nome: 'Pé Coelho (poção)', icone: '🐰' },
  [ITEM.GLOWSTONE_DUST]:   { nome: 'Pó de Glowstone',   icone: '✨' },
  [ITEM.GUNPOWDER]:        { nome: 'Pólvora',           icone: '⚫' },
  // Outros
  [ITEM.GARRAFA_VIDRO]:    { nome: 'Garrafa de Vidro',  icone: '🍾' },
  [ITEM.BLAZE_ROD]:        { nome: 'Bastão de Blaze',   icone: '🟨' },
  [ITEM.NETHER_STAR]:      { nome: 'Estrela do Nether', icone: '⭐' },
  [ITEM.POTE_AGUA]:        { nome: 'Pote de Água',      icone: '💧' },
  // Poções novas
  [ITEM.POCAO_INVISIVEL]:  { nome: 'Poção Invisível',   icone: '🧪', pocao: 'invisivel' },
  [ITEM.POCAO_NOITE]:      { nome: 'Poção Visão Noite', icone: '🧪', pocao: 'noite' },
  [ITEM.POCAO_LEVITACAO]:  { nome: 'Poção Levitação',   icone: '🧪', pocao: 'levitacao' },
  [ITEM.POCAO_RESISTENCIA]:{ nome: 'Poção Resistência', icone: '🧪', pocao: 'resistencia' },
  [ITEM.POCAO_SLOW_FALL]:  { nome: 'Poção Slow Fall',   icone: '🧪', pocao: 'slow_fall' },
  [ITEM.POCAO_FIRE_RES]:   { nome: 'Poção Fire Resist', icone: '🧪', pocao: 'fire_res' },
  // Music discs
  [ITEM.MUSIC_DISC_13]:    { nome: 'Disco "13"',          icone: '💿' },
  [ITEM.MUSIC_DISC_CAT]:   { nome: 'Disco "Cat"',         icone: '💿' },
  [ITEM.MUSIC_DISC_BLOCKS]:{ nome: 'Disco "Blocks"',      icone: '💿' },
  [ITEM.MUSIC_DISC_CHIRP]: { nome: 'Disco "Chirp"',       icone: '💿' },
  [ITEM.MUSIC_DISC_FAR]:   { nome: 'Disco "Far"',         icone: '💿' },
  // Foods
  [ITEM.COOKIE]:           { nome: 'Biscoito',           icone: '🍪', nutricao: 2 },
  [ITEM.PUMPKIN_PIE]:      { nome: 'Torta de Abóbora',   icone: '🥧', nutricao: 8 },
  [ITEM.BEETROOT]:         { nome: 'Beterraba',          icone: '🍠', nutricao: 1 },
  [ITEM.SOPA_BEETROOT]:    { nome: 'Sopa de Beterraba',  icone: '🍲', nutricao: 6 },
  // Netherite tier (5)
  [ITEM.NETHERITE]:        { nome: 'Lingote Netherite',  icone: '🪨' },
  [ITEM.PIC_NETHERITE]:    { nome: 'Picareta netherite', icone: '⛏', tier: 5, ferramenta: 'pic' },
  [ITEM.ESP_NETHERITE]:    { nome: 'Espada netherite',   icone: '⚔', tier: 5, ferramenta: 'esp' },
  [ITEM.MACHADO_NETHERITE]:{ nome: 'Machado netherite',  icone: '🪓', tier: 5, ferramenta: 'machado' },
  [ITEM.PA_NETHERITE]:     { nome: 'Pá netherite',       icone: '⛓', tier: 5, ferramenta: 'pa' },
  [ITEM.ENXADA_NETHERITE]: { nome: 'Enxada netherite',   icone: '🌾', tier: 5, ferramenta: 'enxada' },
  // Armaduras netherite (defesa máxima)
  [ITEM.CAP_NETHERITE]:    { nome: 'Capacete netherite', icone: '🪖', armadura: 'cabeca', defesa: 4 },
  [ITEM.PEI_NETHERITE]:    { nome: 'Peitoral netherite', icone: '👕', armadura: 'torso',  defesa: 9 },
  [ITEM.PER_NETHERITE]:    { nome: 'Perneiras netherite',icone: '👖', armadura: 'pernas', defesa: 7 },
  [ITEM.BOT_NETHERITE]:    { nome: 'Botas netherite',    icone: '🥾', armadura: 'botas',  defesa: 4 },
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
  { custos: [{i: ITEM.DIAMANTE, q: 2}, {i: ITEM.PAU, q: 1}], saida: {i: ITEM.ESP_DIAMANTE,q: 1}, wb: true },
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
  // Portas coloridas: 6 pranchas crimson/warped → 1 porta
  { custos: [{b: BLOCO.CRIMSON_PLANKS, q: 6}], saida: {b: BLOCO.PORTA_CRIMSON, q: 1}, wb: true },
  { custos: [{b: BLOCO.WARPED_PLANKS, q: 6}], saida: {b: BLOCO.PORTA_WARPED, q: 1}, wb: true },
  // Porta de ferro: 6 ferro
  { custos: [{i: ITEM.FERRO, q: 6}], saida: {b: BLOCO.PORTA_FERRO, q: 1}, wb: true },
  // Trapdoors: 6 pranchas → 2 trapdoors / 4 ferro → 1 trapdoor ferro
  { custos: [{i: ITEM.PRANCHAS, q: 6}], saida: {b: BLOCO.TRAPDOOR_M, q: 2}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 4}], saida: {b: BLOCO.TRAPDOOR_F, q: 1}, wb: true },
  // Portões: 4 paus + 2 pranchas → 1 portão
  { custos: [{i: ITEM.PAU, q: 4}, {i: ITEM.PRANCHAS, q: 2}], saida: {b: BLOCO.PORTAO_M, q: 1}, wb: true },
  { custos: [{i: ITEM.PAU, q: 4}, {b: BLOCO.CRIMSON_PLANKS, q: 2}], saida: {b: BLOCO.PORTAO_C, q: 1}, wb: true },
  // Placa: 6 pranchas + 1 pau → 3 placas
  { custos: [{i: ITEM.PRANCHAS, q: 6}, {i: ITEM.PAU, q: 1}], saida: {b: BLOCO.SIGN_MADEIRA, q: 3}, wb: true },
  // Escadas: 6 do material → 4 escadas (paridade MC stair recipe)
  { custos: [{b: BLOCO.PEDRA, q: 6}],     saida: {b: BLOCO.ESCADA_PEDRA, q: 4}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 6}],   saida: {b: BLOCO.ESCADA_MADEIRA, q: 4}, wb: true },
  { custos: [{b: BLOCO.TIJOLO, q: 6}],    saida: {b: BLOCO.ESCADA_TIJOLO, q: 4}, wb: true },
  // Paredes: 6 do material → 6 paredes
  { custos: [{b: BLOCO.PEDRA, q: 6}],     saida: {b: BLOCO.PAREDE_PEDRA, q: 6}, wb: true },
  { custos: [{b: BLOCO.TIJOLO, q: 6}],    saida: {b: BLOCO.PAREDE_TIJOLO, q: 6}, wb: true },
  { custos: [{b: BLOCO.PAVIMENTO, q: 6}], saida: {b: BLOCO.PAREDE_PAVIMENTO, q: 6}, wb: true },
  // Botões: 1 do material → 1 botão (paridade MC)
  { custos: [{b: BLOCO.PEDRA,    q: 1}], saida: {b: BLOCO.BTN_PEDRA, q: 1}, wb: false },
  { custos: [{i: ITEM.PRANCHAS,  q: 1}], saida: {b: BLOCO.BTN_MADEIRA, q: 1}, wb: false },
  { custos: [{i: ITEM.OURO,      q: 1}], saida: {b: BLOCO.BTN_OURO, q: 1}, wb: false },
  // Placas de pressão: 2 do material → 1 placa
  { custos: [{b: BLOCO.PEDRA,    q: 2}], saida: {b: BLOCO.PLATE_PEDRA, q: 1}, wb: false },
  { custos: [{i: ITEM.PRANCHAS,  q: 2}], saida: {b: BLOCO.PLATE_MADEIRA, q: 1}, wb: false },
  // Alavanca: 1 pau + 1 pedra
  { custos: [{i: ITEM.PAU, q: 1}, {b: BLOCO.PEDRA, q: 1}], saida: {b: BLOCO.ALAVANCA, q: 1}, wb: false },
  // TNT: 5 areia + 4 carvão (proxy de pólvora) → 1 TNT
  { custos: [{b: BLOCO.AREIA, q: 5}, {i: ITEM.CARVAO, q: 4}], saida: {b: BLOCO.TNT, q: 1}, wb: true },
  // Vaso de Flor: 3 tijolos
  { custos: [{b: BLOCO.TIJOLO, q: 3}], saida: {b: BLOCO.VASO_FLOR, q: 1}, wb: true },
  // Grade de Ferro: 6 ferro → 16 grades
  { custos: [{i: ITEM.FERRO, q: 6}], saida: {b: BLOCO.GRADE_FERRO, q: 16}, wb: true },
  // Hopper: 5 ferro + 1 baú
  { custos: [{i: ITEM.FERRO, q: 5}, {b: BLOCO.BAU, q: 1}], saida: {b: BLOCO.HOPPER, q: 1}, wb: true },
  // Dispenser: 7 pedra + 1 arco + 1 redstone
  { custos: [{b: BLOCO.PEDRA, q: 7}, {i: ITEM.ARCO, q: 1}, {i: ITEM.REDSTONE, q: 1}], saida: {b: BLOCO.DISPENSER, q: 1}, wb: true },
  // Observer: 6 pedra + 2 redstone + 1 quartzo
  { custos: [{b: BLOCO.PEDRA, q: 6}, {i: ITEM.REDSTONE, q: 2}, {b: BLOCO.QUARTZO, q: 1}], saida: {b: BLOCO.OBSERVER, q: 1}, wb: true },
  // Tocha Redstone: 1 pau + 1 redstone
  { custos: [{i: ITEM.PAU, q: 1}, {i: ITEM.REDSTONE, q: 1}], saida: {b: BLOCO.TOCHA_REDSTONE, q: 1}, wb: false },
  // Caveira: drop do esqueleto (proxy: 4 ossos)
  { custos: [{i: ITEM.OSSO, q: 4}], saida: {b: BLOCO.CAVEIRA, q: 1}, wb: true },
  // Crânio Wither: 4 ossos + 1 carvão (proxy)
  { custos: [{i: ITEM.OSSO, q: 4}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.CRANIO_WITHER, q: 1}, wb: true },
  // Conduit: 8 prismarine + 1 nautilus shell (proxy: 8 prismarine + 1 diamante)
  { custos: [{b: BLOCO.PRISMARINE, q: 8}, {i: ITEM.DIAMANTE, q: 1}], saida: {b: BLOCO.CONDUIT, q: 1}, wb: true },
  // Heads de mob (proxy de drops raros — workbench)
  { custos: [{i: ITEM.CARVAO, q: 4}, {b: BLOCO.NETHERRACK, q: 1}], saida: {b: BLOCO.HEAD_CREEPER, q: 1}, wb: true },
  { custos: [{i: ITEM.CARNE_PODRE, q: 4}], saida: {b: BLOCO.HEAD_ZUMBI, q: 1}, wb: true },
  { custos: [{i: ITEM.ENDER_PEARL, q: 4}, {b: BLOCO.OBSIDIANA, q: 1}], saida: {b: BLOCO.HEAD_DRAGON, q: 1}, wb: true },
  // Soul Torch: 1 pau + 1 carvão + 1 soul soil
  { custos: [{i: ITEM.PAU, q: 1}, {i: ITEM.CARVAO, q: 1}, {b: BLOCO.SOUL_SOIL, q: 1}], saida: {b: BLOCO.SOUL_TORCH, q: 4}, wb: false },
  // Soul Lantern: 8 ferro + 1 soul torch
  { custos: [{i: ITEM.FERRO, q: 8}, {b: BLOCO.SOUL_TORCH, q: 1}], saida: {b: BLOCO.SOUL_LANTERN, q: 1}, wb: true },
  // Lâmpada Redstone: 4 redstone + 1 luz (glowstone)
  { custos: [{i: ITEM.REDSTONE, q: 4}, {b: BLOCO.LUZ, q: 1}], saida: {b: BLOCO.LAMPADA_RED, q: 1}, wb: true },
  // Bloco de Blaze: 9 ouro (proxy de blaze rod)
  { custos: [{i: ITEM.OURO, q: 9}], saida: {b: BLOCO.BLAZE_BLOCK, q: 1}, wb: true },
  // Lãs adicionais (proxy de corantes)
  { custos: [{b: BLOCO.LA, q: 1}, {i: ITEM.OURO, q: 1}],         saida: {b: BLOCO.LA_LARANJA, q: 1}, wb: false },
  { custos: [{b: BLOCO.LA, q: 1}, {b: BLOCO.COGUMELO_VERM, q: 1}], saida: {b: BLOCO.LA_ROSA,    q: 1}, wb: false },
  { custos: [{b: BLOCO.LA, q: 1}, {b: BLOCO.PRISMARINE, q: 1}],  saida: {b: BLOCO.LA_CIANO,   q: 1}, wb: false },
  { custos: [{b: BLOCO.LA, q: 1}, {b: BLOCO.TERRA, q: 1}],       saida: {b: BLOCO.LA_MARROM,  q: 1}, wb: false },
  { custos: [{b: BLOCO.LA, q: 1}, {i: ITEM.CARVAO, q: 1}],       saida: {b: BLOCO.LA_PRETA,   q: 1}, wb: false },
  { custos: [{b: BLOCO.LA, q: 1}, {b: BLOCO.PEDRA, q: 1}],       saida: {b: BLOCO.LA_CINZA,   q: 1}, wb: false },
  // Concretos: 4 areia + 1 lã colorida
  { custos: [{b: BLOCO.AREIA, q: 4}, {b: BLOCO.LA_VERMELHA, q: 1}], saida: {b: BLOCO.CONCRETO_R, q: 4}, wb: true },
  { custos: [{b: BLOCO.AREIA, q: 4}, {b: BLOCO.LA_AZUL, q: 1}],     saida: {b: BLOCO.CONCRETO_A, q: 4}, wb: true },
  { custos: [{b: BLOCO.AREIA, q: 4}, {b: BLOCO.LA_VERDE, q: 1}],    saida: {b: BLOCO.CONCRETO_V, q: 4}, wb: true },
  { custos: [{b: BLOCO.AREIA, q: 4}, {b: BLOCO.LA_AMARELA, q: 1}],  saida: {b: BLOCO.CONCRETO_AM, q: 4}, wb: true },
  { custos: [{b: BLOCO.AREIA, q: 4}, {b: BLOCO.LA, q: 1}],          saida: {b: BLOCO.CONCRETO_BR, q: 4}, wb: true },
  { custos: [{b: BLOCO.AREIA, q: 4}, {b: BLOCO.LA_PRETA, q: 1}],    saida: {b: BLOCO.CONCRETO_PR, q: 4}, wb: true },
  // Terracotas: 1 argila + 1 corante (proxy)
  { custos: [{b: BLOCO.ARGILA, q: 1}, {b: BLOCO.LA_VERMELHA, q: 1}], saida: {b: BLOCO.TERRACOTA_R,  q: 1}, wb: false },
  { custos: [{b: BLOCO.ARGILA, q: 1}, {b: BLOCO.LA_AZUL, q: 1}],     saida: {b: BLOCO.TERRACOTA_A,  q: 1}, wb: false },
  { custos: [{b: BLOCO.ARGILA, q: 1}, {b: BLOCO.LA_AMARELA, q: 1}],  saida: {b: BLOCO.TERRACOTA_AM, q: 1}, wb: false },
  { custos: [{b: BLOCO.ARGILA, q: 1}, {b: BLOCO.LA, q: 1}],          saida: {b: BLOCO.TERRACOTA_BR, q: 1}, wb: false },
  // Concretos adicionais
  { custos: [{b: BLOCO.AREIA, q: 4}, {b: BLOCO.LA_LARANJA, q: 1}],   saida: {b: BLOCO.CONCRETO_LR, q: 4}, wb: true },
  { custos: [{b: BLOCO.AREIA, q: 4}, {b: BLOCO.LA_ROSA, q: 1}],      saida: {b: BLOCO.CONCRETO_RS, q: 4}, wb: true },
  { custos: [{b: BLOCO.AREIA, q: 4}, {b: BLOCO.LA_CIANO, q: 1}],     saida: {b: BLOCO.CONCRETO_CN, q: 4}, wb: true },
  { custos: [{b: BLOCO.AREIA, q: 4}, {b: BLOCO.LA_MARROM, q: 1}],    saida: {b: BLOCO.CONCRETO_MR, q: 4}, wb: true },
  // Terracotas adicionais
  { custos: [{b: BLOCO.ARGILA, q: 1}, {b: BLOCO.LA_VERDE, q: 1}],    saida: {b: BLOCO.TERRACOTA_V,  q: 1}, wb: false },
  { custos: [{b: BLOCO.ARGILA, q: 1}, {b: BLOCO.LA_ROSA, q: 1}],     saida: {b: BLOCO.TERRACOTA_RX, q: 1}, wb: false },
  { custos: [{b: BLOCO.ARGILA, q: 1}, {b: BLOCO.LA_LARANJA, q: 1}],  saida: {b: BLOCO.TERRACOTA_LR, q: 1}, wb: false },
  { custos: [{b: BLOCO.ARGILA, q: 1}, {b: BLOCO.LA_PRETA, q: 1}],    saida: {b: BLOCO.TERRACOTA_PR, q: 1}, wb: false },
  // Painéis de vidro coloridos: 6 vidro colorido → 16 painéis
  { custos: [{b: BLOCO.VIDRO_VERMELHO, q: 6}], saida: {b: BLOCO.PAINEL_VIDRO_R,  q: 16}, wb: true },
  { custos: [{b: BLOCO.VIDRO_AZUL, q: 6}],     saida: {b: BLOCO.PAINEL_VIDRO_A,  q: 16}, wb: true },
  { custos: [{b: BLOCO.VIDRO_VERDE, q: 6}],    saida: {b: BLOCO.PAINEL_VIDRO_V,  q: 16}, wb: true },
  { custos: [{b: BLOCO.VIDRO_AMARELO, q: 6}],  saida: {b: BLOCO.PAINEL_VIDRO_AM, q: 16}, wb: true },
  // Glazed Terracotas: 1 terracota colorida + 1 carvão (proxy de smelt)
  { custos: [{b: BLOCO.TERRACOTA_R, q: 1},  {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.GLAZED_R,  q: 1}, wb: false },
  { custos: [{b: BLOCO.TERRACOTA_A, q: 1},  {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.GLAZED_A,  q: 1}, wb: false },
  { custos: [{b: BLOCO.TERRACOTA_V, q: 1},  {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.GLAZED_V,  q: 1}, wb: false },
  { custos: [{b: BLOCO.TERRACOTA_AM, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.GLAZED_AM, q: 1}, wb: false },
  { custos: [{b: BLOCO.TERRACOTA_LR, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.GLAZED_LR, q: 1}, wb: false },
  { custos: [{b: BLOCO.TERRACOTA_RX, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.GLAZED_RS, q: 1}, wb: false },
  { custos: [{b: BLOCO.TERRACOTA_BR, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.GLAZED_BR, q: 1}, wb: false },
  { custos: [{b: BLOCO.TERRACOTA_PR, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.GLAZED_PR, q: 1}, wb: false },
  // Lajes de pedras especiais (3 do material → 6 lajes, paridade MC)
  { custos: [{b: BLOCO.ARENITO,    q: 3}], saida: {b: BLOCO.SLAB_ARENITO,    q: 6}, wb: true },
  { custos: [{b: BLOCO.QUARTZO,    q: 3}], saida: {b: BLOCO.SLAB_QUARTZO,    q: 6}, wb: true },
  { custos: [{b: BLOCO.DEEPSLATE,  q: 3}], saida: {b: BLOCO.SLAB_DEEPSLATE,  q: 6}, wb: true },
  { custos: [{b: BLOCO.BLACKSTONE, q: 3}], saida: {b: BLOCO.SLAB_BLACKSTONE, q: 6}, wb: true },
  // Escadas adicionais (6 → 4)
  { custos: [{b: BLOCO.ARENITO, q: 6}],    saida: {b: BLOCO.ESCADA_ARENITO,    q: 4}, wb: true },
  { custos: [{b: BLOCO.QUARTZO, q: 6}],    saida: {b: BLOCO.ESCADA_QUARTZO,    q: 4}, wb: true },
  { custos: [{b: BLOCO.DEEPSLATE, q: 6}],  saida: {b: BLOCO.ESCADA_DEEPSLATE,  q: 4}, wb: true },
  { custos: [{b: BLOCO.BLACKSTONE, q: 6}], saida: {b: BLOCO.ESCADA_BLACKSTONE, q: 4}, wb: true },
  // Paredes adicionais (6 → 6)
  { custos: [{b: BLOCO.ANDESITO, q: 6}],   saida: {b: BLOCO.PAREDE_ANDESITO,   q: 6}, wb: true },
  { custos: [{b: BLOCO.BLACKSTONE, q: 6}], saida: {b: BLOCO.PAREDE_BLACKSTONE, q: 6}, wb: true },
  // Bone Block: 9 ossos
  { custos: [{i: ITEM.OSSO, q: 9}],        saida: {b: BLOCO.BONE_BLOCK, q: 1}, wb: true },
  // Rooted Dirt: 1 terra + 1 muda
  { custos: [{b: BLOCO.TERRA, q: 1}, {i: ITEM.MUDA, q: 1}], saida: {b: BLOCO.ROOTED_DIRT, q: 1}, wb: false },
  // Pedras esculpidas: 2 lajes do material → 1 chiseled (paridade MC)
  { custos: [{b: BLOCO.SLAB_PEDRA,    q: 2}], saida: {b: BLOCO.CHISELED_STONE,    q: 1}, wb: true },
  { custos: [{b: BLOCO.SLAB_QUARTZO,  q: 2}], saida: {b: BLOCO.CHISELED_QUARTZO,  q: 1}, wb: true },
  { custos: [{b: BLOCO.SLAB_DEEPSLATE,q: 2}], saida: {b: BLOCO.CHISELED_DEEPSLATE,q: 1}, wb: true },
  { custos: [{b: BLOCO.SLAB_BLACKSTONE,q: 2}], saida: {b: BLOCO.CHISELED_BLACKSTONE, q: 1}, wb: true },
  // Hyphae: 4 stems do mesmo tipo (paridade MC stripped log)
  { custos: [{b: BLOCO.CRIMSON_STEM, q: 4}], saida: {b: BLOCO.CRIMSON_HYPHAE, q: 4}, wb: true },
  { custos: [{b: BLOCO.WARPED_STEM,  q: 4}], saida: {b: BLOCO.WARPED_HYPHAE,  q: 4}, wb: true },
  // Froglights: 4 slimeballs + 1 luz (proxy de drop sapo+magma cube)
  { custos: [{i: ITEM.SLIMEBALL, q: 4}, {b: BLOCO.LUZ, q: 1}], saida: {b: BLOCO.FROGLIGHT_VERDE, q: 1}, wb: true },
  { custos: [{i: ITEM.SLIMEBALL, q: 4}, {b: BLOCO.AMETHYST, q: 1}], saida: {b: BLOCO.FROGLIGHT_ROXO, q: 1}, wb: true },
  // Melancia: 9 sementes (proxy de slice)
  { custos: [{i: ITEM.SEMENTE, q: 9}], saida: {b: BLOCO.MELANCIA, q: 1}, wb: true },
  // Melancia Dourada: 1 melancia + 8 ouro
  { custos: [{b: BLOCO.MELANCIA, q: 1}, {i: ITEM.OURO, q: 8}], saida: {b: BLOCO.MELANCIA_GLISTER, q: 1}, wb: true },
  // Girassol: 1 muda + 1 trigo + 1 flor amarela
  { custos: [{i: ITEM.MUDA, q: 1}, {i: ITEM.TRIGO, q: 1}, {b: BLOCO.FLOR_AMARELA, q: 1}], saida: {b: BLOCO.GIRASSOL, q: 1}, wb: true },
  // Abacaxi: 1 muda + 4 trigo
  { custos: [{i: ITEM.MUDA, q: 1}, {i: ITEM.TRIGO, q: 4}], saida: {b: BLOCO.ABACAXI, q: 1}, wb: true },
  // Painéis de vidro adicionais (6 vidro padrão + 1 corante → 16 painéis)
  // Aqui simplifico: usa lã colorida pra fornecer cor + 6 vidro normal
  { custos: [{b: BLOCO.VIDRO, q: 6}, {b: BLOCO.LA_LARANJA, q: 1}], saida: {b: BLOCO.PAINEL_VIDRO_LR, q: 16}, wb: true },
  { custos: [{b: BLOCO.VIDRO, q: 6}, {b: BLOCO.LA_ROSA, q: 1}],    saida: {b: BLOCO.PAINEL_VIDRO_RS, q: 16}, wb: true },
  { custos: [{b: BLOCO.VIDRO, q: 6}, {b: BLOCO.LA_CIANO, q: 1}],   saida: {b: BLOCO.PAINEL_VIDRO_CN, q: 16}, wb: true },
  { custos: [{b: BLOCO.VIDRO, q: 6}, {b: BLOCO.LA, q: 1}],         saida: {b: BLOCO.PAINEL_VIDRO_BR, q: 16}, wb: true },
  { custos: [{b: BLOCO.VIDRO, q: 6}, {b: BLOCO.LA_PRETA, q: 1}],   saida: {b: BLOCO.PAINEL_VIDRO_PR, q: 16}, wb: true },
  { custos: [{b: BLOCO.VIDRO, q: 6}, {b: BLOCO.LA_CINZA, q: 1}],   saida: {b: BLOCO.PAINEL_VIDRO_CZ, q: 16}, wb: true },
  // Bloco de Bambu: 9 bambus
  { custos: [{b: BLOCO.BAMBU, q: 9}], saida: {b: BLOCO.BAMBU_BLOCO, q: 1}, wb: true },
  // Bloco de Cacto: 9 cactos
  { custos: [{b: BLOCO.CACTO, q: 9}], saida: {b: BLOCO.CACTO_BLOCO, q: 1}, wb: true },
  // 4 escadas adicionais (6 → 4)
  { custos: [{b: BLOCO.COBRE, q: 6}],          saida: {b: BLOCO.ESCADA_COBRE,    q: 4}, wb: true },
  { custos: [{b: BLOCO.TIJOLO_NETHER, q: 6}],  saida: {b: BLOCO.ESCADA_NETHER,   q: 4}, wb: true },
  { custos: [{b: BLOCO.PAVIMENTO, q: 6}],      saida: {b: BLOCO.ESCADA_PAVIMENTO,q: 4}, wb: true },
  { custos: [{b: BLOCO.TIJOLO_LAMA, q: 6}],    saida: {b: BLOCO.ESCADA_LAMA,     q: 4}, wb: true },
  // 2 paredes adicionais (6 → 6)
  { custos: [{b: BLOCO.ARENITO, q: 6}],     saida: {b: BLOCO.PAREDE_ARENITO, q: 6}, wb: true },
  { custos: [{b: BLOCO.TIJOLO_LAMA, q: 6}], saida: {b: BLOCO.PAREDE_LAMA,    q: 6}, wb: true },
  // 2 lajes adicionais (3 → 6)
  { custos: [{b: BLOCO.PAVIMENTO, q: 3}],   saida: {b: BLOCO.SLAB_PAVIMENTO, q: 6}, wb: true },
  { custos: [{b: BLOCO.CALCITE, q: 3}],     saida: {b: BLOCO.SLAB_CALCITE,   q: 6}, wb: true },
  // 4 escadas pedras naturais (6 → 4)
  { custos: [{b: BLOCO.GRANITO, q: 6}],    saida: {b: BLOCO.ESCADA_GRANITO,    q: 4}, wb: true },
  { custos: [{b: BLOCO.DIORITO, q: 6}],    saida: {b: BLOCO.ESCADA_DIORITO,    q: 4}, wb: true },
  { custos: [{b: BLOCO.ANDESITO, q: 6}],   saida: {b: BLOCO.ESCADA_ANDESITO,   q: 4}, wb: true },
  { custos: [{b: BLOCO.PRISMARINE, q: 6}], saida: {b: BLOCO.ESCADA_PRISMARINE, q: 4}, wb: true },
  // 2 paredes pedras naturais (6 → 6)
  { custos: [{b: BLOCO.GRANITO, q: 6}],    saida: {b: BLOCO.PAREDE_GRANITO, q: 6}, wb: true },
  { custos: [{b: BLOCO.DIORITO, q: 6}],    saida: {b: BLOCO.PAREDE_DIORITO, q: 6}, wb: true },
  // 2 lajes pedras naturais (3 → 6)
  { custos: [{b: BLOCO.GRANITO, q: 3}],    saida: {b: BLOCO.SLAB_GRANITO, q: 6}, wb: true },
  { custos: [{b: BLOCO.DIORITO, q: 3}],    saida: {b: BLOCO.SLAB_DIORITO, q: 6}, wb: true },
  // 4 escadas polidas (6 → 4)
  { custos: [{b: BLOCO.GRANITO_POL, q: 6}],  saida: {b: BLOCO.ESCADA_GRANITO_POL,  q: 4}, wb: true },
  { custos: [{b: BLOCO.DIORITO_POL, q: 6}],  saida: {b: BLOCO.ESCADA_DIORITO_POL,  q: 4}, wb: true },
  { custos: [{b: BLOCO.ANDESITO_POL, q: 6}], saida: {b: BLOCO.ESCADA_ANDESITO_POL, q: 4}, wb: true },
  { custos: [{b: BLOCO.PEDRA_LISA, q: 6}],   saida: {b: BLOCO.ESCADA_PEDRA_LISA,   q: 4}, wb: true },
  // 2 paredes polidas (6 → 6)
  { custos: [{b: BLOCO.ANDESITO_POL, q: 6}],   saida: {b: BLOCO.PAREDE_ANDESITO_POL,   q: 6}, wb: true },
  { custos: [{b: BLOCO.BLACKSTONE_POL, q: 6}], saida: {b: BLOCO.PAREDE_BLACKSTONE_POL, q: 6}, wb: true },
  // 2 lajes polidas (3 → 6)
  { custos: [{b: BLOCO.ANDESITO_POL, q: 3}],   saida: {b: BLOCO.SLAB_ANDESITO_POL,   q: 6}, wb: true },
  { custos: [{b: BLOCO.BLACKSTONE_POL, q: 3}], saida: {b: BLOCO.SLAB_BLACKSTONE_POL, q: 6}, wb: true },
  // 4 escadas (6 → 4)
  { custos: [{b: BLOCO.END_BRICK, q: 6}],     saida: {b: BLOCO.ESCADA_END_BRICK,    q: 4}, wb: true },
  { custos: [{b: BLOCO.PURPUR_BLOCK, q: 6}],  saida: {b: BLOCO.ESCADA_PURPUR,       q: 4}, wb: true },
  { custos: [{b: BLOCO.NETHER_CORTADO, q: 6}], saida: {b: BLOCO.ESCADA_NETHER_BRICK, q: 4}, wb: true },
  { custos: [{b: BLOCO.TIJOLO_MUSGO, q: 6}],  saida: {b: BLOCO.ESCADA_MUSGO,        q: 4}, wb: true },
  // 2 paredes (6 → 6)
  { custos: [{b: BLOCO.END_BRICK, q: 6}],      saida: {b: BLOCO.PAREDE_END_BRICK, q: 6}, wb: true },
  { custos: [{b: BLOCO.NETHER_CORTADO, q: 6}], saida: {b: BLOCO.PAREDE_NETHER_BRICK, q: 6}, wb: true },
  // 2 lajes (3 → 6)
  { custos: [{b: BLOCO.END_BRICK, q: 3}],      saida: {b: BLOCO.SLAB_END_BRICK, q: 6}, wb: true },
  { custos: [{b: BLOCO.PURPUR_BLOCK, q: 3}],   saida: {b: BLOCO.SLAB_PURPUR,    q: 6}, wb: true },
  // 4 escadas (6 → 4)
  { custos: [{b: BLOCO.DEEPSLATE_PAV, q: 6}],  saida: {b: BLOCO.ESCADA_DEEPSLATE_PAV, q: 4}, wb: true },
  { custos: [{b: BLOCO.DEEPSLATE_POL, q: 6}],  saida: {b: BLOCO.ESCADA_DEEPSLATE_POL, q: 4}, wb: true },
  { custos: [{b: BLOCO.OBSIDIANA, q: 6}],      saida: {b: BLOCO.ESCADA_OBSIDIANA,     q: 4}, wb: true },
  { custos: [{b: BLOCO.BASALTO, q: 6}],        saida: {b: BLOCO.ESCADA_BASALTO,       q: 4}, wb: true },
  // 2 paredes (6 → 6)
  { custos: [{b: BLOCO.DEEPSLATE_POL, q: 6}],  saida: {b: BLOCO.PAREDE_DEEPSLATE_POL, q: 6}, wb: true },
  { custos: [{b: BLOCO.BASALTO, q: 6}],        saida: {b: BLOCO.PAREDE_BASALTO,       q: 6}, wb: true },
  // 2 lajes (3 → 6)
  { custos: [{b: BLOCO.DEEPSLATE_PAV, q: 3}],  saida: {b: BLOCO.SLAB_DEEPSLATE_PAV,   q: 6}, wb: true },
  { custos: [{b: BLOCO.BASALTO, q: 3}],        saida: {b: BLOCO.SLAB_BASALTO,         q: 6}, wb: true },
  // 4 escadas (6 → 4)
  { custos: [{b: BLOCO.CRIMSON_PLANKS, q: 6}], saida: {b: BLOCO.ESCADA_CRIMSON,     q: 4}, wb: true },
  { custos: [{b: BLOCO.WARPED_PLANKS, q: 6}],  saida: {b: BLOCO.ESCADA_WARPED,      q: 4}, wb: true },
  { custos: [{b: BLOCO.BAMBU_BLOCO, q: 6}],    saida: {b: BLOCO.ESCADA_BAMBU,       q: 4}, wb: true },
  { custos: [{b: BLOCO.COBRE_GASTO, q: 6}],    saida: {b: BLOCO.ESCADA_COBRE_GASTO, q: 4}, wb: true },
  // 2 paredes (6 → 6)
  { custos: [{b: BLOCO.COBRE, q: 6}],          saida: {b: BLOCO.PAREDE_COBRE,         q: 6}, wb: true },
  { custos: [{b: BLOCO.COBRE_OXIDADO, q: 6}],  saida: {b: BLOCO.PAREDE_COBRE_OXIDADO, q: 6}, wb: true },
  // 2 lajes (3 → 6)
  { custos: [{b: BLOCO.CRIMSON_PLANKS, q: 3}], saida: {b: BLOCO.SLAB_CRIMSON, q: 6}, wb: true },
  { custos: [{b: BLOCO.WARPED_PLANKS, q: 3}],  saida: {b: BLOCO.SLAB_WARPED,  q: 6}, wb: true },
  // 4 escadas concreto (6 → 4)
  { custos: [{b: BLOCO.CONCRETO_R, q: 6}],     saida: {b: BLOCO.ESCADA_CONCRETO_R,  q: 4}, wb: true },
  { custos: [{b: BLOCO.CONCRETO_A, q: 6}],     saida: {b: BLOCO.ESCADA_CONCRETO_A,  q: 4}, wb: true },
  { custos: [{b: BLOCO.CONCRETO_V, q: 6}],     saida: {b: BLOCO.ESCADA_CONCRETO_V,  q: 4}, wb: true },
  { custos: [{b: BLOCO.CONCRETO_BR, q: 6}],    saida: {b: BLOCO.ESCADA_CONCRETO_BR, q: 4}, wb: true },
  // 2 paredes concreto (6 → 6)
  { custos: [{b: BLOCO.CONCRETO_R, q: 6}],     saida: {b: BLOCO.PAREDE_CONCRETO_R,  q: 6}, wb: true },
  { custos: [{b: BLOCO.CONCRETO_PR, q: 6}],    saida: {b: BLOCO.PAREDE_CONCRETO_PR, q: 6}, wb: true },
  // 2 lajes concreto (3 → 6)
  { custos: [{b: BLOCO.CONCRETO_R, q: 3}],     saida: {b: BLOCO.SLAB_CONCRETO_R,    q: 6}, wb: true },
  { custos: [{b: BLOCO.CONCRETO_A, q: 3}],     saida: {b: BLOCO.SLAB_CONCRETO_A,    q: 6}, wb: true },
  // Cobre cortado: 4 cobre → 4 cortado
  { custos: [{b: BLOCO.COBRE, q: 4}],          saida: {b: BLOCO.COBRE_CORTADO, q: 4}, wb: true },
  { custos: [{b: BLOCO.COBRE_GASTO, q: 4}],    saida: {b: BLOCO.COBRE_GASTO_CORTADO, q: 4}, wb: true },
  { custos: [{b: BLOCO.COBRE_OXIDADO, q: 4}],  saida: {b: BLOCO.COBRE_OXIDADO_CORTADO, q: 4}, wb: true },
  // Cobre liso (smelt 1 cobre + 1 carvão)
  { custos: [{b: BLOCO.COBRE, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {b: BLOCO.COBRE_LISO, q: 1}, wb: false },
  // Variantes purpur (6/3 → 4/6)
  { custos: [{b: BLOCO.PURPUR_PILLAR, q: 6}], saida: {b: BLOCO.ESCADA_PURPUR_PILLAR, q: 4}, wb: true },
  { custos: [{b: BLOCO.PURPUR_BLOCK, q: 6}],  saida: {b: BLOCO.PAREDE_PURPUR, q: 6}, wb: true },
  { custos: [{b: BLOCO.PURPUR_PILLAR, q: 3}], saida: {b: BLOCO.SLAB_PURPUR_PILLAR, q: 6}, wb: true },
  { custos: [{b: BLOCO.PURPUR_BLOCK, q: 4}, {i: ITEM.LAPIS, q: 1}], saida: {b: BLOCO.PURPUR_LIMPO, q: 4}, wb: true },
  // Workstations (paridade Minecraft)
  { custos: [{i: ITEM.FERRO, q: 2}, {i: ITEM.PRANCHAS, q: 4}], saida: {b: BLOCO.SMITHING_TABLE, q: 1}, wb: true },
  { custos: [{i: ITEM.BLAZE_ROD, q: 1}, {b: BLOCO.PEDRA, q: 3}], saida: {b: BLOCO.BREWING_STAND, q: 1}, wb: true },
  { custos: [{b: BLOCO.FORNALHA, q: 1}, {i: ITEM.FERRO, q: 5}, {b: BLOCO.PEDRA, q: 3}], saida: {b: BLOCO.BLAST_FURNACE, q: 1}, wb: true },
  { custos: [{b: BLOCO.FORNALHA, q: 1}, {i: ITEM.PRANCHAS, q: 4}], saida: {b: BLOCO.SMOKER, q: 1}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 4}, {i: ITEM.LIVRO, q: 2}], saida: {b: BLOCO.CARTOGRAPHY, q: 1}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 4}, {i: ITEM.SILEX, q: 2}], saida: {b: BLOCO.FLETCHING, q: 1}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 2}, {b: BLOCO.LA, q: 2}], saida: {b: BLOCO.LOOM, q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 1}, {b: BLOCO.PEDRA, q: 3}], saida: {b: BLOCO.STONECUTTER, q: 1}, wb: true },
  // Novos blocos especiais
  { custos: [{b: BLOCO.LA, q: 4}, {i: ITEM.REDSTONE, q: 4}, {b: BLOCO.LA_VERMELHA, q: 1}], saida: {b: BLOCO.TARGET_BLOCK, q: 1}, wb: true },
  { custos: [{b: BLOCO.NETHERRACK, q: 8}, {i: ITEM.DIAMANTE, q: 1}], saida: {b: BLOCO.ANCIENT_DEBRIS, q: 1}, wb: true },
  { custos: [{i: ITEM.FAVO_MEL, q: 4}], saida: {b: BLOCO.HONEYCOMB_BLOCK, q: 1}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 4}, {i: ITEM.PAU, q: 3}], saida: {b: BLOCO.COMPOSTER, q: 1}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 4}, {b: BLOCO.ESTANTE, q: 1}], saida: {b: BLOCO.LECTERN, q: 1}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 6}, {b: BLOCO.SLAB_MADEIRA, q: 2}], saida: {b: BLOCO.BARREL, q: 1}, wb: true },
  { custos: [{i: ITEM.PAU, q: 3}, {i: ITEM.CARVAO, q: 1}, {i: ITEM.PRANCHAS, q: 3}], saida: {b: BLOCO.CAMPFIRE, q: 1}, wb: true },
  { custos: [{b: BLOCO.LA_VERDE, q: 9}], saida: {b: BLOCO.DRIED_KELP_BLOCK, q: 1}, wb: true },
  // Mais 8 blocos especiais
  { custos: [{b: BLOCO.ESTANTE, q: 4}, {b: BLOCO.SLAB_MADEIRA, q: 2}], saida: {b: BLOCO.BOOKSHELF_CHISELED, q: 1}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 8}, {i: ITEM.DIAMANTE, q: 1}], saida: {b: BLOCO.JUKEBOX, q: 1}, wb: true },
  { custos: [{i: ITEM.BLAZE_ROD, q: 1}, {i: ITEM.PE_COELHO, q: 1}, {b: BLOCO.LUZ, q: 1}], saida: {b: BLOCO.END_ROD, q: 4}, wb: true },
  { custos: [{i: ITEM.GLOWSTONE_DUST, q: 4}, {i: ITEM.NETHER_STAR, q: 1}], saida: {b: BLOCO.LIGHT_BLOCK, q: 4}, wb: true },
  { custos: [{b: BLOCO.SLAB_MADEIRA, q: 3}, {b: BLOCO.LUZ, q: 1}, {i: ITEM.QUARTZO_BRUTO, q: 3}], saida: {b: BLOCO.DAYLIGHT_DETECTOR, q: 1}, wb: true },
  { custos: [{i: ITEM.PRANCHAS, q: 8}, {i: ITEM.REDSTONE, q: 1}], saida: {b: BLOCO.NOTE_BLOCK, q: 1}, wb: true },
  { custos: [{b: BLOCO.BLOCO_OURO, q: 1}, {b: BLOCO.OBSIDIANA, q: 4}], saida: {b: BLOCO.BELL, q: 1}, wb: true },
  { custos: [{i: ITEM.SLIMEBALL, q: 4}], saida: {b: BLOCO.SEA_PICKLE, q: 4}, wb: true },
  // 4 Blocos especiais novos
  { custos: [{b: BLOCO.OBSIDIANA, q: 8}, {i: ITEM.ENDER_PEARL, q: 1}], saida: {b: BLOCO.ENDER_CHEST, q: 1}, wb: true },
  { custos: [{b: BLOCO.BAU, q: 1}, {b: BLOCO.PURPUR_BLOCK, q: 2}], saida: {b: BLOCO.SHULKER_BOX, q: 1}, wb: true },
  { custos: [{b: BLOCO.BIGORNA, q: 1}, {i: ITEM.CARVAO, q: 4}], saida: {b: BLOCO.ANVIL_DAMAGED, q: 1}, wb: true },
  { custos: [{i: ITEM.TIGELA, q: 4}, {i: ITEM.LAPIS, q: 1}], saida: {b: BLOCO.DECORATED_POT, q: 1}, wb: true },
  // 4 Variantes Prismarine
  { custos: [{b: BLOCO.PRISMARINE_BRK, q: 6}], saida: {b: BLOCO.ESCADA_PRISMARINE_BRK, q: 4}, wb: true },
  { custos: [{b: BLOCO.PRISMARINE, q: 3}],     saida: {b: BLOCO.SLAB_PRISMARINE,       q: 6}, wb: true },
  { custos: [{b: BLOCO.PRISMARINE_BRK, q: 3}], saida: {b: BLOCO.SLAB_PRISMARINE_BRK,   q: 6}, wb: true },
  { custos: [{b: BLOCO.PRISMARINE, q: 6}],     saida: {b: BLOCO.PAREDE_PRISMARINE,     q: 6}, wb: true },
  // 4 Shulker coloridos: 1 shulker base + 1 lã colorida
  { custos: [{b: BLOCO.SHULKER_BOX, q: 1}, {b: BLOCO.LA_VERMELHA, q: 1}], saida: {b: BLOCO.SHULKER_R,  q: 1}, wb: true },
  { custos: [{b: BLOCO.SHULKER_BOX, q: 1}, {b: BLOCO.LA_AZUL, q: 1}],     saida: {b: BLOCO.SHULKER_A,  q: 1}, wb: true },
  { custos: [{b: BLOCO.SHULKER_BOX, q: 1}, {b: BLOCO.LA_VERDE, q: 1}],    saida: {b: BLOCO.SHULKER_V,  q: 1}, wb: true },
  { custos: [{b: BLOCO.SHULKER_BOX, q: 1}, {b: BLOCO.LA_AMARELA, q: 1}],  saida: {b: BLOCO.SHULKER_AM, q: 1}, wb: true },
  // 4 Variantes Arenito Liso/Cortado
  { custos: [{b: BLOCO.ARENITO_LISO, q: 6}],    saida: {b: BLOCO.ESCADA_ARENITO_LISO, q: 4}, wb: true },
  { custos: [{b: BLOCO.ARENITO_LISO, q: 3}],    saida: {b: BLOCO.SLAB_ARENITO_LISO,   q: 6}, wb: true },
  { custos: [{b: BLOCO.ARENITO_LISO, q: 6}],    saida: {b: BLOCO.PAREDE_ARENITO_LISO, q: 6}, wb: true },
  { custos: [{b: BLOCO.ARENITO_CORTADO, q: 6}], saida: {b: BLOCO.ESCADA_ARENITO_CORT, q: 4}, wb: true },
  // 4 Shulker novas cores
  { custos: [{b: BLOCO.SHULKER_BOX, q: 1}, {b: BLOCO.LA, q: 1}],          saida: {b: BLOCO.SHULKER_BR, q: 1}, wb: true },
  { custos: [{b: BLOCO.SHULKER_BOX, q: 1}, {b: BLOCO.LA_PRETA, q: 1}],    saida: {b: BLOCO.SHULKER_PR, q: 1}, wb: true },
  { custos: [{b: BLOCO.SHULKER_BOX, q: 1}, {b: BLOCO.LA_LARANJA, q: 1}],  saida: {b: BLOCO.SHULKER_LR, q: 1}, wb: true },
  { custos: [{b: BLOCO.SHULKER_BOX, q: 1}, {b: BLOCO.LA_ROSA, q: 1}],     saida: {b: BLOCO.SHULKER_RS, q: 1}, wb: true },
  // 4 Variantes Terracota Vermelha + Azul
  { custos: [{b: BLOCO.TERRACOTA_R, q: 6}], saida: {b: BLOCO.ESCADA_TERRACOTA_R, q: 4}, wb: true },
  { custos: [{b: BLOCO.TERRACOTA_R, q: 3}], saida: {b: BLOCO.SLAB_TERRACOTA_R,   q: 6}, wb: true },
  { custos: [{b: BLOCO.TERRACOTA_R, q: 6}], saida: {b: BLOCO.PAREDE_TERRACOTA_R, q: 6}, wb: true },
  { custos: [{b: BLOCO.TERRACOTA_A, q: 6}], saida: {b: BLOCO.ESCADA_TERRACOTA_A, q: 4}, wb: true },
  // Variantes Nether brick
  { custos: [{b: BLOCO.TIJOLO_NETHER, q: 3}], saida: {b: BLOCO.SLAB_NETHER, q: 6}, wb: true },
  { custos: [{b: BLOCO.TIJOLO_NETHER, q: 6}], saida: {b: BLOCO.PAREDE_NETHER, q: 6}, wb: true },
  // 6 Variantes Glazed
  { custos: [{b: BLOCO.GLAZED_R, q: 6}], saida: {b: BLOCO.ESCADA_GLAZED_R, q: 4}, wb: true },
  { custos: [{b: BLOCO.GLAZED_R, q: 3}], saida: {b: BLOCO.SLAB_GLAZED_R, q: 6}, wb: true },
  { custos: [{b: BLOCO.GLAZED_A, q: 6}], saida: {b: BLOCO.ESCADA_GLAZED_A, q: 4}, wb: true },
  { custos: [{b: BLOCO.GLAZED_A, q: 3}], saida: {b: BLOCO.SLAB_GLAZED_A, q: 6}, wb: true },
  { custos: [{b: BLOCO.GLAZED_V, q: 6}], saida: {b: BLOCO.ESCADA_GLAZED_V, q: 4}, wb: true },
  { custos: [{b: BLOCO.GLAZED_AM, q: 6}], saida: {b: BLOCO.ESCADA_GLAZED_AM, q: 4}, wb: true },
  // Variantes Bambu
  { custos: [{b: BLOCO.BAMBU_BLOCO, q: 3}], saida: {b: BLOCO.SLAB_BAMBU, q: 6}, wb: true },
  { custos: [{b: BLOCO.BAMBU_BLOCO, q: 6}], saida: {b: BLOCO.PAREDE_BAMBU, q: 6}, wb: true },
  // Variantes Dried Kelp
  { custos: [{b: BLOCO.DRIED_KELP_BLOCK, q: 6}], saida: {b: BLOCO.ESCADA_DRIED_KELP, q: 4}, wb: true },
  { custos: [{b: BLOCO.DRIED_KELP_BLOCK, q: 3}], saida: {b: BLOCO.SLAB_DRIED_KELP, q: 6}, wb: true },
  // Variantes Quartzo Polido + Parede
  { custos: [{b: BLOCO.QUARTZO_POLIDO, q: 6}], saida: {b: BLOCO.ESCADA_QUARTZO_POL, q: 4}, wb: true },
  { custos: [{b: BLOCO.QUARTZO_POLIDO, q: 3}], saida: {b: BLOCO.SLAB_QUARTZO_POL, q: 6}, wb: true },
  { custos: [{b: BLOCO.QUARTZO, q: 6}],         saida: {b: BLOCO.PAREDE_QUARTZO, q: 6}, wb: true },
  // Escada Bloco Ouro
  { custos: [{b: BLOCO.BLOCO_OURO, q: 6}], saida: {b: BLOCO.ESCADA_BLOCO_OURO, q: 4}, wb: true },
  // Command Block: receita endgame (1 nether star + 4 obsidiana + 4 redstone)
  { custos: [{i: ITEM.NETHER_STAR, q: 1}, {b: BLOCO.OBSIDIANA, q: 4}, {i: ITEM.REDSTONE, q: 4}], saida: {b: BLOCO.COMMAND_BLOCK, q: 1}, wb: true },
  // Escadas/lajes de blocos compactados premium
  { custos: [{b: BLOCO.BLOCO_FERRO, q: 6}],     saida: {b: BLOCO.ESCADA_BLOCO_FERRO, q: 4}, wb: true },
  { custos: [{b: BLOCO.BLOCO_FERRO, q: 3}],     saida: {b: BLOCO.SLAB_BLOCO_FERRO, q: 6}, wb: true },
  { custos: [{b: BLOCO.BLOCO_DIAMANTE, q: 6}],  saida: {b: BLOCO.ESCADA_BLOCO_DIAMANTE, q: 4}, wb: true },
  { custos: [{b: BLOCO.BLOCO_DIAMANTE, q: 3}],  saida: {b: BLOCO.SLAB_BLOCO_DIAMANTE, q: 6}, wb: true },
  { custos: [{b: BLOCO.BLOCO_LAPIS, q: 6}],     saida: {b: BLOCO.ESCADA_BLOCO_LAPIS, q: 4}, wb: true },
  { custos: [{b: BLOCO.BLOCO_LAPIS, q: 3}],     saida: {b: BLOCO.SLAB_BLOCO_LAPIS, q: 6}, wb: true },
  { custos: [{b: BLOCO.BLOCO_REDSTONE, q: 6}],  saida: {b: BLOCO.ESCADA_BLOCO_REDSTONE, q: 4}, wb: true },
  // Sprint paridade Minecraft (407-414)
  { custos: [{b: BLOCO.CRYING_OBSIDIAN, q: 6}, {b: BLOCO.LUZ, q: 3}], saida: {b: BLOCO.RESPAWN_ANCHOR, q: 1}, wb: true },
  { custos: [{b: BLOCO.DEEPSLATE_POL, q: 8}, {i: ITEM.NETHER_STAR, q: 1}], saida: {b: BLOCO.LODESTONE, q: 1}, wb: true },
  { custos: [{b: BLOCO.DEEPSLATE, q: 4}, {i: ITEM.DIAMANTE, q: 4}, {b: BLOCO.OBSIDIANA, q: 1}], saida: {b: BLOCO.REINFORCED_DS, q: 1}, wb: true },
  { custos: [{b: BLOCO.GRAMA, q: 4}, {b: BLOCO.FOLHA, q: 4}], saida: {b: BLOCO.MOSS_BLOCK, q: 4}, wb: true },
  { custos: [{b: BLOCO.MOSS_BLOCK, q: 3}], saida: {b: BLOCO.MOSS_CARPET, q: 6}, wb: true },
  { custos: [{b: BLOCO.MOSS_BLOCK, q: 2}, {b: BLOCO.LILY_PAD, q: 1}], saida: {b: BLOCO.BIG_DRIPLEAF, q: 2}, wb: true },
  { custos: [{b: BLOCO.END_STONE, q: 4}, {i: ITEM.ENDER_PEARL, q: 1}], saida: {b: BLOCO.CHORUS_FLOWER, q: 1}, wb: true },
  { custos: [{b: BLOCO.MADEIRA, q: 3}, {b: BLOCO.PEDRA, q: 4}, {i: ITEM.FERRO, q: 1}, {i: ITEM.REDSTONE, q: 1}], saida: {b: BLOCO.PISTON, q: 1}, wb: true },
  // Sprint redstone + madeiras 1.20+ (415-422)
  { custos: [{b: BLOCO.PISTON, q: 1}, {i: ITEM.SLIMEBALL, q: 1}], saida: {b: BLOCO.STICKY_PISTON, q: 1}, wb: true },
  { custos: [{b: BLOCO.PEDRA, q: 3}, {b: BLOCO.TOCHA_REDSTONE, q: 2}, {i: ITEM.REDSTONE, q: 1}], saida: {b: BLOCO.REPEATER, q: 1}, wb: true },
  { custos: [{b: BLOCO.PEDRA, q: 3}, {b: BLOCO.TOCHA_REDSTONE, q: 3}, {b: BLOCO.QUARTZO, q: 1}], saida: {b: BLOCO.COMPARATOR, q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 5}, {b: BLOCO.WORKBENCH, q: 1}, {b: BLOCO.DROPPER || BLOCO.DISPENSER, q: 1}, {i: ITEM.REDSTONE, q: 2}], saida: {b: BLOCO.CRAFTER, q: 1}, wb: true },
  { custos: [{b: BLOCO.BAU, q: 1}, {i: ITEM.CORDA, q: 1}], saida: {b: BLOCO.TRAPPED_CHEST, q: 1}, wb: true },
  { custos: [{b: BLOCO.MANGROVE_LOG, q: 1}], saida: {b: BLOCO.MANGROVE_PRANCHA, q: 4} },
  { custos: [{b: BLOCO.TERRA, q: 4}, {b: BLOCO.LAMA, q: 1}], saida: {b: BLOCO.MANGROVE_LOG, q: 1}, wb: true },
  { custos: [{b: BLOCO.MADEIRA, q: 4}, {b: BLOCO.FLOR_VERMELHA, q: 1}], saida: {b: BLOCO.CHERRY_LOG, q: 1}, wb: true },
  // Sprint 4: madeiras+plantas 1.20+ (423-430)
  { custos: [{b: BLOCO.CHERRY_LOG, q: 1}], saida: {b: BLOCO.CHERRY_PRANCHA, q: 4} },
  { custos: [{b: BLOCO.FOLHA, q: 4}, {b: BLOCO.FLOR_VERMELHA, q: 1}], saida: {b: BLOCO.CHERRY_FOLHA, q: 4}, wb: true },
  { custos: [{b: BLOCO.FOLHA, q: 4}, {b: BLOCO.LAMA, q: 1}], saida: {b: BLOCO.MANGROVE_FOLHA, q: 4}, wb: true },
  { custos: [{b: BLOCO.MANGROVE_LOG, q: 2}], saida: {b: BLOCO.MANGROVE_RAIZ, q: 4}, wb: true },
  { custos: [{b: BLOCO.FOLHA, q: 2}, {b: BLOCO.GRAMA, q: 1}], saida: {b: BLOCO.AZALEA, q: 1}, wb: true },
  { custos: [{b: BLOCO.AZALEA, q: 1}, {b: BLOCO.FLOR_VERMELHA, q: 1}], saida: {b: BLOCO.AZALEA_FLOWER, q: 1}, wb: true },
  { custos: [{b: BLOCO.CHERRY_FOLHA, q: 1}], saida: {b: BLOCO.PINK_PETALS, q: 4} },
  { custos: [{b: BLOCO.CACTO, q: 1}, {b: BLOCO.FLOR_AMARELA, q: 1}], saida: {b: BLOCO.CACTUS_FLOWER, q: 1}, wb: true },
  // Sprint 5: Nether plants + cipós + andaime (431-438)
  { custos: [{b: BLOCO.BAMBU_BLOCO, q: 4}], saida: {b: BLOCO.BAMBOO_MOSAIC, q: 4}, wb: true },
  { custos: [{b: BLOCO.NETHERRACK, q: 1}, {b: BLOCO.CRIMSON_STEM, q: 1}], saida: {b: BLOCO.CRIMSON_ROOTS, q: 4}, wb: true },
  { custos: [{b: BLOCO.NETHERRACK, q: 1}, {b: BLOCO.WARPED_STEM, q: 1}], saida: {b: BLOCO.WARPED_ROOTS, q: 4}, wb: true },
  { custos: [{b: BLOCO.GELO, q: 1}, {b: BLOCO.LUZ, q: 1}], saida: {b: BLOCO.FROSTED_ICE, q: 1}, wb: true },
  { custos: [{b: BLOCO.FOLHA, q: 4}], saida: {b: BLOCO.VINE, q: 8}, wb: true },
  { custos: [{b: BLOCO.WARPED_STEM, q: 2}, {i: ITEM.ENDER_PEARL, q: 1}], saida: {b: BLOCO.TWISTING_VINES, q: 4}, wb: true },
  { custos: [{b: BLOCO.CRIMSON_STEM, q: 2}, {b: BLOCO.SOUL_SAND, q: 1}], saida: {b: BLOCO.WEEPING_VINES, q: 4}, wb: true },
  { custos: [{b: BLOCO.BAMBU, q: 6}, {i: ITEM.CORDA, q: 1}], saida: {b: BLOCO.SCAFFOLDING, q: 6}, wb: true },
  // Machados (3 do material + 2 paus)
  { custos: [{i: ITEM.PRANCHAS, q: 3}, {i: ITEM.PAU, q: 2}], saida: {i: ITEM.MACHADO_MADEIRA,  q: 1}, wb: true },
  { custos: [{b: BLOCO.PEDRA, q: 3},   {i: ITEM.PAU, q: 2}], saida: {i: ITEM.MACHADO_PEDRA,    q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 3},    {i: ITEM.PAU, q: 2}], saida: {i: ITEM.MACHADO_FERRO,    q: 1}, wb: true },
  { custos: [{i: ITEM.DIAMANTE, q: 3}, {i: ITEM.PAU, q: 2}], saida: {i: ITEM.MACHADO_DIAMANTE, q: 1}, wb: true },
  // Pás (1 do material + 2 paus)
  { custos: [{i: ITEM.PRANCHAS, q: 1}, {i: ITEM.PAU, q: 2}], saida: {i: ITEM.PA_MADEIRA,  q: 1}, wb: true },
  { custos: [{b: BLOCO.PEDRA, q: 1},   {i: ITEM.PAU, q: 2}], saida: {i: ITEM.PA_PEDRA,    q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 1},    {i: ITEM.PAU, q: 2}], saida: {i: ITEM.PA_FERRO,    q: 1}, wb: true },
  { custos: [{i: ITEM.DIAMANTE, q: 1}, {i: ITEM.PAU, q: 2}], saida: {i: ITEM.PA_DIAMANTE, q: 1}, wb: true },
  // Enxadas (2 do material + 2 paus)
  { custos: [{i: ITEM.PRANCHAS, q: 2}, {i: ITEM.PAU, q: 2}], saida: {i: ITEM.ENXADA_MADEIRA,  q: 1}, wb: true },
  { custos: [{b: BLOCO.PEDRA, q: 2},   {i: ITEM.PAU, q: 2}], saida: {i: ITEM.ENXADA_PEDRA,    q: 1}, wb: true },
  { custos: [{i: ITEM.FERRO, q: 2},    {i: ITEM.PAU, q: 2}], saida: {i: ITEM.ENXADA_FERRO,    q: 1}, wb: true },
  { custos: [{i: ITEM.DIAMANTE, q: 2}, {i: ITEM.PAU, q: 2}], saida: {i: ITEM.ENXADA_DIAMANTE, q: 1}, wb: true },
  // Utilitários
  { custos: [{i: ITEM.FERRO, q: 2}], saida: {i: ITEM.TESOURA, q: 1}, wb: true },
  { custos: [{i: ITEM.COURO, q: 5}, {i: ITEM.FERRO, q: 1}], saida: {i: ITEM.SELA, q: 1}, wb: true },
  { custos: [{i: ITEM.PAU, q: 4}, {b: BLOCO.LA, q: 4}], saida: {i: ITEM.CORDA, q: 2}, wb: true },
  { custos: [{i: ITEM.OURO, q: 4}, {i: ITEM.REDSTONE, q: 1}], saida: {i: ITEM.RELOGIO, q: 1}, wb: true },
  { custos: [{i: ITEM.DIAMANTE, q: 4}, {i: ITEM.LAPIS, q: 1}], saida: {i: ITEM.ESPELHO, q: 1}, wb: true },
  { custos: [{i: ITEM.ENDER_PEARL, q: 4}, {i: ITEM.REDSTONE, q: 1}], saida: {i: ITEM.RECOVERY_COMPASS, q: 1}, wb: true },
  // Ingredientes de poção
  { custos: [{i: ITEM.BLAZE_ROD, q: 1}], saida: {i: ITEM.BLAZE_POWDER, q: 2}, wb: false },
  { custos: [{i: ITEM.SLIMEBALL, q: 1}, {i: ITEM.BLAZE_POWDER, q: 1}], saida: {i: ITEM.MAGMA_CREAM, q: 1}, wb: false },
  { custos: [{i: ITEM.OSSO, q: 1}, {b: BLOCO.COGUMELO_VERM, q: 1}], saida: {i: ITEM.FERMENTED_EYE, q: 1}, wb: false },
  { custos: [{i: ITEM.MACA, q: 1}, {i: ITEM.OURO, q: 8}], saida: {i: ITEM.GLISTERING_SLICE, q: 1}, wb: true },
  { custos: [{b: BLOCO.LUZ, q: 1}], saida: {i: ITEM.GLOWSTONE_DUST, q: 4}, wb: false },
  { custos: [{i: ITEM.CARVAO, q: 4}, {b: BLOCO.AREIA, q: 1}], saida: {i: ITEM.GUNPOWDER, q: 4}, wb: true },
  // Garrafa de vidro: 3 vidros
  { custos: [{b: BLOCO.VIDRO, q: 3}], saida: {i: ITEM.GARRAFA_VIDRO, q: 3}, wb: true },
  // Pote de Água: garrafa + balde água
  { custos: [{i: ITEM.GARRAFA_VIDRO, q: 1}, {i: ITEM.BUCKET_AGUA, q: 1}], saida: {i: ITEM.POTE_AGUA, q: 1}, wb: false },
  // Blaze Rod: drop blaze (proxy: 4 carvao + 4 ouro)
  { custos: [{i: ITEM.CARVAO, q: 4}, {i: ITEM.OURO, q: 4}], saida: {i: ITEM.BLAZE_ROD, q: 1}, wb: true },
  // Nether Star: 3 cranios wither + 1 obsidiana (proxy)
  { custos: [{b: BLOCO.CRANIO_WITHER, q: 3}, {b: BLOCO.OBSIDIANA, q: 1}], saida: {i: ITEM.NETHER_STAR, q: 1}, wb: true },
  // 6 poções novas (1 pote + 1 ingrediente + 1 lápis)
  { custos: [{i: ITEM.POTE_AGUA, q: 1}, {i: ITEM.FERMENTED_EYE, q: 1}, {i: ITEM.LAPIS, q: 1}], saida: {i: ITEM.POCAO_INVISIVEL, q: 1}, wb: true },
  { custos: [{i: ITEM.POTE_AGUA, q: 1}, {i: ITEM.GLOWSTONE_DUST, q: 1}], saida: {i: ITEM.POCAO_NOITE, q: 1}, wb: true },
  { custos: [{i: ITEM.POTE_AGUA, q: 1}, {i: ITEM.MAGMA_CREAM, q: 1}], saida: {i: ITEM.POCAO_FIRE_RES, q: 1}, wb: true },
  { custos: [{i: ITEM.POTE_AGUA, q: 1}, {i: ITEM.RABBIT_FOOT, q: 1}], saida: {i: ITEM.POCAO_SLOW_FALL, q: 1}, wb: true },
  { custos: [{i: ITEM.POTE_AGUA, q: 1}, {i: ITEM.BLAZE_POWDER, q: 1}], saida: {i: ITEM.POCAO_LEVITACAO, q: 1}, wb: true },
  { custos: [{i: ITEM.POTE_AGUA, q: 1}, {i: ITEM.GHAST_TEAR, q: 1}], saida: {i: ITEM.POCAO_RESISTENCIA, q: 1}, wb: true },
  // Music discs (5 paus + 1 redstone + 1 lápis = base; + ingrediente único cada)
  { custos: [{i: ITEM.PAU, q: 5}, {i: ITEM.REDSTONE, q: 1}], saida: {i: ITEM.MUSIC_DISC_13, q: 1}, wb: true },
  { custos: [{i: ITEM.PAU, q: 5}, {i: ITEM.LAPIS, q: 1}],    saida: {i: ITEM.MUSIC_DISC_CAT, q: 1}, wb: true },
  { custos: [{i: ITEM.PAU, q: 5}, {i: ITEM.DIAMANTE, q: 1}], saida: {i: ITEM.MUSIC_DISC_BLOCKS, q: 1}, wb: true },
  { custos: [{i: ITEM.PAU, q: 5}, {i: ITEM.OURO, q: 1}],     saida: {i: ITEM.MUSIC_DISC_CHIRP, q: 1}, wb: true },
  { custos: [{i: ITEM.PAU, q: 5}, {i: ITEM.ESMERALDA, q: 1}],saida: {i: ITEM.MUSIC_DISC_FAR, q: 1}, wb: true },
  // Foods
  { custos: [{i: ITEM.TRIGO, q: 2}, {i: ITEM.CARVAO, q: 1}], saida: {i: ITEM.COOKIE, q: 8}, wb: true },
  { custos: [{b: BLOCO.PUMPKIN, q: 1}, {i: ITEM.OVO, q: 1}, {i: ITEM.CARVAO, q: 1}], saida: {i: ITEM.PUMPKIN_PIE, q: 1}, wb: true },
  { custos: [{i: ITEM.SEMENTE, q: 4}], saida: {i: ITEM.BEETROOT, q: 1}, wb: false },
  { custos: [{i: ITEM.BEETROOT, q: 6}, {i: ITEM.TIGELA, q: 1}], saida: {i: ITEM.SOPA_BEETROOT, q: 1}, wb: true },
  // Netherite: 4 carvões + 1 ouro + 4 obsidianas (proxy de smelt MC)
  { custos: [{i: ITEM.CARVAO, q: 4}, {i: ITEM.OURO, q: 1}, {b: BLOCO.OBSIDIANA, q: 4}], saida: {i: ITEM.NETHERITE, q: 1}, wb: true },
  // Upgrade ferramentas: diamante + 1 lingote netherite (paridade smithing table)
  { custos: [{i: ITEM.PIC_DIAMANTE, q: 1}, {i: ITEM.NETHERITE, q: 1}], saida: {i: ITEM.PIC_NETHERITE, q: 1}, wb: true },
  { custos: [{i: ITEM.ESP_DIAMANTE, q: 1}, {i: ITEM.NETHERITE, q: 1}], saida: {i: ITEM.ESP_NETHERITE, q: 1}, wb: true },
  { custos: [{i: ITEM.MACHADO_DIAMANTE, q: 1}, {i: ITEM.NETHERITE, q: 1}], saida: {i: ITEM.MACHADO_NETHERITE, q: 1}, wb: true },
  { custos: [{i: ITEM.PA_DIAMANTE, q: 1}, {i: ITEM.NETHERITE, q: 1}], saida: {i: ITEM.PA_NETHERITE, q: 1}, wb: true },
  { custos: [{i: ITEM.ENXADA_DIAMANTE, q: 1}, {i: ITEM.NETHERITE, q: 1}], saida: {i: ITEM.ENXADA_NETHERITE, q: 1}, wb: true },
  // Upgrade armaduras
  { custos: [{i: ITEM.CAP_DIAMANTE, q: 1}, {i: ITEM.NETHERITE, q: 1}], saida: {i: ITEM.CAP_NETHERITE, q: 1}, wb: true },
  { custos: [{i: ITEM.PEI_DIAMANTE, q: 1}, {i: ITEM.NETHERITE, q: 1}], saida: {i: ITEM.PEI_NETHERITE, q: 1}, wb: true },
  { custos: [{i: ITEM.PER_DIAMANTE, q: 1}, {i: ITEM.NETHERITE, q: 1}], saida: {i: ITEM.PER_NETHERITE, q: 1}, wb: true },
  { custos: [{i: ITEM.BOT_DIAMANTE, q: 1}, {i: ITEM.NETHERITE, q: 1}], saida: {i: ITEM.BOT_NETHERITE, q: 1}, wb: true },
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
