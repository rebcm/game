// =====================================================================
// mobs.js — Mobs: tipos, modelos 3D, IA, spawn rules por light level
// =====================================================================

import * as THREE from 'three';
import { BLOCO, ITEM, WORLD_Y } from './constants.js';
import { state } from './state.js';
import { Audio } from './audio.js';
import { spawnArrow, spawnItemDrop } from './particles.js';

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
    drops: () => [
      ...(Math.random() < 0.6 ? [{ i: ITEM.OSSO, q: 1 + (Math.random() < 0.3 ? 1 : 0) }] : []),
      ...(Math.random() < 0.4 ? [{ i: ITEM.FLECHA, q: 1 + Math.floor(Math.random() * 2) }] : []),
    ],
    cor: 0xe0e0e0, sec: 0x9e9e9e,
  },
  aranha: {
    hp: 12, vel: 2.6, hostil: true, dano: 3, alcance: 1.6,
    drops: () => Math.random() < 0.5 ? [{ b: BLOCO.LA, q: 1 }] : [],
    cor: 0x263238, sec: 0xb71c1c,
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
  // Helper: olho emissivo (zumbi/esqueleto/enderman/aranha — brilham)
  const olhosBrilhantes = (cabecaMesh, sep, cy, cz, cor, size = 0.08) => {
    for (const sx of [-sep, sep]) {
      const o = new THREE.Mesh(new THREE.BoxGeometry(size, size, 0.04), matEmissivo(cor, 1.2));
      o.position.set(sx, cy, cz);
      cabecaMesh.add(o);
    }
  };

  switch (tipo) {
    case 'vaca': {
      // Corpo branco com manchas marrons (sec=0x424242)
      const corpo = cubo(0.65, 0.55, 0.95, info.cor);
      corpo.position.y = 0.65; grp.add(corpo);
      // Manchas (decorativas)
      const m1 = cubo(0.66, 0.06, 0.22, info.sec); m1.position.set(0, 0.92, 0.05); grp.add(m1);
      const m2 = cubo(0.66, 0.06, 0.20, info.sec); m2.position.set(0, 0.92, -0.30); grp.add(m2);
      const cabeca = cubo(0.42, 0.42, 0.45, info.cor);
      cabeca.position.set(0, 0.78, 0.62); grp.add(cabeca);
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
      const cauda = cubo(0.06, 0.40, 0.06, info.cor);
      cauda.position.set(0, 0.55, -0.5); grp.add(cauda);
      const caudaTuf = cubo(0.10, 0.08, 0.10, info.sec);
      caudaTuf.position.set(0, 0.32, -0.5); grp.add(caudaTuf);
      // Úbere rosado
      const uber = cubo(0.18, 0.08, 0.20, 0xff80ab);
      uber.position.set(0, 0.34, -0.20); grp.add(uber);
      const pernas = [];
      for (let i = 0; i < 4; i++) {
        const dx = (i % 2 === 0 ? -0.20 : 0.20);
        const dz = (i < 2 ? 0.32 : -0.32);
        const p = pernaComPivot(0.18, 0.42, 0.18, info.sec, 0.42);
        p.position.x = dx; p.position.z = dz;
        grp.add(p); pernas.push(p);
      }
      partes.cabeca = cabeca; partes.pernas = pernas; partes.corpo = corpo;
      break;
    }
    case 'porco': {
      const corpo = cubo(0.55, 0.50, 0.90, info.cor);
      corpo.position.y = 0.55; grp.add(corpo);
      const cabeca = cubo(0.42, 0.40, 0.40, info.cor);
      cabeca.position.set(0, 0.65, 0.60); grp.add(cabeca);
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
      // Corpo lanudo (escala maior pra parecer fluffy)
      const corpo = cubo(0.70, 0.65, 1.00, info.cor);
      corpo.position.y = 0.72; grp.add(corpo);
      // Cabeça preta (paridade MC)
      const cabeca = cubo(0.32, 0.34, 0.40, 0x424242);
      cabeca.position.set(0, 0.85, 0.60); grp.add(cabeca);
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
    case 'zumbi': {
      const corpo = cubo(0.55, 0.75, 0.30, info.cor);
      corpo.position.y = 1.05; grp.add(corpo);
      const cabeca = cubo(0.48, 0.48, 0.48, info.cor);
      cabeca.position.set(0, 1.65, 0); grp.add(cabeca);
      // Olhos vermelho-zumbi (afundados, brilhantes)
      olhosBrilhantes(cabeca, 0.11, 0.02, 0.245, 0xff3d00, 0.07);
      // Boca aberta com dentes
      const boca = cubo(0.20, 0.06, 0.02, 0x1a1a1a);
      boca.position.set(0, -0.13, 0.245); cabeca.add(boca);
      // Cabelo bagunçado em cima
      const cabelo = cubo(0.50, 0.06, 0.50, 0x2e7d32);
      cabelo.position.set(0, 0.27, 0); cabeca.add(cabelo);
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
    case 'esqueleto': {
      // Corpo magro com costelas
      const corpo = cubo(0.42, 0.72, 0.18, info.cor);
      corpo.position.y = 1.04; grp.add(corpo);
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
    case 'aranha': {
      const corpoTras = cubo(0.80, 0.50, 0.65, info.cor);
      corpoTras.position.set(0, 0.45, -0.20); grp.add(corpoTras);
      // Padrão de hourglass vermelho no traseiro
      const hg = cubo(0.30, 0.20, 0.04, info.sec);
      hg.position.set(0, 0.45, -0.50); grp.add(hg);
      const cabeca = cubo(0.45, 0.40, 0.45, info.sec);
      cabeca.position.set(0, 0.45, 0.40); grp.add(cabeca);
      // 8 olhos vermelhos brilhantes em padrão 4×2
      for (let row = 0; row < 2; row++) {
        for (let col = 0; col < 4; col++) {
          const o = cuboEm(0.05, 0.05, 0.03, 0xff1744, 1.0);
          o.position.set(-0.18 + col * 0.12, 0.05 - row * 0.10, 0.235);
          cabeca.add(o);
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
    case 'slime': {
      // Corpo gelatinoso semi-transparente
      const corpoMat = new THREE.MeshLambertMaterial({
        color: info.cor, transparent: true, opacity: 0.78,
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
    case 'galinha':  return { raio: 0.20, altura: 0.70 };
    case 'lobo':     return { raio: 0.30, altura: 0.85 };
    case 'slime':    return { raio: 0.40, altura: 0.50 };
    case 'vaca':
    case 'porco':
    case 'ovelha':   return { raio: 0.40, altura: 1.30 };
    case 'enderman': return { raio: 0.30, altura: 2.50 };
    // Humanóides hostis (zumbi/esqueleto/creeper)
    default:         return { raio: 0.30, altura: 1.80 };
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
    // Lobo: domesticado segue o player e ataca mobs hostis.
    this.domesticado = false;
    // Galinha: timer pra próximo ovo (paridade Minecraft: 5-10 min,
    // aqui 60-120s pra ser jogável).
    this.proxOvo = 60 + Math.random() * 60;
    // Reprodução: loveTimer > 0 = em "love mode" pronto pra acasalar.
    // breedCooldown bloqueia novo acasalamento por 60s pós-spawn de cria.
    this.loveTimer = 0;
    this.breedCooldown = 0;
    this.mesh = construirModeloMob(tipo, info);
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
          if (BLOCO_INFO[b]?.solido) return true;
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
    // Snap vertical: cai por gravidade respeitando AABB (todos os blocos
    // sob a base do mob, não só uma coluna XZ central). Auto-step de 1
    // se preso dentro de bloco. Limite: 1 sobe (não escala árvore).
    let yp = Math.floor(this.y + 0.001);
    if (this.colideEm(world, this.x, yp, this.z)) {
      // Preso: tenta subir 1
      if (!this.colideEm(world, this.x, yp + 1, this.z)) yp++;
    }
    // Cai enquanto não houver suporte sob a base (qualquer bloco no
    // footprint XZ do mob)
    let safety = 64;
    while (yp > 0 && !this.colideEm(world, this.x, yp - 0.05, this.z) && safety-- > 0) yp--;
    this.y = yp;
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
    // Reprodução: decrementa timers
    if (this.loveTimer > 0) this.loveTimer -= dt;
    if (this.breedCooldown > 0) this.breedCooldown -= dt;
  }
  vivo() { return this.hp > 0; }

  // Aplica dano + knockback (vx, vz são velocidade do empurrão em m/s).
  // Mobs passivos entram em pânico (fogem em zigzag por 5s).
  tomarDano(dano, kbX = 0, kbZ = 0) {
    this.hp -= dano;
    this.kbX = kbX;
    this.kbZ = kbZ;
    const info = MOB_INFO[this.tipo];
    if (!info.hostil && !info.amigavel) this.panico = 5;
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
        m.atualizar(dt, world, { x: player.pos.x, z: player.pos.z });
      } else {
        m.atualizar(dt, world, null);
      }
      if (info.hostil) {
        const ddy = m.y - player.pos.y;
        const d2 = ddx*ddx + ddy*ddy + ddz*ddz;
        const naAlcance = d2 < info.alcance ** 2;
        m.cooldownFlecha -= dt;
        // Esqueleto: ataque ranged com flecha (cooldown 2.5s)
        if (m.tipo === 'esqueleto' && naAlcance && m.cooldownFlecha <= 0) {
          const dx = player.pos.x - m.x;
          const dy = (player.pos.y + 1.4) - (m.y + 1.5);
          const dz = player.pos.z - m.z;
          const len = Math.hypot(dx, dy, dz);
          if (len > 0.5) {
            const dir = { x: dx/len, y: dy/len, z: dz/len };
            spawnArrow({ x: m.x, y: m.y + 1.5, z: m.z }, dir, Math.max(1, info.dano - 1));
            m.cooldownFlecha = 2.5;
          }
          continue;
        }
        if (info.explode) {
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
          player.aplicarDano(info.dano, m.tipo);
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
