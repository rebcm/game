// =====================================================================
// save.js — Persistência em localStorage (versão v4)
// =====================================================================

import { SAVE_KEY } from './constants.js';
import { World } from './world.js';
import { state } from './state.js';

export const Save = {
  salvar() {
    try {
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
        v: 4, seed: state.world.seed,
        p: { x: state.player.pos.x, y: state.player.pos.y, z: state.player.pos.z },
        slot: state.inv.slotSel, hp: state.player.hp, fome: state.player.fome,
        xp: state.player.xp, nivel: state.player.nivel,
        td: state.tempoDia, modo: state.player.modo,
        inv: invSerializado,
        arm: armSerializada,
        baus: bausSerializados,
        forn: fornsSerializadas,
        chunks: chunksMod,
      };
      localStorage.setItem(SAVE_KEY, JSON.stringify(data));
      state.ui.toast('Salvo!');
      return true;
    } catch (e) {
      state.ui.toast('Erro ao salvar');
      console.error(e);
      return false;
    }
  },
  carregar() {
    try {
      const raw = localStorage.getItem(SAVE_KEY);
      if (!raw) return null;
      return JSON.parse(raw);
    } catch (_) { return null; }
  },
  apagar() {
    localStorage.removeItem(SAVE_KEY);
    state.ui.toast('Save apagado');
  },
};
