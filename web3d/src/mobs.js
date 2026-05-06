// =====================================================================
// mobs.js — Mobs: tipos, modelos 3D, IA, spawn rules por light level
// =====================================================================

import * as THREE from 'three';
import { BLOCO, ITEM, WORLD_Y } from './constants.js';
import { state } from './state.js';
import { Audio } from './audio.js';

export const TIPO_MOB = {
  VACA: 'vaca', GALINHA: 'galinha', PORCO: 'porco', OVELHA: 'ovelha',
  ZUMBI: 'zumbi', ESQUELETO: 'esqueleto', ARANHA: 'aranha', CREEPER: 'creeper',
  LOBO: 'lobo', SLIME: 'slime', ENDERMAN: 'enderman',
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
  esqueleto: {
    hp: 14, vel: 1.8, hostil: true, dano: 2, alcance: 6.0,
    drops: () => [{ i: ITEM.PAU, q: 1 }],
    cor: 0xe0e0e0, sec: 0x9e9e9e,
  },
  aranha: {
    hp: 12, vel: 2.6, hostil: true, dano: 3, alcance: 1.6,
    drops: () => Math.random() < 0.5 ? [{ b: BLOCO.LA, q: 1 }] : [],
    cor: 0x263238, sec: 0xb71c1c,
  },
  creeper: {
    hp: 10, vel: 1.9, hostil: true, dano: 8, alcance: 2.0,
    drops: () => Math.random() < 0.5 ? [{ i: ITEM.CARVAO, q: 1 }] : [],
    cor: 0x2e7d32, sec: 0x1b5e20, explode: true,
  },
  lobo: {
    hp: 12, vel: 2.4, hostil: false, amigavel: true,
    drops: () => [],
    cor: 0x9e9e9e, sec: 0xeeeeee,
  },
  slime: {
    hp: 8, vel: 1.6, hostil: true, dano: 2, alcance: 1.2,
    drops: () => Math.random() < 0.6 ? [{ b: BLOCO.LA, q: 1 }] : [],
    cor: 0x66bb6a, sec: 0x33691e, pula: true,
  },
  enderman: {
    hp: 20, vel: 2.4, hostil: true, dano: 3, alcance: 2.4,
    drops: () => Math.random() < 0.5 ? [{ i: ITEM.DIAMANTE, q: 1 }] : [],
    cor: 0x121212, sec: 0xb388ff, teleport: true,
  },
};

// Constrói modelo 3D de um mob com pivots para animação.
export function construirModeloMob(tipo, info) {
  const matCor = (c) => new THREE.MeshLambertMaterial({ color: c });
  const cubo = (w, h, d, c) => new THREE.Mesh(new THREE.BoxGeometry(w, h, d), matCor(c));
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

  switch (tipo) {
    case 'vaca':
    case 'porco':
    case 'ovelha':
    case 'lobo': {
      const corpo = cubo(0.5, 0.5, 0.85, info.cor);
      corpo.position.y = 0.65; grp.add(corpo);
      const cabeca = cubo(0.4, 0.4, 0.4, info.cor);
      cabeca.position.set(0, 0.7, 0.55); grp.add(cabeca);
      if (tipo === 'vaca') {
        const m1 = cubo(0.52, 0.05, 0.2, info.sec);
        m1.position.set(0, 0.92, 0.05); grp.add(m1);
        const m2 = cubo(0.52, 0.05, 0.18, info.sec);
        m2.position.set(0, 0.92, -0.25); grp.add(m2);
      }
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const dx = (i % 2 === 0 ? -0.15 : 0.15);
        const dz = (i < 2 ? 0.28 : -0.28);
        const p = pernaComPivot(0.16, 0.4, 0.16, info.sec, 0.4);
        p.position.x = dx; p.position.z = dz;
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.pernas = pernas; partes.corpo = corpo;
      break;
    }
    case 'galinha': {
      const corpo = cubo(0.3, 0.35, 0.45, info.cor);
      corpo.position.y = 0.5; grp.add(corpo);
      const cabeca = cubo(0.22, 0.25, 0.22, info.cor);
      cabeca.position.set(0, 0.78, 0.22); grp.add(cabeca);
      const crista = cubo(0.08, 0.08, 0.18, 0xC62828);
      crista.position.set(0, 0.95, 0.22); grp.add(crista);
      const bico = cubo(0.1, 0.08, 0.12, info.sec);
      bico.position.set(0, 0.76, 0.4); grp.add(bico);
      const pernas = [];
      for (let i = 0; i < 2; i++) {
        const p = pernaComPivot(0.07, 0.28, 0.07, info.sec, 0.28);
        p.position.x = (i === 0 ? -0.1 : 0.1);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.pernas = pernas; partes.corpo = corpo;
      break;
    }
    case 'zumbi':
    case 'esqueleto': {
      const corpo = cubo(0.5, 0.7, 0.25, info.cor);
      corpo.position.y = 1.0; grp.add(corpo);
      const cabeca = cubo(0.45, 0.45, 0.45, info.sec);
      cabeca.position.set(0, 1.6, 0); grp.add(cabeca);
      const oR = cubo(0.07, 0.07, 0.04, 0xff2222);
      oR.position.set(-0.1, 1.62, 0.23); grp.add(oR);
      const oL = cubo(0.07, 0.07, 0.04, 0xff2222);
      oL.position.set( 0.1, 1.62, 0.23); grp.add(oL);
      const bracos = [];
      for (let i = 0; i < 2; i++) {
        const b = pernaComPivot(0.18, 0.65, 0.18, info.cor, 1.3);
        b.position.x = (i === 0 ? -0.34 : 0.34);
        grp.add(b); bracos.push(b);
      }
      const pernas = [];
      for (let i = 0; i < 2; i++) {
        const p = pernaComPivot(0.2, 0.65, 0.2, info.sec, 0.65);
        p.position.x = (i === 0 ? -0.12 : 0.12);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
      partes.bracos = bracos; partes.pernas = pernas;
      break;
    }
    case 'aranha': {
      const corpoTras = cubo(0.7, 0.45, 0.55, info.cor);
      corpoTras.position.set(0, 0.4, -0.15); grp.add(corpoTras);
      const cabeca = cubo(0.4, 0.35, 0.4, info.sec);
      cabeca.position.set(0, 0.4, 0.35); grp.add(cabeca);
      for (let i = 0; i < 4; i++) {
        const o = cubo(0.06, 0.06, 0.04, 0xff0000);
        const x = (i % 2 === 0 ? -0.12 : 0.12);
        const y = (i < 2 ? 0.5 : 0.4);
        o.position.set(x, y, 0.55); grp.add(o);
      }
      const pernas = [];
      for (let i = 0; i < 8; i++) {
        const lado = i < 4 ? -1 : 1;
        const p = pernaComPivot(0.07, 0.5, 0.07, 0x000000, 0.45);
        p.position.set(lado * 0.3, 0.45,
          (i < 4 ? i - 1.5 : (i - 5.5)) * 0.16);
        p.rotation.z = lado * (0.4 + (i % 4) * 0.05);
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.pernas = pernas;
      break;
    }
    case 'creeper': {
      const corpo = cubo(0.4, 1.3, 0.4, info.cor);
      corpo.position.y = 0.95; grp.add(corpo);
      const cabeca = cubo(0.42, 0.42, 0.42, info.sec);
      cabeca.position.set(0, 1.7, 0); grp.add(cabeca);
      const olhoE = cubo(0.1, 0.1, 0.04, 0x000000);
      olhoE.position.set(-0.1, 1.74, 0.22); grp.add(olhoE);
      const olhoD = cubo(0.1, 0.1, 0.04, 0x000000);
      olhoD.position.set(0.1, 1.74, 0.22); grp.add(olhoD);
      const boca = cubo(0.14, 0.18, 0.04, 0x000000);
      boca.position.set(0, 1.62, 0.22); grp.add(boca);
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const dx = (i % 2 === 0 ? -0.1 : 0.1);
        const dz = (i < 2 ? 0.1 : -0.1);
        const p = pernaComPivot(0.18, 0.3, 0.18, info.cor, 0.3);
        p.position.x = dx; p.position.z = dz;
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.pernas = pernas; partes.corpo = corpo;
      break;
    }
    case 'slime': {
      const corpoMat = new THREE.MeshLambertMaterial({ color: info.cor });
      const corpo = new THREE.Mesh(new THREE.BoxGeometry(0.9, 0.9, 0.9), corpoMat);
      corpo.position.y = 0.45; grp.add(corpo);
      const nucleo = cubo(0.5, 0.5, 0.5, info.sec);
      nucleo.position.y = 0.45; grp.add(nucleo);
      const oE = cubo(0.08, 0.08, 0.04, 0x000000);
      oE.position.set(-0.18, 0.55, 0.46); grp.add(oE);
      const oD = cubo(0.08, 0.08, 0.04, 0x000000);
      oD.position.set( 0.18, 0.55, 0.46); grp.add(oD);
      const boca = cubo(0.16, 0.06, 0.04, 0x000000);
      boca.position.set(0, 0.42, 0.46); grp.add(boca);
      partes.corpo = corpo; partes.cabeca = nucleo;
      break;
    }
    case 'enderman': {
      const corpo = cubo(0.4, 1.2, 0.3, info.cor);
      corpo.position.y = 1.5; grp.add(corpo);
      const cabeca = cubo(0.45, 0.5, 0.45, info.cor);
      cabeca.position.set(0, 2.35, 0); grp.add(cabeca);
      const oE = cubo(0.10, 0.05, 0.04, info.sec);
      oE.position.set(-0.12, 2.40, 0.23); grp.add(oE);
      const oD = cubo(0.10, 0.05, 0.04, info.sec);
      oD.position.set( 0.12, 2.40, 0.23); grp.add(oD);
      const pernas = [];
      for (let i = 0; i < 2; i++) {
        const p = pernaComPivot(0.2, 1.0, 0.2, info.cor, 0.95);
        p.position.x = (i === 0 ? -0.13 : 0.13);
        grp.add(p); pernas.push(p);
      }
      const bracos = [];
      for (let i = 0; i < 2; i++) {
        const b = pernaComPivot(0.18, 1.0, 0.18, info.cor, 1.85);
        b.position.x = (i === 0 ? -0.32 : 0.32);
        grp.add(b); bracos.push(b);
      }
      partes.cabeca = cabeca; partes.corpo = corpo;
      partes.pernas = pernas; partes.bracos = bracos;
      break;
    }
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

export class Mob {
  constructor(tipo, x, y, z) {
    this.tipo = tipo;
    this.x = x; this.y = y; this.z = z;
    const info = MOB_INFO[tipo];
    this.hp = info.hp;
    this.dir = Math.random() * Math.PI * 2;
    this.proxMudanca = 0;
    this.cooldownAtaque = 0;
    this.fase = Math.random() * Math.PI * 2;
    this.pulando = 0;
    this.proxPulo = 1.5;
    this.proxTeleport = 5.0;
    this.proxSom = 4 + Math.random() * 6;
    this.mesh = construirModeloMob(tipo, info);
    this.mesh.position.set(x, y, z);
    this.partes = this.mesh.userData.partes;
  }

  atualizar(dt, world, alvo) {
    const info = MOB_INFO[this.tipo];
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
    if (info.hostil && alvo) {
      this.dir = Math.atan2(alvo.z - this.z, alvo.x - this.x);
    } else {
      this.proxMudanca -= dt;
      if (this.proxMudanca <= 0) {
        this.dir = Math.random() * Math.PI * 2;
        this.proxMudanca = 1.5 + Math.random() * 3;
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
        if (!world.isSolido(Math.floor(this.x + dx), Math.floor(this.y), Math.floor(this.z))) {
          this.x += dx; movendo = true;
        }
        if (!world.isSolido(Math.floor(this.x), Math.floor(this.y), Math.floor(this.z + dz))) {
          this.z += dz; movendo = true;
        }
        if (this.pulando >= 1) this.pulando = 0;
      }
    } else {
      const dx = Math.cos(this.dir) * info.vel * dt;
      const dz = Math.sin(this.dir) * info.vel * dt;
      if (!world.isSolido(Math.floor(this.x + dx), Math.floor(this.y), Math.floor(this.z))) {
        this.x += dx; movendo = true;
      }
      if (!world.isSolido(Math.floor(this.x), Math.floor(this.y), Math.floor(this.z + dz))) {
        this.z += dz; movendo = true;
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
    let h = WORLD_Y;
    while (h > 0 && !world.isSolido(Math.floor(this.x), h - 1, Math.floor(this.z))) h--;
    this.y = h;
    let yVisual = this.y;
    if (info.pula && this.pulando > 0) {
      yVisual = this.y + Math.sin(this.pulando * Math.PI) * 0.6;
    }
    this.mesh.position.set(this.x, yVisual, this.z);
    this.mesh.rotation.y = -this.dir + Math.PI / 2;
    this.cooldownAtaque -= dt;

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
      this.partes.cabeca.rotation.y = Math.sin(this.fase * 0.5) * 0.15;
    }
    if (info.pula && this.partes.corpo) {
      const sq = 1 + Math.sin(this.pulando * Math.PI) * 0.15;
      this.partes.corpo.scale.set(1.0 / sq, sq, 1.0 / sq);
    }
  }
  vivo() { return this.hp > 0; }
}

export class MobManager {
  constructor(scene) {
    this.scene = scene;
    this.mobs = [];
    this.acc = 0;
    this.intervalo = 2.0;
  }
  spawn(tipo, x, y, z) {
    const m = new Mob(tipo, x, y, z);
    this.scene.add(m.mesh);
    this.mobs.push(m);
  }
  remover(m) {
    this.scene.remove(m.mesh);
    const i = this.mobs.indexOf(m);
    if (i >= 0) this.mobs.splice(i, 1);
  }
  atualizar(dt, world, player, sun) {
    this.acc += dt;
    if (this.acc >= this.intervalo) {
      this.acc = 0;
      this.tentarSpawn(world, player, sun);
    }
    for (let i = this.mobs.length - 1; i >= 0; i--) {
      const m = this.mobs[i];
      if (!m.vivo()) { this.remover(m); continue; }
      const ddx = m.x - player.pos.x, ddz = m.z - player.pos.z;
      if (ddx*ddx + ddz*ddz > 900) { this.remover(m); continue; }
      const info = MOB_INFO[m.tipo];
      if (info.amigavel) {
        let hostil = null, melhor = 64;
        for (const o of this.mobs) {
          if (!MOB_INFO[o.tipo].hostil) continue;
          const d2 = (o.x - m.x)**2 + (o.z - m.z)**2;
          if (d2 < melhor) { melhor = d2; hostil = o; }
        }
        m.atualizar(dt, world, hostil ? { x: hostil.x, z: hostil.z } : null);
        if (hostil && melhor < 2.25 && m.cooldownAtaque <= 0) {
          hostil.hp -= 4; m.cooldownAtaque = 1.0;
        }
      } else if (info.hostil) {
        m.atualizar(dt, world, { x: player.pos.x, z: player.pos.z });
      } else {
        m.atualizar(dt, world, null);
      }
      if (info.hostil && m.cooldownAtaque <= 0) {
        const ddy = m.y - player.pos.y;
        const d2 = ddx*ddx + ddy*ddy + ddz*ddz;
        if (d2 < info.alcance ** 2) {
          if (info.explode) {
            this.explosao(world, m.x, m.y, m.z, 2);
            player.aplicarDano(info.dano, 'creeper');
            m.hp = 0;
          } else {
            player.aplicarDano(info.dano, m.tipo);
          }
          m.cooldownAtaque = 1.2;
        }
      }
    }
  }
  // Spawn rules por light level (paridade Minecraft).
  tentarSpawn(world, player, sun) {
    if (this.mobs.length >= 14) return;
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
    let tipos;
    if (luzMax <= 7) {
      tipos = ['zumbi', 'esqueleto', 'aranha', 'creeper'];
      if (y < 30) tipos.push('slime');
      if (Math.random() < 0.05) tipos.push('enderman');
    } else if (luzMax >= 9 && (blocoChao === BLOCO.GRAMA || blocoChao === BLOCO.AREIA)) {
      tipos = ['vaca', 'galinha', 'porco', 'ovelha', 'lobo'];
    } else {
      return;
    }
    const tipo = tipos[Math.floor(Math.random() * tipos.length)];
    this.spawn(tipo, x, y, z);
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
