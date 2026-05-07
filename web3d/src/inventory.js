// =====================================================================
// inventory.js — Inventário, drops, crafting
// =====================================================================

import { BLOCO, ITEM, ITEM_INFO, RECEITAS } from './constants.js';
import { state } from './state.js';
import { Audio } from './audio.js';

export class Inventario {
  constructor() {
    this.slots = new Array(36).fill(null); // {b?, i?, q}
    this.slotSel = 0;
    this.armadura = { cabeca: null, torso: null, pernas: null, botas: null };
  }
  defesaTotal() {
    let total = 0;
    for (const peca of Object.values(this.armadura)) {
      if (peca && peca.i !== undefined) total += ITEM_INFO[peca.i]?.defesa || 0;
    }
    return total;
  }
  equiparDoSlot(idx) {
    const it = this.slots[idx];
    if (!it || it.i === undefined) return false;
    const info = ITEM_INFO[it.i];
    if (!info?.armadura) return false;
    const peca = info.armadura;
    const anterior = this.armadura[peca];
    this.armadura[peca] = { ...it, q: 1 };
    this.slots[idx] = anterior;
    Audio.equipArmor();
    state.ui?.atualizar();
    return true;
  }
  desequipar(peca) {
    const item = this.armadura[peca];
    if (!item) return false;
    if (this.adicionar(item)) {
      this.armadura[peca] = null;
      state.ui?.atualizar();
      return true;
    }
    return false;
  }
  itemSelecionado() { return this.slots[this.slotSel]; }
  selecionar(idx) {
    const novo = ((idx % 9) + 9) % 9;
    if (novo === this.slotSel) { state.ui?.atualizar(); return; }
    this.slotSel = novo;
    state.ui?.atualizar();
    const it = this.slots[novo];
    if (it && state.ui) {
      // Importação tardia evita ciclo
      const nome = it.b !== undefined ? state.constantes?.BLOCO_INFO[it.b]?.nome
                : it.i !== undefined ? ITEM_INFO[it.i]?.nome : null;
      if (nome) state.ui.toast(nome);
    }
  }
  adicionar(item) {
    // Empilha em slots existentes do mesmo tipo
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
        if (item.q <= 0) { state.ui?.atualizar(); return true; }
      }
    }
    // Novo slot
    for (let i = 0; i < this.slots.length; i++) {
      if (!this.slots[i]) {
        this.slots[i] = { ...item };
        state.ui?.atualizar();
        return true;
      }
    }
    state.ui?.atualizar();
    return false;
  }
  consumirAtual() {
    const s = this.slots[this.slotSel];
    if (!s) return;
    s.q -= 1;
    if (s.q <= 0) this.slots[this.slotSel] = null;
    state.ui?.atualizar();
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
    state.ui?.atualizar();
  }
  trocar(a, b) {
    const t = this.slots[a]; this.slots[a] = this.slots[b]; this.slots[b] = t;
    state.ui?.atualizar();
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

// Drops e velocidade de quebra por bloco/tier
export const Drops = {
  podeMinerar(b, tier) {
    if (b === BLOCO.BEDROCK) return false;
    if ([BLOCO.DIAMANTE, BLOCO.OURO].includes(b)) return tier >= 3;
    if (b === BLOCO.FERRO) return tier >= 2;
    if ([BLOCO.PEDRA, BLOCO.CARVAO].includes(b)) return tier >= 1;
    if (b === BLOCO.OBSIDIANA) return tier >= 4;
    return ![BLOCO.AR].includes(b);
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
      case BLOCO.VIDRO:    return [{ b: BLOCO.VIDRO, q: 1 }];
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

// Crafting: receitas disponíveis + craft.
export const Crafting = {
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
