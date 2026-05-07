// =====================================================================
// ui.js — UI: HUD, paineis, F3 debug, pause menu, criativo, tooltip
// =====================================================================

import * as THREE from 'three';
import {
  BLOCO, BLOCO_INFO, ITEM, ITEM_INFO, ICONE, RECEITAS, CHUNK_SIZE, WORLD_Y,
} from './constants.js';
import { chunkKey } from './utils.js';
import { Crafting } from './inventory.js';
import { Achievements } from './achievements.js';
import { state } from './state.js';
import { Audio } from './audio.js';

export class UI {
  constructor() {
    this.toastTimer = null;
    this.flashTimer = null;
    this.elHotbar = document.getElementById('hotbar');
    this.elBag = document.getElementById('bag-grid');
    this.elBagHot = document.getElementById('bag-hotbar');
    this.elCraftLista = document.getElementById('craft-lista');
    this.elCraftStatus = document.getElementById('craft-status');
    this.elTooltip = document.getElementById('tooltip');
    this.f3Ativo = false;
    this.hudOculto = false;
    this.criativoAbaAtual = 'construcao';
    this.criativoFiltro = '';
  }

  atualizar() {
    this.renderHotbar();
    this.renderBars();
    this.atualizarXP();
    this.atualizarOverlays();
  }

  atualizarOverlays() {
    if (!state.player) return;
    const vin = document.getElementById('vinheta');
    if (vin) vin.classList.toggle('low-hp', state.player.hp <= 4 && state.player.modo === 'survival');
    const uw = document.getElementById('overlay-underwater');
    if (uw) uw.classList.toggle('show', !!state.player.submerso);
    const arWrap = document.getElementById('ar-wrap');
    if (arWrap) {
      const mostrar = state.player.submerso || (state.player.ar < state.player.arMax && state.player.modo === 'survival');
      arWrap.classList.toggle('hidden', !mostrar);
    }
  }

  flashDano() {
    const el = document.getElementById('flash-dano');
    if (!el) return;
    el.classList.add('show');
    if (this.flashTimer) clearTimeout(this.flashTimer);
    this.flashTimer = setTimeout(() => el.classList.remove('show'), 220);
  }

  // === Damage numbers flutuantes ===
  // Renderizado como div HTML posicionado por projeção 3D → 2D.
  // Cada número anima fade-up por 1.2s e remove.
  spawnDamageNumber(x, y, z, dano, isCrit) {
    if (!this._damageNums) this._damageNums = [];
    const el = document.createElement('div');
    el.className = 'damage-number' + (isCrit ? ' crit' : '');
    el.textContent = isCrit ? `-${dano} ⚡` : `-${dano}`;
    el.style.position = 'fixed';
    el.style.zIndex = '90';
    document.body.appendChild(el);
    this._damageNums.push({
      el, x, y, z,
      vy: 1.0,
      life: 1.2,
      ageMax: 1.2,
    });
  }
  atualizarDamageNumbers(dt) {
    if (!this._damageNums || !state.renderer) return;
    const cam = state.renderer.camera;
    const v = new THREE.Vector3();
    const w = window.innerWidth, h = window.innerHeight;
    for (let i = this._damageNums.length - 1; i >= 0; i--) {
      const d = this._damageNums[i];
      d.life -= dt;
      d.y += d.vy * dt;
      if (d.life <= 0) {
        d.el.remove();
        this._damageNums.splice(i, 1);
        continue;
      }
      // Projeta posição 3D → coordenada de tela
      v.set(d.x, d.y, d.z).project(cam);
      // Atrás da câmera? esconde.
      if (v.z > 1) { d.el.style.display = 'none'; continue; }
      d.el.style.display = '';
      const sx = (v.x * 0.5 + 0.5) * w;
      const sy = (-v.y * 0.5 + 0.5) * h;
      d.el.style.left = `${sx}px`;
      d.el.style.top  = `${sy}px`;
      d.el.style.opacity = `${Math.max(0, d.life / d.ageMax)}`;
    }
  }

  subtitle(texto) {
    const cont = document.getElementById('subtitles');
    if (!cont) return;
    const el = document.createElement('div');
    el.className = 'subtitle';
    el.textContent = texto;
    cont.appendChild(el);
    setTimeout(() => el.remove(), 3000);
    while (cont.children.length > 4) cont.firstChild.remove();
  }

  toast(msg) {
    const el = document.getElementById('toast');
    el.textContent = msg;
    el.classList.add('show');
    if (this.toastTimer) clearTimeout(this.toastTimer);
    this.toastTimer = setTimeout(() => el.classList.remove('show'), 2000);
  }

  // Loading overlay (backlog de chunks/mesh ou aviso de memória)
  mostrarLoading(msg = 'Carregando…', detalhe = '') {
    const ov = document.getElementById('loading-overlay');
    if (!ov) return;
    ov.classList.remove('hidden');
    document.getElementById('loading-msg').textContent = msg;
    document.getElementById('loading-detail').textContent = detalhe;
  }
  esconderLoading() {
    document.getElementById('loading-overlay')?.classList.add('hidden');
  }

  // Conquista (achievement) — toast maior e mais demorado, ícone à esquerda
  toastConquista(ach) {
    let el = document.getElementById('conquista-toast');
    if (!el) {
      el = document.createElement('div');
      el.id = 'conquista-toast';
      el.className = 'conquista-toast';
      document.body.appendChild(el);
    }
    el.innerHTML = `<span class="ico">${ach.icone}</span><div><div class="t">Conquista desbloqueada</div><div class="d">${ach.titulo}</div></div>`;
    el.classList.add('show');
    if (this._conquistaTimer) clearTimeout(this._conquistaTimer);
    this._conquistaTimer = setTimeout(() => el.classList.remove('show'), 4000);
  }

  atualizarXP() {
    if (!state.player) return;
    const nivel = state.player.nivel || 0;
    const cur = state.player.xp || 0;
    const max = Math.max(7, nivel * nivel * 4 + 7);
    const fill = document.getElementById('xp-fill');
    const lbl = document.getElementById('xp-nivel');
    if (fill) fill.style.width = `${Math.min(100, (cur / max) * 100)}%`;
    if (lbl)  lbl.textContent = `Nv.${nivel}  ${cur}/${max}`;
  }

  renderHotbar() {
    if (!state.inv) return;
    if (!this.elHotbar.children.length) {
      for (let i = 0; i < 9; i++) {
        const div = document.createElement('div');
        div.className = 'slot';
        div.dataset.idx = i;
        div.onclick = () => state.inv.selecionar(i);
        div.addEventListener('mouseenter', (e) => this._tooltipMostrar(state.inv.slots[i], e));
        div.addEventListener('mousemove',  (e) => this._tooltipMostrar(state.inv.slots[i], e));
        div.addEventListener('mouseleave', () => this._tooltipEsconder());
        this.elHotbar.appendChild(div);
      }
    }
    for (let i = 0; i < 9; i++) {
      const s = state.inv.slots[i];
      const el = this.elHotbar.children[i];
      el.classList.toggle('sel', i === state.inv.slotSel);
      el.innerHTML = this._slotHTML(s);
    }
  }

  // Cache de mini-blocos isométricos (canvas 32×32) por bloco ID
  _blockIconCache = new Map();
  _criarBlocoIcon(blocoId) {
    if (this._blockIconCache.has(blocoId)) return this._blockIconCache.get(blocoId);
    const info = BLOCO_INFO[blocoId];
    if (!info) return null;
    const cnv = document.createElement('canvas');
    cnv.width = 32; cnv.height = 32;
    const ctx = cnv.getContext('2d');
    // Desenha cubo isométrico simples com 3 faces visíveis
    const corTop = '#' + (info.cor).toString(16).padStart(6, '0');
    const corSide = '#' + (info.lateral).toString(16).padStart(6, '0');
    // Face frontal (esquerda): cor lateral levemente mais escura
    const r = (info.lateral >> 16) & 0xFF;
    const g = (info.lateral >> 8) & 0xFF;
    const b = info.lateral & 0xFF;
    const corFront = `rgb(${Math.max(0,r-25)},${Math.max(0,g-25)},${Math.max(0,b-25)})`;
    // Topo (paralelogramo)
    ctx.fillStyle = corTop;
    ctx.beginPath();
    ctx.moveTo(16, 4); ctx.lineTo(28, 10); ctx.lineTo(16, 16); ctx.lineTo(4, 10);
    ctx.closePath(); ctx.fill();
    // Lado direito
    ctx.fillStyle = corSide;
    ctx.beginPath();
    ctx.moveTo(16, 16); ctx.lineTo(28, 10); ctx.lineTo(28, 24); ctx.lineTo(16, 30);
    ctx.closePath(); ctx.fill();
    // Lado esquerdo (mais escuro)
    ctx.fillStyle = corFront;
    ctx.beginPath();
    ctx.moveTo(16, 16); ctx.lineTo(4, 10); ctx.lineTo(4, 24); ctx.lineTo(16, 30);
    ctx.closePath(); ctx.fill();
    // Bordas finas pretas
    ctx.strokeStyle = 'rgba(0,0,0,0.3)';
    ctx.lineWidth = 0.8;
    ctx.beginPath();
    ctx.moveTo(16, 4); ctx.lineTo(28, 10); ctx.lineTo(28, 24); ctx.lineTo(16, 30);
    ctx.lineTo(4, 24); ctx.lineTo(4, 10); ctx.closePath();
    ctx.moveTo(16, 16); ctx.lineTo(28, 10);
    ctx.moveTo(16, 16); ctx.lineTo(4, 10);
    ctx.moveTo(16, 16); ctx.lineTo(16, 30);
    ctx.stroke();
    const dataUrl = cnv.toDataURL();
    this._blockIconCache.set(blocoId, dataUrl);
    return dataUrl;
  }

  _slotHTML(s) {
    if (!s) return '';
    let ic;
    if (s.b !== undefined) {
      const icon = this._criarBlocoIcon(s.b);
      if (icon) {
        ic = `<img src="${icon}" style="width:28px;height:28px;image-rendering:pixelated;">`;
      } else {
        ic = ICONE[s.b] || '■';
      }
    } else {
      ic = ITEM_INFO[s.i]?.icone || '?';
    }
    const qtd = s.q > 1 ? `<span class="qtd">${s.q}</span>` : '';
    return `${ic}${qtd}`;
  }

  _tooltipMostrar(slot, ev) {
    const el = this.elTooltip;
    if (!el || !slot) { this._tooltipEsconder(); return; }
    const linhas = [];
    if (slot.b !== undefined) {
      const info = BLOCO_INFO[slot.b];
      linhas.push(`<div class="tt-nome">${info?.nome ?? 'Bloco'}</div>`);
      linhas.push(`<div class="tt-tipo">Bloco · ${slot.q} un.</div>`);
      if (info?.emiteLuz) linhas.push(`<div class="tt-tier">Emite luz: ${info.emiteLuz}</div>`);
    } else if (slot.i !== undefined) {
      const info = ITEM_INFO[slot.i];
      linhas.push(`<div class="tt-nome">${info?.nome ?? 'Item'}</div>`);
      const tipo = info?.armadura ? `Armadura (${info.armadura})`
                : info?.ferramenta ? `Ferramenta (${info.ferramenta})`
                : info?.nutricao ? 'Comida' : 'Item';
      linhas.push(`<div class="tt-tipo">${tipo} · ${slot.q} un.</div>`);
      if (info?.tier)     linhas.push(`<div class="tt-tier">Tier ${info.tier}</div>`);
      if (info?.defesa)   linhas.push(`<div class="tt-defesa">+${info.defesa} defesa</div>`);
      if (info?.nutricao) linhas.push(`<div class="tt-nutri">+${info.nutricao} fome</div>`);
      if (info?.suspeito) linhas.push(`<div class="tt-tier" style="color:#e57373">⚠ pode envenenar</div>`);
    } else { this._tooltipEsconder(); return; }
    el.innerHTML = linhas.join('');
    el.classList.remove('hidden');
    el.style.left = `${ev.clientX + 14}px`;
    el.style.top  = `${Math.max(8, ev.clientY - 40)}px`;
  }
  _tooltipEsconder() { if (this.elTooltip) this.elTooltip.classList.add('hidden'); }

  renderBars() {
    if (!state.player) return;
    const p = state.player;
    const barHTML = (icone, vazio, v, max, cor) => {
      const cheios = Math.floor(v / 2);
      const meio = (v % 2 === 1) ? 1 : 0;
      const total = Math.ceil(max / 2);
      let h = '';
      for (let i = 0; i < total; i++) {
        let opacity, content;
        if (i < cheios) { content = icone; opacity = 1; }
        else if (i === cheios && meio) { content = icone; opacity = 0.5; }
        else { content = vazio; opacity = 0.18; }
        h += `<span style="color:${cor};opacity:${opacity}">${content}</span>`;
      }
      return h;
    };
    const hpEl = document.getElementById('hp');
    hpEl.innerHTML = barHTML('❤', '🤍', p.hp, p.hpMax, '#e57373');
    hpEl.classList.toggle('shake', p.hp <= 4 && p.modo === 'survival' && p.hp > 0);
    document.getElementById('fome').innerHTML = barHTML('🍗', '🍗', p.fome, p.fomeMax, '#ffb74d');
    const elAr = document.getElementById('ar');
    if (elAr) {
      const cheios = Math.ceil(p.ar / 2);
      const total = Math.ceil(p.arMax / 2);
      let h = '';
      for (let i = 0; i < total; i++) {
        h += `<span style="color:#4FC3F7;opacity:${i < cheios ? 1 : 0.18}">●</span>`;
      }
      elAr.innerHTML = h;
    }
  }

  renderBag() {
    this.elBag.innerHTML = '';
    this.elBagHot.innerHTML = '';
    for (let i = 9; i < 36; i++) {
      const div = document.createElement('div');
      div.className = 'slot';
      div.innerHTML = this._slotHTML(state.inv.slots[i]);
      div.onclick = () => {
        const it = state.inv.slots[i];
        if (it && it.i !== undefined && ITEM_INFO[it.i]?.armadura) {
          state.inv.equiparDoSlot(i);
        } else {
          state.inv.trocar(i, state.inv.slotSel);
        }
        this.renderBag();
      };
      this.elBag.appendChild(div);
    }
    for (let i = 0; i < 9; i++) {
      const div = document.createElement('div');
      div.className = 'slot' + (i === state.inv.slotSel ? ' sel' : '');
      div.innerHTML = this._slotHTML(state.inv.slots[i]);
      div.onclick = () => {
        const it = state.inv.slots[i];
        if (it && it.i !== undefined && ITEM_INFO[it.i]?.armadura) {
          state.inv.equiparDoSlot(i);
          this.renderBag();
        } else {
          state.inv.selecionar(i);
        }
      };
      this.elBagHot.appendChild(div);
    }
    this.renderArmaduraSlots();
  }

  renderArmaduraSlots() {
    document.querySelectorAll('.armor-slot').forEach(el => {
      const peca = el.dataset.peca;
      const item = state.inv.armadura[peca];
      const ic = el.querySelector('.armor-icon');
      let display = el.querySelector('.equip-display');
      let tierEl = el.querySelector('.equip-tier');
      if (item) {
        el.classList.add('equipado');
        if (ic) ic.style.display = 'none';
        if (!display) {
          display = document.createElement('div');
          display.className = 'equip-display';
          el.appendChild(display);
        }
        const info = ITEM_INFO[item.i];
        display.textContent = info?.icone ?? '?';
        display.style.display = 'block';
        if (!tierEl) {
          tierEl = document.createElement('div');
          tierEl.className = 'equip-tier';
          el.appendChild(tierEl);
        }
        let tier = '';
        if (info.nome.toLowerCase().includes('diamante')) tier = '💎';
        else if (info.nome.toLowerCase().includes('ferro')) tier = '⚙';
        else if (info.nome.toLowerCase().includes('couro')) tier = '🟤';
        tierEl.textContent = tier;
        el.onclick = () => { state.inv.desequipar(peca); this.renderBag(); };
      } else {
        el.classList.remove('equipado');
        if (ic) ic.style.display = 'inline';
        if (display) display.style.display = 'none';
        if (tierEl) tierEl.textContent = '';
        el.onclick = () => state.ui.toast(
          `Equipe um ${peca === 'cabeca' ? 'capacete' : peca === 'torso' ? 'peitoral' : peca === 'pernas' ? 'perneiras' : 'botas'} clicando no inventário.`
        );
      }
    });
    const def = state.inv.defesaTotal();
    const elDef = document.getElementById('armor-defesa');
    if (elDef) elDef.textContent = String(def);
  }

  workbenchPerto() {
    if (!state.world || !state.player) return false;
    const px = Math.floor(state.player.pos.x), py = Math.floor(state.player.pos.y), pz = Math.floor(state.player.pos.z);
    for (let dx = -3; dx <= 3; dx++)
      for (let dy = -2; dy <= 2; dy++)
        for (let dz = -3; dz <= 3; dz++) {
          if (state.world.get(px + dx, py + dy, pz + dz) === BLOCO.WORKBENCH) return true;
        }
    return false;
  }

  renderCraft(perto) {
    const disp = Crafting.disponiveis(state.inv, perto);
    this.elCraftStatus.innerHTML = perto
      ? '🪵 Workbench próximo — receitas avançadas habilitadas'
      : 'Sem workbench: só receitas básicas. Crie e coloque um workbench (4× pranchas).';
    this.elCraftLista.innerHTML = '';
    if (disp.length === 0) {
      this.elCraftLista.innerHTML = '<div class="dica">Sem receitas disponíveis. Junte mais materiais.</div>';
      return;
    }
    for (const r of disp) {
      const div = document.createElement('div');
      div.className = 'receita';
      const ic = r.saida.b !== undefined ? (ICONE[r.saida.b] || '■') : (ITEM_INFO[r.saida.i]?.icone || '?');
      const nome = r.saida.b !== undefined ? BLOCO_INFO[r.saida.b].nome : ITEM_INFO[r.saida.i].nome;
      const qtd = r.saida.q > 1 ? ` ×${r.saida.q}` : '';
      const custos = r.custos.map(c => {
        const n = c.b !== undefined ? BLOCO_INFO[c.b].nome : ITEM_INFO[c.i].nome;
        return `${c.q}× ${n}`;
      }).join(' + ');
      div.innerHTML = `<div class="icone">${ic}</div><div class="info"><div class="nome">${nome}${qtd}</div><div class="custo">${custos}</div></div>`;
      div.onclick = () => {
        const ok = Crafting.craftar(state.inv, r, perto);
        if (ok && r.saida) {
          // Achievements baseados no item produzido
          if (r.saida.i === 110) Achievements.unlock('PRIMEIRA_PRANCHA'); // ITEM.PRANCHAS
          else if (r.saida.i === 200) Achievements.unlock('PRIMEIRA_PICARETA'); // ITEM.PIC_MADEIRA
          else if (r.saida.b === 23) Achievements.unlock('PRIMEIRO_FORNALHA'); // BLOCO.FORNALHA
          else if (r.saida.b === 22) Achievements.unlock('CRIAR_BAU'); // BLOCO.BAU
        }
        this.renderCraft(this.workbenchPerto());
      };
      this.elCraftLista.appendChild(div);
    }
  }

  // === Painel do baú ===
  renderBauPainel() {
    if (!state.bauAtivoCoords) return;
    const bau = state.world.getBau(state.bauAtivoCoords.x, state.bauAtivoCoords.y, state.bauAtivoCoords.z);
    const elBau = document.getElementById('bau-grid');
    const elInv = document.getElementById('bau-inv');
    const elHot = document.getElementById('bau-hotbar');
    elBau.innerHTML = ''; elInv.innerHTML = ''; elHot.innerHTML = '';
    for (let i = 0; i < 27; i++) {
      const div = document.createElement('div');
      div.className = 'slot';
      div.innerHTML = this._slotHTML(bau[i]);
      div.onclick = () => {
        // Mover slot da bag para baú e vice-versa.
        const ativo = state.inv.itemSelecionado();
        if (ativo) {
          const t = bau[i];
          bau[i] = { ...ativo };
          state.inv.slots[state.inv.slotSel] = t;
        } else {
          state.inv.slots[state.inv.slotSel] = bau[i];
          bau[i] = null;
        }
        this.renderBauPainel();
      };
      elBau.appendChild(div);
    }
    for (let i = 9; i < 36; i++) {
      const div = document.createElement('div');
      div.className = 'slot';
      div.innerHTML = this._slotHTML(state.inv.slots[i]);
      div.onclick = () => {
        // Move pra primeiro slot vazio do baú
        for (let k = 0; k < 27; k++) {
          if (!bau[k]) { bau[k] = state.inv.slots[i]; state.inv.slots[i] = null; break; }
        }
        this.renderBauPainel();
      };
      elInv.appendChild(div);
    }
    for (let i = 0; i < 9; i++) {
      const div = document.createElement('div');
      div.className = 'slot' + (i === state.inv.slotSel ? ' sel' : '');
      div.innerHTML = this._slotHTML(state.inv.slots[i]);
      div.onclick = () => { state.inv.selecionar(i); this.renderBauPainel(); };
      elHot.appendChild(div);
    }
  }

  // === Painel da fornalha ===
  renderFornalhaPainel() {
    if (!state.fornalhaAtivaCoords) return;
    const f = state.world.getFornalha(state.fornalhaAtivaCoords.x, state.fornalhaAtivaCoords.y, state.fornalhaAtivaCoords.z);
    const slots = ['forn-input', 'forn-fuel', 'forn-output'];
    const keys  = ['input', 'combustivel', 'output'];
    for (let i = 0; i < 3; i++) {
      const el = document.getElementById(slots[i]);
      if (!el) continue;
      el.innerHTML = this._slotHTML(f[keys[i]]);
      el.onclick = () => {
        const ativo = state.inv.itemSelecionado();
        if (ativo) {
          const t = f[keys[i]];
          f[keys[i]] = { ...ativo };
          state.inv.slots[state.inv.slotSel] = t;
        } else {
          state.inv.slots[state.inv.slotSel] = f[keys[i]];
          f[keys[i]] = null;
        }
        this.renderFornalhaPainel();
      };
    }
    const hot = document.getElementById('fornalha-hotbar');
    if (hot) {
      hot.innerHTML = '';
      for (let i = 0; i < 9; i++) {
        const div = document.createElement('div');
        div.className = 'slot' + (i === state.inv.slotSel ? ' sel' : '');
        div.innerHTML = this._slotHTML(state.inv.slots[i]);
        div.onclick = () => { state.inv.selecionar(i); this.renderFornalhaPainel(); };
        hot.appendChild(div);
      }
    }
  }

  // === Tela de morte ===
  mostrarMorte(causa) {
    try { document.exitPointerLock?.(); } catch (_) {}
    const el = document.getElementById('morte');
    const causaEl = document.getElementById('morte-causa');
    if (causaEl) {
      const map = {
        lava: '🔥 Você caiu na lava',
        cacto: '🌵 Espinhos do cacto',
        afogamento: '💧 Você se afogou',
        fome: '🍗 Morreu de fome',
        creeper: '💥 Foi explodido por um Creeper',
        zumbi: '🧟 Devorado por um Zumbi',
        esqueleto: '🏹 Flechado por um Esqueleto',
        aranha: '🕷 Envenenado por uma Aranha',
        slime: '🟢 Esmagado por um Slime',
        enderman: '🟣 Atacado por um Enderman',
        void: '⬛ Caiu no vazio',
      };
      const nice = map[causa] ||
        (causa && causa.startsWith('queda') ? `🪂 Caiu de muito alto (${causa})` : `Causa: ${causa || '?'}`);
      causaEl.textContent = nice;
    }
    el.classList.remove('hidden');
  }
  esconderMorte() {
    document.getElementById('morte').classList.add('hidden');
    setTimeout(() => { try { state.player?.controls?.lock(); } catch (_) {} }, 80);
  }

  // === Pause menu ===
  mostrarPause() {
    const el = document.getElementById('pause-menu');
    if (!el) return;
    el.classList.remove('hidden');
    try { document.exitPointerLock?.(); } catch (_) {}
    if (state.player) state.player.pausado = true;
  }
  esconderPause() {
    const el = document.getElementById('pause-menu');
    if (!el) return;
    el.classList.add('hidden');
    if (state.player) state.player.pausado = false;
    setTimeout(() => { try { state.player?.controls?.lock(); } catch (_) {} }, 50);
  }

  // === F3 debug overlay ===
  toggleF3() {
    this.f3Ativo = !this.f3Ativo;
    const el = document.getElementById('f3-debug');
    if (el) el.classList.toggle('hidden', !this.f3Ativo);
    const topo = document.getElementById('topo');
    if (topo) topo.style.opacity = this.f3Ativo ? '0' : '1';
  }
  toggleHud() {
    this.hudOculto = !this.hudOculto;
    const elementos = ['#topo', '#bars', '#hotbar', '.hud-btn', '#tooltip'];
    for (const sel of elementos) {
      document.querySelectorAll(sel).forEach(el => {
        el.style.opacity = this.hudOculto ? '0' : '';
        el.style.pointerEvents = this.hudOculto ? 'none' : '';
      });
    }
    this.toast(this.hudOculto ? 'HUD oculto (F1)' : 'HUD visível (F1)');
  }
  atualizarF3(extra) {
    if (!this.f3Ativo || !state.player || !state.world) return;
    const px = state.player.pos.x, py = state.player.pos.y, pz = state.player.pos.z;
    const cx = Math.floor(px / CHUNK_SIZE), cz = Math.floor(pz / CHUNK_SIZE);
    const yawCam = state.renderer ? state.renderer.camera.rotation.y : 0;
    const yawDeg = ((yawCam * 180 / Math.PI) % 360 + 360) % 360;
    let face = 'south (+Z)';
    if (yawDeg < 45 || yawDeg >= 315) face = 'south (+Z)';
    else if (yawDeg < 135) face = 'east (+X)';
    else if (yawDeg < 225) face = 'north (-Z)';
    else face = 'west (-X)';
    document.getElementById('f3-pos').textContent =
      `XYZ: ${px.toFixed(2)} / ${py.toFixed(2)} / ${pz.toFixed(2)}`;
    document.getElementById('f3-block').textContent =
      `Block: ${Math.floor(px)} ${Math.floor(py)} ${Math.floor(pz)}`;
    document.getElementById('f3-chunk').textContent =
      `Chunk: ${cx},${cz} (in ${Math.floor(px) - cx*CHUNK_SIZE}, ${Math.floor(pz) - cz*CHUNK_SIZE})`;
    document.getElementById('f3-facing').textContent = `Facing: ${face}`;
    const ySup = Math.max(0, Math.floor(py));
    const topoB = state.world.get(Math.floor(px), ySup - 1, Math.floor(pz));
    const biomaNome = (topoB === BLOCO.NEVE) ? 'tundra'
                    : (topoB === BLOCO.AREIA) ? 'deserto'
                    : (topoB === BLOCO.GRAMA || topoB === BLOCO.TERRA) ? 'planicies'
                    : (topoB === BLOCO.PEDRA) ? 'montanha' : 'subterraneo';
    document.getElementById('f3-biome').textContent = `Biome: ${biomaNome}`;
    const sun = Math.max(0.05, 0.5 + 0.5 * Math.sin(state.tempoDia * Math.PI * 2 - Math.PI / 2));
    const luzPlayer = state.world.getLightAt(Math.floor(px), Math.floor(py), Math.floor(pz));
    document.getElementById('f3-light').textContent =
      `Sky / Block light: ${luzPlayer.sky} / ${luzPlayer.block}`;
    const tEl = document.getElementById('f3-target');
    const tMesh  = document.getElementById('f3-target-mesh');
    const tNeigh = document.getElementById('f3-target-neigh');
    const tAtlas = document.getElementById('f3-target-atlas');
    if (extra && extra.targetBlock) {
      const t = extra.targetBlock;
      const info = BLOCO_INFO[t.b];
      const nome = info?.nome || '?';
      const flags = [
        info?.solido ? 'solid' : 'non-solid',
        info?.emiteLuz ? `light=${info.emiteLuz}` : null,
      ].filter(Boolean).join(',');
      tEl.textContent = `Targeted: ${nome} [ID ${t.b}, ${flags}] @ ${t.x},${t.y},${t.z}`;

      // Estado do mesh do chunk que contém o bloco-alvo (a transparência
      // mais comum vem de chunk gerado-mas-sem-mesh ou mesh-dirty).
      const tcx = Math.floor(t.x / CHUNK_SIZE), tcz = Math.floor(t.z / CHUNK_SIZE);
      const tchunk = state.world.chunks.get(chunkKey(tcx, tcz));
      let meshStatus;
      if (!tchunk)              meshStatus = '⚠ no-chunk';
      else if (!tchunk.mesh)    meshStatus = '⚠ mesh-null (não construído)';
      else if (tchunk.dirty)    meshStatus = '⚠ dirty (rebuild pendente)';
      else                      meshStatus = `built (${tchunk.mesh.geometry?.attributes?.position?.count || 0} verts)`;
      tMesh.textContent = `Mesh chunk ${tcx},${tcz}: ${meshStatus}`;

      // Vizinhos: face é renderizada se vizinho é AR ou não-sólido.
      // Marca com ⚠ os lados onde o vizinho é sólido (= face culled).
      const dirs = [
        { dx: 0,  dy: 1,  dz: 0,  label: 'TOP' },
        { dx: 0,  dy: -1, dz: 0,  label: 'BOT' },
        { dx: 1,  dy: 0,  dz: 0,  label: 'E' },
        { dx: -1, dy: 0,  dz: 0,  label: 'W' },
        { dx: 0,  dy: 0,  dz: 1,  label: 'S' },
        { dx: 0,  dy: 0,  dz: -1, label: 'N' },
      ];
      const parts = dirs.map(d => {
        const nb = state.world.get(t.x + d.dx, t.y + d.dy, t.z + d.dz);
        const ni = BLOCO_INFO[nb];
        const culled = ni?.solido && nb !== BLOCO.AR;
        const tag = culled ? '✗' : '✓'; // ✗ = face culada, ✓ = face renderizada
        return `${d.label}${tag}${ni?.nome || `?[${nb}]`}`;
      });
      tNeigh.textContent = `Neighbors: ${parts.join('  ')}`;

      // Quais células do atlas estão sendo usadas pra esse bloco
      const am = state.renderer?.atlas?.mapa?.[t.b];
      tAtlas.textContent = am
        ? `Atlas: top=${am.top} side=${am.side} bot=${am.bottom}`
        : `Atlas: ⚠ não-mapeado (BLOCO ${t.b})`;
    } else {
      tEl.textContent  = 'Targeted: --';
      tMesh.textContent  = 'Mesh: --';
      tNeigh.textContent = 'Neighbors: --';
      tAtlas.textContent = 'Atlas: --';
    }
    const memEl = document.getElementById('f3-mem');
    const mem = performance && performance.memory;
    if (mem) {
      const used = (mem.usedJSHeapSize / 1048576).toFixed(0);
      const tot  = (mem.totalJSHeapSize / 1048576).toFixed(0);
      memEl.textContent = `Mem: ${used} / ${tot} MB`;
    } else memEl.textContent = `Mem: --`;
    const horas = Math.floor((state.tempoDia * 24 + 6) % 24);
    const mins = Math.floor(((state.tempoDia * 24 + 6) % 1) * 60);
    document.getElementById('f3-time').textContent =
      `Day time: ${String(horas).padStart(2,'0')}:${String(mins).padStart(2,'0')} (sun ${sun.toFixed(2)})`;
    document.getElementById('f3-mobs').textContent =
      `Entities: ${state.mobMgr ? state.mobMgr.mobs.length : 0} mobs / ${state.dropEntidades.length} drops / ${state.xpOrbs.length} orbs`;
  }

  // === Inventário criativo (abas + busca) ===
  _categoriaItem(slot) {
    if (slot.b !== undefined) {
      const b = slot.b;
      if ([BLOCO.AGUA, BLOCO.LAVA].includes(b)) return 'liquidos';
      if ([BLOCO.OURO, BLOCO.FERRO, BLOCO.DIAMANTE, BLOCO.CARVAO, BLOCO.OBSIDIANA].includes(b)) return 'minerios';
      if ([BLOCO.GRAMA, BLOCO.TERRA, BLOCO.AREIA, BLOCO.NEVE, BLOCO.FOLHA, BLOCO.MADEIRA, BLOCO.CACTO].includes(b)) return 'natureza';
      if ([BLOCO.VIDRO, BLOCO.LUZ, BLOCO.LA, BLOCO.TOCHA, BLOCO.CAMA].includes(b)) return 'decoracao';
      if ([BLOCO.WORKBENCH, BLOCO.BAU, BLOCO.FORNALHA].includes(b)) return 'decoracao';
      return 'construcao';
    }
    const i = slot.i;
    const info = ITEM_INFO[i];
    if (info?.armadura) return 'combate';
    if (info?.ferramenta === 'esp') return 'combate';
    if (info?.ferramenta === 'pic') return 'ferramentas';
    if (info?.nutricao) return 'comida';
    return 'ferramentas';
  }
  renderCriativo() {
    const grid = document.getElementById('criativo-grid');
    const hot  = document.getElementById('criativo-hotbar');
    if (!grid || !hot) return;
    grid.innerHTML = '';
    hot.innerHTML = '';
    const todos = [];
    for (const k of Object.keys(BLOCO_INFO)) {
      const b = parseInt(k, 10);
      if (b === BLOCO.AR || b === BLOCO.BEDROCK) continue;
      todos.push({ b, q: 64 });
    }
    for (const k of Object.keys(ITEM_INFO)) todos.push({ i: parseInt(k, 10), q: 1 });
    const filtro = (this.criativoFiltro || '').toLowerCase().trim();
    const filtrados = todos.filter(s => {
      if (this._categoriaItem(s) !== this.criativoAbaAtual) return false;
      if (!filtro) return true;
      const nome = s.b !== undefined ? BLOCO_INFO[s.b]?.nome : ITEM_INFO[s.i]?.nome;
      return (nome || '').toLowerCase().includes(filtro);
    });
    for (const s of filtrados) {
      const div = document.createElement('div');
      div.className = 'slot';
      div.innerHTML = this._slotHTML(s);
      div.addEventListener('mouseenter', (e) => this._tooltipMostrar(s, e));
      div.addEventListener('mousemove',  (e) => this._tooltipMostrar(s, e));
      div.addEventListener('mouseleave', () => this._tooltipEsconder());
      div.onclick = () => {
        const novo = s.b !== undefined ? { b: s.b, q: 64 }
                  : { i: s.i, q: (ITEM_INFO[s.i]?.tier || ITEM_INFO[s.i]?.armadura) ? 1 : 64 };
        state.inv.slots[state.inv.slotSel] = novo;
        state.ui.atualizar();
        this.renderCriativoHotbar();
        Audio.pickup();
      };
      grid.appendChild(div);
    }
    this.renderCriativoHotbar();
  }
  renderCriativoHotbar() {
    const hot = document.getElementById('criativo-hotbar');
    if (!hot) return;
    hot.innerHTML = '';
    for (let i = 0; i < 9; i++) {
      const div = document.createElement('div');
      div.className = 'slot' + (i === state.inv.slotSel ? ' sel' : '');
      div.innerHTML = this._slotHTML(state.inv.slots[i]);
      div.onclick = () => { state.inv.selecionar(i); this.renderCriativo(); };
      hot.appendChild(div);
    }
  }
  fecharPainel(id) { document.getElementById(id).classList.add('hidden'); }
}
