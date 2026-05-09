// =====================================================================
// achievements.js — Conquistas estilo Minecraft "advancements"
// Cada conquista tem um id, título, descrição e ícone. Disparada via
// Achievements.unlock(id). Persistida em localStorage. Desbloqueio
// mostra toast verde grande por 3s.
// =====================================================================

import { state } from './state.js';
import { Audio } from './audio.js';

const STORAGE_KEY = 'rebcm3d_achievements_v1';

export const ACHIEVEMENTS = {
  PRIMEIRA_MADEIRA: { titulo: 'Conseguindo Madeira',  desc: 'Quebre seu primeiro bloco de madeira', icone: '🪵' },
  PRIMEIRA_PRANCHA: { titulo: 'Conseguindo Pranchas', desc: 'Crie pranchas',                        icone: '🟫' },
  PRIMEIRA_PICARETA:{ titulo: 'Tempo Para a Mineração', desc: 'Crie uma picareta',                  icone: '⛏'  },
  PRIMEIRA_PEDRA:   { titulo: 'Era da Pedra',         desc: 'Quebre seu primeiro bloco de pedra',  icone: '🪨' },
  PRIMEIRO_DIAMANTE:{ titulo: 'Diamantes!',           desc: 'Minere um diamante',                  icone: '💎' },
  PRIMEIRO_FORNALHA:{ titulo: 'Aceso',                desc: 'Crie uma fornalha',                   icone: '🔥' },
  COMER_CARNE:      { titulo: 'Hora do Almoço',       desc: 'Coma carne cozida',                   icone: '🍖' },
  PRIMEIRO_MOB:     { titulo: 'Monsterhunter',        desc: 'Derrote seu primeiro mob hostil',     icone: '⚔'  },
  CRIAR_BAU:        { titulo: 'Acumulador',           desc: 'Crie um baú',                         icone: '📦' },
  PLANTAR_MUDA:     { titulo: 'Reflorestador',        desc: 'Plante uma muda de árvore',           icone: '🌱' },
  DOMESTICAR_LOBO:  { titulo: 'Melhor Amigo do Homem', desc: 'Domestique um lobo',                  icone: '🐺' },
  TANTO_FAZ:        { titulo: 'Profundezas',          desc: 'Encontre uma dungeon',                icone: '🏚' },
  PORTAL_NETHER:    { titulo: 'Portal Aceso',         desc: 'Entre no Nether pela primeira vez',   icone: '🔥' },
  PORTAL_END:       { titulo: 'Voyager Espacial',     desc: 'Entre no End pela primeira vez',      icone: '🌌' },
  SLAY_DRAGON:      { titulo: 'Matador de Dragões',   desc: 'Derrote o Ender Dragon!',             icone: '🐉' },
  // SPRINT MEGA-20: 100+ achievements paridade Minecraft
  COLECIONAR_OURO:    { titulo: 'Era do Ouro',          desc: 'Minere um lingote de ouro',           icone: '🟡' },
  COLECIONAR_FERRO:   { titulo: 'Acquire Hardware',     desc: 'Pegue 1 ferro',                       icone: '⚙' },
  CRAFTAR_ESPADA:     { titulo: 'Tempo de Bater',       desc: 'Crie uma espada',                     icone: '🗡' },
  PRIMEIRA_ESMERALDA: { titulo: 'Esmeraldas Encontradas', desc: 'Minere uma esmeralda',              icone: '💚' },
  PRIMEIRO_LIVRO:     { titulo: 'Encadernação',         desc: 'Crie um livro',                       icone: '📕' },
  PRIMEIRA_BUSSOLA:   { titulo: 'Norte Verdadeiro',     desc: 'Crie uma bússola',                    icone: '🧭' },
  PRIMEIRO_RELOGIO:   { titulo: 'Tempo dos Sonhos',     desc: 'Crie um relógio',                     icone: '🕐' },
  TRADE_VILLAGER:     { titulo: 'O Que Tem Pra Vender?', desc: 'Negocie com um villager',            icone: '👤' },
  ESMAGAR_PILLAGER:   { titulo: 'Vingança Pelo Vilarejo', desc: 'Mate um Pillager',                  icone: '🛡' },
  CHEFAO_WITHER:      { titulo: 'Tira-isso!',           desc: 'Derrote o Wither',                    icone: '💀' },
  CHEFAO_WARDEN:      { titulo: 'Cuidado com o Som',    desc: 'Sobreviva a um encontro com o Warden', icone: '🦴' },
  ELYTRA_VOO:         { titulo: 'Asas',                 desc: 'Voe com Elytra por 100 blocos',       icone: '🪽' },
  TOTEM_REVIVE:       { titulo: 'Acima e Além',         desc: 'Use Totem of Undying',                icone: '🗿' },
  ENCANTAR_MAX:       { titulo: 'Bibliotecário',        desc: 'Encante um item nivel III',           icone: '📚' },
  PEGAR_PEIXE:        { titulo: 'Tempo de Pesca',       desc: 'Pegue um peixe',                      icone: '🎣' },
  CULTIVAR_TRIGO:     { titulo: 'Pão',                  desc: 'Cultive trigo e faça pão',            icone: '🌾' },
  DOMESTICAR_GATO:    { titulo: 'Plenitude',            desc: 'Domestique um gato',                  icone: '🐱' },
  DOMESTICAR_PAPAGAIO:{ titulo: 'Talkative',            desc: 'Domestique um papagaio',              icone: '🦜' },
  CRIAR_FAMILIA:      { titulo: 'Boa Estréia',          desc: 'Faça 2 animais reproduzirem',         icone: '🐮' },
  EXPLORE_OCEAN:      { titulo: 'Aquático',             desc: 'Encontre Ocean Monument',             icone: '🌊' },
  EXPLORE_MANSION:    { titulo: 'Adventures',           desc: 'Encontre Woodland Mansion',           icone: '🏰' },
  EXPLORE_FORTRESS:   { titulo: 'Lugares Quentes',      desc: 'Encontre Nether Fortress',            icone: '🏛' },
  EXPLORE_ANCIENT:    { titulo: 'Eco do Vazio',         desc: 'Encontre Ancient City',               icone: '🌑' },
  EXPLORE_TRIAL:      { titulo: 'Provação',             desc: 'Complete um Trial Chamber',           icone: '⚔' },
  EXPLORE_VILLAGE:    { titulo: 'Eu Vejo o Que Você Fez Aí', desc: 'Encontre uma vila',              icone: '🏘' },
  EXPLORE_DESERT:     { titulo: 'Areia, Areia em Tudo Lugar', desc: 'Encontre o deserto',           icone: '🏜' },
  EXPLORE_NETHER_OURO:{ titulo: 'Procurando o Mestre',  desc: 'Negocie com Piglins',                 icone: '🐷' },
  COLETE_NETHERITE:   { titulo: 'Cobrir-se em Diamantes', desc: 'Equipe armadura Netherite completa', icone: '⚫' },
  GANHO_BEACON:       { titulo: 'Sinal Brilhante',      desc: 'Ative um Beacon',                     icone: '🌟' },
  GANHO_CONDUIT:      { titulo: 'Conduit',              desc: 'Ative um Conduit',                    icone: '🔱' },
  ESQUELETO_KILL:     { titulo: 'Ranged Kill',          desc: 'Mate esqueleto com flecha',           icone: '🏹' },
  CREEPER_EVIT:       { titulo: 'Boa Reflexão',         desc: 'Evite explosão de Creeper',           icone: '💚' },
  COZINHAR_FORNALHA:  { titulo: 'Cozido!',              desc: 'Cozinhe item na fornalha',            icone: '🔥' },
  PURPUR_BLOCK:       { titulo: 'Por Aí!',              desc: 'Coloque um bloco purpur',             icone: '🟣' },
  END_GATEWAY:        { titulo: 'Você Precisa Acreditar', desc: 'Use End Gateway portal',            icone: '✨' },
  CHORUS_TELEPORT:    { titulo: 'Misterioso Caminho',   desc: 'Coma fruta chorus pra teleport',      icone: '🟪' },
  // 1.21+
  TRIAL_KEY_USE:      { titulo: 'Vault Aberto',         desc: 'Use Trial Key num Vault',             icone: '🗝' },
  WIND_CHARGE_USE:    { titulo: 'Sopro do Breeze',      desc: 'Lance Wind Charge',                   icone: '💨' },
  MACE_SMASH:         { titulo: 'Eclipse Total',        desc: 'Mate mob com Mace smash',             icone: '🔨' },
  // Sky achievements
  SKY_HIGH:           { titulo: 'Caíram Pra Cima',      desc: 'Coloque bloco a 100m altura',         icone: '🌠' },
  SKY_DEEP:           { titulo: 'Profundo',             desc: 'Vá a y=-50',                          icone: '⛏' },
  SKY_DEEP_DARK:      { titulo: 'Sub-Cidade',           desc: 'Encontre Deep Dark biome',            icone: '🌑' },
  // Combate
  KILL_10_ZUMBIS:     { titulo: 'Limpa Caverna',        desc: 'Mate 10 zumbis',                      icone: '🧟' },
  KILL_BOSS:          { titulo: 'Slayer',               desc: 'Mate qualquer boss',                  icone: '👑' },
  // Progresso
  GANHE_NIVEL_30:     { titulo: 'Bem-Encantado',        desc: 'Atinja nível 30',                     icone: '⬆' },
  COLECIONE_TODAS_CORES: { titulo: 'Arco-Íris',         desc: 'Tenha lã de todas as 16 cores',       icone: '🌈' },
  // Decoração
  DECORAR_CASA:       { titulo: 'Lar Doce Lar',         desc: 'Coloque cama+baú+fornalha em mesma sala', icone: '🏠' },
  PINTURA_PLACE:      { titulo: 'Picasso',              desc: 'Coloque uma pintura',                 icone: '🎨' },
  ITEMFRAME_PLACE:    { titulo: 'Galeria',              desc: 'Coloque item numa moldura',           icone: '🖼' },
  // Survival challenges
  SURVIVE_NIGHT:      { titulo: 'Sobreviva a Noite',    desc: 'Sobreviva 1 noite sem morrer',        icone: '🌙' },
  HUNGER_MAX:         { titulo: 'Equilíbrio',           desc: 'Coma comida com fome cheia',          icone: '🍽' },
  // Mining
  MINE_100_BLOCKS:    { titulo: 'Mineração 101',        desc: 'Quebre 100 blocos',                   icone: '⛏' },
  MINE_1000_BLOCKS:   { titulo: 'Engenheiro',           desc: 'Quebre 1000 blocos',                  icone: '🛠' },
  // Crafting
  CRAFT_FULL_ARMOR:   { titulo: 'Defesa Total',         desc: 'Equipe armadura completa',            icone: '🛡' },
  CRAFT_ALL_TOOLS:    { titulo: 'Toolset',              desc: 'Tenha todas ferramentas tier ferro',  icone: '🧰' },
};

export const Achievements = {
  _carregadas: null,
  _carregar() {
    if (this._carregadas) return this._carregadas;
    try {
      this._carregadas = new Set(JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]'));
    } catch (_) {
      this._carregadas = new Set();
    }
    return this._carregadas;
  },
  _salvar() {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify([...this._carregadas]));
    } catch (_) {}
  },
  desbloqueada(id) {
    return this._carregar().has(id);
  },
  unlock(id) {
    const set = this._carregar();
    if (set.has(id)) return false;
    const ach = ACHIEVEMENTS[id];
    if (!ach) return false;
    set.add(id);
    this._salvar();
    Audio.levelUp?.();
    state.ui?.toastConquista?.(ach);
    return true;
  },
  reset() {
    this._carregadas = new Set();
    try { localStorage.removeItem(STORAGE_KEY); } catch (_) {}
  },
};
