// =====================================================================
// save.js — Persistência multi-mundo em localStorage.
//
// Layout:
//   rebcm3d_player        → { name } (persistido entre sessões)
//   rebcm3d_worlds_index  → [ { name, seed, lastPlayed, modo } ]
//   rebcm3d_world_<name>  → snapshot completo do mundo (v5)
//   rebcm3d_save_v4       → save legado (auto-migrado pra "Mundo 1")
// =====================================================================

import { state } from './state.js';

const PLAYER_KEY = 'rebcm3d_player';
const INDEX_KEY  = 'rebcm3d_worlds_index';
const WORLD_PREFIX = 'rebcm3d_world_';
const LEGACY_KEY = 'rebcm3d_save_v4';

function _safeJSON(s, fb) {
  // BUG-fix: JSON.parse(null) retorna null sem throw — precisa de check
  // explícito ou _renderBoot quebra na 1ª inicialização sem localStorage.
  if (s === null || s === undefined) return fb;
  try {
    const v = JSON.parse(s);
    return (v === null || v === undefined) ? fb : v;
  } catch (_) { return fb; }
}

export const Save = {
  // === Identidade do jogador ===
  getPlayer() {
    return _safeJSON(localStorage.getItem(PLAYER_KEY), { name: '' });
  },
  setPlayer(name) {
    localStorage.setItem(PLAYER_KEY, JSON.stringify({ name }));
  },

  // === Index de mundos ===
  listarMundos() {
    const idx = _safeJSON(localStorage.getItem(INDEX_KEY), []);
    // Migração: se há save legado e não está no index, vira "Mundo Antigo"
    if (localStorage.getItem(LEGACY_KEY) && !idx.find(w => w.name === 'Mundo Antigo')) {
      idx.unshift({ name: 'Mundo Antigo', seed: 42, lastPlayed: 0, modo: 'survival', _legacy: true });
      localStorage.setItem(INDEX_KEY, JSON.stringify(idx));
    }
    return idx;
  },
  registrarMundo(name, seed, modo) {
    const idx = this.listarMundos().filter(w => w.name !== name);
    idx.unshift({ name, seed, lastPlayed: Date.now(), modo: modo || 'survival' });
    if (idx.length > 12) idx.length = 12;
    localStorage.setItem(INDEX_KEY, JSON.stringify(idx));
  },
  apagarMundo(name) {
    const idx = this.listarMundos().filter(w => w.name !== name);
    localStorage.setItem(INDEX_KEY, JSON.stringify(idx));
    localStorage.removeItem(WORLD_PREFIX + name);
  },

  // === Salvar / carregar mundo ===
  _keyDoMundo(name) {
    if (name === 'Mundo Antigo') return LEGACY_KEY; // compat
    return WORLD_PREFIX + name;
  },

  salvar() {
    try {
      const name = state.worldName || 'Mundo 1';
      const chunksMod = [];
      for (const [, c] of state.world.chunks) {
        if (c.modificado) {
          chunksMod.push({
            cx: c.cx, cz: c.cz,
            b: btoa(String.fromCharCode(...c.blocks)),
          });
        }
      }
      const invSerializado = [];
      for (let k = 0; k < state.inv.slots.length; k++) {
        const s = state.inv.slots[k];
        if (!s) continue;
        invSerializado.push({ sx: k, b: s.b, i: s.i, q: s.q });
      }
      const armSerializada = {};
      for (const peca of Object.keys(state.inv.armadura)) {
        const a = state.inv.armadura[peca];
        if (a) armSerializada[peca] = { b: a.b, i: a.i, q: a.q };
      }
      const bausSerializados = [];
      for (const [k, slots] of state.world.bauTesouros) {
        if (slots.some(s => s)) bausSerializados.push({ k, slots });
      }
      const fornsSerializadas = [];
      for (const [k, f] of state.world.fornalhaEstados) {
        if (f.input || f.combustivel || f.output) {
          fornsSerializadas.push({ k, input: f.input, combustivel: f.combustivel, output: f.output });
        }
      }
      const data = {
        v: 5, name, seed: state.world.seed,
        playerName: state.playerName || '',
        p: { x: state.player.pos.x, y: state.player.pos.y, z: state.player.pos.z },
        slot: state.inv.slotSel, hp: state.player.hp, fome: state.player.fome,
        xp: state.player.xp, nivel: state.player.nivel,
        td: state.tempoDia, modo: state.player.modo,
        inv: invSerializado,
        arm: armSerializada,
        baus: bausSerializados,
        forn: fornsSerializadas,
        chunks: chunksMod,
        savedAt: Date.now(),
      };
      localStorage.setItem(this._keyDoMundo(name), JSON.stringify(data));
      this.registrarMundo(name, state.world.seed, state.player.modo);
      state.ui?.toast?.('Salvo!');
      return true;
    } catch (e) {
      state.ui?.toast?.('Erro ao salvar');
      console.error(e);
      return false;
    }
  },

  carregarPorNome(name) {
    return _safeJSON(localStorage.getItem(this._keyDoMundo(name)), null);
  },

  // Compat com chamadas antigas Save.carregar() — pega o último mundo
  // jogado (1º do index).
  carregar() {
    const idx = this.listarMundos();
    if (!idx.length) return null;
    return this.carregarPorNome(idx[0].name);
  },

  apagar() {
    const name = state.worldName;
    if (name) this.apagarMundo(name);
    state.ui?.toast?.('Save apagado');
  },

  // === Export/Import (compartilhamento entre jogadores) ===
  exportarMundoAtual() {
    const name = state.worldName || 'Mundo 1';
    const data = this.carregarPorNome(name);
    if (!data) return null;
    const blob = new Blob([JSON.stringify(data)], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `${name.replace(/[^a-z0-9]/gi, '_')}.json`;
    a.click();
    URL.revokeObjectURL(url);
    return true;
  },
  importarMundo(json) {
    try {
      const data = typeof json === 'string' ? JSON.parse(json) : json;
      if (!data || !data.seed) return null;
      const name = data.name || `Importado ${Date.now() % 1000}`;
      data.name = name;
      localStorage.setItem(WORLD_PREFIX + name, JSON.stringify(data));
      this.registrarMundo(name, data.seed, data.modo);
      return name;
    } catch (e) { console.error(e); return null; }
  },
};
