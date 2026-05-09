// =====================================================================
// mobs.js — Mobs: tipos, modelos 3D, IA, spawn rules por light level
// =====================================================================

import * as THREE from 'three';
import { BLOCO, BLOCO_INFO, ITEM, WORLD_Y } from './constants.js';
import { state } from './state.js';
import { Audio } from './audio.js';
import { spawnArrow, spawnItemDrop } from './particles.js';
import { aStarMob } from './utils.js';

export const TIPO_MOB = {
  VACA: 'vaca', GALINHA: 'galinha', PORCO: 'porco', OVELHA: 'ovelha',
  ZUMBI: 'zumbi', ESQUELETO: 'esqueleto', ARANHA: 'aranha', CREEPER: 'creeper',
  LOBO: 'lobo', SLIME: 'slime', ENDERMAN: 'enderman',
  // Sprint 4
  CAT: 'cat', VILLAGER: 'villager', IRON_GOLEM: 'iron_golem', WITCH: 'witch',
  // Sprint 9
  GHAST: 'ghast',
  // Sprint End
  ENDER_DRAGON: 'ender_dragon',
  // Bonus
  WANDERING_TRADER: 'wandering_trader',
  SNOW_GOLEM: 'snow_golem',
};

export const MOB_INFO = {
  vaca: {
    hp: 8, vel: 1.4, hostil: false,
    drops: () => [
      { i: ITEM.CARNE_CRUA, q: 1 + (Math.random() < 0.5 ? 1 : 0) },
      { i: ITEM.COURO,      q: 1 + (Math.random() < 0.5 ? 1 : 0) },
    ],
    cor: 0xffffff, sec: 0x424242,
  },
  galinha: {
    hp: 4, vel: 1.7, hostil: false,
    drops: () => [{ i: ITEM.CARNE_CRUA, q: 1 }, ...(Math.random() < 0.5 ? [{ i: ITEM.OVO, q: 1 }] : [])],
    cor: 0xfff59d, sec: 0xff6f00,
  },
  porco: {
    hp: 6, vel: 1.5, hostil: false,
    drops: () => [
      { i: ITEM.CARNE_CRUA, q: 1 + (Math.random() < 0.5 ? 1 : 0) },
      ...(Math.random() < 0.4 ? [{ i: ITEM.COURO, q: 1 }] : []),
    ],
    cor: 0xf8bbd0, sec: 0xec407a,
  },
  ovelha: {
    hp: 8, vel: 1.3, hostil: false,
    drops: () => [{ b: BLOCO.LA, q: 1 + (Math.random() < 0.5 ? 1 : 0) }],
    cor: 0xfafafa, sec: 0xeeeeee,
  },
  zumbi: {
    hp: 16, vel: 2.2, hostil: true, dano: 2, alcance: 1.6,
    drops: () => Math.random() < 0.6 ? [{ i: ITEM.CARNE_PODRE, q: 1 }] : [],
    cor: 0x4caf50, sec: 0x2e7d32,
  },
  // Drowned: zumbi aquático azul-esverdeado, ataca com tridente (chance)
  drowned: {
    hp: 14, vel: 1.7, hostil: true, dano: 3, alcance: 1.6,
    drops: () => [
      ...(Math.random() < 0.5 ? [{ i: ITEM.CARNE_PODRE, q: 1 }] : []),
      ...(Math.random() < 0.06 ? [{ i: ITEM.TRIDENTE, q: 1 }] : []),
      ...(Math.random() < 0.20 ? [{ i: ITEM.PEIXE, q: 1 }] : []),
    ],
    cor: 0x4dd0e1, sec: 0x00838f, // ciano + verde-escuro
    aquatico: true, // não queima de dia, só spawna em água
  },
  // Husk: zumbi do deserto, mais HP, sem dano de dia (resistente ao sol)
  husk: {
    hp: 18, vel: 1.6, hostil: true, dano: 4, alcance: 1.6,
    drops: () => [
      ...(Math.random() < 0.7 ? [{ i: ITEM.CARNE_PODRE, q: 1 }] : []),
      ...(Math.random() < 0.15 ? [{ b: BLOCO.AREIA, q: 1 }] : []),
    ],
    cor: 0xc6a45e, sec: 0x8d6e3f, // bege + marrom
    resistenteSol: true, // não queima de dia (paridade Minecraft)
  },
  esqueleto: {
    hp: 14, vel: 1.8, hostil: true, dano: 2, alcance: 6.0,
    drops: () => [
      ...(Math.random() < 0.6 ? [{ i: ITEM.OSSO, q: 1 + (Math.random() < 0.3 ? 1 : 0) }] : []),
      ...(Math.random() < 0.4 ? [{ i: ITEM.FLECHA, q: 1 + Math.floor(Math.random() * 2) }] : []),
    ],
    cor: 0xe0e0e0, sec: 0x9e9e9e,
  },
  // Mooshroom: vaca rosa coberta de cogumelos vermelhos. Drop carne + cogumelos.
  // Right-click com tigela vazia → sopa de cogumelo (paridade MC).
  mooshroom: {
    hp: 12, vel: 1.0, hostil: false,
    drops: () => [
      ...(Math.random() < 0.7 ? [{ i: ITEM.CARNE_CRUA, q: 1 }] : []),
      ...(Math.random() < 0.5 ? [{ i: ITEM.COURO, q: 1 }] : []),
      ...(Math.random() < 0.4 ? [{ i: ITEM.COGUMELO_R, q: 1 + Math.floor(Math.random()*2) }] : []),
    ],
    cor: 0xef9a9a, sec: 0xc62828, // rosa vaca + vermelho cogumelo
    mooshroom: true, // permite right-click com tigela
  },
  // Camelo: passivo grande do deserto, alta HP, drop nada (decorativo)
  camelo: {
    hp: 32, vel: 1.4, hostil: false,
    drops: () => Math.random() < 0.3 ? [{ i: ITEM.COURO, q: 1 }] : [],
    cor: 0xc6a45e, sec: 0x8d6e3f, // bege deserto + marrom
  },
  // Axolote: anfíbio aquático rosa fofo
  axolote: {
    hp: 14, vel: 1.0, hostil: false,
    drops: () => Math.random() < 0.3 ? [{ i: ITEM.PEIXE, q: 1 }] : [],
    cor: 0xf48fb1, sec: 0xc2185b, // rosa + magenta
    voa: true, // nada livre na água
  },
  // Raposa: passiva da taiga, ágil, drop carne
  raposa: {
    hp: 10, vel: 2.4, hostil: false,
    drops: () => [
      ...(Math.random() < 0.5 ? [{ i: ITEM.CARNE_CRUA, q: 1 }] : []),
      ...(Math.random() < 0.10 ? [{ i: ITEM.MACA, q: 1 }] : []),
    ],
    cor: 0xff7043, sec: 0xfafafa, // laranja + branco
  },
  // Blaze: hostil voador do Nether (chama)
  blaze: {
    hp: 20, vel: 1.4, hostil: true, dano: 4, alcance: 8.0,
    drops: () => Math.random() < 0.7 ? [{ i: ITEM.CARVAO, q: 1 + Math.floor(Math.random()*2) }] : [],
    cor: 0xfdd835, sec: 0xff9800, // amarelo + laranja
    voa: true,
    luminoso: true,
    resistenteSol: true,
  },
  // Glow Squid: lula passiva aquática brilhante (emissive ciano)
  glow_squid: {
    hp: 10, vel: 0.5, hostil: false,
    drops: () => Math.random() < 0.7 ? [{ i: ITEM.TINTA_GLOW, q: 1 + Math.floor(Math.random()*2) }] : [],
    cor: 0x00bcd4, sec: 0x00838f, // ciano + ciano escuro
    voa: true, // "voa" na água (move livre)
    luminoso: true,
  },
  // Bee: passiva voa baixo, neutro provocado pica e morre
  bee: {
    hp: 8, vel: 1.5, hostil: false, neutro: true, dano: 2, alcance: 1.4,
    drops: () => Math.random() < 0.4 ? [{ i: ITEM.FAVO_MEL, q: 1 }] : [],
    cor: 0xfdd835, sec: 0x212121, // amarelo + preto
    voa: true,
    pica: true, // morre após picar (perde aguilhão)
  },
  // Magma Cube: slime do Nether, vermelho-laranja, dano alto, queima
  magma_cube: {
    hp: 12, vel: 2.0, hostil: true, dano: 4, alcance: 1.4,
    drops: () => [
      ...(Math.random() < 0.5 ? [{ i: ITEM.SLIMEBALL, q: 1 }] : []),
      ...(Math.random() < 0.30 ? [{ b: BLOCO.MAGMA, q: 1 }] : []),
    ],
    cor: 0xff5722, sec: 0xbf360c, // laranja vivo + vermelho escuro
    pula: true,
    nether: true, // só spawna no Nether
  },
  // Sapo: anfíbio passivo, salta, vive em grama perto da água
  sapo: {
    hp: 5, vel: 1.6, hostil: false,
    drops: () => [
      ...(Math.random() < 0.40 ? [{ i: ITEM.SLIMEBALL, q: 1 }] : []),
      ...(Math.random() < 0.10 ? [{ i: ITEM.PE_COELHO, q: 1 }] : []), // proxy de "rana foot"
    ],
    cor: 0x66bb6a, sec: 0x2e7d32, // verde claro + verde escuro
    pula: true,
  },
  // Allay: fada azul fofa que voa próxima do player, drops raros, raríssima
  allay: {
    hp: 6, vel: 2.0, hostil: false,
    drops: () => Math.random() < 0.3 ? [{ i: ITEM.LAPIS, q: 1 }] : [],
    cor: 0x4fc3f7, sec: 0xb3e5fc, // azul claro brilhante + azul muito claro
    voa: true,
    luminoso: true, // emite luz visual sutil
  },
  // Tartaruga: passiva, lenta, drop raro casco. Spawn em areia perto da água.
  tartaruga: {
    hp: 10, vel: 0.6, hostil: false,
    drops: () => [
      ...(Math.random() < 0.30 ? [{ i: ITEM.PEIXE, q: 1 }] : []),
      ...(Math.random() < 0.05 ? [{ i: ITEM.CASCO_TARTARUGA, q: 1 }] : []),
    ],
    cor: 0x4caf50, sec: 0x2e7d32, // verde médio + verde escuro (casco)
  },
  // Papagaio: passivo pequeno, voa baixo, 4 cores escolhidas no spawn
  papagaio: {
    hp: 6, vel: 1.8, hostil: false,
    drops: () => Math.random() < 0.5 ? [{ i: ITEM.OSSO, q: 1 }] : [],
    cor: 0xff5252, sec: 0xfff176, // padrão (override no spawn)
    voa: true,
  },
  // Urso polar: neutro, ataca se provocado, alta HP (taiga/neve)
  urso_polar: {
    hp: 30, vel: 1.6, hostil: false, neutro: true, dano: 5, alcance: 1.8,
    drops: () => [
      ...(Math.random() < 0.7 ? [{ i: ITEM.PEIXE, q: 1 }] : []),
      ...(Math.random() < 0.3 ? [{ i: ITEM.CARNE_CRUA, q: 1 }] : []),
    ],
    cor: 0xfafafa, sec: 0xeceff1, // branco neve
  },
  // Coelho: passivo pequeno, salta, drop carne + raro pé-de-coelho
  coelho: {
    hp: 4, vel: 2.5, hostil: false,
    drops: () => [
      ...(Math.random() < 0.6 ? [{ i: ITEM.CARNE_COELHO, q: 1 }] : []),
      ...(Math.random() < 0.10 ? [{ i: ITEM.PE_COELHO, q: 1 }] : []),
    ],
    cor: 0xefebe9, sec: 0xbcaaa4, // bege claro + bege médio
    pula: true,
  },
  // Stray: esqueleto da taiga, atira flechas de slowness, mais HP
  stray: {
    hp: 16, vel: 1.7, hostil: true, dano: 2, alcance: 7.0,
    drops: () => [
      ...(Math.random() < 0.6 ? [{ i: ITEM.OSSO, q: 1 + (Math.random() < 0.3 ? 1 : 0) }] : []),
      ...(Math.random() < 0.5 ? [{ i: ITEM.FLECHA, q: 1 + Math.floor(Math.random() * 2) }] : []),
      ...(Math.random() < 0.10 ? [{ b: BLOCO.NEVE, q: 1 }] : []),
    ],
    cor: 0xb3e5fc, sec: 0x4fc3f7, // azul-claro (gelado) + azul médio
    slowness: true, // ataque aplica slowness 5s
    resistenteSol: true, // não queima
  },
  aranha: {
    hp: 12, vel: 2.6, hostil: true, dano: 3, alcance: 1.6,
    drops: () => Math.random() < 0.5 ? [{ b: BLOCO.LA, q: 1 }] : [],
    cor: 0x263238, sec: 0xb71c1c,
  },
  // Cave Spider: aranha menor azul, spawn em mineshafts, ataca com veneno
  cave_spider: {
    hp: 8, vel: 3.0, hostil: true, dano: 2, alcance: 1.4,
    drops: () => [
      ...(Math.random() < 0.5 ? [{ b: BLOCO.LA, q: 1 }] : []),
      ...(Math.random() < 0.3 ? [{ i: ITEM.SLIMEBALL, q: 1 }] : []),
    ],
    cor: 0x1565c0, sec: 0x0d47a1, // azul escuro + azul ainda mais escuro
    poison: true, // ataque envenena player (dreno HP por tempo)
  },
  creeper: {
    hp: 10, vel: 1.9, hostil: true, dano: 8, alcance: 2.5,
    drops: () => Math.random() < 0.5 ? [{ i: ITEM.CARVAO, q: 1 }] : [],
    cor: 0x2e7d32, sec: 0x1b5e20, explode: true, fuseSegundos: 1.5,
  },
  lobo: {
    hp: 12, vel: 2.4, hostil: false, amigavel: true,
    drops: () => [],
    cor: 0x9e9e9e, sec: 0xeeeeee,
  },
  slime: {
    hp: 8, vel: 1.6, hostil: true, dano: 2, alcance: 1.2,
    drops: () => [
      ...(Math.random() < 0.7 ? [{ i: ITEM.SLIMEBALL, q: 1 + Math.floor(Math.random() * 2) }] : []),
    ],
    cor: 0x66bb6a, sec: 0x33691e, pula: true,
  },
  enderman: {
    hp: 20, vel: 2.4, hostil: true, dano: 3, alcance: 2.4,
    drops: () => [
      ...(Math.random() < 0.6 ? [{ i: ITEM.ENDER_PEARL, q: 1 }] : []),
      ...(Math.random() < 0.2 ? [{ i: ITEM.DIAMANTE, q: 1 }] : []),
    ],
    cor: 0x121212, sec: 0xb388ff, teleport: true,
  },
  // === Sprint 4: population ===
  cat: {
    hp: 6, vel: 2.0, hostil: false, amigavel: false,
    drops: () => Math.random() < 0.4 ? [{ i: ITEM.PEIXE, q: 1 }] : [],
    cor: 0xe0a050, sec: 0x4a2c10, // laranja + bigode escuro
  },
  villager: {
    hp: 14, vel: 1.0, hostil: false,
    drops: () => Math.random() < 0.3 ? [{ i: ITEM.ESMERALDA, q: 1 }] : [],
    cor: 0x6d4c41, sec: 0xd7ccc8, // robe marrom + nariz claro
  },
  iron_golem: {
    hp: 60, vel: 0.9, hostil: false, amigavel: true, // amigavel = ataca hostis (igual lobo)
    drops: () => [{ i: ITEM.FERRO, q: 3 + Math.floor(Math.random() * 3) }],
    cor: 0xb0a896, sec: 0x607d3a, // ferro + folha verde no peito
  },
  witch: {
    hp: 18, vel: 1.5, hostil: true, dano: 3, alcance: 8.0,
    drops: () => [
      ...(Math.random() < 0.5 ? [{ i: ITEM.LAPIS, q: 1 }] : []),
      ...(Math.random() < 0.3 ? [{ i: ITEM.POCAO_HEAL, q: 1 }] : []),
    ],
    cor: 0x6a1b9a, sec: 0x000000, // robe roxo + chapéu preto
  },
  // Sprint 9: Nether boss-like
  ghast: {
    hp: 14, vel: 1.0, hostil: true, dano: 5, alcance: 6.0,
    drops: () => [{ i: ITEM.OURO, q: 1 + Math.floor(Math.random() * 2) }],
    cor: 0xfafafa, sec: 0xb71c1c,
    flutua: true,
  },
  // Snow Golem: friendly tank pequeno, atira snowball em hostis
  snow_golem: {
    hp: 8, vel: 1.6, hostil: false, amigavel: true,
    drops: () => [{ b: BLOCO.NEVE, q: 1 + Math.floor(Math.random() * 3) }],
    cor: 0xfafafa, sec: 0xff9800, // neve + pumpkin
  },
  // Wandering Trader — passivo nômade, trades raras + drops bonus
  wandering_trader: {
    hp: 14, vel: 1.4, hostil: false,
    drops: () => [
      ...(Math.random() < 0.6 ? [{ i: ITEM.ESMERALDA, q: 1 + Math.floor(Math.random() * 2) }] : []),
      ...(Math.random() < 0.3 ? [{ i: ITEM.ENDER_PEARL, q: 1 }] : []),
    ],
    cor: 0x4a148c, sec: 0xe1bee7, // robe roxo + nariz claro
  },
  // Boss do End — gigante, 100 HP, atira fireball, voa em órbita
  ender_dragon: {
    hp: 100, vel: 1.5, hostil: true, dano: 8, alcance: 12.0,
    drops: () => [
      { b: 38 /* DRAGON_EGG */, q: 1 },
      { i: ITEM.DIAMANTE, q: 5 + Math.floor(Math.random() * 5) },
      { i: ITEM.ENDER_PEARL, q: 5 + Math.floor(Math.random() * 5) },
    ],
    cor: 0x121212, sec: 0xb388ff,
    flutua: true, boss: true, // boss = HP bar na HUD
  },
  // SPRINT MEGA-2: 24 mobs novos para paridade total
  // BOSS Wither — 3 cabeças, 200 HP, atira withersulks
  wither: {
    hp: 200, vel: 1.0, hostil: true, dano: 12, alcance: 20.0,
    drops: () => [
      { i: ITEM.NETHER_STAR, q: 1 },
    ],
    cor: 0x1a1a1a, sec: 0x424242,
    flutua: true, boss: true, ranged: true,
  },
  // Guardian — Ocean Monument, atira laser
  guardian: {
    hp: 30, vel: 1.0, hostil: true, dano: 6, alcance: 12.0,
    drops: () => [
      { i: ITEM.PRISMARINE_SHARD, q: 1 + Math.floor(Math.random() * 2) },
      { i: ITEM.PEIXE, q: Math.random() < 0.4 ? 1 : 0 },
    ],
    cor: 0x4dd0e1, sec: 0xff5722, // ciano + olho laranja
    aquatico: true, ranged: true,
  },
  // Elder Guardian — debuff mining fatigue
  elder_guardian: {
    hp: 80, vel: 0.7, hostil: true, dano: 8, alcance: 16.0,
    drops: () => [
      { i: ITEM.PRISMARINE_SHARD, q: 3 + Math.floor(Math.random() * 5) },
      { b: 100 /* PRISMARINE bloco */, q: Math.random() < 0.5 ? 1 : 0 },
    ],
    cor: 0xb2dfdb, sec: 0xff5722,
    aquatico: true, ranged: true, boss: true,
  },
  // Warden — Deep Dark, invisível pra player se não fizer som
  warden: {
    hp: 500, vel: 1.4, hostil: true, dano: 30, alcance: 8.0,
    drops: () => [
      { i: ITEM.SCULK_CATALYST || 154, q: 1 },
      { i: ITEM.ECHO_SHARD, q: 1 + Math.floor(Math.random() * 2) },
    ],
    cor: 0x0a1a2a, sec: 0x40c4ff,
    boss: true, ignoresArmor: true,
  },
  // Phantom — voa alto, ataca insônia
  phantom: {
    hp: 20, vel: 2.5, hostil: true, dano: 4, alcance: 4.0,
    drops: () => [
      { i: ITEM.PHANTOM_MEMBRANE, q: 1 },
    ],
    cor: 0x2c1f47, sec: 0x9c27b0,
    flutua: true,
  },
  // Pillager — outpost, crossbow
  pillager: {
    hp: 24, vel: 1.5, hostil: true, dano: 5, alcance: 8.0,
    drops: () => [
      { i: ITEM.CROSSBOW, q: Math.random() < 0.3 ? 1 : 0 },
      { i: ITEM.ESMERALDA, q: Math.random() < 0.5 ? 1 : 0 },
    ],
    cor: 0x607d8b, sec: 0x424242,
    ranged: true,
  },
  // Vindicator — espada, mansion
  vindicator: {
    hp: 24, vel: 1.4, hostil: true, dano: 7,
    drops: () => [
      { i: ITEM.MACHADO_FERRO, q: Math.random() < 0.3 ? 1 : 0 },
      { i: ITEM.ESMERALDA, q: 1 + Math.floor(Math.random() * 2) },
    ],
    cor: 0x4a4a4a, sec: 0x6d4c41,
  },
  // Evoker — magia, summon Vex
  evoker: {
    hp: 24, vel: 1.5, hostil: true, dano: 6, alcance: 10.0,
    drops: () => [
      { i: ITEM.TOTEM_VIDA, q: 1 },
      { i: ITEM.ESMERALDA, q: 2 + Math.floor(Math.random() * 3) },
    ],
    cor: 0x4a4a4a, sec: 0xfdd835,
    ranged: true,
  },
  // Vex — voa, espada, summoned by Evoker
  vex: {
    hp: 14, vel: 2.8, hostil: true, dano: 5,
    drops: () => [],
    cor: 0xeceff1, sec: 0xc62828,
    flutua: true,
  },
  // Ravager — gigante, raids
  ravager: {
    hp: 100, vel: 1.2, hostil: true, dano: 12,
    drops: () => [
      { i: ITEM.SELA, q: 1 },
      { i: ITEM.ESMERALDA, q: 5 + Math.floor(Math.random() * 5) },
    ],
    cor: 0x4a4a4a, sec: 0x000000,
    big: true,
  },
  // Horse — montar, sela, jump boost
  horse: {
    hp: 30, vel: 2.4, hostil: false,
    drops: () => [
      { i: ITEM.COURO, q: 1 },
    ],
    cor: 0x6d4c41, sec: 0x3e2723,
    rideable: true,
  },
  // Donkey — inventory extra
  donkey: {
    hp: 22, vel: 1.8, hostil: false,
    drops: () => [{ i: ITEM.COURO, q: 1 }],
    cor: 0x9e9e9e, sec: 0x616161,
    rideable: true, hasInventory: true,
  },
  // Mule — Donkey × Horse breed
  mule: {
    hp: 26, vel: 2.0, hostil: false,
    drops: () => [{ i: ITEM.COURO, q: 1 }],
    cor: 0x5d4037, sec: 0x3e2723,
    rideable: true, hasInventory: true,
  },
  // Llama — neutro, cuspem
  llama: {
    hp: 22, vel: 1.4, hostil: false,
    drops: () => [{ i: ITEM.COURO, q: 1 }],
    cor: 0xeceff1, sec: 0xa1887f,
    rideable: true, ranged: true, // cospe quando provocada
  },
  // Strider — Nether, montar em lava
  strider: {
    hp: 20, vel: 1.7, hostil: false,
    drops: () => [{ i: ITEM.CORDA, q: 1 }],
    cor: 0xc62828, sec: 0xfdd835, // vermelho com listras amarelas
    rideable: true, lavaWalker: true,
  },
  // Piglin — Nether, neutro com ouro, atrai trades
  piglin: {
    hp: 16, vel: 1.5, hostil: true, dano: 4,
    drops: () => [
      { i: ITEM.OURO, q: Math.random() < 0.3 ? 1 : 0 },
      { i: ITEM.PIC_OURO || ITEM.PIC_FERRO, q: Math.random() < 0.1 ? 1 : 0 },
    ],
    cor: 0xc97a4d, sec: 0xfdd835,
  },
  // Hoglin — Nether hostil, comida
  hoglin: {
    hp: 40, vel: 1.6, hostil: true, dano: 7,
    drops: () => [
      { i: ITEM.CARNE_CRUA, q: 2 + Math.floor(Math.random() * 3) },
      { i: ITEM.COURO, q: Math.random() < 0.5 ? 1 : 0 },
    ],
    cor: 0xc62828, sec: 0x6d4c41,
    big: true,
  },
  // Zoglin — Hoglin zumbi
  zoglin: {
    hp: 40, vel: 1.6, hostil: true, dano: 8,
    drops: () => [
      { i: ITEM.CARNE_PODRE, q: 1 + Math.floor(Math.random() * 3) },
    ],
    cor: 0x4a4a4a, sec: 0x424242,
    big: true,
  },
  // Zombified Piglin — Nether, neutro a menos que provocado
  zombified_piglin: {
    hp: 20, vel: 1.5, hostil: false, dano: 5, // ataca se provocado
    drops: () => [
      { i: ITEM.OURO, q: Math.random() < 0.4 ? 1 : 0 },
      { i: ITEM.CARNE_PODRE, q: Math.random() < 0.6 ? 1 : 0 },
    ],
    cor: 0x9e9e9e, sec: 0xfdd835,
  },
  // Endermite — drop enderman, hostil
  endermite: {
    hp: 8, vel: 2.4, hostil: true, dano: 2,
    drops: () => [],
    cor: 0x121212, sec: 0x9c27b0,
    pequeno: true,
  },
  // Silverfish — mineshaft, hostil
  silverfish: {
    hp: 8, vel: 2.4, hostil: true, dano: 1,
    drops: () => [],
    cor: 0xbcaaa4, sec: 0x9e9e9e,
    pequeno: true,
  },
  // Goat — montanha, corneia
  goat: {
    hp: 10, vel: 2.0, hostil: false,
    drops: () => [
      { i: ITEM.GOAT_HORN, q: Math.random() < 0.2 ? 1 : 0 },
    ],
    cor: 0xfff8e1, sec: 0xeceff1,
  },
  // Panda — bambu, 7 personalidades
  panda: {
    hp: 30, vel: 1.5, hostil: false,
    drops: () => [
      { i: ITEM.BAMBOO, q: 1 + Math.floor(Math.random() * 3) },
    ],
    cor: 0xfafafa, sec: 0x000000,
  },
  // Bat — caverna, neutra
  bat: {
    hp: 6, vel: 1.5, hostil: false,
    drops: () => [],
    cor: 0x424242, sec: 0x6d4c41,
    flutua: true, pequeno: true,
  },
  // Squid — oceano, drop tinta
  squid: {
    hp: 10, vel: 0.8, hostil: false,
    drops: () => [{ i: ITEM.TINTA_GLOW, q: 1 + Math.floor(Math.random() * 3) }],
    cor: 0x424242, sec: 0x000000,
    aquatico: true,
  },
  // Dolphin — oceano, neutro
  dolphin: {
    hp: 10, vel: 2.5, hostil: false,
    drops: () => [{ i: ITEM.PEIXE, q: Math.random() < 0.5 ? 1 : 0 }],
    cor: 0x90a4ae, sec: 0xeceff1,
    aquatico: true,
  },
  // Shulker — End City, ranged
  shulker: {
    hp: 30, vel: 0.0, hostil: true, dano: 4, alcance: 10.0,
    drops: () => [
      { i: ITEM.SCULK_CATALYST || 154, q: Math.random() < 0.5 ? 1 : 0 },
    ],
    cor: 0xab47bc, sec: 0xc97a4d,
    ranged: true, static: true,
  },
  // Spider Jockey — esqueleto montando aranha (compound)
  spider_jockey: {
    hp: 20, vel: 2.6, hostil: true, dano: 4, alcance: 7.0,
    drops: () => [
      { i: ITEM.OSSO, q: 1 },
      { i: ITEM.CORDA, q: Math.random() < 0.4 ? 1 : 0 },
    ],
    cor: 0x424242, sec: 0xfafafa,
    ranged: true, big: true,
  },
  // Frog — sapo (ja existe? — variantes 3 cores)
  frog_temperate: {
    hp: 10, vel: 1.6, hostil: false,
    drops: () => [],
    cor: 0xf57f17, sec: 0xfdd835,
  },
  frog_warm: {
    hp: 10, vel: 1.6, hostil: false,
    drops: () => [],
    cor: 0xfff176, sec: 0xfff8e1,
  },
  frog_cold: {
    hp: 10, vel: 1.6, hostil: false,
    drops: () => [],
    cor: 0x4dd0e1, sec: 0xb3e5fc,
  },
  // Tadpole (girino) — frog filhote
  tadpole: {
    hp: 4, vel: 1.5, hostil: false,
    drops: () => [],
    cor: 0x4e342e, sec: 0x000000,
    aquatico: true, pequeno: true,
  },
  // Glow Squid — caverna brilhante
  glow_squid_var: {
    hp: 10, vel: 0.8, hostil: false,
    drops: () => [{ i: ITEM.TINTA_GLOW, q: 1 + Math.floor(Math.random() * 3) }],
    cor: 0x4dd0e1, sec: 0xe1f5fe,
    aquatico: true, brilha: true,
  },
};

// Constrói modelo 3D de um mob com pivots para animação.
// Cada mob tem detalhes faciais (olhos brancos+pupila preta), focinhos,
// orelhas, caudas, asas — visual estilo MC mas mais detalhado.
export function construirModeloMob(tipo, info) {
  const matCor = (c) => new THREE.MeshLambertMaterial({ color: c });
  const matEmissivo = (c, e = 0.8) => {
    const m = new THREE.MeshLambertMaterial({ color: c, emissive: c, emissiveIntensity: e });
    return m;
  };
  const cubo = (w, h, d, c) => new THREE.Mesh(new THREE.BoxGeometry(w, h, d), matCor(c));
  const cuboEm = (w, h, d, c, e) => new THREE.Mesh(new THREE.BoxGeometry(w, h, d), matEmissivo(c, e));
  const grp = new THREE.Group();
  const partes = {};
  // Pivot trick para pernas/braços oscilarem
  const pernaComPivot = (w, h, d, cor, posY) => {
    const pivot = new THREE.Group();
    pivot.position.y = posY;
    const m = cubo(w, h, d, cor);
    m.position.y = -h / 2;
    pivot.add(m);
    return pivot;
  };
  // Helper: par de olhos (esclera branca + pupila preta) na cabeça-alvo,
  // posicionados em coords LOCAIS à cabeça. Reutilizado por 11 mobs.
  const olhosPretos = (cabecaMesh, sep, cy, cz, escleraSize = 0.08, pupSize = 0.04) => {
    const escleraMat = matCor(0xffffff);
    const pupMat = matCor(0x000000);
    for (const sx of [-sep, sep]) {
      const escl = new THREE.Mesh(new THREE.BoxGeometry(escleraSize, escleraSize, 0.02), escleraMat);
      escl.position.set(sx, cy, cz);
      cabecaMesh.add(escl);
      const pup = new THREE.Mesh(new THREE.BoxGeometry(pupSize, pupSize, 0.025), pupMat);
      pup.position.set(sx, cy, cz + 0.005);
      cabecaMesh.add(pup);
    }
  };
  // Helper: olho com sclera BRANCA + pupila colorida (emissive opcional).
  // Antes era 100% emissive na cor, dando aspecto fluorescente irreal.
  // Agora todos os mobs têm sclera branca convencional, pupila pequena
  // colorida (emissive pra mobs hostis brilharem à noite).
  const olhosBrilhantes = (cabecaMesh, sep, cy, cz, cor, size = 0.08) => {
    const escleraMat = matCor(0xffffff);
    const pupMat = matEmissivo(cor, 1.0);
    for (const sx of [-sep, sep]) {
      const escl = new THREE.Mesh(new THREE.BoxGeometry(size, size, 0.02), escleraMat);
      escl.position.set(sx, cy, cz);
      cabecaMesh.add(escl);
      const pup = new THREE.Mesh(new THREE.BoxGeometry(size * 0.55, size * 0.55, 0.025), pupMat);
      pup.position.set(sx, cy, cz + 0.005);
      cabecaMesh.add(pup);
    }
  };

  switch (tipo) {
    case 'mooshroom':
    case 'vaca': {
      // Corpo branco com manchas marrons (sec=0x424242). Maior dos animais
      // passivos pra refletir hierarquia visual: vaca > ovelha > porco > galinha.
      const corpo = cubo(0.78, 0.62, 1.10, info.cor);
      corpo.position.y = 0.72; grp.add(corpo);
      const m1 = cubo(0.79, 0.06, 0.25, info.sec); m1.position.set(0, 1.04, 0.10); grp.add(m1);
      const m2 = cubo(0.79, 0.06, 0.22, info.sec); m2.position.set(0, 1.04, -0.32); grp.add(m2);
      // Mooshroom: 4 cogumelos vermelhos com bolinhas brancas no dorso
      if (tipo === 'mooshroom') {
        const posCog = [
          { x: -0.20, z:  0.30 },
          { x:  0.20, z:  0.10 },
          { x: -0.15, z: -0.20 },
          { x:  0.20, z: -0.40 },
        ];
        for (const p of posCog) {
          // Caule branco
          const caule = cubo(0.06, 0.10, 0.06, 0xfafafa);
          caule.position.set(p.x, 1.10, p.z); grp.add(caule);
          // Chapéu vermelho
          const chapeu = cubo(0.18, 0.10, 0.18, 0xc62828);
          chapeu.position.set(p.x, 1.20, p.z); grp.add(chapeu);
          // Bolinha branca pequena no chapéu
          const bola = cubo(0.04, 0.02, 0.04, 0xfafafa);
          bola.position.set(p.x + 0.04, 1.26, p.z + 0.04); grp.add(bola);
        }
      }
      const cabeca = cubo(0.46, 0.46, 0.50, info.cor);
      cabeca.position.set(0, 0.86, 0.72); grp.add(cabeca);
      olhosPretos(cabeca, 0.11, 0.05, 0.23);
      // Focinho rosa
      const focinho = cubo(0.28, 0.22, 0.06, 0xff8a80);
      focinho.position.set(0, -0.08, 0.24); cabeca.add(focinho);
      // Narinas
      for (const sx of [-0.06, 0.06]) {
        const n = cubo(0.04, 0.04, 0.02, 0x424242);
        n.position.set(sx, -0.03, 0.27); cabeca.add(n);
      }
      // Chifres brancos
      for (const sx of [-0.18, 0.18]) {
        const c = cubo(0.06, 0.18, 0.06, 0xfafafa);
        c.position.set(sx, 0.27, -0.05); cabeca.add(c);
      }
      // Orelhas
      for (const sx of [-0.27, 0.27]) {
        const o = cubo(0.10, 0.08, 0.18, info.cor);
        o.position.set(sx, 0.10, 0.0); cabeca.add(o);
      }
      // Cauda fininha pendurada
      const cauda = cubo(0.06, 0.45, 0.06, info.cor);
      cauda.position.set(0, 0.62, -0.58); grp.add(cauda);
      const caudaTuf = cubo(0.10, 0.10, 0.10, info.sec);
      caudaTuf.position.set(0, 0.36, -0.58); grp.add(caudaTuf);
      // Úbere rosado
      const uber = cubo(0.20, 0.10, 0.22, 0xff80ab);
      uber.position.set(0, 0.36, -0.24); grp.add(uber);
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const dx = (i % 2 === 0 ? -0.24 : 0.24);
        const dz = (i < 2 ? 0.38 : -0.38);
        const p = pernaComPivot(0.20, 0.48, 0.20, info.sec, 0.48);
        p.position.x = dx; p.position.z = dz;
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.pernas = pernas; partes.corpo = corpo;
      break;
    }
    case 'porco': {
      // Médio. Mais baixo que vaca, mais comprido que ovelha.
      const corpo = cubo(0.50, 0.46, 0.82, info.cor);
      corpo.position.y = 0.52; grp.add(corpo);
      const cabeca = cubo(0.40, 0.38, 0.38, info.cor);
      cabeca.position.set(0, 0.62, 0.55); grp.add(cabeca);
      olhosPretos(cabeca, 0.10, 0.04, 0.22);
      // Focinho rosa escuro com narinas
      const focinho = cubo(0.22, 0.18, 0.10, info.sec);
      focinho.position.set(0, -0.06, 0.22); cabeca.add(focinho);
      for (const sx of [-0.05, 0.05]) {
        const n = cubo(0.04, 0.04, 0.02, 0x000000);
        n.position.set(sx, 0.0, 0.27); cabeca.add(n);
      }
      // Orelhas triangulares (cubinho inclinado)
      for (const sx of [-0.16, 0.16]) {
        const o = cubo(0.10, 0.10, 0.05, info.sec);
        o.position.set(sx, 0.22, -0.05); cabeca.add(o);
        o.rotation.z = sx > 0 ? -0.3 : 0.3;
      }
      // Cauda enroladinha (cubo pequeno)
      const cauda = cubo(0.08, 0.16, 0.08, info.cor);
      cauda.position.set(0, 0.65, -0.50); grp.add(cauda);
      cauda.rotation.x = 0.5;
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const dx = (i % 2 === 0 ? -0.16 : 0.16);
        const dz = (i < 2 ? 0.30 : -0.30);
        const p = pernaComPivot(0.14, 0.30, 0.14, info.sec, 0.30);
        p.position.x = dx; p.position.z = dz;
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.pernas = pernas; partes.corpo = corpo;
      break;
    }
    case 'ovelha': {
      // Menor que vaca, mais alta proporcionalmente (fluffy).
      const corpo = cubo(0.58, 0.58, 0.85, info.cor);
      corpo.position.y = 0.65; grp.add(corpo);
      // Cabeça preta (paridade MC) menor
      const cabeca = cubo(0.30, 0.32, 0.36, 0x424242);
      cabeca.position.set(0, 0.78, 0.52); grp.add(cabeca);
      olhosPretos(cabeca, 0.09, 0.04, 0.22, 0.06, 0.03);
      // Focinho preto (mesma cor da cabeça, só silhueta)
      // Orelhas
      for (const sx of [-0.20, 0.20]) {
        const o = cubo(0.08, 0.06, 0.12, 0x424242);
        o.position.set(sx, 0.10, 0.0); cabeca.add(o);
      }
      // Cauda fofa pequena
      const cauda = cubo(0.18, 0.18, 0.14, info.cor);
      cauda.position.set(0, 0.78, -0.55); grp.add(cauda);
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const dx = (i % 2 === 0 ? -0.20 : 0.20);
        const dz = (i < 2 ? 0.32 : -0.32);
        const p = pernaComPivot(0.16, 0.40, 0.16, 0x424242, 0.40);
        p.position.x = dx; p.position.z = dz;
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.pernas = pernas; partes.corpo = corpo;
      break;
    }
    case 'lobo': {
      const corpo = cubo(0.45, 0.45, 0.85, info.cor);
      corpo.position.y = 0.55; grp.add(corpo);
      const cabeca = cubo(0.40, 0.36, 0.40, info.cor);
      cabeca.position.set(0, 0.62, 0.55); grp.add(cabeca);
      olhosBrilhantes(cabeca, 0.10, 0.05, 0.22, 0xfff176, 0.06);
      // Focinho preto
      const focinho = cubo(0.22, 0.16, 0.18, 0x424242);
      focinho.position.set(0, -0.06, 0.20); cabeca.add(focinho);
      // Nariz preto pontudo
      const nariz = cubo(0.08, 0.06, 0.04, 0x000000);
      nariz.position.set(0, 0.0, 0.31); cabeca.add(nariz);
      // Orelhas pontudas (triangular look via cubinho)
      for (const sx of [-0.15, 0.15]) {
        const o = cubo(0.08, 0.14, 0.06, info.cor);
        o.position.set(sx, 0.22, -0.05); cabeca.add(o);
      }
      // Cauda longa pendurada
      const cauda = cubo(0.10, 0.10, 0.36, info.cor);
      cauda.position.set(0, 0.55, -0.55); grp.add(cauda);
      cauda.rotation.x = -0.5;
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const dx = (i % 2 === 0 ? -0.13 : 0.13);
        const dz = (i < 2 ? 0.28 : -0.28);
        const p = pernaComPivot(0.13, 0.32, 0.13, info.sec, 0.32);
        p.position.x = dx; p.position.z = dz;
        grp.add(p); pernas.push(p);
      }
      // Colar (visível só quando domesticado)
      const colar = cubo(0.45, 0.10, 0.45, 0xc62828);
      colar.position.set(0, 0.42, 0.36);
      colar.visible = false;
      grp.add(colar);
      partes.colar = colar;
      partes.cabeca = cabeca; partes.pernas = pernas; partes.corpo = corpo;
      break;
    }
    case 'sapo': {
      // Corpo redondo verde + cabeça larga + 2 olhos esbugalhados em cima
      const corpo = cubo(0.40, 0.20, 0.40, info.cor);
      corpo.position.y = 0.20; grp.add(corpo);
      // Manchas escuras no dorso
      for (const sx of [-0.10, 0.10]) {
        const mancha = cubo(0.10, 0.04, 0.12, info.sec);
        mancha.position.set(sx, 0.31, -0.05); grp.add(mancha);
      }
      const cabeca = cubo(0.36, 0.18, 0.20, info.cor);
      cabeca.position.set(0, 0.30, 0.20); grp.add(cabeca);
      // Olhos protuberantes (cubinhos altos com pupila preta)
      for (const sx of [-0.11, 0.11]) {
        const sclera = cubo(0.10, 0.10, 0.10, 0xfafafa);
        sclera.position.set(sx, 0.10, 0.03); cabeca.add(sclera);
        const pupila = cubo(0.05, 0.05, 0.03, 0x000000);
        pupila.position.set(sx, 0.10, 0.08); cabeca.add(pupila);
      }
      // Boca larga (faixa escura)
      const boca = cubo(0.30, 0.02, 0.02, 0x1a1a1a);
      boca.position.set(0, -0.06, 0.105); cabeca.add(boca);
      // 2 patas dianteiras pequenas + 2 traseiras grandes (pra pular)
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const traseira = i >= 2;
        const altPerna = traseira ? 0.16 : 0.10;
        const p = pernaComPivot(0.06, altPerna, 0.06, info.sec, 0.12);
        p.position.x = (i % 2 === 0 ? -0.13 : 0.13);
        p.position.z = traseira ? -0.10 : 0.13;
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo; partes.pernas = pernas;
      break;
    }
    case 'allay': {
      // Pequena fada azul brilhante: corpo + cabeça grande + 4 asas
      // Corpo azul claro
      const corpo = cubo(0.20, 0.30, 0.18, info.cor);
      corpo.position.y = 0.50; grp.add(corpo);
      // Cabeça maior que o corpo (estilo chibi)
      const cabeca = cubo(0.30, 0.30, 0.30, info.cor);
      cabeca.position.set(0, 0.80, 0); grp.add(cabeca);
      // Olhos pretos grandes (cabeça grande pede olhos grandes)
      olhosPretos(cabeca, 0.13, 0.04, 0.155, 0.07, 0.04);
      // Cabelo azul-escuro em cima (3 cubinhos)
      for (const sx of [-0.08, 0, 0.08]) {
        const cab = cubo(0.07, 0.06, 0.30, 0x0277bd);
        cab.position.set(sx, 0.18, -0.05); cabeca.add(cab);
      }
      // 4 asas com cor secundária mais clara (translucidez visual)
      const asaMat = matCor(info.sec);
      asaMat.transparent = true;
      asaMat.opacity = 0.75;
      for (let i = 0; i < 4; i++) {
        const asa = new THREE.Mesh(new THREE.BoxGeometry(0.04, 0.18, 0.20), asaMat);
        const lado = i < 2 ? -1 : 1;
        const cima = i % 2 === 0 ? 1 : -1;
        asa.position.set(lado * 0.14, 0.55 + cima * 0.08, -0.10);
        asa.rotation.z = lado * 0.3;
        grp.add(asa);
      }
      // Mãos azuis pequenas estendidas (parecem agarrando algo)
      for (const sx of [-0.13, 0.13]) {
        const mao = cubo(0.06, 0.06, 0.06, info.cor);
        mao.position.set(sx, 0.40, 0.10); grp.add(mao);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
      break;
    }
    case 'tartaruga': {
      // Casco grande arredondado em cima + corpo embaixo + cabeça + 4 nadadeiras
      // Casco verde escuro (info.sec)
      const casco = cubo(0.65, 0.20, 0.55, info.sec);
      casco.position.y = 0.30; grp.add(casco);
      // Padrões hexagonais no casco (linhas mais escuras)
      for (let s = -1; s <= 1; s++) {
        const linha = cubo(0.60, 0.04, 0.06, 0x1b5e20);
        linha.position.set(0, 0.40, s * 0.18); grp.add(linha);
      }
      // Corpo verde médio (mais largo que casco em baixo)
      const corpo = cubo(0.55, 0.12, 0.45, info.cor);
      corpo.position.y = 0.18; grp.add(corpo);
      // Cabeça verde
      const cabeca = cubo(0.20, 0.18, 0.20, info.cor);
      cabeca.position.set(0, 0.24, 0.32); grp.add(cabeca);
      olhosPretos(cabeca, 0.07, 0.02, 0.105, 0.04, 0.025);
      // 4 nadadeiras planas (curtas mas largas)
      const nadadeiras = [];
      for (let i = 0; i < 4; i++) {
        const n = cubo(0.18, 0.05, 0.08, info.sec);
        n.position.x = (i % 2 === 0 ? -0.32 : 0.32);
        n.position.y = 0.18;
        n.position.z = (i < 2 ? 0.18 : -0.18);
        grp.add(n); nadadeiras.push(n);
      }
      partes.cabeca = cabeca; partes.corpo = corpo; partes.pernas = nadadeiras;
      break;
    }
    case 'papagaio': {
      // Pássaro pequeno colorido com asas + cauda longa + bico curvo
      const corpo = cubo(0.20, 0.30, 0.18, info.cor);
      corpo.position.y = 0.45; grp.add(corpo);
      const cabeca = cubo(0.18, 0.18, 0.16, info.cor);
      cabeca.position.set(0, 0.70, 0.05); grp.add(cabeca);
      // Olhos pretos pequenos
      olhosPretos(cabeca, 0.06, 0.02, 0.085, 0.04, 0.025);
      // Bico curvo amarelo
      const bico = cubo(0.06, 0.06, 0.10, 0xffd54f);
      bico.position.set(0, -0.04, 0.13); cabeca.add(bico);
      // 2 asas com a cor secundária (contraste visual)
      for (const sx of [-0.13, 0.13]) {
        const asa = cubo(0.06, 0.22, 0.20, info.sec);
        asa.position.set(sx, 0.45, 0); grp.add(asa);
      }
      // Cauda longa (3 segmentos colorindo do escuro pro claro)
      for (let s = 0; s < 3; s++) {
        const segCor = s === 0 ? info.sec : (s === 1 ? info.cor : info.sec);
        const seg = cubo(0.10, 0.06, 0.08, segCor);
        seg.position.set(0, 0.40 - s * 0.04, -0.16 - s * 0.08); grp.add(seg);
      }
      // 2 pés pequenos
      for (const sx of [-0.05, 0.05]) {
        const pe = cubo(0.04, 0.06, 0.04, 0xffc107);
        pe.position.set(sx, 0.27, 0); grp.add(pe);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
      break;
    }
    case 'urso_polar': {
      // Urso branco grande, focinho, orelhas redondas, 4 patas robustas
      const corpo = cubo(0.95, 0.65, 1.15, info.cor);
      corpo.position.y = 0.85; grp.add(corpo);
      // Pelos textura (grupos brancos sec)
      for (const sx of [-0.30, 0, 0.30]) {
        const pelo = cubo(0.22, 0.06, 0.05, info.sec);
        pelo.position.set(sx, 1.18, 0.40); grp.add(pelo);
      }
      const cabeca = cubo(0.55, 0.50, 0.50, info.cor);
      cabeca.position.set(0, 1.10, 0.65); grp.add(cabeca);
      olhosPretos(cabeca, 0.13, 0.02, 0.255, 0.06, 0.04);
      // Focinho cinza-claro
      const focinho = cubo(0.30, 0.18, 0.20, info.sec);
      focinho.position.set(0, -0.12, 0.18); cabeca.add(focinho);
      // Nariz preto
      const nariz = cubo(0.08, 0.06, 0.04, 0x1a1a1a);
      nariz.position.set(0, 0.04, 0.10); focinho.add(nariz);
      // 2 orelhas redondas (cubinhos pequenos)
      for (const sx of [-0.20, 0.20]) {
        const orelha = cubo(0.13, 0.13, 0.10, info.cor);
        orelha.position.set(sx, 0.30, -0.05); cabeca.add(orelha);
      }
      // 4 patas robustas
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const p = pernaComPivot(0.25, 0.55, 0.25, info.sec, 0.55);
        p.position.x = (i % 2 === 0 ? -0.30 : 0.30);
        p.position.z = (i < 2 ? 0.40 : -0.40);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo; partes.pernas = pernas;
      break;
    }
    case 'coelho': {
      // Corpo bege oval pequeno + cabeça com 2 orelhas longas + pernas traseiras grandes
      const corpo = cubo(0.30, 0.22, 0.40, info.cor);
      corpo.position.y = 0.30; grp.add(corpo);
      const cabeca = cubo(0.22, 0.20, 0.22, info.cor);
      cabeca.position.set(0, 0.48, 0.20); grp.add(cabeca);
      // Olhos pretos pequenos
      olhosPretos(cabeca, 0.07, 0.02, 0.115, 0.04, 0.025);
      // Nariz rosa
      const nariz = cubo(0.04, 0.03, 0.03, 0xf48fb1);
      nariz.position.set(0, -0.05, 0.115); cabeca.add(nariz);
      // 2 orelhas verticais longas (caracteristica do coelho)
      for (const sx of [-0.06, 0.06]) {
        const orelha = cubo(0.05, 0.20, 0.04, info.cor);
        orelha.position.set(sx, 0.18, -0.04); cabeca.add(orelha);
        // Interior rosa da orelha
        const orInt = cubo(0.03, 0.16, 0.02, 0xf48fb1);
        orInt.position.set(0, 0, 0.025); orelha.add(orInt);
      }
      // Cauda branca pequena (pompom traseiro)
      const cauda = cubo(0.10, 0.10, 0.08, 0xfafafa);
      cauda.position.set(0, 0.30, -0.22); grp.add(cauda);
      // 2 pernas dianteiras curtas + 2 traseiras maiores (pra pular)
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const traseira = i >= 2;
        const altPerna = traseira ? 0.20 : 0.16;
        const p = pernaComPivot(0.07, altPerna, 0.07, info.sec, 0.20);
        p.position.x = (i % 2 === 0 ? -0.10 : 0.10);
        p.position.z = traseira ? -0.13 : 0.13;
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo; partes.pernas = pernas;
      break;
    }
    case 'galinha': {
      const corpo = cubo(0.32, 0.38, 0.45, info.cor);
      corpo.position.y = 0.5; grp.add(corpo);
      const cabeca = cubo(0.24, 0.26, 0.24, info.cor);
      cabeca.position.set(0, 0.80, 0.22); grp.add(cabeca);
      olhosPretos(cabeca, 0.08, 0.02, 0.13, 0.05, 0.025);
      // Crista vermelha tripla (em cima da cabeça)
      const crista1 = cubo(0.06, 0.10, 0.04, 0xC62828);
      crista1.position.set(0, 0.18, 0.05); cabeca.add(crista1);
      const crista2 = cubo(0.06, 0.08, 0.04, 0xC62828);
      crista2.position.set(0, 0.18, -0.05); cabeca.add(crista2);
      // Bico amarelo
      const bico = cubo(0.10, 0.08, 0.14, info.sec);
      bico.position.set(0, -0.04, 0.18); cabeca.add(bico);
      // Barbela vermelha sob bico
      const barbela = cubo(0.06, 0.06, 0.04, 0xC62828);
      barbela.position.set(0, -0.14, 0.10); cabeca.add(barbela);
      // Asas (2 cubinhos finos nos lados do corpo)
      const asaE = cubo(0.05, 0.30, 0.36, info.cor);
      asaE.position.set(-0.18, 0.50, 0); grp.add(asaE);
      const asaD = cubo(0.05, 0.30, 0.36, info.cor);
      asaD.position.set( 0.18, 0.50, 0); grp.add(asaD);
      // Cauda (penas)
      const caudaP = cubo(0.20, 0.26, 0.10, info.cor);
      caudaP.position.set(0, 0.62, -0.28); grp.add(caudaP);
      caudaP.rotation.x = -0.4;
      const pernas = [];
      for (let i = 0; i < 2; i++) {
        const p = pernaComPivot(0.06, 0.28, 0.06, info.sec, 0.28);
        p.position.x = (i === 0 ? -0.10 : 0.10);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.pernas = pernas; partes.corpo = corpo;
      break;
    }
    case 'drowned':
    case 'husk':
    case 'zumbi': {
      const corpo = cubo(0.55, 0.75, 0.30, info.cor);
      corpo.position.y = 1.05; grp.add(corpo);
      const cabeca = cubo(0.48, 0.48, 0.48, info.cor);
      cabeca.position.set(0, 1.65, 0); grp.add(cabeca);
      // Olhos: drowned tem azul brilhante, husk tem amarelo, zumbi vermelho
      const corOlho = tipo === 'drowned' ? 0x40c4ff : tipo === 'husk' ? 0xffc107 : 0xff3d00;
      olhosBrilhantes(cabeca, 0.11, 0.02, 0.245, corOlho, 0.07);
      // Boca aberta com dentes
      const boca = cubo(0.20, 0.06, 0.02, 0x1a1a1a);
      boca.position.set(0, -0.13, 0.245); cabeca.add(boca);
      // Cabelo bagunçado em cima (drowned: algas; husk: faixa de areia)
      const corCabelo = tipo === 'drowned' ? 0x33691e : tipo === 'husk' ? 0xfdd835 : 0x2e7d32;
      const cabelo = cubo(0.50, 0.06, 0.50, corCabelo);
      cabelo.position.set(0, 0.27, 0); cabeca.add(cabelo);
      // Drowned: algas penduradas dos braços (3 fitas verdes)
      if (tipo === 'drowned') {
        for (let s = -1; s <= 1; s++) {
          const alga = cubo(0.10, 0.18, 0.04, 0x2e7d32);
          alga.position.set(s * 0.18, 0.85, 0.18);
          grp.add(alga);
        }
      }
      // Husk: faixas de tecido bege descendo do corpo (esfarrapado)
      if (tipo === 'husk') {
        for (let s of [-0.18, 0.18]) {
          const faixa = cubo(0.10, 0.20, 0.04, 0xa1887f);
          faixa.position.set(s, 0.65, 0.18);
          grp.add(faixa);
        }
      }
      // Braços ESTENDIDOS (zumbi clássico)
      const bracos = [];
      for (let i = 0; i < 2; i++) {
        const b = pernaComPivot(0.18, 0.65, 0.18, info.cor, 1.35);
        b.position.x = (i === 0 ? -0.36 : 0.36);
        b.rotation.x = -1.4; // estendido pra frente
        grp.add(b); bracos.push(b);
      }
      const pernas = [];
      for (let i = 0; i < 2; i++) {
        const p = pernaComPivot(0.20, 0.66, 0.20, info.sec, 0.66);
        p.position.x = (i === 0 ? -0.13 : 0.13);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
      partes.bracos = bracos; partes.pernas = pernas;
      break;
    }
    case 'stray':
    case 'esqueleto': {
      // Corpo magro com costelas
      const corpo = cubo(0.42, 0.72, 0.18, info.cor);
      corpo.position.y = 1.04; grp.add(corpo);
      // Stray: faixas de tecido frio azuladas penduradas (decoração)
      if (tipo === 'stray') {
        for (const sx of [-0.20, 0, 0.20]) {
          const faixa = cubo(0.12, 0.16, 0.04, 0x4fc3f7);
          faixa.position.set(sx, 0.65, 0.10); grp.add(faixa);
        }
      }
      // Costelas (3 listras horizontais)
      for (let r = 0; r < 3; r++) {
        const rib = cubo(0.44, 0.04, 0.20, 0xb0bec5);
        rib.position.set(0, 1.20 - r * 0.18, 0); grp.add(rib);
      }
      // Crânio
      const cabeca = cubo(0.46, 0.46, 0.46, info.cor);
      cabeca.position.set(0, 1.65, 0); grp.add(cabeca);
      // Olhos vazios pretos (cavernosos)
      for (const sx of [-0.10, 0.10]) {
        const o = cubo(0.10, 0.12, 0.04, 0x000000);
        o.position.set(sx, 0.04, 0.235); cabeca.add(o);
      }
      // Mandíbula fixa abaixo
      const mand = cubo(0.34, 0.06, 0.44, info.cor);
      mand.position.set(0, -0.20, 0); cabeca.add(mand);
      const dentes = cubo(0.30, 0.04, 0.02, 0xfafafa);
      dentes.position.set(0, -0.18, 0.20); cabeca.add(dentes);
      // Braços ossudos finos
      const bracos = [];
      for (let i = 0; i < 2; i++) {
        const b = pernaComPivot(0.10, 0.65, 0.10, info.cor, 1.35);
        b.position.x = (i === 0 ? -0.30 : 0.30);
        grp.add(b); bracos.push(b);
      }
      const pernas = [];
      for (let i = 0; i < 2; i++) {
        const p = pernaComPivot(0.12, 0.65, 0.12, info.cor, 0.65);
        p.position.x = (i === 0 ? -0.10 : 0.10);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
      partes.bracos = bracos; partes.pernas = pernas;
      break;
    }
    case 'cave_spider': {
      // Cave spider = aranha menor (escala 0.7) azul escura, com pernas
      // mais longas. Reusa estrutura da aranha mas com paleta diferente.
      const corpoTras = cubo(0.55, 0.35, 0.45, info.cor);
      corpoTras.position.set(0, 0.40, -0.15); grp.add(corpoTras);
      const cabeca = cubo(0.32, 0.28, 0.32, info.sec);
      cabeca.position.set(0, 0.40, 0.28); grp.add(cabeca);
      // 6 olhos vermelhos brilhantes (2 fileiras × 3)
      const escleraMatCS = matCor(0xffffff);
      for (let row = 0; row < 2; row++) {
        for (let col = 0; col < 3; col++) {
          const x = -0.10 + col * 0.10;
          const y = 0.04 - row * 0.08;
          const escl = new THREE.Mesh(new THREE.BoxGeometry(0.04, 0.04, 0.02), escleraMatCS);
          escl.position.set(x, y, 0.165);
          cabeca.add(escl);
          const pup = cuboEm(0.020, 0.020, 0.020, 0xff1744, 1.2);
          pup.position.set(x, y, 0.171);
          cabeca.add(pup);
        }
      }
      // Presas envenenadoras (verde)
      for (const sx of [-0.07, 0.07]) {
        const pr = cubo(0.04, 0.10, 0.04, 0x76ff03);
        pr.position.set(sx, -0.15, 0.16); cabeca.add(pr);
      }
      const pernasCS = [];
      for (let i = 0; i < 8; i++) {
        const lado = i < 4 ? -1 : 1;
        // Pernas mais finas e mais longas que aranha normal
        const p = pernaComPivot(0.05, 0.50, 0.05, 0x0d47a1, 0.40);
        p.position.set(lado * 0.25, 0.40,
          (i < 4 ? i - 1.5 : (i - 5.5)) * 0.12);
        p.rotation.z = lado * (0.55 + (i % 4) * 0.05);
        grp.add(p); pernasCS.push(p);
      }
      partes.cabeca = cabeca; partes.pernas = pernasCS;
      break;
    }
    case 'aranha': {
      const corpoTras = cubo(0.80, 0.50, 0.65, info.cor);
      corpoTras.position.set(0, 0.45, -0.20); grp.add(corpoTras);
      // Padrão de hourglass vermelho no traseiro
      const hg = cubo(0.30, 0.20, 0.04, info.sec);
      hg.position.set(0, 0.45, -0.50); grp.add(hg);
      const cabeca = cubo(0.45, 0.40, 0.45, info.sec);
      cabeca.position.set(0, 0.45, 0.40); grp.add(cabeca);
      // 8 olhos: sclera branca + pupila vermelha emissiva (4×2)
      const escleraMat = matCor(0xffffff);
      for (let row = 0; row < 2; row++) {
        for (let col = 0; col < 4; col++) {
          const x = -0.18 + col * 0.12;
          const y = 0.05 - row * 0.10;
          const escl = new THREE.Mesh(new THREE.BoxGeometry(0.05, 0.05, 0.02), escleraMat);
          escl.position.set(x, y, 0.235);
          cabeca.add(escl);
          const pup = cuboEm(0.025, 0.025, 0.025, 0xff1744, 1.0);
          pup.position.set(x, y, 0.241);
          cabeca.add(pup);
        }
      }
      // Presas
      for (const sx of [-0.08, 0.08]) {
        const pr = cubo(0.04, 0.10, 0.04, 0xfafafa);
        pr.position.set(sx, -0.20, 0.20); cabeca.add(pr);
      }
      const pernas = [];
      for (let i = 0; i < 8; i++) {
        const lado = i < 4 ? -1 : 1;
        const p = pernaComPivot(0.07, 0.55, 0.07, 0x000000, 0.45);
        p.position.set(lado * 0.32, 0.45,
          (i < 4 ? i - 1.5 : (i - 5.5)) * 0.16);
        p.rotation.z = lado * (0.5 + (i % 4) * 0.05);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.pernas = pernas;
      break;
    }
    case 'creeper': {
      const corpo = cubo(0.45, 1.30, 0.45, info.cor);
      corpo.position.y = 0.95; grp.add(corpo);
      // Padrão "vine" no corpo (manchas escuras)
      for (let i = 0; i < 4; i++) {
        const v = cubo(0.46, 0.12, 0.02, info.sec);
        v.position.set((i % 2 ? 0.10 : -0.10), 1.30 - i * 0.30, 0.225); grp.add(v);
      }
      const cabeca = cubo(0.46, 0.46, 0.46, info.sec);
      cabeca.position.set(0, 1.72, 0); grp.add(cabeca);
      // Face clássica creeper: 2 olhos pretos quadrados + boca em cruz
      for (const sx of [-0.12, 0.12]) {
        const o = cubo(0.12, 0.12, 0.04, 0x000000);
        o.position.set(sx, 0.05, 0.235); cabeca.add(o);
      }
      // Boca: cubo central + 2 cubinhos descendo (formato MC)
      const bocaC = cubo(0.10, 0.12, 0.04, 0x000000);
      bocaC.position.set(0, -0.10, 0.235); cabeca.add(bocaC);
      for (const sx of [-0.12, 0.12]) {
        const b = cubo(0.10, 0.10, 0.04, 0x000000);
        b.position.set(sx, -0.18, 0.235); cabeca.add(b);
      }
      // 4 patas curtas (paridade MC creeper)
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const dx = (i % 2 === 0 ? -0.13 : 0.13);
        const dz = (i < 2 ? 0.13 : -0.13);
        const p = pernaComPivot(0.18, 0.30, 0.18, info.cor, 0.30);
        p.position.x = dx; p.position.z = dz;
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.pernas = pernas; partes.corpo = corpo;
      break;
    }
    case 'camelo': {
      // Camelo grande com 2 corcovas + pescoço comprido + cabeça pequena
      const corpo = cubo(0.85, 0.55, 1.40, info.cor);
      corpo.position.y = 1.20; grp.add(corpo);
      // 2 corcovas (clássico do dromedário/camelo bactriano)
      const corcova1 = cubo(0.55, 0.30, 0.40, info.cor);
      corcova1.position.set(0, 1.62, 0.20); grp.add(corcova1);
      const corcova2 = cubo(0.55, 0.30, 0.40, info.cor);
      corcova2.position.set(0, 1.62, -0.30); grp.add(corcova2);
      // Pescoço longo (vertical inclinado pra frente)
      const pescoco = cubo(0.30, 0.70, 0.30, info.cor);
      pescoco.position.set(0, 1.55, 0.75); grp.add(pescoco);
      // Cabeça
      const cabeca = cubo(0.32, 0.32, 0.40, info.cor);
      cabeca.position.set(0, 2.05, 0.85); grp.add(cabeca);
      olhosPretos(cabeca, 0.10, 0.06, 0.205, 0.05, 0.04);
      // Boca/focinho mais escuro
      const focinho = cubo(0.20, 0.10, 0.10, info.sec);
      focinho.position.set(0, -0.10, 0.20); cabeca.add(focinho);
      // 2 orelhas pequenas em cima
      for (const sx of [-0.10, 0.10]) {
        const o = cubo(0.06, 0.10, 0.04, info.cor);
        o.position.set(sx, 0.20, -0.05); cabeca.add(o);
      }
      // 4 pernas LONGAS (caracteristica camelo)
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const p = pernaComPivot(0.18, 1.10, 0.18, info.sec, 1.10);
        p.position.x = (i % 2 === 0 ? -0.30 : 0.30);
        p.position.z = (i < 2 ? 0.50 : -0.50);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo; partes.pernas = pernas;
      break;
    }
    case 'axolote': {
      // Anfíbio rosa pequeno: corpo + cabeça grande + 4 patinhas + cauda
      const corpo = cubo(0.30, 0.20, 0.40, info.cor);
      corpo.position.y = 0.25; grp.add(corpo);
      const cabeca = cubo(0.26, 0.22, 0.22, info.cor);
      cabeca.position.set(0, 0.30, 0.26); grp.add(cabeca);
      olhosPretos(cabeca, 0.09, 0.04, 0.115, 0.04, 0.025);
      // Boca rosa-escura
      const boca = cubo(0.10, 0.02, 0.02, info.sec);
      boca.position.set(0, -0.06, 0.115); cabeca.add(boca);
      // 6 antenas/guelras coloridas (3 de cada lado)
      for (const sx of [-0.13, 0.13]) {
        for (let i = 0; i < 3; i++) {
          const ant = cubo(0.04, 0.02, 0.06, info.sec);
          ant.position.set(sx, 0.05 - i * 0.04, -0.05); cabeca.add(ant);
        }
      }
      // Cauda longa (3 segmentos diminuindo)
      for (let s = 0; s < 3; s++) {
        const seg = cubo(0.10 - s * 0.02, 0.06, 0.08, info.cor);
        seg.position.set(0, 0.25, -0.20 - s * 0.08); grp.add(seg);
      }
      // 4 patinhas
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const p = cubo(0.05, 0.06, 0.05, info.sec);
        p.position.x = (i % 2 === 0 ? -0.13 : 0.13);
        p.position.y = 0.12;
        p.position.z = (i < 2 ? 0.10 : -0.10);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo; partes.pernas = pernas;
      break;
    }
    case 'raposa': {
      // Raposa laranja com peito branco + cauda longa fofa
      const corpo = cubo(0.45, 0.30, 0.70, info.cor);
      corpo.position.y = 0.55; grp.add(corpo);
      // Peito branco
      const peito = cubo(0.30, 0.20, 0.20, info.sec);
      peito.position.set(0, 0.50, 0.30); grp.add(peito);
      // Cabeça laranja com focinho branco
      const cabeca = cubo(0.40, 0.34, 0.38, info.cor);
      cabeca.position.set(0, 0.78, 0.40); grp.add(cabeca);
      olhosPretos(cabeca, 0.13, 0.04, 0.195, 0.05, 0.04);
      // Focinho branco
      const focinho = cubo(0.20, 0.16, 0.14, info.sec);
      focinho.position.set(0, -0.06, 0.16); cabeca.add(focinho);
      // Nariz preto
      const nariz = cubo(0.06, 0.04, 0.04, 0x000000);
      nariz.position.set(0, 0.04, 0.075); focinho.add(nariz);
      // 2 orelhas triangulares pretas
      for (const sx of [-0.14, 0.14]) {
        const o = cubo(0.10, 0.12, 0.06, info.cor);
        o.position.set(sx, 0.20, -0.05); cabeca.add(o);
        const oInt = cubo(0.06, 0.08, 0.04, 0x000000);
        oInt.position.set(0, -0.01, 0.025); o.add(oInt);
      }
      // Cauda longa fofa (3 segmentos com ponta branca)
      for (let s = 0; s < 3; s++) {
        const corCauda = s === 2 ? info.sec : info.cor;
        const seg = cubo(0.18 - s * 0.02, 0.20, 0.18, corCauda);
        seg.position.set(0, 0.55, -0.40 - s * 0.16); grp.add(seg);
      }
      // 4 patas
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const p = pernaComPivot(0.10, 0.32, 0.10, 0x4e342e, 0.32);
        p.position.x = (i % 2 === 0 ? -0.15 : 0.15);
        p.position.z = (i < 2 ? 0.20 : -0.20);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo; partes.pernas = pernas;
      break;
    }
    case 'blaze': {
      // Blaze: cabeça flutuante + 8 hastes amarelas em volta + chamas
      const matBril = new THREE.MeshLambertMaterial({
        color: info.cor, emissive: info.cor, emissiveIntensity: 0.7,
      });
      const matHaste = new THREE.MeshLambertMaterial({
        color: info.sec, emissive: info.sec, emissiveIntensity: 0.5,
      });
      // Cabeça grande emissive
      const cabeca = new THREE.Mesh(new THREE.BoxGeometry(0.55, 0.55, 0.55), matBril);
      cabeca.position.y = 1.05; grp.add(cabeca);
      // Olhos pretos
      olhosPretos(cabeca, 0.11, 0.02, 0.285, 0.07, 0.04);
      // 8 hastes flutuantes ao redor (rotacionando livre)
      for (let i = 0; i < 8; i++) {
        const ang = (i / 8) * Math.PI * 2;
        const haste = new THREE.Mesh(new THREE.BoxGeometry(0.10, 0.50, 0.10), matHaste);
        const r = 0.45;
        haste.position.set(Math.cos(ang) * r, 1.0 + Math.sin(i * 0.5) * 0.2, Math.sin(ang) * r);
        grp.add(haste);
      }
      // 4 chamas no topo
      for (let i = 0; i < 4; i++) {
        const ang = (i / 4) * Math.PI * 2;
        const chama = new THREE.Mesh(new THREE.BoxGeometry(0.08, 0.20, 0.08), matBril);
        chama.position.set(Math.cos(ang) * 0.20, 1.55, Math.sin(ang) * 0.20);
        grp.add(chama);
      }
      partes.cabeca = cabeca;
      break;
    }
    case 'glow_squid': {
      // Cabeça/manto cônico ciano + 8 tentáculos pendurados (4 longos + 4 curtos)
      // Material emissive (brilha sozinho na água escura)
      const matBril = new THREE.MeshLambertMaterial({
        color: info.cor, emissive: info.cor, emissiveIntensity: 0.8,
      });
      const matBrilSec = new THREE.MeshLambertMaterial({
        color: info.sec, emissive: info.sec, emissiveIntensity: 0.5,
      });
      // Cabeça/manto: trapezoide aprox via 2 cubos empilhados
      const manto1 = new THREE.Mesh(new THREE.BoxGeometry(0.40, 0.20, 0.40), matBril);
      manto1.position.y = 0.55; grp.add(manto1);
      const manto2 = new THREE.Mesh(new THREE.BoxGeometry(0.30, 0.18, 0.30), matBril);
      manto2.position.y = 0.78; grp.add(manto2);
      // Olhos ciano-claros emissivos (lateral do manto)
      for (const sx of [-0.21, 0.21]) {
        const o = new THREE.Mesh(new THREE.BoxGeometry(0.04, 0.04, 0.06), matBril);
        o.position.set(sx, 0.55, 0); grp.add(o);
        // Pupila escura
        const pup = cubo(0.02, 0.02, 0.025, 0x000000);
        pup.position.set(sx + (sx < 0 ? -0.025 : 0.025), 0.55, 0); grp.add(pup);
      }
      // 8 tentáculos pendurados (4 longos + 4 curtos)
      for (let i = 0; i < 8; i++) {
        const longo = i < 4;
        const altT = longo ? 0.45 : 0.25;
        const t = new THREE.Mesh(new THREE.BoxGeometry(0.05, altT, 0.05), matBrilSec);
        const ang = (i / 8) * Math.PI * 2;
        t.position.set(Math.cos(ang) * 0.13, 0.55 - altT / 2 - 0.10, Math.sin(ang) * 0.13);
        grp.add(t);
      }
      partes.cabeca = manto1; partes.corpo = manto2;
      break;
    }
    case 'bee': {
      // Corpo amarelo com listras pretas (clássico abelha) + asas + ferrão
      const corpo = cubo(0.30, 0.22, 0.26, info.cor);
      corpo.position.y = 0.55; grp.add(corpo);
      // 3 listras pretas no corpo
      for (const z of [-0.10, 0, 0.10]) {
        const listra = cubo(0.31, 0.06, 0.04, info.sec);
        listra.position.set(0, 0.55, z); grp.add(listra);
      }
      // Cabeça preta pequena
      const cabeca = cubo(0.20, 0.18, 0.16, info.sec);
      cabeca.position.set(0, 0.55, 0.18); grp.add(cabeca);
      // Olhos brancos
      for (const sx of [-0.06, 0.06]) {
        const o = cubo(0.05, 0.07, 0.02, 0xfafafa);
        o.position.set(sx, 0, 0.085); cabeca.add(o);
      }
      // Antenas pequenas (2 cubinhos finos)
      for (const sx of [-0.04, 0.04]) {
        const ant = cubo(0.02, 0.10, 0.02, info.sec);
        ant.position.set(sx, 0.13, 0.04); cabeca.add(ant);
      }
      // Ferrão preto traseiro
      const ferrao = cubo(0.04, 0.04, 0.06, info.sec);
      ferrao.position.set(0, 0.55, -0.18); grp.add(ferrao);
      // 4 asas translúcidas brancas (par superior + par inferior)
      const asaMat = matCor(0xfafafa);
      asaMat.transparent = true;
      asaMat.opacity = 0.55;
      for (let i = 0; i < 4; i++) {
        const asa = new THREE.Mesh(new THREE.BoxGeometry(0.04, 0.10, 0.18), asaMat);
        const lado = i < 2 ? -1 : 1;
        const cima = i % 2 === 0 ? 1 : -1;
        asa.position.set(lado * 0.13, 0.65 + cima * 0.04, -0.04);
        asa.rotation.z = lado * 0.25;
        grp.add(asa);
      }
      // Pernas pequenas (4)
      for (let i = 0; i < 4; i++) {
        const p = cubo(0.03, 0.08, 0.03, info.sec);
        p.position.x = (i % 2 === 0 ? -0.10 : 0.10);
        p.position.y = 0.40;
        p.position.z = (i < 2 ? -0.06 : 0.06);
        grp.add(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
      break;
    }
    case 'magma_cube':
    case 'slime': {
      // Corpo gelatinoso semi-transparente
      const corpoMat = new THREE.MeshLambertMaterial({
        color: info.cor, transparent: true, opacity: 0.78,
        emissive: tipo === 'magma_cube' ? 0xff5722 : 0x000000,
        emissiveIntensity: tipo === 'magma_cube' ? 0.4 : 0,
      });
      const corpo = new THREE.Mesh(new THREE.BoxGeometry(0.95, 0.95, 0.95), corpoMat);
      corpo.position.y = 0.48; grp.add(corpo);
      // Núcleo interno (visível pela transparência)
      const nucleo = cubo(0.55, 0.55, 0.55, info.sec);
      nucleo.position.y = 0.48; grp.add(nucleo);
      // Cara feliz no núcleo
      olhosPretos(nucleo, 0.18, 0.10, 0.30, 0.10, 0.05);
      // Sorriso (curva via 3 cubinhos)
      const s1 = cubo(0.05, 0.05, 0.04, 0x000000);
      s1.position.set(-0.14, -0.10, 0.30); nucleo.add(s1);
      const s2 = cubo(0.18, 0.04, 0.04, 0x000000);
      s2.position.set(0, -0.14, 0.30); nucleo.add(s2);
      const s3 = cubo(0.05, 0.05, 0.04, 0x000000);
      s3.position.set( 0.14, -0.10, 0.30); nucleo.add(s3);
      partes.corpo = corpo; partes.cabeca = nucleo;
      break;
    }
    case 'enderman': {
      const corpo = cubo(0.40, 1.20, 0.30, info.cor);
      corpo.position.y = 1.50; grp.add(corpo);
      const cabeca = cubo(0.48, 0.55, 0.48, info.cor);
      cabeca.position.set(0, 2.40, 0); grp.add(cabeca);
      // Olhos magenta brilhantes (paridade MC enderman)
      olhosBrilhantes(cabeca, 0.13, 0.05, 0.245, info.sec, 0.10);
      // Boca pequena fechada
      const boca = cubo(0.10, 0.04, 0.02, 0x000000);
      boca.position.set(0, -0.12, 0.245); cabeca.add(boca);
      const pernas = [];
      for (let i = 0; i < 2; i++) {
        const p = pernaComPivot(0.20, 1.05, 0.20, info.cor, 0.95);
        p.position.x = (i === 0 ? -0.13 : 0.13);
        grp.add(p); pernas.push(p);
      }
      // Braços extra-longos (enderman característico)
      const bracos = [];
      for (let i = 0; i < 2; i++) {
        const b = pernaComPivot(0.18, 1.10, 0.18, info.cor, 1.95);
        b.position.x = (i === 0 ? -0.30 : 0.30);
        grp.add(b); bracos.push(b);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
      partes.pernas = pernas; partes.bracos = bracos;
      break;
    }
    case 'cat': {
      // Gato pequeno, baixinho, cauda longa
      const corpo = cubo(0.32, 0.30, 0.55, info.cor);
      corpo.position.y = 0.32; grp.add(corpo);
      const cabeca = cubo(0.30, 0.28, 0.30, info.cor);
      cabeca.position.set(0, 0.46, 0.36); grp.add(cabeca);
      olhosPretos(cabeca, 0.08, 0.04, 0.16, 0.06, 0.03);
      // Orelhas triangulares
      for (const sx of [-0.10, 0.10]) {
        const o = cubo(0.07, 0.10, 0.05, info.cor);
        o.position.set(sx, 0.20, -0.08); cabeca.add(o);
      }
      // Bigode (sec=preto)
      const bigode = cubo(0.18, 0.04, 0.04, info.sec);
      bigode.position.set(0, -0.05, 0.16); cabeca.add(bigode);
      // Cauda longa erguida
      const cauda = cubo(0.06, 0.08, 0.32, info.cor);
      cauda.position.set(0, 0.40, -0.42); grp.add(cauda);
      cauda.rotation.x = 0.6;
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const dx = (i % 2 === 0 ? -0.10 : 0.10);
        const dz = (i < 2 ? 0.18 : -0.18);
        const p = pernaComPivot(0.08, 0.20, 0.08, info.cor, 0.20);
        p.position.x = dx; p.position.z = dz;
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.pernas = pernas; partes.corpo = corpo;
      break;
    }
    case 'villager': {
      // Humanóide com nariz grande característico
      const corpo = cubo(0.50, 0.80, 0.30, info.cor);
      corpo.position.y = 1.05; grp.add(corpo);
      const cabeca = cubo(0.46, 0.46, 0.46, info.sec);
      cabeca.position.set(0, 1.70, 0); grp.add(cabeca);
      olhosPretos(cabeca, 0.12, 0.02, 0.235);
      // Nariz grande pra frente
      const nariz = cubo(0.10, 0.16, 0.18, info.sec);
      nariz.position.set(0, -0.05, 0.30); cabeca.add(nariz);
      // Cabelo cinza no topo
      const cabelo = cubo(0.48, 0.06, 0.48, 0x424242);
      cabelo.position.set(0, 0.26, 0); cabeca.add(cabelo);
      const bracos = [];
      for (let i = 0; i < 2; i++) {
        const b = pernaComPivot(0.16, 0.70, 0.16, info.cor, 1.40);
        b.position.x = (i === 0 ? -0.33 : 0.33);
        // Braços cruzados na frente do corpo (típico villager)
        b.rotation.x = -1.2;
        grp.add(b); bracos.push(b);
      }
      const pernas = [];
      for (let i = 0; i < 2; i++) {
        const p = pernaComPivot(0.18, 0.65, 0.18, info.cor, 0.65);
        p.position.x = (i === 0 ? -0.11 : 0.11);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
      partes.bracos = bracos; partes.pernas = pernas;
      break;
    }
    case 'iron_golem': {
      // Tank grande, peito largo, braços enormes
      const corpo = cubo(0.85, 1.10, 0.55, info.cor);
      corpo.position.y = 1.20; grp.add(corpo);
      // Detalhe verde no peito (vine — paridade MC)
      const peito = cubo(0.30, 0.35, 0.04, info.sec);
      peito.position.set(0, 1.30, 0.28); grp.add(peito);
      const cabeca = cubo(0.40, 0.55, 0.45, info.cor);
      cabeca.position.set(0, 2.00, 0); grp.add(cabeca);
      // Olhos vermelhos pequenos
      olhosBrilhantes(cabeca, 0.10, 0.05, 0.225, 0xff5252, 0.06);
      // Nariz protuberante
      const nariz = cubo(0.10, 0.20, 0.15, info.cor);
      nariz.position.set(0, -0.10, 0.28); cabeca.add(nariz);
      // Braços enormes pendurados até o chão
      const bracos = [];
      for (let i = 0; i < 2; i++) {
        const b = pernaComPivot(0.30, 1.40, 0.30, info.cor, 1.85);
        b.position.x = (i === 0 ? -0.55 : 0.55);
        grp.add(b); bracos.push(b);
      }
      // Pernas curtas e largas
      const pernas = [];
      for (let i = 0; i < 2; i++) {
        const p = pernaComPivot(0.32, 0.65, 0.32, info.cor, 0.65);
        p.position.x = (i === 0 ? -0.20 : 0.20);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
      partes.bracos = bracos; partes.pernas = pernas;
      break;
    }
    case 'witch': {
      // Robe roxo + chapéu pontudo preto
      const corpo = cubo(0.50, 0.80, 0.30, info.cor);
      corpo.position.y = 1.05; grp.add(corpo);
      const cabeca = cubo(0.42, 0.42, 0.42, 0xa1887f); // pele clara
      cabeca.position.set(0, 1.66, 0); grp.add(cabeca);
      olhosBrilhantes(cabeca, 0.11, 0.04, 0.225, 0x69f0ae, 0.07); // olhos verdes
      // Nariz pontudo
      const nariz = cubo(0.08, 0.12, 0.20, 0xa1887f);
      nariz.position.set(0, -0.04, 0.32); cabeca.add(nariz);
      // Verruga
      const verruga = cubo(0.04, 0.04, 0.04, 0x424242);
      verruga.position.set(0.04, 0.10, 0.32); cabeca.add(verruga);
      // Chapéu pontudo (cone via cubo + pequeno topo)
      const chapeuBase = cubo(0.55, 0.08, 0.55, info.sec);
      chapeuBase.position.set(0, 0.27, 0); cabeca.add(chapeuBase);
      const chapeuMeio = cubo(0.30, 0.20, 0.30, info.sec);
      chapeuMeio.position.set(0, 0.40, 0); cabeca.add(chapeuMeio);
      const chapeuPonta = cubo(0.10, 0.20, 0.10, info.sec);
      chapeuPonta.position.set(0.06, 0.55, 0); cabeca.add(chapeuPonta);
      chapeuPonta.rotation.z = -0.4;
      const bracos = [];
      for (let i = 0; i < 2; i++) {
        const b = pernaComPivot(0.16, 0.70, 0.16, info.cor, 1.40);
        b.position.x = (i === 0 ? -0.33 : 0.33);
        grp.add(b); bracos.push(b);
      }
      const pernas = [];
      for (let i = 0; i < 2; i++) {
        const p = pernaComPivot(0.18, 0.65, 0.18, info.cor, 0.65);
        p.position.x = (i === 0 ? -0.11 : 0.11);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
      partes.bracos = bracos; partes.pernas = pernas;
      break;
    }
    case 'snow_golem': {
      // Bola de neve grande (corpo) + bola média (peito) + cabeça pumpkin
      const bolaBase = cubo(0.65, 0.65, 0.65, info.cor);
      bolaBase.position.y = 0.40; grp.add(bolaBase);
      const bolaPeito = cubo(0.55, 0.55, 0.55, info.cor);
      bolaPeito.position.y = 1.05; grp.add(bolaPeito);
      // Cabeça pumpkin laranja
      const cabeca = cubo(0.50, 0.50, 0.50, info.sec);
      cabeca.position.y = 1.65; grp.add(cabeca);
      // Face talhada na pumpkin (olhos triangulares amarelos)
      for (const sx of [-0.12, 0.12]) {
        const olho = new THREE.Mesh(
          new THREE.BoxGeometry(0.08, 0.08, 0.04),
          new THREE.MeshLambertMaterial({ color: 0xfff59d, emissive: 0xfff59d, emissiveIntensity: 0.7 }),
        );
        olho.position.set(sx, 0.05, 0.255);
        cabeca.add(olho);
      }
      // Boca jack-o-lantern
      const boca = new THREE.Mesh(
        new THREE.BoxGeometry(0.20, 0.06, 0.04),
        new THREE.MeshLambertMaterial({ color: 0xfff59d, emissive: 0xfff59d, emissiveIntensity: 0.5 }),
      );
      boca.position.set(0, -0.10, 0.255); cabeca.add(boca);
      // Braços de gravetos (pernas finas marrom)
      const bracos = [];
      for (let i = 0; i < 2; i++) {
        const b = pernaComPivot(0.08, 0.55, 0.08, 0x6e5235, 1.20);
        b.position.x = (i === 0 ? -0.40 : 0.40);
        b.rotation.z = (i === 0 ? 0.4 : -0.4);
        grp.add(b); bracos.push(b);
      }
      partes.cabeca = cabeca; partes.corpo = bolaBase; partes.bracos = bracos;
      break;
    }
    case 'wandering_trader': {
      // Humanoid robe roxo escuro, nariz grande tipo villager
      const corpo = cubo(0.50, 0.80, 0.30, info.cor);
      corpo.position.y = 1.05; grp.add(corpo);
      const cabeca = cubo(0.46, 0.46, 0.46, info.sec);
      cabeca.position.set(0, 1.70, 0); grp.add(cabeca);
      olhosPretos(cabeca, 0.12, 0.02, 0.235);
      const nariz = cubo(0.10, 0.16, 0.18, info.sec);
      nariz.position.set(0, -0.05, 0.30); cabeca.add(nariz);
      // Chapéu pontudo roxo escuro (caracteristico)
      const chapeuBase = cubo(0.55, 0.10, 0.55, info.cor);
      chapeuBase.position.set(0, 0.27, 0); cabeca.add(chapeuBase);
      const chapeuPonta = cubo(0.20, 0.30, 0.20, info.cor);
      chapeuPonta.position.set(0, 0.45, 0); cabeca.add(chapeuPonta);
      // Cabelo branco/cinza embaixo do chapéu
      const cabelo = cubo(0.48, 0.06, 0.48, 0xb39ddb);
      cabelo.position.set(0, 0.22, 0); cabeca.add(cabelo);
      const bracos = [];
      for (let i = 0; i < 2; i++) {
        const b = pernaComPivot(0.16, 0.70, 0.16, info.cor, 1.40);
        b.position.x = (i === 0 ? -0.33 : 0.33);
        grp.add(b); bracos.push(b);
      }
      const pernas = [];
      for (let i = 0; i < 2; i++) {
        const p = pernaComPivot(0.18, 0.65, 0.18, info.cor, 0.65);
        p.position.x = (i === 0 ? -0.11 : 0.11);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
      partes.bracos = bracos; partes.pernas = pernas;
      break;
    }
    case 'ender_dragon': {
      // Boss gigante: corpo alongado + cabeça com mandíbula + asas grandes + cauda
      const corpo = cubo(1.6, 1.0, 2.4, info.cor);
      corpo.position.y = 1.8; grp.add(corpo);
      // Cabeça (à frente do corpo)
      const cabeca = cubo(1.0, 0.9, 1.4, info.cor);
      cabeca.position.set(0, 1.9, 1.8); grp.add(cabeca);
      // Olhos magenta brilhantes (grandes)
      olhosBrilhantes(cabeca, 0.30, 0.10, 0.71, info.sec, 0.18);
      // Mandíbula inferior (com dentes brancos)
      const mand = cubo(0.9, 0.20, 1.0, info.cor);
      mand.position.set(0, -0.40, 0); cabeca.add(mand);
      const dentes = cubo(0.85, 0.05, 0.05, 0xfafafa);
      dentes.position.set(0, -0.30, 0.50); cabeca.add(dentes);
      // Cauda (segmentos cônicos atrás)
      for (let i = 0; i < 4; i++) {
        const tam = 0.6 - i * 0.1;
        const seg = cubo(tam, tam, 0.6, info.cor);
        seg.position.set(0, 1.8, -1.4 - i * 0.6);
        grp.add(seg);
      }
      // Asas grandes (chapinhas roxas estendidas)
      const asaMat = new THREE.MeshLambertMaterial({
        color: info.sec, transparent: true, opacity: 0.85, side: THREE.DoubleSide,
      });
      for (const sx of [-1, 1]) {
        const asa = new THREE.Mesh(new THREE.BoxGeometry(2.5, 0.10, 1.6), asaMat);
        asa.position.set(sx * 1.6, 2.0, 0.2);
        asa.rotation.z = sx * 0.3;
        grp.add(asa);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
      break;
    }
    case 'ghast': {
      // Cubo branco grande com 9 tentáculos pendurados
      const corpo = cubo(1.4, 1.0, 1.4, info.cor);
      corpo.position.y = 1.30; grp.add(corpo);
      // Olhos vermelhos brilhantes (apertados, característicos)
      olhosBrilhantes(corpo, 0.25, 0.10, 0.71, info.sec, 0.18);
      // Boca pequena fechada (linha vermelha)
      const boca = cubo(0.30, 0.06, 0.04, info.sec);
      boca.position.set(0, -0.20, 0.71); corpo.add(boca);
      // 9 tentáculos pendurados (pivots animáveis)
      const pernas = [];
      for (let i = 0; i < 9; i++) {
        const dx = ((i % 3) - 1) * 0.40;
        const dz = (Math.floor(i / 3) - 1) * 0.40;
        const t = pernaComPivot(0.16, 0.50, 0.16, info.cor, 0.80);
        t.position.x = dx; t.position.z = dz;
        grp.add(t); pernas.push(t);
      }
      partes.corpo = corpo; partes.cabeca = corpo; partes.pernas = pernas;
      break;
    }
    // SPRINT MEGA-7: Models 3D para mobs novos (paridade Minecraft)
    case 'wither': {
      // Boss: 3 cabeças + corpo esqueleto preto + costas espinhas
      const corpo = cubo(0.7, 1.4, 0.3, info.cor); corpo.position.y = 1.0; grp.add(corpo);
      // 3 cabeças
      const cab1 = cubo(0.5, 0.5, 0.5, info.sec); cab1.position.y = 1.9; grp.add(cab1);
      const cab2 = cubo(0.4, 0.4, 0.4, info.sec); cab2.position.set(-0.5, 1.7, 0); grp.add(cab2);
      const cab3 = cubo(0.4, 0.4, 0.4, info.sec); cab3.position.set(0.5, 1.7, 0); grp.add(cab3);
      // Olhos vermelhos brilhantes em cada cabeça
      [cab1, cab2, cab3].forEach(c => {
        const olho = cuboEm(0.05, 0.05, 0.05, 0xff0000, 1.5);
        olho.position.set(-0.1, 0.05, c.geometry.parameters.depth / 2 + 0.01);
        c.add(olho);
        const olho2 = olho.clone(); olho2.position.x = 0.1; c.add(olho2);
      });
      // Espinha vertical (tail)
      const tail = cubo(0.15, 0.4, 0.15, info.cor); tail.position.y = 0.4; grp.add(tail);
      partes.cabeca = cab1; partes.corpo = corpo;
    } break;
    case 'guardian':
    case 'elder_guardian': {
      // Cubo gigante com olho central laranja brilhante
      const big = tipo === 'elder_guardian' ? 1.4 : 1.0;
      const corpo = cubo(0.9 * big, 0.9 * big, 0.9 * big, info.cor);
      corpo.position.y = 0.5 * big; grp.add(corpo);
      // Olho central laranja
      const olho = cuboEm(0.3 * big, 0.3 * big, 0.05, info.sec, 1.0);
      olho.position.set(0, 0.5 * big, 0.46 * big); corpo.add(olho);
      // Espinhos (4 ao redor)
      for (let i = 0; i < 4; i++) {
        const s = cubo(0.1, 0.5 * big, 0.1, info.cor);
        const ang = (i / 4) * Math.PI * 2;
        s.position.set(Math.cos(ang) * 0.55 * big, 0.5 * big, Math.sin(ang) * 0.55 * big);
        grp.add(s);
      }
      partes.cabeca = corpo; partes.corpo = corpo;
    } break;
    case 'warden': {
      // Bicho gigante deepslate com runas azuis brilhantes nas costas
      const corpo = cubo(0.9, 1.6, 0.5, info.cor); corpo.position.y = 1.2; grp.add(corpo);
      const cabeca = cubo(0.7, 0.5, 0.5, info.cor); cabeca.position.y = 2.2; grp.add(cabeca);
      // Runas azuis na cabeça (pulsam)
      const runa1 = cuboEm(0.25, 0.05, 0.05, info.sec, 1.8);
      runa1.position.set(0, 0.15, 0.27); cabeca.add(runa1);
      const runa2 = cuboEm(0.05, 0.20, 0.05, info.sec, 1.8);
      runa2.position.set(-0.1, 0, 0.27); cabeca.add(runa2);
      // Braços longos
      const bracoE = cubo(0.25, 1.6, 0.25, info.cor); bracoE.position.set(-0.6, 1.0, 0); grp.add(bracoE);
      const bracoD = cubo(0.25, 1.6, 0.25, info.cor); bracoD.position.set(0.6, 1.0, 0); grp.add(bracoD);
      // Pernas
      const pernaE = cubo(0.3, 0.6, 0.3, info.cor); pernaE.position.set(-0.2, 0.3, 0); grp.add(pernaE);
      const pernaD = cubo(0.3, 0.6, 0.3, info.cor); pernaD.position.set(0.2, 0.3, 0); grp.add(pernaD);
      partes.cabeca = cabeca; partes.corpo = corpo;
      partes.bracoE = bracoE; partes.bracoD = bracoD;
      partes.pernaE = pernaE; partes.pernaD = pernaD;
    } break;
    case 'phantom': {
      // Manta voadora roxa-escura com olhos
      const corpo = cubo(1.2, 0.15, 0.7, info.cor); corpo.position.y = 0.5; grp.add(corpo);
      // 2 olhos brilhantes
      const olhoE = cuboEm(0.1, 0.05, 0.05, info.sec, 1.5);
      olhoE.position.set(-0.2, 0.55, 0.3); grp.add(olhoE);
      const olhoD = olhoE.clone(); olhoD.position.x = 0.2; grp.add(olhoD);
      // Asas
      const asaE = cubo(0.6, 0.05, 0.4, info.cor); asaE.position.set(-0.7, 0.5, 0); grp.add(asaE);
      const asaD = asaE.clone(); asaD.position.x = 0.7; grp.add(asaD);
      partes.cabeca = corpo; partes.corpo = corpo; partes.asaE = asaE; partes.asaD = asaD;
    } break;
    case 'pillager':
    case 'vindicator': {
      // Humanoid + cores específicas
      const corpo = cubo(0.5, 0.7, 0.3, info.cor); corpo.position.y = 1.0; grp.add(corpo);
      const cabeca = cubo(0.45, 0.5, 0.45, info.sec); cabeca.position.y = 1.6; grp.add(cabeca);
      // Nariz característico (illager)
      const nariz = cubo(0.1, 0.15, 0.2, 0xa1887f); nariz.position.set(0, 1.55, 0.3); grp.add(nariz);
      // Pernas
      const pE = cubo(0.2, 0.6, 0.2, 0x4a4a4a); pE.position.set(-0.15, 0.3, 0); grp.add(pE);
      const pD = pE.clone(); pD.position.x = 0.15; grp.add(pD);
      // Braço com arma (crossbow ou machado)
      const braco = cubo(0.2, 0.5, 0.2, info.cor); braco.position.set(0.4, 1.1, 0); grp.add(braco);
      partes.cabeca = cabeca; partes.corpo = corpo;
      partes.pernaE = pE; partes.pernaD = pD; partes.braco = braco;
    } break;
    case 'evoker': {
      // Robe escuro + dourado
      const corpo = cubo(0.6, 1.0, 0.3, info.cor); corpo.position.y = 0.85; grp.add(corpo);
      const cabeca = cubo(0.45, 0.5, 0.45, 0xa1887f); cabeca.position.y = 1.6; grp.add(cabeca);
      // Capa dourada
      const capa = cubo(0.7, 0.3, 0.05, info.sec); capa.position.set(0, 1.2, 0.16); grp.add(capa);
      // Mãos brilhantes (magic)
      const mao = cuboEm(0.15, 0.15, 0.15, info.sec, 1.0);
      mao.position.set(0.4, 1.0, 0); grp.add(mao);
      partes.cabeca = cabeca; partes.corpo = corpo; partes.mao = mao;
    } break;
    case 'vex': {
      // Pequena fada hostil
      const corpo = cubo(0.3, 0.4, 0.2, info.cor); corpo.position.y = 0.5; grp.add(corpo);
      const cabeca = cubo(0.2, 0.2, 0.2, info.cor); cabeca.position.y = 0.85; grp.add(cabeca);
      // Olhos vermelhos
      const olho = cuboEm(0.05, 0.05, 0.05, info.sec, 1.5);
      olho.position.set(-0.05, 0.85, 0.11); grp.add(olho);
      const olho2 = olho.clone(); olho2.position.x = 0.05; grp.add(olho2);
      // Asas pequenas
      const asaE = cubo(0.25, 0.2, 0.05, 0xeceff1); asaE.position.set(-0.2, 0.6, -0.1); grp.add(asaE);
      const asaD = asaE.clone(); asaD.position.x = 0.2; grp.add(asaD);
      partes.cabeca = cabeca; partes.corpo = corpo; partes.asaE = asaE; partes.asaD = asaD;
    } break;
    case 'ravager': {
      // Bicho gigante com chifres
      const corpo = cubo(1.4, 1.0, 1.6, info.cor); corpo.position.y = 0.7; grp.add(corpo);
      const cabeca = cubo(0.9, 0.7, 0.7, info.cor); cabeca.position.set(0, 0.9, 0.95); grp.add(cabeca);
      // Chifres pretos
      const chif1 = cubo(0.15, 0.4, 0.15, info.sec); chif1.position.set(-0.3, 1.4, 1.0); grp.add(chif1);
      const chif2 = chif1.clone(); chif2.position.x = 0.3; grp.add(chif2);
      // 4 pernas grossas
      for (const [px, pz] of [[-0.5, -0.6], [0.5, -0.6], [-0.5, 0.6], [0.5, 0.6]]) {
        const p = cubo(0.3, 0.5, 0.3, info.cor); p.position.set(px, 0.25, pz); grp.add(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
    } break;
    case 'horse':
    case 'donkey':
    case 'mule': {
      // Cavalo: corpo retangular + cabeça inclinada + 4 pernas
      const corpo = cubo(0.6, 0.7, 1.4, info.cor); corpo.position.y = 0.95; grp.add(corpo);
      const cabeca = cubo(0.4, 0.5, 0.4, info.cor); cabeca.position.set(0, 1.4, 0.85); grp.add(cabeca);
      // Crina
      const crina = cubo(0.1, 0.3, 0.5, info.sec); crina.position.set(0, 1.4, 0.4); grp.add(crina);
      // Orelhas
      const orE = cubo(0.05, 0.15, 0.05, info.cor); orE.position.set(-0.15, 1.65, 0.85); grp.add(orE);
      const orD = orE.clone(); orD.position.x = 0.15; grp.add(orD);
      // 4 pernas
      for (const [px, pz] of [[-0.2, -0.55], [0.2, -0.55], [-0.2, 0.55], [0.2, 0.55]]) {
        const p = cubo(0.18, 0.6, 0.18, info.sec); p.position.set(px, 0.3, pz); grp.add(p);
      }
      // Cauda
      const cauda = cubo(0.1, 0.4, 0.1, info.sec); cauda.position.set(0, 1.0, -0.7); grp.add(cauda);
      partes.cabeca = cabeca; partes.corpo = corpo; partes.cauda = cauda;
    } break;
    case 'llama': {
      const corpo = cubo(0.5, 1.0, 1.2, info.cor); corpo.position.y = 1.0; grp.add(corpo);
      const cabeca = cubo(0.4, 0.4, 0.3, info.cor); cabeca.position.set(0, 1.7, 0.55); grp.add(cabeca);
      // Pescoço longo
      const pesc = cubo(0.3, 0.7, 0.3, info.cor); pesc.position.set(0, 1.5, 0.5); grp.add(pesc);
      for (const [px, pz] of [[-0.18, -0.5], [0.18, -0.5], [-0.18, 0.5], [0.18, 0.5]]) {
        const p = cubo(0.15, 0.6, 0.15, info.sec); p.position.set(px, 0.3, pz); grp.add(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
    } break;
    case 'strider': {
      const corpo = cubo(0.7, 0.7, 1.0, info.cor); corpo.position.y = 1.0; grp.add(corpo);
      // Pernas longas (caminha em lava)
      const pE = cubo(0.15, 1.0, 0.15, info.cor); pE.position.set(-0.3, 0.5, 0); grp.add(pE);
      const pD = pE.clone(); pD.position.x = 0.3; grp.add(pD);
      // Listras amarelas
      const listra = cubo(0.71, 0.1, 1.01, info.sec); listra.position.y = 1.0; grp.add(listra);
      partes.cabeca = corpo; partes.corpo = corpo;
    } break;
    case 'piglin':
    case 'zombified_piglin': {
      const corpo = cubo(0.5, 0.8, 0.3, info.cor); corpo.position.y = 1.0; grp.add(corpo);
      const cabeca = cubo(0.5, 0.5, 0.5, info.cor); cabeca.position.y = 1.6; grp.add(cabeca);
      // Focinho de porco
      const focinho = cubo(0.3, 0.2, 0.15, 0xa1887f); focinho.position.set(0, 1.55, 0.3); grp.add(focinho);
      // Olhos
      const olho = cuboEm(0.06, 0.06, 0.05, 0xfafafa, 0.3);
      olho.position.set(-0.1, 1.7, 0.26); grp.add(olho);
      const olho2 = olho.clone(); olho2.position.x = 0.1; grp.add(olho2);
      for (const [px, pz] of [[-0.15, -0.05], [0.15, -0.05]]) {
        const p = cubo(0.2, 0.5, 0.2, info.cor); p.position.set(px, 0.3, pz); grp.add(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
    } break;
    case 'hoglin':
    case 'zoglin': {
      const corpo = cubo(1.0, 0.9, 1.5, info.cor); corpo.position.y = 0.7; grp.add(corpo);
      const cabeca = cubo(0.7, 0.5, 0.5, info.cor); cabeca.position.set(0, 0.95, 0.95); grp.add(cabeca);
      // Presas
      const pres1 = cubo(0.1, 0.15, 0.1, 0xfafafa); pres1.position.set(-0.2, 0.85, 1.18); grp.add(pres1);
      const pres2 = pres1.clone(); pres2.position.x = 0.2; grp.add(pres2);
      for (const [px, pz] of [[-0.35, -0.5], [0.35, -0.5], [-0.35, 0.5], [0.35, 0.5]]) {
        const p = cubo(0.2, 0.4, 0.2, info.sec); p.position.set(px, 0.2, pz); grp.add(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
    } break;
    case 'endermite':
    case 'silverfish': {
      // Pequenos
      const corpo = cubo(0.35, 0.25, 0.25, info.cor); corpo.position.y = 0.15; grp.add(corpo);
      // Olhos brilhantes
      const olho = cuboEm(0.05, 0.05, 0.05, info.sec, 1.0);
      olho.position.set(-0.08, 0.18, 0.13); grp.add(olho);
      const olho2 = olho.clone(); olho2.position.x = 0.08; grp.add(olho2);
      partes.cabeca = corpo; partes.corpo = corpo;
    } break;
    case 'goat': {
      const corpo = cubo(0.5, 0.7, 1.0, info.cor); corpo.position.y = 0.7; grp.add(corpo);
      const cabeca = cubo(0.4, 0.4, 0.4, info.cor); cabeca.position.set(0, 1.05, 0.65); grp.add(cabeca);
      // Chifres
      const ch1 = cubo(0.05, 0.25, 0.05, info.sec); ch1.position.set(-0.1, 1.3, 0.6); grp.add(ch1);
      const ch2 = ch1.clone(); ch2.position.x = 0.1; grp.add(ch2);
      for (const [px, pz] of [[-0.18, -0.35], [0.18, -0.35], [-0.18, 0.35], [0.18, 0.35]]) {
        const p = cubo(0.15, 0.4, 0.15, info.sec); p.position.set(px, 0.2, pz); grp.add(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
    } break;
    case 'panda': {
      const corpo = cubo(0.9, 0.9, 1.3, info.cor); corpo.position.y = 0.6; grp.add(corpo);
      const cabeca = cubo(0.7, 0.6, 0.7, info.cor); cabeca.position.set(0, 1.05, 0.7); grp.add(cabeca);
      // Olhos pretos
      const olhoE = cubo(0.18, 0.18, 0.05, info.sec); olhoE.position.set(-0.18, 1.05, 1.05); grp.add(olhoE);
      const olhoD = olhoE.clone(); olhoD.position.x = 0.18; grp.add(olhoD);
      // Orelhas pretas
      const orE = cubo(0.15, 0.15, 0.05, info.sec); orE.position.set(-0.25, 1.4, 0.65); grp.add(orE);
      const orD = orE.clone(); orD.position.x = 0.25; grp.add(orD);
      // 4 pernas
      for (const [px, pz] of [[-0.3, -0.5], [0.3, -0.5], [-0.3, 0.5], [0.3, 0.5]]) {
        const p = cubo(0.2, 0.4, 0.2, info.sec); p.position.set(px, 0.2, pz); grp.add(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
    } break;
    case 'bat': {
      const corpo = cubo(0.2, 0.2, 0.2, info.cor); corpo.position.y = 0.4; grp.add(corpo);
      // Asas
      const asaE = cubo(0.4, 0.05, 0.3, info.sec); asaE.position.set(-0.3, 0.4, 0); grp.add(asaE);
      const asaD = asaE.clone(); asaD.position.x = 0.3; grp.add(asaD);
      partes.cabeca = corpo; partes.corpo = corpo; partes.asaE = asaE; partes.asaD = asaD;
    } break;
    case 'squid': {
      const corpo = cubo(0.6, 0.6, 0.6, info.cor); corpo.position.y = 0.7; grp.add(corpo);
      // 8 tentáculos
      for (let i = 0; i < 8; i++) {
        const ang = (i / 8) * Math.PI * 2;
        const t = cubo(0.08, 0.6, 0.08, info.cor);
        t.position.set(Math.cos(ang) * 0.25, 0.3, Math.sin(ang) * 0.25);
        grp.add(t);
      }
      partes.cabeca = corpo; partes.corpo = corpo;
    } break;
    case 'dolphin': {
      const corpo = cubo(0.5, 0.5, 1.5, info.cor); corpo.position.y = 0.5; grp.add(corpo);
      // Bico
      const bico = cubo(0.2, 0.2, 0.3, info.cor); bico.position.set(0, 0.5, 0.85); grp.add(bico);
      // Barriga clara
      const barriga = cubo(0.51, 0.2, 1.51, info.sec); barriga.position.y = 0.35; grp.add(barriga);
      // Nadadeira dorsal
      const nad = cubo(0.05, 0.3, 0.3, info.cor); nad.position.set(0, 0.85, 0); grp.add(nad);
      partes.cabeca = corpo; partes.corpo = corpo;
    } break;
    case 'shulker': {
      // Caixa fechada
      const corpo = cubo(0.85, 0.85, 0.85, info.sec); corpo.position.y = 0.45; grp.add(corpo);
      // Tampa pequena (top piece roxa)
      const tampa = cubo(0.6, 0.3, 0.6, info.cor); tampa.position.y = 0.95; grp.add(tampa);
      partes.cabeca = tampa; partes.corpo = corpo;
    } break;
    case 'spider_jockey': {
      // Aranha base + esqueleto em cima
      const corpoAranha = cubo(0.7, 0.45, 0.55, info.cor); corpoAranha.position.y = 0.4; grp.add(corpoAranha);
      // 8 pernas pretas
      for (let i = 0; i < 8; i++) {
        const ang = (i / 8) * Math.PI * 2;
        const p = cubo(0.06, 0.3, 0.06, info.cor);
        p.position.set(Math.cos(ang) * 0.4, 0.2, Math.sin(ang) * 0.4);
        grp.add(p);
      }
      // Esqueleto em cima
      const esq = cubo(0.4, 0.6, 0.25, info.sec); esq.position.y = 1.0; grp.add(esq);
      const cabEsq = cubo(0.4, 0.4, 0.4, info.sec); cabEsq.position.y = 1.5; grp.add(cabEsq);
      partes.cabeca = cabEsq; partes.corpo = corpoAranha;
    } break;
    case 'frog_temperate':
    case 'frog_warm':
    case 'frog_cold': {
      // Sapo colorido — copia model base
      const corpo = cubo(0.45, 0.35, 0.35, info.cor); corpo.position.y = 0.2; grp.add(corpo);
      const cabeca = cubo(0.4, 0.25, 0.4, info.cor); cabeca.position.set(0, 0.45, 0.05); grp.add(cabeca);
      // Olhos enormes
      const olho = cuboEm(0.12, 0.12, 0.12, info.sec, 0.6);
      olho.position.set(-0.13, 0.6, 0.15); grp.add(olho);
      const olho2 = olho.clone(); olho2.position.x = 0.13; grp.add(olho2);
      partes.cabeca = cabeca; partes.corpo = corpo;
    } break;
    case 'tadpole': {
      // Girino
      const corpo = cubo(0.2, 0.15, 0.3, info.cor); corpo.position.y = 0.1; grp.add(corpo);
      const cauda = cubo(0.05, 0.05, 0.25, info.sec); cauda.position.set(0, 0.1, -0.3); grp.add(cauda);
      partes.cabeca = corpo; partes.corpo = corpo;
    } break;
    case 'glow_squid_var': {
      const corpo = cubo(0.5, 0.5, 0.5, info.cor); corpo.position.y = 0.6; grp.add(corpo);
      // Glow azul brilhante
      const glow = cuboEm(0.55, 0.55, 0.55, info.sec, 0.5); glow.position.y = 0.6; grp.add(glow);
      for (let i = 0; i < 6; i++) {
        const ang = (i / 6) * Math.PI * 2;
        const t = cuboEm(0.06, 0.5, 0.06, info.sec, 0.4);
        t.position.set(Math.cos(ang) * 0.2, 0.25, Math.sin(ang) * 0.2);
        grp.add(t);
      }
      partes.cabeca = corpo; partes.corpo = corpo;
    } break;
    default: {
      const corpo = cubo(0.6, 0.7, 0.4, info.cor);
      corpo.position.y = 0.45; grp.add(corpo);
      const cabeca = cubo(0.4, 0.4, 0.4, info.sec);
      cabeca.position.y = 1.0; grp.add(cabeca);
      partes.cabeca = cabeca; partes.corpo = corpo;
    }
  }

  grp.userData.partes = partes;
  return grp;
}

// Bounding box (raio horizontal + altura) por tipo de mob — usado pra
// colisão AABB com blocos. Ajustado pelo tamanho do mesh visual de cada
// mob em construirModeloMob.
function _dimsMob(tipo) {
  switch (tipo) {
    case 'aranha':   return { raio: 0.45, altura: 0.55 };
    case 'cave_spider': return { raio: 0.30, altura: 0.45 };
    case 'drowned':  return { raio: 0.30, altura: 1.85 };
    case 'husk':     return { raio: 0.30, altura: 1.85 };
    case 'stray':    return { raio: 0.30, altura: 1.85 };
    case 'galinha':  return { raio: 0.20, altura: 0.70 };
    case 'coelho':   return { raio: 0.18, altura: 0.50 };
    case 'papagaio': return { raio: 0.15, altura: 0.50 };
    case 'urso_polar': return { raio: 0.55, altura: 1.50 };
    case 'tartaruga': return { raio: 0.32, altura: 0.45 };
    case 'allay':    return { raio: 0.15, altura: 0.50 };
    case 'sapo':     return { raio: 0.20, altura: 0.30 };
    case 'lobo':     return { raio: 0.30, altura: 0.85 };
    case 'slime':    return { raio: 0.42, altura: 0.55 };
    case 'magma_cube': return { raio: 0.42, altura: 0.55 };
    case 'bee':      return { raio: 0.16, altura: 0.30 };
    case 'glow_squid': return { raio: 0.22, altura: 0.90 };
    case 'camelo':   return { raio: 0.55, altura: 2.20 };
    case 'axolote':  return { raio: 0.20, altura: 0.32 };
    case 'raposa':   return { raio: 0.30, altura: 0.95 };
    case 'blaze':    return { raio: 0.30, altura: 1.50 };
    case 'vaca':     return { raio: 0.45, altura: 1.40 };
    case 'mooshroom': return { raio: 0.45, altura: 1.40 };
    case 'porco':    return { raio: 0.32, altura: 1.05 };
    case 'ovelha':   return { raio: 0.34, altura: 1.20 };
    case 'enderman':   return { raio: 0.30, altura: 2.50 };
    case 'ender_dragon': return { raio: 1.20, altura: 1.80 };
    case 'cat':        return { raio: 0.20, altura: 0.55 };
    case 'villager':   return { raio: 0.30, altura: 1.85 };
    case 'iron_golem': return { raio: 0.55, altura: 2.40 };
    case 'witch':      return { raio: 0.30, altura: 1.85 };
    case 'wandering_trader': return { raio: 0.30, altura: 1.85 };
    case 'snow_golem': return { raio: 0.30, altura: 1.85 };
    case 'ghast':      return { raio: 0.85, altura: 1.40 };
    // SPRINT MEGA-7: bounding boxes para mobs novos
    case 'wither':     return { raio: 0.50, altura: 2.50 };
    case 'guardian':   return { raio: 0.50, altura: 1.0 };
    case 'elder_guardian': return { raio: 0.70, altura: 1.4 };
    case 'warden':     return { raio: 0.50, altura: 2.80 };
    case 'phantom':    return { raio: 0.65, altura: 0.40 };
    case 'pillager':
    case 'vindicator':
    case 'evoker':     return { raio: 0.30, altura: 1.85 };
    case 'vex':        return { raio: 0.20, altura: 0.85 };
    case 'ravager':    return { raio: 0.85, altura: 1.55 };
    case 'horse':
    case 'donkey':
    case 'mule':       return { raio: 0.40, altura: 1.65 };
    case 'llama':      return { raio: 0.30, altura: 1.90 };
    case 'strider':    return { raio: 0.40, altura: 1.65 };
    case 'piglin':
    case 'zombified_piglin': return { raio: 0.30, altura: 1.85 };
    case 'hoglin':
    case 'zoglin':     return { raio: 0.55, altura: 1.40 };
    case 'endermite':
    case 'silverfish': return { raio: 0.20, altura: 0.30 };
    case 'goat':       return { raio: 0.27, altura: 1.35 };
    case 'panda':      return { raio: 0.55, altura: 1.20 };
    case 'bat':        return { raio: 0.18, altura: 0.55 };
    case 'squid':
    case 'glow_squid_var': return { raio: 0.40, altura: 1.20 };
    case 'dolphin':    return { raio: 0.45, altura: 0.65 };
    case 'shulker':    return { raio: 0.45, altura: 1.20 };
    case 'spider_jockey': return { raio: 0.45, altura: 1.80 };
    case 'frog_temperate':
    case 'frog_warm':
    case 'frog_cold':  return { raio: 0.20, altura: 0.50 };
    case 'tadpole':    return { raio: 0.18, altura: 0.18 };
    // Humanóides hostis (zumbi/esqueleto/creeper)
    default:           return { raio: 0.30, altura: 1.80 };
  }
}

export class Mob {
  constructor(tipo, x, y, z, opts = {}) {
    this.tipo = tipo;
    this.x = x; this.y = y; this.z = z;
    const info = MOB_INFO[tipo];
    // Slime tamanho 1-3 (3 = grande, 1 = pequeno). Outros mobs: tamanho 1.
    this.tamanho = opts.tamanho ?? (tipo === 'slime' ? 3 : 1);
    const escala = tipo === 'slime' ? this.tamanho / 3 : 1;
    this.hp = Math.max(1, Math.round(info.hp * (tipo === 'slime' ? this.tamanho / 3 : 1)));
    this.dir = Math.random() * Math.PI * 2;
    this.proxMudanca = 0;
    this.cooldownAtaque = 0;
    this.fase = Math.random() * Math.PI * 2;
    this.pulando = 0;
    this.proxPulo = 1.5;
    this.proxTeleport = 5.0;
    this.proxSom = 4 + Math.random() * 6;
    // Creeper fuse: armado quando player entra no alcance, dispara em fuseSegundos.
    // Volta a 0 se player sair do alcance — você pode "fugir" de creeper.
    this.creeperFuse = 0;
    // Knockback velocity (decai por frame). Setada por damage source.
    this.kbX = 0; this.kbZ = 0;
    // Pânico: timer de fuga após levar dano (passivos fogem em zigzag rápido).
    this.panico = 0;
    // Sunburn (zumbi/esqueleto): timer entre damage ticks de sol.
    this.sunburn = 0;
    // Esqueleto: cooldown entre flechadas.
    this.cooldownFlecha = 1.5 + Math.random();
    // Stuck detection: monitora posição últimos N seconds. Se variou
    // < 0.3 bloco em 3s, força repath + leve teleport pra cima.
    this._stuckLastX = x; this._stuckLastZ = z; this._stuckTimer = 0;
    // Lobo: domesticado segue o player e ataca mobs hostis.
    this.domesticado = false;
    // Galinha: timer pra próximo ovo (paridade Minecraft: 5-10 min,
    // aqui 60-120s pra ser jogável).
    this.proxOvo = 60 + Math.random() * 60;
    // Reprodução: loveTimer > 0 = em "love mode" pronto pra acasalar.
    // breedCooldown bloqueia novo acasalamento por 60s pós-spawn de cria.
    this.loveTimer = 0;
    this.breedCooldown = 0;
    // Cor override (ex: papagaio escolhe cor aleatória no spawn)
    const infoEfetivo = (opts.cor || opts.sec)
      ? { ...info, cor: opts.cor || info.cor, sec: opts.sec || info.sec }
      : info;
    this.mesh = construirModeloMob(tipo, infoEfetivo);
    if (escala !== 1) this.mesh.scale.set(escala, escala, escala);
    this.mesh.position.set(x, y, z);
    this.partes = this.mesh.userData.partes;
    // Dimensões pra colisão AABB
    const dims = _dimsMob(tipo);
    this.raio = dims.raio * escala;
    this.altura = dims.altura * escala;
    // Flag: spawn precisa ser desclipado no primeiro frame
    this._descliparNoSpawn = true;
  }

  // Empurra mob pra cima se ele spawnou dentro de bloco (até 8 blocos
  // pra cima). Usado uma vez por mob, no primeiro atualizar.
  desclipar(world) {
    if (!this._descliparNoSpawn) return;
    this._descliparNoSpawn = false;
    let safety = 8;
    while (this.colideEm(world, this.x, this.y, this.z) && safety-- > 0) this.y += 1;
  }

  // Line-of-sight: testa se há linha reta até (tx,ty,tz) sem bloco
  // sólido no caminho. Usado pra hostis NÃO agredirem player através
  // de paredes (paridade Minecraft real). Step ~0.4 bloco, max 24m.
  podeVer(world, tx, ty, tz) {
    const sx = this.x, sy = this.y + this.altura * 0.7, sz = this.z;
    const dx = tx - sx, dy = ty - sy, dz = tz - sz;
    const dist = Math.hypot(dx, dy, dz);
    if (dist > 24) return false;
    const steps = Math.max(2, Math.ceil(dist / 0.4));
    const px = dx / steps, py = dy / steps, pz = dz / steps;
    for (let i = 1; i < steps; i++) {
      const cx = sx + px * i, cy = sy + py * i, cz = sz + pz * i;
      const b = world.get(Math.floor(cx), Math.floor(cy), Math.floor(cz));
      if (b === BLOCO.AR || b === BLOCO.AGUA) continue;
      if (BLOCO_INFO[b]?.solido) return false;
    }
    return true;
  }

  // AABB collision: verifica se a bounding box do mob na posição (x,y,z)
  // intersecta algum bloco sólido. Igual ao player.colisaoBlocos. Ignora
  // água (passável). Inclui cria (escala 0.6).
  colideEm(world, x, y, z) {
    const r = this.raio * (this._cria ? 0.6 : 1);
    const h = this.altura * (this._cria ? 0.6 : 1);
    const x0 = Math.floor(x - r), x1 = Math.floor(x + r);
    const y0 = Math.floor(y),     y1 = Math.floor(y + h - 0.05);
    const z0 = Math.floor(z - r), z1 = Math.floor(z + r);
    for (let xi = x0; xi <= x1; xi++)
      for (let yi = y0; yi <= y1; yi++)
        for (let zi = z0; zi <= z1; zi++) {
          const b = world.get(xi, yi, zi);
          if (b === BLOCO.AGUA) continue;
          const info = BLOCO_INFO[b];
          if (!info?.solido) continue;
          if (info.shape === 'slab') {
            if (y >= yi + 0.5) continue;
            if (y + h - 0.05 <= yi) continue;
            if (x + r <= xi || x - r >= xi + 1) continue;
            if (z + r <= zi || z - r >= zi + 1) continue;
            return true;
          }
          if (info.shape === 'fence') {
            if (x + r <= xi + 0.3 || x - r >= xi + 0.7) continue;
            if (z + r <= zi + 0.3 || z - r >= zi + 0.7) continue;
            return true;
          }
          if (info.shape === 'ladder') continue;
          if (info.shape === 'door_open') continue;
          if (info.shape === 'door') {
            if (z + r <= zi || z - r >= zi + 0.18) continue;
            return true;
          }
          return true;
        }
    return false;
  }

  atualizar(dt, world, alvo) {
    const info = MOB_INFO[this.tipo];
    // Garante que spawn não está dentro de bloco
    this.desclipar(world);
    // Som casual
    this.proxSom -= dt;
    if (this.proxSom <= 0) {
      this.proxSom = 6 + Math.random() * 12;
      const p = state.player;
      if (p) {
        const dx = this.x - p.pos.x, dz = this.z - p.pos.z;
        if (dx*dx + dz*dz < 576) Audio.mobCall(this.tipo);
      }
    }
    // Pânico: passivo fugindo do player em zigzag (paridade Minecraft)
    if (this.panico > 0) {
      this.panico -= dt;
      const p = state.player;
      if (p) {
        // Direção: oposta ao player + ruído pra não ir reto
        const ang = Math.atan2(this.z - p.pos.z, this.x - p.pos.x);
        this.dir = ang + (Math.sin(this.fase * 6) * 0.6);
      }
    } else if (info.hostil && alvo) {
      this.dir = Math.atan2(alvo.z - this.z, alvo.x - this.x);
    } else {
      this.proxMudanca -= dt;
      if (this.proxMudanca <= 0) {
        this.dir = Math.random() * Math.PI * 2;
        this.proxMudanca = 1.5 + Math.random() * 3;
      }
    }
    // Aplica knockback (velocidade que decai). Move ANTES da locomoção
    // para que o knockback dure mesmo se o mob estiver parado.
    if (this.kbX !== 0 || this.kbZ !== 0) {
      const kdx = this.kbX * dt, kdz = this.kbZ * dt;
      if (!this.colideEm(world, this.x + kdx, this.y, this.z)) {
        this.x += kdx;
      }
      if (!this.colideEm(world, this.x, this.y, this.z + kdz)) {
        this.z += kdz;
      }
      // Decai exponencialmente (≈80% restante por segundo)
      const decay = Math.exp(-5 * dt);
      this.kbX *= decay; this.kbZ *= decay;
      if (Math.abs(this.kbX) < 0.05 && Math.abs(this.kbZ) < 0.05) {
        this.kbX = 0; this.kbZ = 0;
      }
    }
    let movendo = false;
    if (info.pula) {
      this.proxPulo -= dt;
      if (this.proxPulo <= 0) {
        this.pulando = 0.001;
        this.proxPulo = 1.2 + Math.random() * 0.8;
      }
      if (this.pulando > 0) {
        this.pulando = Math.min(1, this.pulando + dt * 1.5);
        const passo = info.vel * dt * 1.5;
        const dx = Math.cos(this.dir) * passo;
        const dz = Math.sin(this.dir) * passo;
        if (!this.colideEm(world, this.x + dx, this.y, this.z)) {
          this.x += dx; movendo = true;
        }
        if (!this.colideEm(world, this.x, this.y, this.z + dz)) {
          this.z += dz; movendo = true;
        }
        if (this.pulando >= 1) this.pulando = 0;
      }
    } else {
      const dx = Math.cos(this.dir) * info.vel * dt;
      const dz = Math.sin(this.dir) * info.vel * dt;
      if (!this.colideEm(world, this.x + dx, this.y, this.z)) {
        this.x += dx; movendo = true;
      } else if (!this.colideEm(world, this.x + dx, this.y + 1, this.z)) {
        // Auto-step de 1 bloco quando bate em parede de 1 bloco de altura
        this.x += dx; this.y += 1; movendo = true;
      }
      if (!this.colideEm(world, this.x, this.y, this.z + dz)) {
        this.z += dz; movendo = true;
      } else if (!this.colideEm(world, this.x, this.y + 1, this.z + dz)) {
        this.z += dz; this.y += 1; movendo = true;
      }
    }
    if (info.teleport) {
      this.proxTeleport -= dt;
      if (this.proxTeleport <= 0 && alvo) {
        if (Math.random() < 0.3) {
          const ang = Math.random() * Math.PI * 2;
          const dist = 4 + Math.random() * 8;
          const tx = Math.floor(alvo.x + Math.cos(ang) * dist);
          const tz = Math.floor(alvo.z + Math.sin(ang) * dist);
          let ty = WORLD_Y;
          while (ty > 0 && !world.isSolido(tx, ty - 1, tz)) ty--;
          if (ty > 0 && ty < WORLD_Y - 2) {
            this.x = tx + 0.5; this.z = tz + 0.5; this.y = ty;
            Audio.endermanTeleport();
          }
        }
        this.proxTeleport = 5.0 + Math.random() * 3;
      }
    }
    // Sunburn: zumbi/esqueleto pegam fogo em luz solar plena durante o dia.
    // Toma 1 dano a cada 1.5s. Paridade Minecraft.
    // Drowned aquatico + Husk resistente NÃO queimam (paridade Minecraft real)
    if ((this.tipo === 'zumbi' || this.tipo === 'esqueleto') && state.tempoDia !== undefined) {
      const sun = Math.max(0, 0.5 + 0.5 * Math.sin(state.tempoDia * Math.PI * 2 - Math.PI / 2));
      if (sun > 0.5) {
        const luz = world.getLightAt(Math.floor(this.x), Math.floor(this.y) + 1, Math.floor(this.z));
        if (luz.sky >= 14) {
          this.sunburn -= dt;
          if (this.sunburn <= 0) {
            this.hp -= 1;
            this.sunburn = 1.5;
            Audio.hurt();
          }
        } else {
          this.sunburn = 0.5; // delay pra reentrar no sol
        }
      }
    }
    // Mob que flutua (ghast): mantém altura via leve oscilação. Sem
    // snap pro chão. Sai cedo do bloco de física vertical.
    if (info.flutua) {
      const t = (typeof performance !== 'undefined' ? performance.now() : Date.now()) * 0.001;
      // Boss ender_dragon: orbita plataforma + heal se há crystals vivos
      if (this.tipo === 'ender_dragon') {
        // Órbita ao redor de (0, 40, 0) — raio 14, velocidade angular 0.3 rad/s
        const ang = t * 0.3;
        this.x = Math.cos(ang) * 14;
        this.z = Math.sin(ang) * 14;
        this.y = 40 + Math.sin(t * 0.7) * 3;
        this.dir = ang + Math.PI / 2; // aponta tangencial à órbita
        // Heal de crystals próximos (4 pillars em ±12)
        this._healAcc = (this._healAcc || 0) + dt;
        if (this._healAcc >= 1) {
          this._healAcc = 0;
          let crystals = 0;
          for (const [px, pz] of [[12, 0], [-12, 0], [0, 12], [0, -12]]) {
            if (world.get(px, 36, pz) === BLOCO.END_CRYSTAL) crystals++;
          }
          if (crystals > 0 && this.hp < MOB_INFO.ender_dragon.hp) {
            this.hp = Math.min(MOB_INFO.ender_dragon.hp, this.hp + crystals);
            // TODO particle beam crystal → dragon (visual)
          }
        }
      } else {
        this.y = (this._yBase = this._yBase ?? this.y) + Math.sin(t * 0.6) * 0.4;
      }
      this.mesh.position.set(this.x, this.y, this.z);
      this.mesh.rotation.y = -this.dir + Math.PI / 2;
      return; // skip resto
    }
    // Snap vertical: cai por gravidade respeitando AABB. Auto-step 1.
    let yp = Math.floor(this.y + 0.001);
    if (this.colideEm(world, this.x, yp, this.z)) {
      if (!this.colideEm(world, this.x, yp + 1, this.z)) yp++;
    }
    // Mob FLUTUA na água: se há água no bloco do mob, sobe lentamente
    // até a superfície (não cai pro fundo). Igual MC.
    const blocoMob = world.get(Math.floor(this.x), yp, Math.floor(this.z));
    if (blocoMob === BLOCO.AGUA) {
      // Sobe se ainda há água acima, senão fica na superfície
      if (world.get(Math.floor(this.x), yp + 1, Math.floor(this.z)) === BLOCO.AGUA) yp++;
    } else {
      // Cai normalmente
      let safety = 64;
      while (yp > 0 && !this.colideEm(world, this.x, yp - 0.05, this.z) && safety-- > 0) yp--;
    }
    this.y = yp;
    let yVisual = this.y;
    if (info.pula && this.pulando > 0) {
      yVisual = this.y + Math.sin(this.pulando * Math.PI) * 0.6;
    }
    this.mesh.position.set(this.x, yVisual, this.z);
    this.mesh.rotation.y = -this.dir + Math.PI / 2;
    this.cooldownAtaque -= dt;

    // === LOD distance-based ===
    // Distância ao player; se > 32 blocos, pula animação inteira (mob fica
    // estático mas continua existindo). Frustum culling implícito também:
    // mesh fica fora do view → renderer pula naturalmente.
    const _p = state.player;
    let _dist2 = 0;
    if (_p) {
      const _ddx = _p.pos.x - this.x, _ddz = _p.pos.z - this.z;
      _dist2 = _ddx * _ddx + _ddz * _ddz;
      if (_dist2 > 32 * 32) {
        // Skip animação visual (perf win em chunks lotados de mobs)
        return;
      }
    }
    // Animação
    this.fase += dt * (movendo ? 8 : 0);
    if (this.partes && this.partes.pernas) {
      const amp = movendo ? 0.55 : 0;
      for (let i = 0; i < this.partes.pernas.length; i++) {
        const sign = (i % 2 === 0) ? 1 : -1;
        const fase = this.fase + (i < 2 ? 0 : Math.PI);
        this.partes.pernas[i].rotation.x = Math.sin(fase) * amp * sign * 0.7;
      }
    }
    if (this.partes && this.partes.bracos) {
      const amp = movendo ? 0.5 : (info.hostil ? 0.3 : 0);
      this.partes.bracos[0].rotation.x = Math.sin(this.fase + Math.PI) * amp;
      this.partes.bracos[1].rotation.x = Math.sin(this.fase) * amp;
      if (info.hostil && !info.teleport) {
        this.partes.bracos[0].rotation.x -= 1.2;
        this.partes.bracos[1].rotation.x -= 1.2;
      }
    }
    if (this.partes && this.partes.cabeca) {
      // Head tracking: cabeça olha pro player se estiver perto. Senão, idle.
      const p = state.player;
      let trackY = Math.sin(this.fase * 0.5) * 0.15;
      let trackX = 0;
      if (p) {
        const dx = p.pos.x - this.x, dz = p.pos.z - this.z;
        const dist2 = dx*dx + dz*dz;
        if (dist2 < 144) {
          // World Y angle to face player (three.js conv: 0 = +Z, atan2(x,z))
          const angWorld = Math.atan2(dx, dz);
          // Body's world Y rotation (já aplicada no mesh):
          const bodyYWorld = -this.dir + Math.PI / 2;
          // Head é filho do mesh → rotation local = world - body
          let rel = angWorld - bodyYWorld;
          while (rel > Math.PI)  rel -= 2 * Math.PI;
          while (rel < -Math.PI) rel += 2 * Math.PI;
          // Limita pra não virar 180° (pescoço quebrado)
          rel = Math.max(-1.2, Math.min(1.2, rel));
          trackY = rel;
          // Pitch: olha pra cima/baixo se player em altura diferente
          const dy = (p.pos.y + 1.5) - (this.y + 1.0);
          trackX = -Math.max(-0.7, Math.min(0.7, Math.atan2(dy, Math.sqrt(dist2))));
        }
      }
      this.partes.cabeca.rotation.y = trackY;
      this.partes.cabeca.rotation.x = trackX;
    }
    if (info.pula && this.partes.corpo) {
      const sq = 1 + Math.sin(this.pulando * Math.PI) * 0.15;
      this.partes.corpo.scale.set(1.0 / sq, sq, 1.0 / sq);
    }
    // Mostra colar se lobo foi domesticado
    if (this.partes.colar) this.partes.colar.visible = !!this.domesticado;
    // Galinha: solta ovo periodicamente (paridade MC)
    if (this.tipo === 'galinha') {
      this.proxOvo -= dt;
      if (this.proxOvo <= 0) {
        this.proxOvo = 60 + Math.random() * 60;
        spawnItemDrop({ i: ITEM.OVO, q: 1 }, this.x, this.y + 0.2, this.z);
        Audio.galinha();
      }
    }
    // Snow Golem: dano em hostis adjacentes via "snowball" (efeito instantâneo)
    if (this.tipo === 'snow_golem') {
      this._snowAcc = (this._snowAcc || 0) + dt;
      if (this._snowAcc >= 1.0) {
        this._snowAcc = 0;
        for (const o of state.mobMgr.mobs) {
          if (!MOB_INFO[o.tipo]?.hostil) continue;
          const dx = o.x - this.x, dz = o.z - this.z;
          if (dx*dx + dz*dz < 36) { // raio 6
            const len = Math.sqrt(dx*dx + dz*dz) || 1;
            o.tomarDano(1, (dx/len) * 4, (dz/len) * 4);
            break;
          }
        }
      }
    }
    // Reprodução: decrementa timers + spawna/remove corações flutuantes
    if (this.loveTimer > 0) {
      this.loveTimer -= dt;
      // Cria coração visual se não existe (mostra que mob tá em love mode)
      if (!this._heart) {
        const heartMat = new THREE.MeshLambertMaterial({
          color: 0xff5252, emissive: 0xff5252, emissiveIntensity: 0.6,
        });
        const heart = new THREE.Mesh(new THREE.BoxGeometry(0.18, 0.18, 0.05), heartMat);
        heart.position.y = this.altura + 0.4;
        this.mesh.add(heart);
        this._heart = heart;
      }
      // Animação: pulsa + sobe levemente
      const t = (typeof performance !== 'undefined' ? performance.now() : Date.now()) * 0.001;
      this._heart.scale.setScalar(1 + Math.sin(t * 4) * 0.2);
      this._heart.position.y = this.altura + 0.4 + Math.sin(t * 2) * 0.1;
    } else if (this._heart) {
      // Remove coração quando love mode acaba
      this.mesh.remove(this._heart);
      this._heart.geometry.dispose();
      this._heart.material.dispose();
      this._heart = null;
    }
    if (this.breedCooldown > 0) this.breedCooldown -= dt;
    // Stuck detection: força repath + minor teleport se mob não mexeu
    // o suficiente em 3s. Previne mobs travados em quinas/buracos.
    this._stuckTimer += dt;
    if (this._stuckTimer >= 3) {
      const dx = this.x - this._stuckLastX;
      const dz = this.z - this._stuckLastZ;
      if (dx*dx + dz*dz < 0.09) {
        // Stuck — invalida path + tenta pular
        this._path = null;
        this._pathTimer = 0;
        if (this.colideEm(world, this.x, this.y + 1, this.z) === false) {
          this.y += 0.6; // pequeno hop
        }
      }
      this._stuckLastX = this.x; this._stuckLastZ = this.z; this._stuckTimer = 0;
    }
  }
  vivo() { return this.hp > 0; }

  // Aplica dano + knockback (vx, vz são velocidade do empurrão em m/s).
  // Mobs passivos entram em pânico (fogem em zigzag por 5s).
  tomarDano(dano, kbX = 0, kbZ = 0) {
    this.hp -= dano;
    this.kbX = kbX;
    this.kbZ = kbZ;
    const info = MOB_INFO[this.tipo];
    // Neutro vira hostil quando atacado (urso polar, etc) por 30s
    if (info.neutro) {
      this._provocado = true;
      this._provocadoAte = (typeof performance !== 'undefined' ? performance.now() : Date.now()) + 30000;
    }
    if (!info.hostil && !info.amigavel && !info.neutro) this.panico = 5;
  }
}

export class MobManager {
  constructor(scene) {
    this.scene = scene;
    this.mobs = [];
    this.acc = 0;
    this.intervalo = 2.0;
  }
  spawn(tipo, x, y, z, opts) {
    const m = new Mob(tipo, x, y, z, opts);
    this.scene.add(m.mesh);
    this.mobs.push(m);
    return m;
  }
  remover(m) {
    this.scene.remove(m.mesh);
    const i = this.mobs.indexOf(m);
    if (i >= 0) this.mobs.splice(i, 1);
  }
  // Procura pares de mobs do mesmo tipo em love mode próximos e spawna cria.
  tentarReproducao() {
    for (let i = 0; i < this.mobs.length; i++) {
      const a = this.mobs[i];
      if (!a.vivo() || a.loveTimer <= 0 || a.breedCooldown > 0) continue;
      for (let j = i + 1; j < this.mobs.length; j++) {
        const b = this.mobs[j];
        if (b.tipo !== a.tipo) continue;
        if (!b.vivo() || b.loveTimer <= 0 || b.breedCooldown > 0) continue;
        const dx = a.x - b.x, dz = a.z - b.z;
        if (dx*dx + dz*dz > 9) continue; // 3 blocos
        // Spawn cria entre os dois (visualmente menor via tamanho=cria)
        const cx = (a.x + b.x) / 2, cz = (a.z + b.z) / 2;
        const cy = Math.max(a.y, b.y);
        const cria = this.spawn(a.tipo, cx, cy, cz);
        if (cria) {
          cria.mesh.scale.setScalar(0.6);
          cria._cria = true;
          cria._criaUntil = Date.now() + 60000; // 60s pra crescer
        }
        a.loveTimer = 0; b.loveTimer = 0;
        a.breedCooldown = 60; b.breedCooldown = 60;
        if (state.ui) state.ui.toast(`💕 ${a.tipo} reproduziu!`);
        return; // 1 par por frame
      }
    }
  }
  // Faz cria virar adulto após 60s
  atualizarCrias() {
    const agora = Date.now();
    for (const m of this.mobs) {
      if (m._cria && m._criaUntil && agora >= m._criaUntil) {
        m.mesh.scale.setScalar(1);
        m._cria = false;
      }
    }
  }
  atualizar(dt, world, player, sun) {
    this.acc += dt;
    if (this.acc >= this.intervalo) {
      this.acc = 0;
      this.tentarSpawn(world, player, sun);
      this.tentarReproducao();
      this.atualizarCrias();
    }
    for (let i = this.mobs.length - 1; i >= 0; i--) {
      const m = this.mobs[i];
      if (!m.vivo()) {
        // Slime split: ao morrer, slime maior gera 2-3 menores ao redor
        if (m.tipo === 'slime' && m.tamanho > 1) {
          const n = 2 + Math.floor(Math.random() * 2);
          for (let k = 0; k < n; k++) {
            const ang = (k / n) * Math.PI * 2 + Math.random() * 0.5;
            const ox = Math.cos(ang) * 0.6, oz = Math.sin(ang) * 0.6;
            this.spawn('slime', m.x + ox, m.y, m.z + oz, { tamanho: m.tamanho - 1 });
          }
        }
        this.remover(m); continue;
      }
      const ddx = m.x - player.pos.x, ddz = m.z - player.pos.z;
      if (ddx*ddx + ddz*ddz > 900) { this.remover(m); continue; }
      const info = MOB_INFO[m.tipo];
      if (info.amigavel) {
        // Domesticado vê hostis mais longe (16 blocos vs 8 sem domesticar)
        let hostil = null, melhor = m.domesticado ? 256 : 64;
        for (const o of this.mobs) {
          if (!MOB_INFO[o.tipo].hostil) continue;
          const d2 = (o.x - m.x)**2 + (o.z - m.z)**2;
          if (d2 < melhor) { melhor = d2; hostil = o; }
        }
        let alvoMov = hostil ? { x: hostil.x, z: hostil.z } : null;
        // Domesticado sem hostil → segue o player se distante (>2 blocos)
        if (m.domesticado && !hostil) {
          const dx = player.pos.x - m.x, dz = player.pos.z - m.z;
          if (dx*dx + dz*dz > 4) alvoMov = { x: player.pos.x, z: player.pos.z };
        }
        m.atualizar(dt, world, alvoMov);
        if (hostil && melhor < 2.25 && m.cooldownAtaque <= 0) {
          const fx = hostil.x - m.x, fz = hostil.z - m.z;
          const len = Math.hypot(fx, fz) || 1;
          hostil.tomarDano(4, (fx/len) * 5, (fz/len) * 5);
          m.cooldownAtaque = 1.0;
        }
      } else if (info.hostil) {
        // Hostis SÓ perseguem se virem o player (LOS), cacheada por ~0.5s.
        m._losTimer = (m._losTimer || 0) - dt;
        if (m._losTimer <= 0) {
          m._losTimer = 0.4 + Math.random() * 0.3;
          m._vePlayer = m.podeVer(world, player.pos.x, player.pos.y + 0.8, player.pos.z);
        }
        // A* pathfinding pra hostis melee (skip esqueleto/witch — ranged).
        // Computa path 1×/1.2s. Se path existe, segue waypoint; senão
        // fallback pra movimento direto (vePlayer).
        let alvoMov = m._vePlayer ? { x: player.pos.x, z: player.pos.z } : null;
        if (m._vePlayer && m.tipo !== 'esqueleto' && m.tipo !== 'witch' && m.tipo !== 'creeper') {
          m._pathTimer = (m._pathTimer || 0) - dt;
          if (m._pathTimer <= 0) {
            m._pathTimer = 1.2;
            const dist2 = (player.pos.x - m.x) ** 2 + (player.pos.z - m.z) ** 2;
            if (dist2 < 256) { // só path se < 16 blocos
              m._path = aStarMob(world, m.x, Math.floor(m.y), m.z,
                                 player.pos.x, player.pos.z, 80);
              m._pathIdx = 0;
            }
          }
          if (m._path && m._pathIdx < m._path.length) {
            const wp = m._path[m._pathIdx];
            const dx = wp.x + 0.5 - m.x;
            const dz = wp.z + 0.5 - m.z;
            const d = Math.hypot(dx, dz);
            if (d < 0.3) m._pathIdx++;
            else alvoMov = { x: wp.x + 0.5, z: wp.z + 0.5 };
          }
        }
        m.atualizar(dt, world, alvoMov);
      } else {
        m.atualizar(dt, world, null);
      }
      // Neutro provocado age como hostil temporariamente (30s)
      const provocadoAtivo = m._provocado && m._provocadoAte > (typeof performance !== 'undefined' ? performance.now() : Date.now());
      if (provocadoAtivo === false && m._provocado) m._provocado = false;
      if (info.hostil || provocadoAtivo) {
        const ddy = m.y - player.pos.y;
        const d2 = ddx*ddx + ddy*ddy + ddz*ddz;
        const naAlcance = d2 < info.alcance ** 2 && m._vePlayer; // só ataca se vê
        m.cooldownFlecha -= dt;
        // SPRINT MEGA-10: Pillager — ataque crossbow (flecha mais rápida)
        if (m.tipo === 'pillager' && naAlcance && m.cooldownFlecha <= 0) {
          const dx = player.pos.x - m.x;
          const dy = (player.pos.y + 1.4) - (m.y + 1.5);
          const dz = player.pos.z - m.z;
          const len = Math.hypot(dx, dy, dz);
          if (len > 0.5) {
            const dir = { x: dx/len, y: dy/len, z: dz/len };
            spawnArrow({ x: m.x, y: m.y + 1.5, z: m.z }, dir, info.dano);
            m.cooldownFlecha = 1.8; // mais rápido que esqueleto
          }
          continue;
        }
        // SPRINT MEGA-10: Blaze — atira fireball
        if (m.tipo === 'blaze' && naAlcance && m.cooldownFlecha <= 0) {
          const dx = player.pos.x - m.x;
          const dy = (player.pos.y + 1.4) - (m.y + 1.5);
          const dz = player.pos.z - m.z;
          const len = Math.hypot(dx, dy, dz);
          if (len > 0.5) {
            const dir = { x: dx/len, y: dy/len, z: dz/len };
            spawnArrow({ x: m.x, y: m.y + 1.5, z: m.z }, dir, info.dano);
            // TODO: incendiar player ao atingir (placeholder via efeito wither)
            if (len < 6 && Math.random() < 0.3) {
              player.efeitos = player.efeitos || {};
              player.efeitos.wither = Date.now() + 5000;
            }
            m.cooldownFlecha = 2.0;
          }
          continue;
        }
        // SPRINT MEGA-10: Ghast — fireball lenta mas explode
        if (m.tipo === 'ghast' && naAlcance && m.cooldownFlecha <= 0) {
          const dx = player.pos.x - m.x;
          const dy = (player.pos.y + 1.4) - (m.y + 1.5);
          const dz = player.pos.z - m.z;
          const len = Math.hypot(dx, dy, dz);
          if (len > 0.5) {
            const dir = { x: dx/len, y: dy/len, z: dz/len };
            spawnArrow({ x: m.x, y: m.y + 1.5, z: m.z }, dir, info.dano);
            m.cooldownFlecha = 3.0;
          }
          continue;
        }
        // SPRINT MEGA-10: Wither boss — atira 3 fireballs por turno (3 cabeças)
        if (m.tipo === 'wither' && naAlcance && m.cooldownFlecha <= 0) {
          const dx = player.pos.x - m.x;
          const dy = (player.pos.y + 1.4) - (m.y + 1.8);
          const dz = player.pos.z - m.z;
          const len = Math.hypot(dx, dy, dz);
          if (len > 0.5) {
            // 3 fireballs (uma por cabeça, leve dispersão)
            for (let k = -1; k <= 1; k++) {
              const ang = Math.atan2(dz, dx) + k * 0.15;
              const dirL = { x: Math.cos(ang), y: dy/len, z: Math.sin(ang) };
              spawnArrow({ x: m.x, y: m.y + 1.8, z: m.z }, dirL, info.dano);
            }
            // Wither effect próximo
            if (len < 8) {
              player.efeitos = player.efeitos || {};
              player.efeitos.wither = Date.now() + 10000;
            }
            m.cooldownFlecha = 2.5;
          }
          continue;
        }
        // SPRINT MEGA-10: Shulker — atira shulker bullet (homing simulado)
        if (m.tipo === 'shulker' && naAlcance && m.cooldownFlecha <= 0) {
          const dx = player.pos.x - m.x;
          const dy = (player.pos.y + 1.4) - (m.y + 0.5);
          const dz = player.pos.z - m.z;
          const len = Math.hypot(dx, dy, dz);
          if (len > 0.5) {
            const dir = { x: dx/len, y: dy/len, z: dz/len };
            spawnArrow({ x: m.x, y: m.y + 0.5, z: m.z }, dir, info.dano);
            // Levitação 5s próximo (paridade MC shulker)
            if (len < 10) {
              player.efeitos = player.efeitos || {};
              player.efeitos.levitacao = Date.now() + 5000;
            }
            m.cooldownFlecha = 3.5;
          }
          continue;
        }
        // SPRINT MEGA-10: Phantom dive — ataque vertical de cima
        if (m.tipo === 'phantom' && naAlcance && m.cooldownAtaque <= 0) {
          // Mergulha rapidamente (placeholder via dano direto)
          player.aplicarDano(info.dano, 'phantom');
          m.cooldownAtaque = 4.0;
          continue;
        }
        // SPRINT MEGA-10: Warden — sonic boom (atravessa paredes, sem armor reduce)
        if (m.tipo === 'warden' && naAlcance && m.cooldownFlecha <= 0) {
          // Aplica dano mesmo se player escondido (warden detecta vibração)
          const dx = player.pos.x - m.x;
          const dy = (player.pos.y + 1.4) - (m.y + 2.2);
          const dz = player.pos.z - m.z;
          const len = Math.hypot(dx, dy, dz);
          if (len < 12) {
            player.aplicarDano(15, 'warden_sonic'); // sonic boom não considera armor
            player.efeitos = player.efeitos || {};
            player.efeitos.blindness = Date.now() + 8000; // cega
            player.efeitos.weakness = Date.now() + 12000;
            m.cooldownFlecha = 5.0;
            state.ui?.toast?.('💥 SONIC BOOM!');
            state.renderer?.aplicarShake?.(0.6);
          }
          continue;
        }
        // SPRINT MEGA-10: Llama — cuspe ranged
        if (m.tipo === 'llama' && naAlcance && m.cooldownFlecha <= 0 && m._provocada) {
          const dx = player.pos.x - m.x;
          const dy = (player.pos.y + 1.4) - (m.y + 1.5);
          const dz = player.pos.z - m.z;
          const len = Math.hypot(dx, dy, dz);
          if (len > 0.5) {
            const dir = { x: dx/len, y: dy/len, z: dz/len };
            spawnArrow({ x: m.x, y: m.y + 1.5, z: m.z }, dir, 1);
            m.cooldownFlecha = 3.0;
          }
          continue;
        }
        // SPRINT MEGA-10: Evoker — summon Vex periodically
        if (m.tipo === 'evoker' && naAlcance && m.cooldownFlecha <= 0) {
          // Spawn 3 vex ao redor
          for (let k = 0; k < 3; k++) {
            const ang = (k / 3) * Math.PI * 2;
            this.spawn('vex', m.x + Math.cos(ang) * 2, m.y + 1, m.z + Math.sin(ang) * 2);
          }
          m.cooldownFlecha = 12.0; // 12s entre summons
          state.ui?.toast?.('🎆 Evoker summons Vex!');
          continue;
        }
        // Esqueleto + Stray + Witch: ataque ranged (flecha / poção). Cooldown 2.5s.
        if ((m.tipo === 'esqueleto' || m.tipo === 'stray' || m.tipo === 'witch') && naAlcance && m.cooldownFlecha <= 0) {
          const dx = player.pos.x - m.x;
          const dy = (player.pos.y + 1.4) - (m.y + 1.5);
          const dz = player.pos.z - m.z;
          const len = Math.hypot(dx, dy, dz);
          if (len > 0.5) {
            const dir = { x: dx/len, y: dy/len, z: dz/len };
            spawnArrow({ x: m.x, y: m.y + 1.5, z: m.z }, dir, Math.max(1, info.dano - 1));
            // Stray: aplica slowness 5s no player se a flecha o atingir
            // (proxy: aplica imediatamente já que o tracking de hit está em
            // particles.js sem callback. Custo: aplica mesmo se errar)
            if (m.tipo === 'stray' && len < 8) {
              player.efeitos = player.efeitos || {};
              player.efeitos.slowness = Date.now() + 5000;
            }
            m.cooldownFlecha = m.tipo === 'witch' ? 3.0 : 2.5;
          }
          continue;
        }
        if (info.explode) {
          // Creeper foge se há um cat dentro de 6 blocos (paridade MC).
          let catPerto = false;
          for (const o of this.mobs) {
            if (o.tipo !== 'cat') continue;
            const dx = o.x - m.x, dz = o.z - m.z;
            if (dx*dx + dz*dz < 36) { catPerto = true; break; }
          }
          if (catPerto) {
            m.panico = 2;        // entra em pânico (foge zigzag)
            m.creeperFuse = 0;   // desarma fuse
            continue;            // skip explosão
          }
          // Creeper: arma o fuse quando player entra no alcance.
          // Se player sair antes do fuse acabar, desarma e foge da explosão.
          if (naAlcance) {
            if (m.creeperFuse <= 0) {
              m.creeperFuse = info.fuseSegundos || 1.5;
              Audio.creeperHiss();
            } else {
              m.creeperFuse -= dt;
              if (m.creeperFuse <= 0) {
                this.explosao(world, m.x, m.y, m.z, 2);
                // Dano cai com a distância (linear até alcance + 1)
                const dist = Math.sqrt(d2);
                const fator = Math.max(0, 1 - dist / (info.alcance + 1));
                if (fator > 0) player.aplicarDano(Math.ceil(info.dano * fator), 'creeper');
                m.hp = 0;
              }
            }
          } else if (m.creeperFuse > 0) {
            // Player escapou — desarma silenciosamente
            m.creeperFuse = 0;
          }
        } else if (naAlcance && m.cooldownAtaque <= 0) {
          // Invisibilidade: mob ignora player se efeito ativo
          if (player.efeitos?.invisivel && Date.now() < player.efeitos.invisivel) continue;
          player.aplicarDano(info.dano, m.tipo);
          // Veneno: cave spider envenena player por 8s (1 dano cada 1.5s)
          if (info.poison) {
            player.efeitos = player.efeitos || {};
            player.efeitos.poison = Date.now() + 8000;
          }
          m.cooldownAtaque = 1.2;
        }
      }
    }
  }
  // Spawn rules por light level (paridade Minecraft).
  tentarSpawn(world, player, sun) {
    if (this.mobs.length >= (state.quality?.maxMobs ?? 14)) return;
    const ang = Math.random() * Math.PI * 2;
    const dist = 12 + Math.random() * 8;
    const x = Math.floor(player.pos.x + Math.cos(ang) * dist);
    const z = Math.floor(player.pos.z + Math.sin(ang) * dist);
    let y = WORLD_Y;
    while (y > 0 && !world.isSolido(x, y - 1, z)) y--;
    if (y >= WORLD_Y - 1 || y <= 1) return;
    const luz = world.getLightAt(x, y, z);
    const luzMax = Math.max(luz.sky, luz.block);
    const blocoChao = world.get(x, y - 1, z);
    // Rejeita spawn em cima de árvore (madeira/folha) — mob não pode
    // nascer no topo de copa, fica preso e parece "voando".
    if (blocoChao === BLOCO.MADEIRA || blocoChao === BLOCO.FOLHA) return;
    let tipos;
    // End: só spawna 1 ender_dragon (boss único). Player vê dragon imediatamente.
    if (state.world?.dimensao === 'end') {
      const jaTemDragon = this.mobs.some(m => m.tipo === 'ender_dragon');
      if (!jaTemDragon) {
        // Spawna dragon perto da plataforma central, voando alto
        this.spawn('ender_dragon', 5, 50, 5);
        state.ui?.toast?.('🐉 ENDER DRAGON apareceu!');
      }
      return;
    }
    // Nether: ghast voador OU magma_cube OU blaze + Piglin/Hoglin/Strider/Zombified Piglin (paridade Minecraft)
    if (state.world?.dimensao === 'nether') {
      if (this.mobs.length >= 10) return;
      const r = Math.random();
      if (r < 0.20) this.spawn('magma_cube', x, y, z);
      else if (r < 0.30) this.spawn('blaze', x, y + 4, z);
      else if (r < 0.40) this.spawn('ghast', x, y + 8, z);
      else if (r < 0.55) this.spawn('piglin', x, y, z);
      else if (r < 0.65) this.spawn('hoglin', x, y, z);
      else if (r < 0.72) this.spawn('zoglin', x, y, z);
      else if (r < 0.85) this.spawn('zombified_piglin', x, y, z);
      else if (r < 0.92) this.spawn('strider', x, y, z); // próximo a lava
      else this.spawn('phantom', x, y + 6, z); // raro
      return;
    }
    // End: Shulker em superfícies elevadas (raros)
    if (state.world?.dimensao === 'end' && y > 30 && Math.random() < 0.10) {
      this.spawn('shulker', x, y, z);
      return;
    }
    if (luzMax <= 7) {
      // Torch detection extra: hostis NÃO spawnam se luz block (artificial)
      // de qualquer voxel adjacente é >= 8. Permite o player iluminar área
      // segura com tochas (paridade Minecraft real).
      let luzArtPerto = 0;
      for (let dy = 0; dy <= 1 && luzArtPerto < 8; dy++) {
        for (let dx = -1; dx <= 1 && luzArtPerto < 8; dx++) {
          for (let dz = -1; dz <= 1 && luzArtPerto < 8; dz++) {
            const lz = world.getLightAt(x + dx, y + dy, z + dz);
            if (lz.block > luzArtPerto) luzArtPerto = lz.block;
          }
        }
      }
      if (luzArtPerto >= 8) return;
      tipos = ['zumbi', 'esqueleto', 'aranha', 'creeper'];
      if (y < 30) tipos.push('slime');
      if (Math.random() < 0.05) tipos.push('enderman');
      if (Math.random() < 0.04) tipos.push('witch'); // raro à noite
      // SPRINT MEGA-8: hostis novos noturnos
      if (Math.random() < 0.05) tipos.push('phantom'); // voador insônia
      if (Math.random() < 0.03) tipos.push('pillager'); // raro
      if (Math.random() < 0.02) tipos.push('vindicator'); // raro
      if (y < 12 && Math.random() < 0.10) tipos.push('silverfish'); // mineshaft deep
      if (Math.random() < 0.03 && y < 5) tipos.push('warden'); // SUPER RARO em deep
      if (Math.random() < 0.02) tipos.push('spider_jockey');
      // Drowned: spawn em (ou sobre) AGUA, durante a noite
      if (blocoChao === BLOCO.AGUA || world.get(x, y, z) === BLOCO.AGUA) {
        tipos.push('drowned'); tipos.push('drowned'); // peso 2× pra dominar em água
        // Glow Squid: passivo aquático, brilhante (chance moderada)
        if (Math.random() < 0.40) tipos.push('glow_squid');
        // Axolote: anfíbio aquático rosa (raro, 20%)
        if (Math.random() < 0.20) tipos.push('axolote');
      }
      // Stray: substitui esqueleto em chão de NEVE (taiga/montanhas)
      if (blocoChao === BLOCO.NEVE) {
        tipos.push('stray'); tipos.push('stray'); tipos.push('stray');
      }
    } else if (luzMax >= 9 && (blocoChao === BLOCO.GRAMA || blocoChao === BLOCO.AREIA)) {
      tipos = ['vaca', 'galinha', 'porco', 'ovelha', 'lobo'];
      if (Math.random() < 0.06) tipos.push('cat');      // raro
      // Coelho: comum em planicies/floresta, mais raro no deserto
      if (blocoChao === BLOCO.GRAMA) {
        if (Math.random() < 0.30) tipos.push('coelho');
        // Papagaio: 8% chance em grama (proxy de floresta tropical)
        if (Math.random() < 0.08) tipos.push('papagaio');
        // Mooshroom: bem raro (3%) em grama, biome cogumelo proxy
        if (Math.random() < 0.03) tipos.push('mooshroom');
        // Allay: raríssimo (1%), spawna em qualquer grama
        if (Math.random() < 0.01) tipos.push('allay');
        // Bee: passiva voadora, comum em grama (15% chance) — fauna ambient
        if (Math.random() < 0.15) tipos.push('bee');
        // Sapo: spawn em grama com água perto (proxy de pântano)
        let _aguaPerto = false;
        for (let dx = -3; dx <= 3 && !_aguaPerto; dx++) {
          for (let dz = -3; dz <= 3 && !_aguaPerto; dz++) {
            if (world.get(x + dx, y, z + dz) === BLOCO.AGUA) _aguaPerto = true;
          }
        }
        if (_aguaPerto && Math.random() < 0.25) tipos.push('sapo');
      } else if (blocoChao === BLOCO.AREIA) {
        if (Math.random() < 0.10) tipos.push('coelho');
        // Camelo: passivo grande do deserto (8% chance em areia)
        if (Math.random() < 0.08) tipos.push('camelo');
        // Tartaruga: spawn em areia próxima da água (1 bloco de água em raio 3)
        let aguaPerto = false;
        for (let dx = -3; dx <= 3 && !aguaPerto; dx++) {
          for (let dz = -3; dz <= 3 && !aguaPerto; dz++) {
            if (world.get(x + dx, y, z + dz) === BLOCO.AGUA) aguaPerto = true;
          }
        }
        if (aguaPerto && Math.random() < 0.40) tipos.push('tartaruga');
      } else if (blocoChao === BLOCO.NEVE) {
        // Urso polar: passivo neutro em taiga (chão de NEVE)
        if (Math.random() < 0.15) tipos.push('urso_polar');
        // Raposa: passiva ágil (taiga)
        if (Math.random() < 0.20) tipos.push('raposa');
        // SPRINT MEGA-8: Goat (montanha/snowy)
        if (Math.random() < 0.10) tipos.push('goat');
      }
      // SPRINT MEGA-8: Mobs específicos por bioma (Cherry/Mangrove/Bamboo/Mushroom)
      const biomaAtual = world.biomaEm?.(x, z);
      if (biomaAtual === 'bamboo_jungle' && Math.random() < 0.30) tipos.push('panda');
      if (biomaAtual === 'mangrove_swamp' && Math.random() < 0.25) {
        tipos.push('frog_temperate', 'frog_warm', 'frog_cold');
      }
      if (biomaAtual === 'cherry_grove' && Math.random() < 0.10) tipos.push('bee');
      if (biomaAtual === 'mushroom_fields' && Math.random() < 0.40) tipos.push('mooshroom');
      // Bat em cavernas (luz baixa mas dia)
      if (luzMax >= 9 && y < 25 && Math.random() < 0.05) tipos.push('bat');
      // Squid/Dolphin em água
      if ((blocoChao === BLOCO.AGUA || world.get(x, y, z) === BLOCO.AGUA)) {
        if (Math.random() < 0.20) tipos.push('squid');
        if (Math.random() < 0.10) tipos.push('dolphin');
      }
      // Horse em plains (mob mount)
      if (blocoChao === BLOCO.GRAMA && Math.random() < 0.05) {
        const r2 = Math.random();
        if (r2 < 0.5) tipos.push('horse');
        else if (r2 < 0.8) tipos.push('donkey');
        else tipos.push('llama');
      }
      // Endermite raro (drop enderman)
      if (Math.random() < 0.005) tipos.push('endermite');
      if (Math.random() < 0.03) tipos.push('villager'); // muito raro (em "vilas")
      if (Math.random() < 0.015) tipos.push('iron_golem'); // raríssimo
      if (Math.random() < 0.008) tipos.push('wandering_trader'); // muito raro
      // Husk: hostil que spawna de DIA em deserto (não queima no sol)
      if (blocoChao === BLOCO.AREIA && Math.random() < 0.20) {
        tipos.push('husk');
      }
    } else {
      return;
    }
    const tipo = tipos[Math.floor(Math.random() * tipos.length)];
    // Papagaio: 4 paletas de cor (vermelho, azul, verde, amarelo)
    if (tipo === 'papagaio') {
      const paletas = [
        { cor: 0xff5252, sec: 0xfff176 }, // vermelho/amarelo
        { cor: 0x42a5f5, sec: 0xff5252 }, // azul/vermelho
        { cor: 0x66bb6a, sec: 0xff9800 }, // verde/laranja
        { cor: 0xffeb3b, sec: 0x42a5f5 }, // amarelo/azul
      ];
      const p = paletas[Math.floor(Math.random() * paletas.length)];
      this.spawn(tipo, x, y, z, p);
    } else {
      this.spawn(tipo, x, y, z);
    }
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
    Audio.explosao();
    for (let dx = -raio; dx <= raio; dx++)
      for (let dy = -raio; dy <= raio; dy++)
        for (let dz = -raio; dz <= raio; dz++) {
          if (dx*dx + dy*dy + dz*dz > raio*raio) continue;
          const x = Math.floor(cx + dx), y = Math.floor(cy + dy), z = Math.floor(cz + dz);
          const b = world.get(x, y, z);
          if (b === BLOCO.AR || b === BLOCO.BEDROCK) continue;
          world.set(x, y, z, BLOCO.AR);
        }
  }
}
