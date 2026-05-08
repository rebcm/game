// =====================================================================
// world.js — Chunks, geração de mundo e iluminação 15 níveis
// =====================================================================

import {
  CHUNK_SIZE, WORLD_Y, BLOCO, BLOCO_INFO, ITEM,
} from './constants.js';
import { hash2, hash3, clamp, chunkKey, perlin2, perlin3, fbm2 } from './utils.js';

// Um chunk de 16×16×64 voxels.
// `blocks` armazena IDs de bloco (0-25). `light` armazena luz por voxel
// num só byte: 4 bits sky + 4 bits block (0-15 cada).
export class Chunk {
  constructor(cx, cz) {
    this.cx = cx; this.cz = cz;
    this.blocks = new Uint8Array(CHUNK_SIZE * CHUNK_SIZE * WORLD_Y);
    this.light = new Uint8Array(CHUNK_SIZE * CHUNK_SIZE * WORLD_Y);
    this.dirty = true;       // mesh precisa rebuild
    this.luzDirty = true;    // luz precisa recalcular
    this.modificado = false; // foi alterado pelo player (vai pro save)
    this.mesh = null;
    this.lights = [];        // lista de blocos emissivos (lava/luz/tocha)
  }
  static idx(lx, y, lz) { return y * CHUNK_SIZE * CHUNK_SIZE + lx * CHUNK_SIZE + lz; }
  get(lx, y, lz) {
    if (lx < 0 || lx >= CHUNK_SIZE || lz < 0 || lz >= CHUNK_SIZE) return BLOCO.AR;
    if (y < 0 || y >= WORLD_Y) return BLOCO.AR;
    return this.blocks[Chunk.idx(lx, y, lz)];
  }
  set(lx, y, lz, t) {
    if (lx < 0 || lx >= CHUNK_SIZE || lz < 0 || lz >= CHUNK_SIZE) return;
    if (y < 0 || y >= WORLD_Y) return;
    const i = Chunk.idx(lx, y, lz);
    if (this.blocks[i] === t) return;
    this.blocks[i] = t;
    this.dirty = true;
    this.luzDirty = true;
  }
  getLightSky(lx, y, lz) {
    if (lx < 0 || lx >= CHUNK_SIZE || lz < 0 || lz >= CHUNK_SIZE) return 15;
    if (y < 0 || y >= WORLD_Y) return 15;
    return (this.light[Chunk.idx(lx, y, lz)] >> 4) & 0x0F;
  }
  getLightBlock(lx, y, lz) {
    if (lx < 0 || lx >= CHUNK_SIZE || lz < 0 || lz >= CHUNK_SIZE) return 0;
    if (y < 0 || y >= WORLD_Y) return 0;
    return this.light[Chunk.idx(lx, y, lz)] & 0x0F;
  }
  setLightCombinado(lx, y, lz, sky, block) {
    if (lx < 0 || lx >= CHUNK_SIZE || lz < 0 || lz >= CHUNK_SIZE) return;
    if (y < 0 || y >= WORLD_Y) return;
    this.light[Chunk.idx(lx, y, lz)] = ((sky & 0x0F) << 4) | (block & 0x0F);
  }
}

// O mundo: dicionário de chunks + estados de blocos funcionais (baú, fornalha).
export class World {
  constructor(seed = 42) {
    this.seed = seed;
    this.chunks = new Map();
    this.bauTesouros = new Map();    // "x,y,z" -> array de 27 slots
    this.fornalhaEstados = new Map(); // "x,y,z" -> {input, combustivel, output, progresso, ativa}
    this.mudas = new Map();          // "x,y,z" -> {plantadaEm: ms timestamp}
    this.crops = new Map();          // "x,y,z" -> {plantadaEm, tipo: 'trigo'}
  }
  static keyXYZ(x, y, z) { return `${x},${y},${z}`; }

  getBau(x, y, z) {
    const k = World.keyXYZ(x, y, z);
    if (!this.bauTesouros.has(k)) this.bauTesouros.set(k, new Array(27).fill(null));
    return this.bauTesouros.get(k);
  }
  getFornalha(x, y, z) {
    const k = World.keyXYZ(x, y, z);
    if (!this.fornalhaEstados.has(k)) {
      this.fornalhaEstados.set(k, {
        input: null, combustivel: null, output: null,
        progresso: 0, ativa: false,
      });
    }
    return this.fornalhaEstados.get(k);
  }
  removerEstadoBloco(x, y, z) {
    const k = World.keyXYZ(x, y, z);
    this.bauTesouros.delete(k);
    this.fornalhaEstados.delete(k);
  }

  // === Geração de terreno ===
  // Altura por fBM (fractal Brownian motion) Perlin 2D — paridade com
  // Minecraft real. 4 oitavas dão relevo orgânico (colinas + detalhe).
  alturaTerreno(x, z) {
    // Frequência base 1/64 → colinas a cada ~64 blocos. Persistência
    // 0.5 e lacunarity 2.0 são valores padrão para terreno suave.
    const v = fbm2(x / 64, z / 64, 4, 2.0, 0.5, this.seed);
    // v vem em ~[-1, 1]. Normaliza para [0, 1] e mapeia para altura.
    const n = (v + 1) * 0.5;
    return clamp(20 + Math.floor(n * 22), 2, WORLD_Y - 8);
  }
  // === Biomas via Perlin 2D ===
  // 4 biomas: deserto (areia + cactos), planicies (grama + árvores raras),
  // floresta (grama + árvores densas), taiga (neve + grama). Selecionado
  // por dois noises baixa-frequência (temperatura + umidade) — paridade
  // Minecraft ("temperature/humidity climate model").
  biomaEm(x, z) {
    if (this.alturaTerreno(x, z) >= 38) return 'taiga'; // alta altitude = sempre frio
    const temp = perlin2(x / 220, z / 220, this.seed ^ 0x7E11);
    const umid = perlin2(x / 180, z / 180, this.seed ^ 0x9999);
    // temp [-1,1], umid [-1,1]. Mapeia em 4 quadrantes:
    if (temp > 0.25) {
      return umid < -0.10 ? 'deserto' : 'planicies';
    } else {
      return umid > 0.10 ? 'floresta' : 'taiga';
    }
  }
  // Bloco do topo do terreno dependendo do bioma.
  topoBioma(x, z, h) {
    const b = this.biomaEm(x, z);
    if (b === 'deserto')  return BLOCO.AREIA;
    if (b === 'taiga')    return BLOCO.NEVE;
    return BLOCO.GRAMA; // planicies + floresta
  }
  // Cavernas via Perlin 3D — paridade Minecraft real.
  // Threshold > 0.55 cria túneis/câmaras orgânicas. Concentra y em [5, 50].
  caverna(x, y, z) {
    if (y <= 4 || y >= WORLD_Y - 4) return false;
    const v = perlin3(x / 18, y / 14, z / 18, this.seed ^ 0xCAFE);
    return v > 0.58;
  }

  // Gera (uma única vez) o conteúdo do chunk.
  gerarChunk(cx, cz) {
    const c = new Chunk(cx, cz);
    const NIVEL_AGUA = 8; // blocos abaixo desse nível viram água
    // 1. Terreno + minérios
    for (let lx = 0; lx < CHUNK_SIZE; lx++) {
      for (let lz = 0; lz < CHUNK_SIZE; lz++) {
        const gx = cx * CHUNK_SIZE + lx;
        const gz = cz * CHUNK_SIZE + lz;
        const h = this.alturaTerreno(gx, gz);
        for (let y = 0; y <= Math.max(h, NIVEL_AGUA); y++) {
          let b;
          if (y <= 2) b = BLOCO.BEDROCK;
          else if (y <= 4) {
            const hh = hash2(gx, gz + y * 31, this.seed ^ 0xfee10) & 0xFF;
            b = hh < 14 ? BLOCO.LAVA : BLOCO.PEDRA;
          } else if (y > h && y <= NIVEL_AGUA) {
            // Preenche com água até o nível do mar
            b = BLOCO.AGUA;
          } else if (y > h) {
            continue;
          } else if (y < h - 3) {
            // Cavernas
            if (this.caverna(gx, y, gz)) { c.set(lx, y, lz, BLOCO.AR); continue; }
            const hh = hash3(gx, y, gz, this.seed ^ 0xa1b2) & 0xFF;
            if (y < 6 && hh < 3) b = BLOCO.DIAMANTE;
            else if (y < 10 && hh < 6) b = BLOCO.OURO;
            else if (y < 14 && hh < 14) b = BLOCO.FERRO;
            else if (hh < 26) b = BLOCO.CARVAO;
            else b = BLOCO.PEDRA;
          } else if (y < h) {
            b = BLOCO.TERRA;
          } else {
            b = this.topoBioma(gx, gz, h);
          }
          c.set(lx, y, lz, b);
        }
      }
    }
    // 2. Árvores — densidade varia por bioma (floresta densa, planicies
    // esparsa, deserto/taiga sem). Paridade Minecraft.
    for (let lx = 0; lx < CHUNK_SIZE; lx++) {
      for (let lz = 0; lz < CHUNK_SIZE; lz++) {
        const gx = cx * CHUNK_SIZE + lx;
        const gz = cz * CHUNK_SIZE + lz;
        const h = this.alturaTerreno(gx, gz);
        if (c.get(lx, h, lz) !== BLOCO.GRAMA) continue;
        const bioma = this.biomaEm(gx, gz);
        const limiar = bioma === 'floresta' ? 36 : (bioma === 'planicies' ? 8 : 0);
        if (limiar === 0) continue;
        const hh = hash2(gx, gz, this.seed ^ 0xA75) & 0xFF;
        if (hh > limiar) continue;
        const altura = 4 + (hh & 0x3);
        for (let y = 1; y <= altura; y++) c.set(lx, h + y, lz, BLOCO.MADEIRA);
        // Copa esférica
        for (let dx = -2; dx <= 2; dx++) {
          for (let dz = -2; dz <= 2; dz++) {
            for (let dy = 0; dy <= 2; dy++) {
              if (dx*dx + dz*dz + dy*dy <= 5) {
                if (lx + dx < 0 || lx + dx >= CHUNK_SIZE) continue;
                if (lz + dz < 0 || lz + dz >= CHUNK_SIZE) continue;
                if (c.get(lx + dx, h + altura + dy, lz + dz) === BLOCO.AR) {
                  c.set(lx + dx, h + altura + dy, lz + dz, BLOCO.FOLHA);
                }
              }
            }
          }
        }
      }
    }
    // 3. Cactos no deserto
    for (let lx = 0; lx < CHUNK_SIZE; lx++) {
      for (let lz = 0; lz < CHUNK_SIZE; lz++) {
        const gx = cx * CHUNK_SIZE + lx;
        const gz = cz * CHUNK_SIZE + lz;
        const h = this.alturaTerreno(gx, gz);
        if (c.get(lx, h, lz) !== BLOCO.AREIA) continue;
        const hh = hash2(gx, gz, this.seed ^ 0xCAC) & 0xFF;
        if (hh > 6) continue;
        const altura = 1 + (hh & 0x2);
        for (let y = 1; y <= altura; y++) c.set(lx, h + y, lz, BLOCO.CACTO);
      }
    }
    // 4. Dungeon subterrânea: 1 chance a cada ~50 chunks. Sala 5×5×4 com
    // baú no centro e tochas nos cantos. Spawnada em y 8-25 (caverna level).
    // Skip no chunk (0,0) pra não engolir o spawn do player.
    const dungHash = hash2(cx, cz, this.seed ^ 0xD6307) & 0xFFFF;
    if (dungHash < 1300 && !(cx === 0 && cz === 0)) { // ~2% por chunk
      const cxLocal = 5 + (dungHash & 0x5); // 5..10 dentro do chunk
      const czLocal = 5 + ((dungHash >> 4) & 0x5);
      const cy = 8 + (dungHash >> 8) % 16; // 8..23
      this._gerarDungeon(c, cx, cz, cxLocal, cy, czLocal);
    }
    return c;
  }

  // Sala 5×5×4 oca com paredes de pedra e baú no centro com loot.
  // Coordenadas locais ao chunk (lx, ly, lz). Não estende além do chunk
  // pra evitar dependências cross-chunk.
  _gerarDungeon(c, cx, cz, lx, ly, lz) {
    const W = 5, H = 4, D = 5;
    for (let dx = 0; dx < W; dx++) {
      for (let dy = 0; dy < H; dy++) {
        for (let dz = 0; dz < D; dz++) {
          const x = lx + dx, y = ly + dy, z = lz + dz;
          if (x >= CHUNK_SIZE || z >= CHUNK_SIZE || y >= WORLD_Y) continue;
          // Paredes/teto/chão = pedra; interior = ar
          const naBorda = dx === 0 || dx === W-1 || dy === 0 || dy === H-1 || dz === 0 || dz === D-1;
          c.set(x, y, z, naBorda ? BLOCO.PEDRA : BLOCO.AR);
        }
      }
    }
    // Baú no centro com loot (3-5 items aleatórios)
    const cxC = lx + Math.floor(W / 2);
    const cyC = ly + 1;
    const czC = lz + Math.floor(D / 2);
    if (cxC < CHUNK_SIZE && czC < CHUNK_SIZE && cyC < WORLD_Y) {
      c.set(cxC, cyC, czC, BLOCO.BAU);
      // Salva loot no Map de baús (será preenchido na primeira abertura)
      const k = World.keyXYZ(cx * CHUNK_SIZE + cxC, cyC, cz * CHUNK_SIZE + czC);
      const loot = this._gerarLootDungeon(cx, cz);
      this.bauTesouros.set(k, loot);
    }
    // Tochas nos 4 cantos do teto pra iluminar
    const tochas = [[lx+1, ly+H-2, lz+1], [lx+W-2, ly+H-2, lz+1],
                    [lx+1, ly+H-2, lz+D-2], [lx+W-2, ly+H-2, lz+D-2]];
    for (const [tx, ty, tz] of tochas) {
      if (tx < CHUNK_SIZE && tz < CHUNK_SIZE) c.set(tx, ty, tz, BLOCO.TOCHA);
    }
  }

  _gerarLootDungeon(cx, cz) {
    const loot = new Array(27).fill(null);
    const items = [
      { i: ITEM.PAU, q: 4 },
      { i: ITEM.CARVAO, q: 3 },
      { i: ITEM.FERRO, q: 2 },
      { i: ITEM.OURO, q: 1 },
      { b: BLOCO.PEDRA, q: 8 },
    ];
    // Loot raro: diamante 25%, esmeralda nada, comida cozida 30%
    if ((hash2(cx, cz, this.seed ^ 0xD1A) & 0xFF) < 64) items.push({ i: ITEM.DIAMANTE, q: 1 });
    if ((hash2(cx, cz, this.seed ^ 0xC02) & 0xFF) < 80) items.push({ i: ITEM.CARNE_COZIDA, q: 3 });
    if ((hash2(cx, cz, this.seed ^ 0xA20) & 0xFF) < 40) items.push({ i: ITEM.ARCO, q: 1 });
    // Distribui aleatoriamente nos primeiros slots
    let s = (hash2(cx, cz, this.seed ^ 0x5705) >>> 0) % 7;
    for (const it of items) {
      loot[s % 27] = { ...it };
      s = (s * 5 + 3) % 27;
    }
    return loot;
  }

  // Carrega chunk (gera se não existe).
  getChunk(cx, cz) {
    const k = chunkKey(cx, cz);
    let c = this.chunks.get(k);
    if (!c) { c = this.gerarChunk(cx, cz); this.chunks.set(k, c); }
    return c;
  }
  hasChunk(cx, cz) { return this.chunks.has(chunkKey(cx, cz)); }

  // Acesso global por (x, y, z).
  get(x, y, z) {
    if (y < 0 || y >= WORLD_Y) return BLOCO.AR;
    const cx = Math.floor(x / CHUNK_SIZE);
    const cz = Math.floor(z / CHUNK_SIZE);
    const lx = ((x % CHUNK_SIZE) + CHUNK_SIZE) % CHUNK_SIZE;
    const lz = ((z % CHUNK_SIZE) + CHUNK_SIZE) % CHUNK_SIZE;
    return this.getChunk(cx, cz).get(lx, y, lz);
  }
  set(x, y, z, t) {
    if (y < 0 || y >= WORLD_Y) return null;
    const cx = Math.floor(x / CHUNK_SIZE);
    const cz = Math.floor(z / CHUNK_SIZE);
    const lx = ((x % CHUNK_SIZE) + CHUNK_SIZE) % CHUNK_SIZE;
    const lz = ((z % CHUNK_SIZE) + CHUNK_SIZE) % CHUNK_SIZE;
    const c = this.getChunk(cx, cz);
    if (c.get(lx, y, lz) === t) return null;
    c.set(lx, y, lz, t);
    c.modificado = true;
    // Marca chunks vizinhos como dirty/luzDirty (faces/luz cruzam borda)
    const out = [c];
    if (lx === 0)               out.push(this.getChunk(cx - 1, cz));
    if (lx === CHUNK_SIZE - 1)  out.push(this.getChunk(cx + 1, cz));
    if (lz === 0)               out.push(this.getChunk(cx, cz - 1));
    if (lz === CHUNK_SIZE - 1)  out.push(this.getChunk(cx, cz + 1));
    for (const cc of out) { cc.dirty = true; cc.luzDirty = true; }
    return c;
  }
  isSolido(x, y, z) {
    return BLOCO_INFO[this.get(x, y, z)].solido;
  }

  // === Fluxo de fluido (água/lava) ===
  // BFS event-driven: chama-se ao colocar água/lava (bucket) ou ao
  // expor uma fonte. Espalha até max blocos horizontal + cai vertical.
  // Limita processamento a 100 blocos pra evitar runaway.
  espalharFluido(x, y, z, tipo) {
    if (tipo !== BLOCO.AGUA && tipo !== BLOCO.LAVA) return;
    const maxDist = tipo === BLOCO.AGUA ? 4 : 2;
    const queue = [{ x, y, z, dist: 0 }];
    const visitados = new Set();
    visitados.add(`${x},${y},${z}`);
    let processed = 0;
    while (queue.length && processed < 100) {
      const { x: cx, y: cy, z: cz, dist } = queue.shift();
      processed++;
      // Tenta cair primeiro
      if (cy > 0 && this.get(cx, cy - 1, cz) === BLOCO.AR) {
        this.set(cx, cy - 1, cz, tipo);
        const k = `${cx},${cy-1},${cz}`;
        if (!visitados.has(k)) {
          visitados.add(k);
          queue.push({ x: cx, y: cy - 1, z: cz, dist });
        }
        continue; // se caiu, não espalha horizontal nesse nível
      }
      if (dist >= maxDist) continue;
      for (const [dx, dz] of [[1,0],[-1,0],[0,1],[0,-1]]) {
        const nx = cx + dx, nz = cz + dz;
        if (this.get(nx, cy, nz) !== BLOCO.AR) continue;
        const k = `${nx},${cy},${nz}`;
        if (visitados.has(k)) continue;
        visitados.add(k);
        this.set(nx, cy, nz, tipo);
        queue.push({ x: nx, y: cy, z: nz, dist: dist + 1 });
      }
    }
  }

  // === Dirt → Grass spread ===
  // Tick periódico: pega N tentativas random de converter TERRA exposta
  // (com céu acima) num raio do player em GRAMA. Requer GRAMA adjacente.
  // Chamado do main loop a cada ~5s.
  spreadGrama(playerX, playerZ, tentativas = 6) {
    const px = Math.floor(playerX), pz = Math.floor(playerZ);
    let convertidas = 0;
    for (let i = 0; i < tentativas; i++) {
      const dx = Math.floor((Math.random() - 0.5) * 32);
      const dz = Math.floor((Math.random() - 0.5) * 32);
      const x = px + dx, z = pz + dz;
      if (!this.hasChunk(Math.floor(x / CHUNK_SIZE), Math.floor(z / CHUNK_SIZE))) continue;
      // Acha topo
      let y = 50;
      while (y > 0 && this.get(x, y, z) === BLOCO.AR) y--;
      if (this.get(x, y, z) !== BLOCO.TERRA) continue;
      // Precisa AR acima (exposto)
      if (this.get(x, y + 1, z) !== BLOCO.AR) continue;
      // Precisa GRAMA num vizinho 4-direcional + topo
      let temGrama = false;
      for (const [vx, vy, vz] of [[1,0,0],[-1,0,0],[0,0,1],[0,0,-1],[0,1,0],[1,1,0],[-1,1,0],[0,1,1],[0,1,-1]]) {
        if (this.get(x + vx, y + vy, z + vz) === BLOCO.GRAMA) { temGrama = true; break; }
      }
      if (!temGrama) continue;
      this.set(x, y, z, BLOCO.GRAMA);
      convertidas++;
    }
    return convertidas;
  }

  // === Crops / farming ===
  // Planta semente em (x, y, z): requer AR no local + TERRA logo abaixo.
  plantarSemente(x, y, z, tipo = 'trigo') {
    if (this.get(x, y, z) !== BLOCO.AR) return false;
    const abaixo = this.get(x, y - 1, z);
    if (abaixo !== BLOCO.TERRA && abaixo !== BLOCO.GRAMA) return false;
    this.crops.set(World.keyXYZ(x, y, z), { plantadaEm: Date.now(), tipo });
    return true;
  }
  // Tickado a cada frame. Quando crop atinge 30s, vira "maduro" (não muda
  // bloco visível ainda — quebra direto pela coleta dropa trigo+sementes).
  // Retorna lista de crops maduros [{x,y,z,tipo}].
  atualizarCrops() {
    const agora = Date.now();
    const maduros = [];
    for (const [k, c] of this.crops) {
      if (c.maduro) continue;
      if (agora - c.plantadaEm < 30000) continue;
      c.maduro = true;
      const [x, y, z] = k.split(',').map(Number);
      maduros.push({ x, y, z, tipo: c.tipo });
    }
    return maduros;
  }
  // Colhe um crop em (x,y,z). Retorna drops ou null se não há crop maduro.
  colherCrop(x, y, z) {
    const k = World.keyXYZ(x, y, z);
    const c = this.crops.get(k);
    if (!c || !c.maduro) return null;
    this.crops.delete(k);
    return [
      { i: ITEM.TRIGO, q: 1 },
      { i: ITEM.SEMENTE, q: 1 + Math.floor(Math.random() * 3) },
    ];
  }

  // === Mudas / crescimento de árvore ===
  // Planta uma muda na célula (x, y, z). Requer que esteja em AR e o
  // bloco abaixo seja GRAMA. Retorna true se plantou.
  plantarMuda(x, y, z) {
    if (this.get(x, y, z) !== BLOCO.AR) return false;
    if (this.get(x, y - 1, z) !== BLOCO.GRAMA) return false;
    this.mudas.set(World.keyXYZ(x, y, z), { plantadaEm: Date.now() });
    return true;
  }
  // Itera mudas pendentes e converte em árvore após 15-25s. Chamado
  // do main loop. Retorna número de árvores que cresceram nesse tick.
  atualizarMudas() {
    const agora = Date.now();
    let cresceram = 0;
    for (const [k, m] of this.mudas) {
      const idade = (agora - m.plantadaEm) / 1000;
      // tempo varia 15-25s pra não nascerem todas no mesmo frame
      const tempoNec = m._tempoNec ?? (m._tempoNec = 15 + Math.random() * 10);
      if (idade < tempoNec) continue;
      // Decompõe a key
      const [x, y, z] = k.split(',').map(Number);
      // Verifica se o lugar ainda é válido (player pode ter quebrado a grama)
      if (this.get(x - 1 + 1, y - 1, z) !== BLOCO.GRAMA && this.get(x, y - 1, z) !== BLOCO.GRAMA) {
        this.mudas.delete(k); continue;
      }
      // Cresce a árvore (mesma lógica do gerarChunk: tronco + copa)
      const altura = 4 + (Math.floor(Math.random() * 4));
      for (let dy = 0; dy < altura; dy++) {
        if (this.get(x, y + dy, z) === BLOCO.AR) this.set(x, y + dy, z, BLOCO.MADEIRA);
      }
      // Copa esférica
      for (let dx = -2; dx <= 2; dx++) {
        for (let dz = -2; dz <= 2; dz++) {
          for (let dy = 0; dy <= 2; dy++) {
            if (dx*dx + dz*dz + dy*dy <= 5) {
              const fx = x + dx, fy = y + altura - 1 + dy, fz = z + dz;
              if (this.get(fx, fy, fz) === BLOCO.AR) this.set(fx, fy, fz, BLOCO.FOLHA);
            }
          }
        }
      }
      this.mudas.delete(k);
      cresceram++;
    }
    return cresceram;
  }

  // Folha decay: depois que MADEIRA é cortada, FOLHAS num raio R que
  // não tenham madeira por perto somem (cai item raro). Paridade
  // Minecraft "leaves decay". BFS limitado pra não escanear mundo todo.
  iniciarDecayFolhas(x, y, z, raio = 4) {
    const candidatos = [];
    for (let dy = -raio; dy <= raio; dy++) {
      for (let dx = -raio; dx <= raio; dx++) {
        for (let dz = -raio; dz <= raio; dz++) {
          if (dx*dx + dy*dy + dz*dz > raio * raio) continue;
          const fx = x + dx, fy = y + dy, fz = z + dz;
          if (this.get(fx, fy, fz) !== BLOCO.FOLHA) continue;
          // Procura madeira em raio menor (R=4) ao redor desta folha
          let temMadeira = false;
          for (let ay = -4; ay <= 4 && !temMadeira; ay++) {
            for (let ax = -4; ax <= 4 && !temMadeira; ax++) {
              for (let az = -4; az <= 4 && !temMadeira; az++) {
                if (ax*ax + ay*ay + az*az > 16) continue;
                if (this.get(fx + ax, fy + ay, fz + az) === BLOCO.MADEIRA) temMadeira = true;
              }
            }
          }
          if (!temMadeira) candidatos.push({ x: fx, y: fy, z: fz });
        }
      }
    }
    // Agenda remoção escalonada (visual de decay gradual ao longo de ~3s)
    for (const c of candidatos) {
      const delay = 200 + Math.random() * 2800;
      setTimeout(() => {
        if (this.get(c.x, c.y, c.z) === BLOCO.FOLHA) {
          this.set(c.x, c.y, c.z, BLOCO.AR);
        }
      }, delay);
    }
    return candidatos.length;
  }

  // Aplica gravidade a blocos como AREIA: se há areia logo acima de
  // (x, y, z), cascateia para baixo até encontrar suporte sólido (ou
  // bedrock). Chamado após um bloco ser removido — a coluna inteira
  // de areia em cima desce. Paridade Minecraft.
  aplicarGravidadeBlocos(x, y, z) {
    let topo = y + 1;
    let movimentos = 0;
    while (topo < WORLD_Y && this.get(x, topo, z) === BLOCO.AREIA) {
      // Acha o destino mais baixo (1 acima do primeiro sólido abaixo)
      let dest = topo - 1;
      while (dest >= 0 && this.get(x, dest, z) === BLOCO.AR) dest--;
      dest += 1;
      if (dest === topo) break; // areia já está apoiada
      this.set(x, topo, z, BLOCO.AR);
      this.set(x, dest, z, BLOCO.AREIA);
      movimentos++;
      topo++;
    }
    return movimentos;
  }

  // === Iluminação 15 níveis (skylight + blocklight) ===
  // Skylight vertical: desce do topo, fica em 15 enquanto não bater opaco.
  // Blocklight: BFS partindo de fontes emissivas, decaindo 1 por bloco.
  // BFS é per-chunk (não cruza bordas) — simplificação aceitável.
  recalcLuzChunk(chunk) {
    const cs = CHUNK_SIZE;
    chunk.light.fill(0);
    // 1) Skylight vertical
    for (let lx = 0; lx < cs; lx++) {
      for (let lz = 0; lz < cs; lz++) {
        let sky = 15;
        for (let y = WORLD_Y - 1; y >= 0; y--) {
          const b = chunk.blocks[Chunk.idx(lx, y, lz)];
          if (BLOCO_INFO[b].solido) sky = 0;
          chunk.light[Chunk.idx(lx, y, lz)] = ((sky & 0x0F) << 4);
        }
      }
    }
    // 1b) Skylight lateral BFS — propaga horizontalmente com -1 por bloco
    const skyQ = [];
    for (let lx = 0; lx < cs; lx++) {
      for (let lz = 0; lz < cs; lz++) {
        for (let y = WORLD_Y - 1; y >= 0; y--) {
          const i = Chunk.idx(lx, y, lz);
          const sky = (chunk.light[i] >> 4) & 0x0F;
          if (sky > 1) skyQ.push(lx, y, lz, sky);
        }
      }
    }
    let sH = 0;
    while (sH < skyQ.length) {
      const lx = skyQ[sH++], y = skyQ[sH++], lz = skyQ[sH++], lvl = skyQ[sH++];
      if (lvl <= 1) continue;
      const novo = lvl - 1;
      const vizinhos = [[lx-1,y,lz],[lx+1,y,lz],[lx,y-1,lz],[lx,y+1,lz],[lx,y,lz-1],[lx,y,lz+1]];
      for (const [vx,vy,vz] of vizinhos) {
        if (vx < 0 || vx >= cs || vz < 0 || vz >= cs) continue;
        if (vy < 0 || vy >= WORLD_Y) continue;
        const vi = Chunk.idx(vx, vy, vz);
        if (BLOCO_INFO[chunk.blocks[vi]].solido) continue;
        const curSky = (chunk.light[vi] >> 4) & 0x0F;
        if (curSky >= novo) continue;
        chunk.light[vi] = ((novo & 0x0F) << 4) | (chunk.light[vi] & 0x0F);
        skyQ.push(vx, vy, vz, novo);
      }
    }
    // 2) Blocklight BFS — fila plana com 4 entries por nó (lx, y, lz, level)
    const queue = [];
    for (let lx = 0; lx < cs; lx++) {
      for (let lz = 0; lz < cs; lz++) {
        for (let y = 0; y < WORLD_Y; y++) {
          const b = chunk.blocks[Chunk.idx(lx, y, lz)];
          const emite = BLOCO_INFO[b]?.emiteLuz || 0;
          if (emite > 0) {
            const i = Chunk.idx(lx, y, lz);
            chunk.light[i] = (chunk.light[i] & 0xF0) | (emite & 0x0F);
            queue.push(lx, y, lz, emite);
          }
        }
      }
    }
    let head = 0;
    while (head < queue.length) {
      const lx = queue[head++];
      const y  = queue[head++];
      const lz = queue[head++];
      const lvl = queue[head++];
      if (lvl <= 1) continue;
      const novo = lvl - 1;
      const cand = [
        [lx - 1, y, lz], [lx + 1, y, lz],
        [lx, y - 1, lz], [lx, y + 1, lz],
        [lx, y, lz - 1], [lx, y, lz + 1],
      ];
      for (let k = 0; k < 6; k++) {
        const vx = cand[k][0], vy = cand[k][1], vz = cand[k][2];
        if (vx < 0 || vx >= cs || vz < 0 || vz >= cs) continue;
        if (vy < 0 || vy >= WORLD_Y) continue;
        const i = Chunk.idx(vx, vy, vz);
        const bv = chunk.blocks[i];
        // Luz não passa por blocos sólidos.
        if (BLOCO_INFO[bv].solido) continue;
        const luzAtual = chunk.light[i] & 0x0F;
        if (luzAtual >= novo) continue;
        chunk.light[i] = (chunk.light[i] & 0xF0) | (novo & 0x0F);
        queue.push(vx, vy, vz, novo);
      }
    }
    chunk.luzDirty = false;
  }
  // Lê luz num voxel global. Retorna {sky, block} ambos 0-15.
  getLightAt(x, y, z) {
    if (y < 0 || y >= WORLD_Y) return { sky: 15, block: 0 };
    const cx = Math.floor(x / CHUNK_SIZE), cz = Math.floor(z / CHUNK_SIZE);
    const c = this.chunks.get(chunkKey(cx, cz));
    if (!c) return { sky: 15, block: 0 };
    if (c.luzDirty) this.recalcLuzChunk(c);
    const lx = ((x % CHUNK_SIZE) + CHUNK_SIZE) % CHUNK_SIZE;
    const lz = ((z % CHUNK_SIZE) + CHUNK_SIZE) % CHUNK_SIZE;
    return { sky: c.getLightSky(lx, y, lz), block: c.getLightBlock(lx, y, lz) };
  }
}
