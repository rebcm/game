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
