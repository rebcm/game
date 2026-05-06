// =====================================================================
// render.js — Renderer Three.js: atlas, mesh, sky, sol/lua, nuvens, mão
//
// Todos os blocos são OPACOS — não há mais path de mesh transparente.
// Mesh builder usa AO + iluminação 15 níveis (sky + block) para vertex
// colors. Sun intensity modula em tempo real via ambient/hemi/sol lights.
// =====================================================================

import * as THREE from 'three';
import {
  CHUNK_SIZE, WORLD_Y, BLOCO, BLOCO_INFO, VIEW_RADIUS,
} from './constants.js';
import { AO_OFFSETS, vertexAOValor, uvCelula } from './utils.js';
import { corCeuComClima } from './weather.js';

// === Atlas procedural ===
// Pinta texturas pixeladas 32×32 px num canvas único 8×4 células = 256×128.
// Retorna {texture, mapa} onde mapa[BLOCO.X] = {top, side, bottom} (índices).
function criarAtlas() {
  const COLS = 8, ROWS = 5, CELL = 32;
  const W = COLS * CELL, H = ROWS * CELL;
  const cnv = document.createElement('canvas');
  cnv.width = W; cnv.height = H;
  const ctx = cnv.getContext('2d');
  // Fundo magenta (debug — qualquer célula não pintada vira ofensiva)
  ctx.fillStyle = '#ff00ff'; ctx.fillRect(0, 0, W, H);

  // Pinta uma célula sólida com ruído suave estilo pixel art Minecraft.
  function pintar(idx, corBase, corRuido = null, intensidadeRuido = 0.18) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = corBase;
    ctx.fillRect(x0, y0, CELL, CELL);
    if (corRuido) {
      ctx.fillStyle = corRuido;
      // Ruído determinístico por célula (noise pixelado)
      let seed = idx * 9301 + 49297;
      for (let py = 0; py < CELL; py += 2) {
        for (let px = 0; px < CELL; px += 2) {
          seed = (seed * 9301 + 49297) % 233280;
          if ((seed / 233280) < intensidadeRuido) {
            ctx.fillRect(x0 + px, y0 + py, 2, 2);
          }
        }
      }
    }
  }

  // Pinta padrão de tijolos.
  function pintarTijolo(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#7a2828'; ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#cc6e6e';
    for (let r = 0; r < 4; r++) {
      const offset = (r % 2) * 8;
      for (let c = 0; c < 4; c++) {
        ctx.fillRect(x0 + c * 8 + offset, y0 + r * 8 + 1, 7, 6);
      }
    }
  }

  // Pinta padrão de madeira (anéis).
  function pintarMadeira(idx, lateral = false) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    if (lateral) {
      ctx.fillStyle = '#8d6e63'; ctx.fillRect(x0, y0, CELL, CELL);
      ctx.fillStyle = '#5d4037';
      for (let py = 0; py < CELL; py += 4) {
        ctx.fillRect(x0, y0 + py, CELL, 1);
      }
    } else {
      // Topo: anéis concêntricos
      ctx.fillStyle = '#a1887f'; ctx.fillRect(x0, y0, CELL, CELL);
      ctx.strokeStyle = '#5d4037'; ctx.lineWidth = 1;
      for (let r = 4; r < 16; r += 4) {
        ctx.beginPath(); ctx.arc(x0 + 16, y0 + 16, r, 0, Math.PI * 2); ctx.stroke();
      }
    }
  }

  // === Pinta cada bloco ===
  // Convenção de índices: top=N, side=N+1, bottom=N+2 (quando precisa de 3 faces)
  // ou index único quando todos os lados são iguais.
  pintar(0,  '#4CAF50', '#388E3C'); // grama topo
  pintar(1,  '#8D6E63', '#6D4C41'); // grama lado (terra com pouca grama)
  pintar(2,  '#6D4C41', '#5D4037'); // terra
  pintar(3,  '#9E9E9E', '#757575', 0.30); // pedra
  pintar(4,  '#FFEB3B', '#FDD835', 0.20); // areia
  pintarMadeira(5, false);                // madeira topo
  pintarMadeira(6, true);                 // madeira lado
  pintar(7,  '#66BB6A', '#388E3C', 0.30); // folha
  pintarTijolo(8);                        // tijolo
  pintar(9,  '#B3E5FC', '#81D4FA', 0.18); // vidro (com brilho azulado)
  pintar(10, '#FFD54F', '#FBC02D');       // ouro
  pintar(11, '#80DEEA', '#4DD0E1');       // diamante
  pintar(12, '#FFF9C4', '#FFEE58');       // luz
  pintar(13, '#ECEFF1', '#CFD8DC', 0.10); // neve
  pintar(14, '#424242', '#212121', 0.40); // carvão
  pintar(15, '#CFD8DC', '#B0BEC5', 0.25); // ferro
  pintar(16, '#388E3C', '#2E7D32');       // cacto
  pintar(17, '#2196F3', '#1976D2', 0.20); // água
  pintar(18, '#FF5722', '#FFAB40', 0.40); // lava
  pintar(19, '#4d3e5e', '#5d4e6e', 0.30); // obsidiana
  pintar(20, '#6D4C41', '#4E342E');       // workbench topo
  pintar(21, '#8D6E63', '#5D4037');       // workbench lado
  pintar(22, '#FAFAFA', '#EEEEEE', 0.10); // lã
  pintar(23, '#FFB300', '#FF6F00');       // tocha (cor de chama)
  pintar(24, '#8B5A2B', '#6D4C41');       // baú
  pintar(25, '#6E6E6E', '#424242');       // fornalha
  pintar(26, '#E53935', '#C62828');       // cama
  pintar(27, '#555555', '#4a4a4a', 0.35); // bedrock
  // Novos blocos decorativos

  // Mapa: [BLOCO.X] = { top, side, bottom }
  const mapa = {};
  // Bloco que não aparece (AR) não precisa entrada.
  mapa[BLOCO.GRAMA]     = { top: 0,  side: 1,  bottom: 2 };
  mapa[BLOCO.TERRA]     = { top: 2,  side: 2,  bottom: 2 };
  mapa[BLOCO.PEDRA]     = { top: 3,  side: 3,  bottom: 3 };
  mapa[BLOCO.AREIA]     = { top: 4,  side: 4,  bottom: 4 };
  mapa[BLOCO.MADEIRA]   = { top: 5,  side: 6,  bottom: 5 };
  mapa[BLOCO.FOLHA]     = { top: 7,  side: 7,  bottom: 7 };
  mapa[BLOCO.TIJOLO]    = { top: 8,  side: 8,  bottom: 8 };
  mapa[BLOCO.VIDRO]     = { top: 9,  side: 9,  bottom: 9 };
  mapa[BLOCO.OURO]      = { top: 10, side: 10, bottom: 10 };
  mapa[BLOCO.DIAMANTE]  = { top: 11, side: 11, bottom: 11 };
  mapa[BLOCO.LUZ]       = { top: 12, side: 12, bottom: 12 };
  mapa[BLOCO.NEVE]      = { top: 13, side: 13, bottom: 13 };
  mapa[BLOCO.CARVAO]    = { top: 14, side: 14, bottom: 14 };
  mapa[BLOCO.FERRO]     = { top: 15, side: 15, bottom: 15 };
  mapa[BLOCO.CACTO]     = { top: 16, side: 16, bottom: 16 };
  mapa[BLOCO.AGUA]      = { top: 17, side: 17, bottom: 17 };
  mapa[BLOCO.LAVA]      = { top: 18, side: 18, bottom: 18 };
  mapa[BLOCO.OBSIDIANA] = { top: 19, side: 19, bottom: 19 };
  mapa[BLOCO.WORKBENCH] = { top: 20, side: 21, bottom: 20 };
  mapa[BLOCO.LA]        = { top: 22, side: 22, bottom: 22 };
  mapa[BLOCO.TOCHA]     = { top: 23, side: 23, bottom: 23 };
  mapa[BLOCO.BAU]       = { top: 24, side: 24, bottom: 24 };
  mapa[BLOCO.FORNALHA]  = { top: 25, side: 25, bottom: 25 };
  mapa[BLOCO.CAMA]      = { top: 26, side: 26, bottom: 26 };
  mapa[BLOCO.BEDROCK]   = { top: 27, side: 27, bottom: 27 };

  const texture = new THREE.CanvasTexture(cnv);
  texture.magFilter = THREE.NearestFilter;
  texture.minFilter = THREE.NearestFilter;
  texture.wrapS = THREE.ClampToEdgeWrapping;
  texture.wrapT = THREE.ClampToEdgeWrapping;
  texture.colorSpace = THREE.SRGBColorSpace;
  const material = new THREE.MeshLambertMaterial({
    map: texture,
    vertexColors: true,
  });
  return { texture, material, mapa, cols: COLS, rows: ROWS };
}

// === Cracks textura ===
// 5 estágios (0..4) num atlas horizontal 5×1 com padrões de rachaduras.
function criarTexturaCracks() {
  const W = 32 * 5, H = 32;
  const cnv = document.createElement('canvas');
  cnv.width = W; cnv.height = H;
  const ctx = cnv.getContext('2d');
  ctx.clearRect(0, 0, W, H);
  for (let est = 0; est < 5; est++) {
    const x0 = est * 32;
    ctx.strokeStyle = `rgba(0,0,0,${0.4 + est * 0.10})`;
    ctx.lineWidth = 1 + Math.floor(est * 0.5);
    const linhas = 2 + est * 3;
    for (let i = 0; i < linhas; i++) {
      const sx = x0 + Math.random() * 32;
      const sy = Math.random() * 32;
      const ex = x0 + Math.random() * 32;
      const ey = Math.random() * 32;
      ctx.beginPath(); ctx.moveTo(sx, sy); ctx.lineTo(ex, ey); ctx.stroke();
    }
  }
  const tex = new THREE.CanvasTexture(cnv);
  tex.magFilter = THREE.NearestFilter;
  tex.minFilter = THREE.NearestFilter;
  return tex;
}

// === Disco de sol/lua ===
function criarDisco(cor, raio) {
  const cnv = document.createElement('canvas');
  cnv.width = 64; cnv.height = 64;
  const ctx = cnv.getContext('2d');
  ctx.fillStyle = '#' + cor.toString(16).padStart(6, '0');
  ctx.beginPath(); ctx.arc(32, 32, raio * 5, 0, Math.PI * 2); ctx.fill();
  const tex = new THREE.CanvasTexture(cnv);
  const mat = new THREE.SpriteMaterial({ map: tex, transparent: true, depthWrite: false });
  const sprite = new THREE.Sprite(mat);
  sprite.scale.set(20, 20, 1);
  return sprite;
}

export class Renderer {
  constructor(canvas) {
    this.canvas = canvas;
    this.camera = new THREE.PerspectiveCamera(70, window.innerWidth / window.innerHeight, 0.1, 400);
    this.scene = new THREE.Scene();
    this.renderer = new THREE.WebGLRenderer({ canvas, antialias: false });
    this.renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 3));
    this.renderer.setSize(window.innerWidth, window.innerHeight, false);
    // Cor inicial — atualizada por atualizarCeu.
    this.scene.background = new THREE.Color(0x87CEEB);
    this.scene.fog = new THREE.Fog(0x87CEEB, 40, CHUNK_SIZE * (VIEW_RADIUS + 0.5));

    // === Luzes globais ===
    // Intensidades reduzidas em relação ao default Lambert para EVITAR
    // overbright em blocos claros (neve/diamante/vidro/lã) — combinado
    // com vertex color próximo a 1.0 isso fazia o chão parecer espelhado.
    // A iluminação 15 níveis (sky+block) já está baked no vertex color,
    // então as luzes globais só precisam dar um leve "preenchimento".
    this.hemi = new THREE.HemisphereLight(0xbcd8ff, 0x6b5a3f, 0.35);
    this.scene.add(this.hemi);
    this.ambient = new THREE.AmbientLight(0xffffff, 0.18);
    this.scene.add(this.ambient);
    this.sol = new THREE.DirectionalLight(0xffffff, 0.35);
    this.sol.position.set(40, 80, 30);
    this.scene.add(this.sol);
    this.luaLuz = new THREE.DirectionalLight(0xc0d0ff, 0.0);
    this.luaLuz.position.set(-40, 80, -30);
    this.scene.add(this.luaLuz);

    // Sol/lua
    this.discoSol = criarDisco(0xFFEE58, 6);
    this.discoLua = criarDisco(0xECEFF1, 4);
    this.scene.add(this.discoSol);
    this.scene.add(this.discoLua);

    // Estrelas (visíveis à noite)
    this._criarEstrelas();
    // Nuvens (paralelo no céu)
    this._criarNuvens();

    // Pool de PointLights (tochas/lava perto do player)
    this.poolLuzes = [];
    for (let i = 0; i < 8; i++) {
      const l = new THREE.PointLight(0xffaa44, 0.0, 12, 2);
      l.visible = false;
      this.scene.add(l);
      this.poolLuzes.push(l);
    }

    // Atlas + materials
    this.atlas = criarAtlas();
    // Highlight do bloco mirado: outline duplo (preto + branco)
    const eg1 = new THREE.EdgesGeometry(new THREE.BoxGeometry(1.008, 1.008, 1.008));
    const matPreto = new THREE.LineBasicMaterial({
      color: 0x000000, transparent: true, opacity: 0.95,
      depthTest: false, depthWrite: false,
    });
    this.highlightPreto = new THREE.LineSegments(eg1, matPreto);
    this.highlightPreto.renderOrder = 999;
    this.highlightPreto.visible = false;
    this.scene.add(this.highlightPreto);
    const eg2 = new THREE.EdgesGeometry(new THREE.BoxGeometry(1.020, 1.020, 1.020));
    const matBranco = new THREE.LineBasicMaterial({
      color: 0xffffff, transparent: true, opacity: 0.55,
      depthTest: false, depthWrite: false,
    });
    this.highlight = new THREE.LineSegments(eg2, matBranco);
    this.highlight.renderOrder = 998;
    this.highlight.visible = false;
    this.scene.add(this.highlight);

    // Cracks (overlay no bloco quebrando)
    this.crackTexture = criarTexturaCracks();
    this.crackMat = new THREE.MeshBasicMaterial({
      map: this.crackTexture, transparent: true, opacity: 1.0,
      polygonOffset: true, polygonOffsetFactor: -1, polygonOffsetUnits: -1,
    });
    this.crackMesh = new THREE.Mesh(new THREE.BoxGeometry(1.004, 1.004, 1.004), this.crackMat);
    this.crackMesh.visible = false;
    this.scene.add(this.crackMesh);
    this.crackEstagioAtual = -1;

    // Mão 1ª pessoa (cubo no canto inferior direito da câmera)
    this._criarMao();

    // Camera shake
    this.shakeAmount = 0;
    this.shakePhase = 0;
    // Camera bobbing (paridade Minecraft real ao andar)
    this.bobPhase = 0;
    this.bobActive = false;
    // Swing animation da mão
    this.swingProgress = 0;
  }

  _criarEstrelas() {
    const N = 800;
    const positions = new Float32Array(N * 3);
    for (let i = 0; i < N; i++) {
      const theta = Math.random() * Math.PI * 2;
      const phi = Math.random() * Math.PI * 0.6 + 0.05;
      const r = 280;
      positions[i*3 + 0] = r * Math.sin(phi) * Math.cos(theta);
      positions[i*3 + 1] = r * Math.cos(phi);
      positions[i*3 + 2] = r * Math.sin(phi) * Math.sin(theta);
    }
    const geo = new THREE.BufferGeometry();
    geo.setAttribute('position', new THREE.BufferAttribute(positions, 3));
    const mat = new THREE.PointsMaterial({
      color: 0xffffff, size: 1.6, sizeAttenuation: false,
      transparent: true, opacity: 0, depthWrite: false,
    });
    this.estrelas = new THREE.Points(geo, mat);
    this.scene.add(this.estrelas);
  }

  _criarNuvens() {
    const cnv = document.createElement('canvas');
    cnv.width = 256; cnv.height = 256;
    const ctx = cnv.getContext('2d');
    ctx.clearRect(0, 0, 256, 256);
    ctx.fillStyle = '#ffffff';
    let seed = 1234;
    const rand = () => { seed = (seed * 9301 + 49297) % 233280; return seed / 233280; };
    for (let i = 0; i < 80; i++) {
      const x = Math.floor(rand() * 256 / 16) * 16;
      const y = Math.floor(rand() * 256 / 16) * 16;
      const w = (3 + Math.floor(rand() * 5)) * 16;
      const h = (1 + Math.floor(rand() * 3)) * 16;
      ctx.fillRect(x, y, w, h);
    }
    for (let i = 0; i < 50; i++) {
      const x = Math.floor(rand() * 256 / 16) * 16;
      const y = Math.floor(rand() * 256 / 16) * 16;
      ctx.fillRect(x, y, 16, 16);
    }
    const tex = new THREE.CanvasTexture(cnv);
    tex.wrapS = tex.wrapT = THREE.RepeatWrapping;
    tex.repeat.set(8, 8);
    tex.magFilter = THREE.NearestFilter;
    tex.minFilter = THREE.NearestFilter;
    this.cloudTexture = tex;
    const mat = new THREE.MeshBasicMaterial({
      map: tex, transparent: true, opacity: 0.85,
      depthWrite: false, alphaTest: 0.5,
    });
    const geo = new THREE.PlaneGeometry(2048, 2048);
    this.cloudMesh = new THREE.Mesh(geo, mat);
    this.cloudMesh.rotation.x = -Math.PI / 2;
    this.cloudMesh.position.y = 70;
    this.cloudMesh.renderOrder = -1;
    this.scene.add(this.cloudMesh);
  }

  _criarMao() {
    this.maoGroup = new THREE.Group();
    const geo = new THREE.BoxGeometry(0.18, 0.36, 0.18);
    const mat = new THREE.MeshBasicMaterial({ color: 0xFFCDA4 });
    this.maoMesh = new THREE.Mesh(geo, mat);
    this.maoMesh.position.set(0, 0, 0);
    this.maoGroup.add(this.maoMesh);
    this.maoGroup.position.set(0.32, -0.32, -0.55);
    this.maoGroup.rotation.set(-0.3, 0.2, -0.1);
    this.camera.add(this.maoGroup);
    this.scene.add(this.camera);
  }

  resize() {
    this.camera.aspect = window.innerWidth / window.innerHeight;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(window.innerWidth, window.innerHeight, false);
  }

  // === Mesh builder por chunk ===
  // Per-face meshing. Calcula AO + iluminação 15 níveis no vertex color.
  buildChunkMesh(world, chunk) {
    const positions = [], normals = [], colors = [], uvs = [], indices = [];
    chunk.lights = [];
    const cs = CHUNK_SIZE;
    const ox = chunk.cx * cs, oz = chunk.cz * cs;
    if (chunk.luzDirty) world.recalcLuzChunk(chunk);

    // Sombreamento por face (top mais claro, bottom mais escuro)
    const SHADE = { top: 1.00, sideX: 0.88, sideZ: 0.78, bottom: 0.70 };
    const AO_FACTOR = [0.72, 0.84, 0.93, 1.00];

    const faceVisivel = (x, y, z, blocoAtual) => {
      const v = world.get(x, y, z);
      // Face visível se vizinho é ar OU bloco não-sólido (flores, grama alta)
      if (v === BLOCO.AR) return true;
      const vi = BLOCO_INFO[v];
      if (!vi) return true;
      return !vi.solido;
    };

    const addFace = (faceShade, uvIdx, faceIdx, sx, sy, sz,
                     x, y, z, nx, ny, nz, ux, uy, uz, vx, vy, vz) => {
      const i0 = positions.length / 3;
      positions.push(x,           y,           z);
      positions.push(x + ux,      y + uy,      z + uz);
      positions.push(x + ux + vx, y + uy + vy, z + uz + vz);
      positions.push(x + vx,      y + vy,      z + vz);
      for (let i = 0; i < 4; i++) normals.push(nx, ny, nz);
      // Luz no voxel adjacente (não no bloco em si — bloco opaco tem luz=0).
      let lvx = sx, lvy = sy, lvz = sz;
      if (faceIdx === 0)      lvy += 1;
      else if (faceIdx === 1) lvy -= 1;
      else if (faceIdx === 2) lvx += 1;
      else if (faceIdx === 3) lvx -= 1;
      else if (faceIdx === 4) lvz += 1;
      else if (faceIdx === 5) lvz -= 1;
      const luz = world.getLightAt(lvx, lvy, lvz);
      const luzNorm = Math.max(luz.sky, luz.block) / 15;
      // Cap em 0.85 para evitar saturação visual quando texture clara +
      // luz alta. Combinado com a redução das luzes globais, blocos
      // claros (neve, vidro, diamante) deixam de parecer espelhados.
      const luzFator = 0.10 + 0.75 * luzNorm;
      // AO por vértice
      const tab = AO_OFFSETS[faceIdx];
      const ao0 = vertexAOValor(world, sx, sy, sz, tab[0]);
      const ao1 = vertexAOValor(world, sx, sy, sz, tab[1]);
      const ao2 = vertexAOValor(world, sx, sy, sz, tab[2]);
      const ao3 = vertexAOValor(world, sx, sy, sz, tab[3]);
      const baseShade = faceShade * luzFator;
      const s0 = baseShade * AO_FACTOR[ao0];
      const s1 = baseShade * AO_FACTOR[ao1];
      const s2 = baseShade * AO_FACTOR[ao2];
      const s3 = baseShade * AO_FACTOR[ao3];
      colors.push(s0, s0, s0, s1, s1, s1, s2, s2, s2, s3, s3, s3);
      // UVs do atlas
      const cellUV = uvCelula(this.atlas, uvIdx);
      for (let i = 0; i < 8; i++) uvs.push(cellUV[i]);
      // Flip de diagonal pra evitar split de luz em quads
      if (ao0 + ao2 < ao1 + ao3) {
        indices.push(i0 + 1, i0 + 2, i0 + 3, i0 + 1, i0 + 3, i0);
      } else {
        indices.push(i0, i0 + 1, i0 + 2, i0, i0 + 2, i0 + 3);
      }
    };

    for (let lx = 0; lx < cs; lx++) {
      for (let lz = 0; lz < cs; lz++) {
        for (let y = 0; y < WORLD_Y; y++) {
          const t = chunk.get(lx, y, lz);
          if (t === BLOCO.AR) continue;
          const info = BLOCO_INFO[t];
          if (info.emiteLuz) {
            chunk.lights.push({ x: ox + lx + 0.5, y: y + 0.5, z: oz + lz + 0.5, nivel: info.emiteLuz });
          }
          const x = ox + lx, z = oz + lz;
          const cellMap = this.atlas.mapa[t];
          if (!cellMap) continue;
          const idxTop = cellMap.top, idxSide = cellMap.side, idxBot = cellMap.bottom;
          if (faceVisivel(x, y + 1, z, t))
            addFace(SHADE.top, idxTop, 0, x, y, z, x, y+1, z, 0,1,0, 1,0,0, 0,0,1);
          if (faceVisivel(x, y - 1, z, t))
            addFace(SHADE.bottom, idxBot, 1, x, y, z, x, y, z+1, 0,-1,0, 1,0,0, 0,0,-1);
          if (faceVisivel(x + 1, y, z, t))
            addFace(SHADE.sideX, idxSide, 2, x, y, z, x+1, y, z, 1,0,0, 0,0,1, 0,1,0);
          if (faceVisivel(x - 1, y, z, t))
            addFace(SHADE.sideX, idxSide, 3, x, y, z, x, y, z+1, -1,0,0, 0,0,-1, 0,1,0);
          if (faceVisivel(x, y, z + 1, t))
            addFace(SHADE.sideZ, idxSide, 4, x, y, z, x+1, y, z+1, 0,0,1, -1,0,0, 0,1,0);
          if (faceVisivel(x, y, z - 1, t))
            addFace(SHADE.sideZ, idxSide, 5, x, y, z, x, y, z, 0,0,-1, 1,0,0, 0,1,0);
        }
      }
    }

    // Libera mesh anterior
    if (chunk.mesh) this.liberarChunkMesh(chunk);
    // Build BufferGeometry
    if (positions.length === 0) { chunk.dirty = false; return; }
    const geo = new THREE.BufferGeometry();
    geo.setAttribute('position', new THREE.BufferAttribute(new Float32Array(positions), 3));
    geo.setAttribute('normal',   new THREE.BufferAttribute(new Float32Array(normals), 3));
    geo.setAttribute('color',    new THREE.BufferAttribute(new Float32Array(colors), 3));
    geo.setAttribute('uv',       new THREE.BufferAttribute(new Float32Array(uvs), 2));
    geo.setIndex(indices);
    geo.computeBoundingSphere();
    chunk.mesh = new THREE.Mesh(geo, this.atlas.material);
    chunk.mesh.frustumCulled = true;
    this.scene.add(chunk.mesh);
    chunk.dirty = false;
  }

  liberarChunkMesh(chunk) {
    if (chunk.mesh) {
      this.scene.remove(chunk.mesh);
      chunk.mesh.geometry?.dispose();
      chunk.mesh = null;
    }
  }

  // === Highlight + cracks ===
  atualizarAlvo(hit, progresso) {
    if (!hit) {
      this.highlight.visible = false;
      this.highlightPreto.visible = false;
      this.crackMesh.visible = false;
      return;
    }
    this.highlight.position.set(hit.x + 0.5, hit.y + 0.5, hit.z + 0.5);
    this.highlightPreto.position.copy(this.highlight.position);
    this.highlight.visible = true;
    this.highlightPreto.visible = true;
    if (progresso > 0) {
      const estagio = Math.min(4, Math.floor(progresso * 5));
      if (estagio !== this.crackEstagioAtual) {
        this.crackEstagioAtual = estagio;
        // 5 estágios horizontalmente — atualiza UV via repeat/offset
        this.crackTexture.repeat.set(0.2, 1);
        this.crackTexture.offset.set(estagio * 0.2, 0);
        this.crackTexture.needsUpdate = true;
      }
      this.crackMesh.position.copy(this.highlight.position);
      this.crackMesh.visible = true;
    } else {
      this.crackMesh.visible = false;
      this.crackEstagioAtual = -1;
    }
  }

  // === Animação da mão ao bater ===
  atualizarMao(dt, batendoContinuo, ferramenta) {
    const swingSpeed = ferramenta ? 6 : 4;
    if (batendoContinuo) {
      this.swingProgress += dt * swingSpeed;
      if (this.swingProgress >= 1) this.swingProgress = 0;
    } else {
      this.swingProgress = Math.max(0, this.swingProgress - dt * swingSpeed * 1.4);
    }
    const a = Math.sin(this.swingProgress * Math.PI);
    this.maoGroup.rotation.x = -0.3 - a * 1.1;
    this.maoGroup.rotation.z = -0.1 + a * 0.4;
    this.maoGroup.position.y = -0.32 + a * 0.06;
  }

  // === Camera bobbing ao andar (paridade Minecraft) ===
  atualizarBobbing(dt, movendo, correndo) {
    if (movendo) {
      const freq = correndo ? 14.0 : 10.0;
      this.bobPhase += dt * freq;
      this.bobActive = true;
    } else if (this.bobActive) {
      // Desacelera suavemente até 0
      const target = Math.round(this.bobPhase / (Math.PI * 2)) * Math.PI * 2;
      this.bobPhase += (target - this.bobPhase) * Math.min(1, 8 * dt);
      if (Math.abs(this.bobPhase - target) < 0.05) {
        this.bobPhase = target;
        this.bobActive = false;
      }
    }
    const ampY = movendo ? (correndo ? 0.07 : 0.045) : 0;
    const ampX = movendo ? (correndo ? 0.035 : 0.022) : 0;
    const decay = this.bobActive ? 1 : 0;
    return {
      y: Math.sin(this.bobPhase) * ampY * decay,
      x: Math.cos(this.bobPhase * 0.5) * ampX * decay,
    };
  }

  // === FOV pulse ao sprintar ===
  atualizarFOV(dt, correndo) {
    const alvo = 70 + (correndo ? 8 : 0);
    const atual = this.camera.fov;
    if (Math.abs(atual - alvo) < 0.01) return;
    const k = Math.min(1, 10 * dt);
    this.camera.fov = atual + (alvo - atual) * k;
    this.camera.updateProjectionMatrix();
  }

  // === Camera bobbing (paridade Minecraft real) ===
  // Pequeno balanço vertical e horizontal ao andar/correr.
  // Retorna {x, y} pra aplicar como offset à camera.position.
  atualizarBobbing(dt, andando, sprintando) {
    if (!andando) {
      this.bobPhase = 0;
      return { x: 0, y: 0 };
    }
    const taxa = sprintando ? 11 : 7;
    const amp  = sprintando ? 0.045 : 0.030;
    this.bobPhase += dt * taxa;
    const y = Math.abs(Math.sin(this.bobPhase)) * amp;
    const x = Math.cos(this.bobPhase) * amp * 0.6;
    return { x, y: -y };
  }
  // === Camera shake ===
  aplicarShake(intensidade) {
    this.shakeAmount = Math.min(0.45, this.shakeAmount + intensidade);
  }
  atualizarShake(dt) {
    if (this.shakeAmount < 0.001) { this.shakeAmount = 0; return { x: 0, y: 0, z: 0 }; }
    this.shakePhase += dt * 38;
    const a = this.shakeAmount;
    const dx = Math.sin(this.shakePhase) * a;
    const dy = Math.cos(this.shakePhase * 1.3) * a * 0.6;
    const dz = Math.sin(this.shakePhase * 0.7 + 1.0) * a * 0.4;
    this.shakeAmount *= Math.pow(0.001, dt);
    return { x: dx, y: dy, z: dz };
  }

  // === Sky / sol / lua / nuvens / estrelas ===
  atualizarCeu(tempoDia, playerPos) {
    const sun = Math.max(0.05, 0.5 + 0.5 * Math.sin(tempoDia * Math.PI * 2 - Math.PI / 2));
    // Intensidades reduzidas (paridade com Minecraft: visual sem brilho
    // metálico). A iluminação 15 níveis no vertex color cobre o grosso.
    this.hemi.intensity    = 0.20 + 0.20 * sun;
    this.ambient.intensity = 0.10 + 0.12 * sun;
    this.sol.intensity     = 0.05 + 0.30 * sun;
    this.luaLuz.intensity  = 0.10 * (1 - sun);
    if (sun < 0.4) {
      this.hemi.color.setHex(0x4a6ba8);
      this.hemi.groundColor.setHex(0x2e2820);
    } else {
      this.hemi.color.setHex(0xbcd8ff);
      this.hemi.groundColor.setHex(0x6b5a3f);
    }
    // Cor do céu interpola entre noite/crepúsculo/dia
    const c1 = new THREE.Color(0x4a5878);
    const c2 = new THREE.Color(0xFF8A65);
    const c3 = new THREE.Color(0x87CEEB);
    let bg;
    if (sun < 0.35) bg = c1.clone().lerp(c2, sun / 0.35);
    else            bg = c2.clone().lerp(c3, (sun - 0.35) / 0.65);
    // Aplica tinte do clima (cinza durante chuva, sem efeito quando clear)
    bg = corCeuComClima(bg, sun);
    this.renderer.setClearColor(bg);
    if (this.scene.background) this.scene.background.copy(bg);
    if (this.scene.fog) this.scene.fog.color.copy(bg);
    // Sol e lua
    const ang = (tempoDia - 0.25) * Math.PI * 2;
    const r = 80;
    this.discoSol.position.set(
      playerPos.x + Math.sin(ang) * r,
      playerPos.y + Math.cos(ang) * r * 0.7,
      playerPos.z,
    );
    this.discoLua.position.set(
      playerPos.x + Math.sin(ang + Math.PI) * r,
      playerPos.y + Math.cos(ang + Math.PI) * r * 0.7,
      playerPos.z,
    );
    this.discoSol.visible = this.discoSol.position.y > playerPos.y - 30;
    this.discoLua.visible = this.discoLua.position.y > playerPos.y - 30;
    this.sol.position.copy(this.discoSol.position);
    this.luaLuz.position.copy(this.discoLua.position);
    // Nuvens scrolling + opacidade
    if (this.cloudMesh) {
      this.cloudMesh.position.x = playerPos.x;
      this.cloudMesh.position.z = playerPos.z;
      this.cloudTexture.offset.x = (tempoDia * 8) % 1;
      this.cloudMesh.material.opacity = 0.30 + 0.55 * Math.max(0, sun);
    }
    // Estrelas fade noturno
    if (this.estrelas) {
      this.estrelas.position.set(playerPos.x, playerPos.y, playerPos.z);
      const opa = Math.max(0, Math.min(0.95, (0.3 - sun) * 3.8));
      this.estrelas.material.opacity = opa;
      this.estrelas.visible = opa > 0.01;
    }
  }

  atualizarLuzesPontuais(world, playerPos) {
    const cx = Math.floor(playerPos.x / CHUNK_SIZE);
    const cz = Math.floor(playerPos.z / CHUNK_SIZE);
    const candidatas = [];
    for (let dx = -2; dx <= 2; dx++) {
      for (let dz = -2; dz <= 2; dz++) {
        const c = world.chunks.get(((cx + dx) & 0xFFFF) | (((cz + dz) & 0xFFFF) << 16));
        if (!c) continue;
        for (const l of c.lights) {
          const ddx = l.x - playerPos.x, ddy = l.y - playerPos.y, ddz = l.z - playerPos.z;
          candidatas.push({ ...l, d2: ddx*ddx + ddy*ddy + ddz*ddz });
        }
      }
    }
    candidatas.sort((a, b) => a.d2 - b.d2);
    for (let i = 0; i < this.poolLuzes.length; i++) {
      const l = this.poolLuzes[i];
      const c = candidatas[i];
      if (c) {
        l.visible = true;
        l.position.set(c.x, c.y, c.z);
        l.intensity = c.nivel / 15 * 0.8;
        l.distance = c.nivel + 1;
        l.color.setHex(c.nivel >= 15 ? 0xff6622 : 0xffaa55);
      } else {
        l.visible = false;
      }
    }
  }

  render() { this.renderer.render(this.scene, this.camera); }
}
