// =====================================================================
// render.js — Renderer Three.js: atlas, mesh, sky, sol/lua, nuvens, mão
//
// Todos os blocos são OPACOS — não há mais path de mesh transparente.
// Mesh builder usa AO + iluminação 15 níveis (sky + block) para vertex
// colors. Sun intensity modula em tempo real via ambient/hemi/sol lights.
// =====================================================================

import * as THREE from 'three';
import {
  CHUNK_SIZE, WORLD_Y, BLOCO, BLOCO_INFO, VIEW_RADIUS, N_BLOCOS,
} from './constants.js';
import { AO_OFFSETS, vertexAOValor, uvCelula } from './utils.js';
import { corCeuComClima } from './weather.js';
import { state } from './state.js';

// === Atlas procedural ===
// Pinta texturas pixeladas 32×32 px num canvas único 8×4 células = 256×128.
// Retorna {texture, mapa} onde mapa[BLOCO.X] = {top, side, bottom} (índices).
function criarAtlas() {
  const COLS = 8, ROWS = 46, CELL = 32;
  const W = COLS * CELL, H = ROWS * CELL;
  const cnv = document.createElement('canvas');
  cnv.width = W; cnv.height = H;
  const ctx = cnv.getContext('2d');
  // Fundo magenta (debug — qualquer célula não pintada vira ofensiva)
  ctx.fillStyle = '#ff00ff'; ctx.fillRect(0, 0, W, H);

  // ============================================================
  // Stratified sampling: distribui pontos de cor SEM aglutinação.
  // Divide a área em sub-células `bucket` e sortia 1 ponto por
  // bucket com offset aleatório dentro dela. Resultado:
  // distribuição uniforme estilo Poisson disk (sem clusters
  // visíveis que aparecem com Math.random ou rng denso linear).
  // ============================================================
  function spawnPontosUniforme(x0, y0, w, h, cor, densidade = 0.5, bucket = 4, tamPonto = 1, seedInit = 1) {
    ctx.fillStyle = cor;
    let seed = seedInit | 0;
    for (let by = 0; by < h; by += bucket) {
      for (let bx = 0; bx < w; bx += bucket) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) >= densidade) continue;
        // Offset dentro do bucket (1 ponto por bucket)
        seed = (seed * 9301 + 49297) % 233280;
        const ox = seed % Math.max(1, bucket - tamPonto);
        seed = (seed * 9301 + 49297) % 233280;
        const oy = seed % Math.max(1, bucket - tamPonto);
        ctx.fillRect(x0 + bx + ox, y0 + by + oy, tamPonto, tamPonto);
      }
    }
    return seed;
  }

  // Pinta uma célula sólida com ruído distribuído uniformemente
  // (sem clusters de pontos pretos aglutinados — qualidade visual MC real).
  function pintar(idx, corBase, corRuido = null, intensidadeRuido = 0.45) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = corBase;
    ctx.fillRect(x0, y0, CELL, CELL);
    if (corRuido) {
      // Stratified: bucket 4×4 → max 64 pontos por célula 32×32, todos
      // bem espaçados. Tamanho 2 pra ainda ser visível pixel-art.
      spawnPontosUniforme(x0, y0, CELL, CELL, corRuido, intensidadeRuido, 4, 2, idx * 9301 + 49297);
    }
  }

  // Pinta padrão de tijolos: mortar cinza + tijolos vermelhos staggered + highlight.
  function pintarTijolo(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#7E7E7E'; ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#B05B36';
    for (let r = 0; r < 4; r++) {
      const offset = (r % 2) * 8;
      for (let c = 0; c < 4; c++) {
        ctx.fillRect(x0 + c * 8 + offset, y0 + r * 8 + 1, 7, 6);
      }
    }
    ctx.fillStyle = '#C77548';
    for (let r = 0; r < 4; r++) {
      const offset = (r % 2) * 8;
      for (let c = 0; c < 4; c++) {
        ctx.fillRect(x0 + c * 8 + offset, y0 + r * 8 + 1, 7, 1);
      }
    }
  }

  // Pedra com 3 tons + linhas de fissura sutis (cracks) pra parecer
  // pedra natural texturizada, não plástica.
  function pintarPedra(idx, base, dark, light, intensity = 0.30) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Stratified sampling: dark (sombras) e light (highlights) distribuídos
    // uniformemente sem aglutinação. Bucket 4×4 garante espaçamento.
    const seed1 = idx * 9301 + 49297;
    let seed = spawnPontosUniforme(x0, y0, CELL, CELL, dark,  intensity * 0.55, 4, 2, seed1);
    seed     = spawnPontosUniforme(x0, y0, CELL, CELL, light, intensity * 0.55, 4, 2, seed + 7919);
    // Cracks: 2-3 linhas finas escuras zigue-zague (fissuras naturais)
    ctx.fillStyle = dark;
    for (let i = 0; i < 2; i++) {
      seed = (seed * 9301 + 49297) % 233280;
      let cx = (seed % CELL);
      seed = (seed * 9301 + 49297) % 233280;
      let cy = (seed % CELL);
      const len = 6 + (seed % 8);
      for (let j = 0; j < len; j++) {
        if (cx >= 0 && cx < CELL && cy >= 0 && cy < CELL) {
          ctx.fillRect(x0 + cx, y0 + cy, 1, 1);
        }
        seed = (seed * 9301 + 49297) % 233280;
        const dir = seed % 4;
        if (dir === 0) cx++;
        else if (dir === 1) cy++;
        else if (dir === 2) { cx++; cy++; }
        else { cx--; cy++; }
      }
    }
  }

  // Minério: pedra base + manchas/clusters do veio (paridade Minecraft).
  // Carvão usa veio escuro, ferro tan, ouro amarelo, diamante ciano.
  function pintarMinerio(idx, corVeio, corVeioBrilho) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base de pedra
    ctx.fillStyle = '#7E7E7E';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#6E6E6E';
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.25) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    // 3-5 clusters de veio
    let s = idx * 7919 + 1234;
    const clusters = 3 + (s % 3);
    for (let c = 0; c < clusters; c++) {
      s = (s * 9301 + 49297) % 233280;
      const cx = (s % 22) + 4;
      s = (s * 9301 + 49297) % 233280;
      const cy = (s % 22) + 4;
      s = (s * 9301 + 49297) % 233280;
      const tam = 4 + (s % 3);
      ctx.fillStyle = corVeio;
      ctx.fillRect(x0 + cx, y0 + cy, tam, tam);
      ctx.fillStyle = corVeioBrilho;
      ctx.fillRect(x0 + cx + 1, y0 + cy + 1, Math.max(1, tam - 2), Math.max(1, tam - 2));
      // Chips em volta
      for (let i = 0; i < 2; i++) {
        s = (s * 9301 + 49297) % 233280;
        const ox = cx + ((s % 6) - 3);
        s = (s * 9301 + 49297) % 233280;
        const oy = cy + ((s % 6) - 3);
        if (ox >= 0 && ox < CELL - 2 && oy >= 0 && oy < CELL - 2) {
          ctx.fillStyle = corVeio;
          ctx.fillRect(x0 + ox, y0 + oy, 2, 2);
        }
      }
    }
  }

  // Grama topo: 4 tons de verde clusterizados + ocasionais "flores"
  // (pixel amarelo/branco sub-pixel) pra dar variação visual rica.
  function pintarGramaTopo(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base verde médio
    ctx.fillStyle = '#5DAB54';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Clusters de verde-claro (ilhas brilhantes)
    let seed = idx * 9301 + 49297;
    const tons = ['#6FBE61', '#3D8C32', '#7BC971', '#458F39'];
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        const r = seed / 233280;
        if (r < 0.35) {
          const tom = tons[Math.floor(r * 4) % 4];
          ctx.fillStyle = tom;
          ctx.fillRect(x0 + px, y0 + py, 2, 2);
        }
      }
    }
    // Flores ocasionais (1-2 por célula): amarelo ou branco
    for (let i = 0; i < 2; i++) {
      seed = (seed * 9301 + 49297) % 233280;
      if ((seed / 233280) < 0.4) {
        seed = (seed * 9301 + 49297) % 233280;
        const fx = (seed % (CELL - 4)) + 1;
        seed = (seed * 9301 + 49297) % 233280;
        const fy = (seed % (CELL - 4)) + 1;
        ctx.fillStyle = i === 0 ? '#FFEB3B' : '#FAFAFA';
        ctx.fillRect(x0 + fx, y0 + fy, 1, 1);
        ctx.fillStyle = '#5DAB54';
        ctx.fillRect(x0 + fx + 1, y0 + fy + 1, 1, 1); // sombra
      }
    }
    // Pontos escuros esparsos (grama densa)
    ctx.fillStyle = '#2E5520';
    for (let py = 0; py < CELL; py += 4) {
      for (let px = 0; px < CELL; px += 4) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.12) ctx.fillRect(x0 + px, y0 + py, 1, 1);
      }
    }
  }

  // Diamante: cristais ciano com sparkles brilhantes (não só manchas)
  function pintarDiamante(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base de pedra
    ctx.fillStyle = '#7E7E7E';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#6E6E6E';
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.25) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    // 4-5 cristais de diamante (formato losango)
    let s = idx * 7919 + 1234;
    const ncristais = 4 + (s % 2);
    for (let c = 0; c < ncristais; c++) {
      s = (s * 9301 + 49297) % 233280;
      const cx = (s % 22) + 5;
      s = (s * 9301 + 49297) % 233280;
      const cy = (s % 22) + 5;
      // Losango ciano (3×3 com cantos cortados)
      ctx.fillStyle = '#3FBFC2';
      ctx.fillRect(x0 + cx - 1, y0 + cy, 3, 1);     // linha h
      ctx.fillRect(x0 + cx, y0 + cy - 1, 1, 3);     // linha v
      ctx.fillStyle = '#7DDDE0';
      ctx.fillRect(x0 + cx, y0 + cy, 1, 1);         // centro brilhante
      // Sparkle aleatório
      s = (s * 9301 + 49297) % 233280;
      if ((s % 4) === 0) {
        ctx.fillStyle = '#ffffff';
        ctx.fillRect(x0 + cx - 1, y0 + cy - 1, 1, 1); // sparkle canto
      }
    }
  }

  // Ouro: clusters dourados maiores com brilho metálico
  function pintarOuro(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#7E7E7E';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#6E6E6E';
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.25) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    // 3 clusters dourados grandes
    let s = idx * 7919 + 1234;
    for (let c = 0; c < 3; c++) {
      s = (s * 9301 + 49297) % 233280;
      const cx = (s % 20) + 6;
      s = (s * 9301 + 49297) % 233280;
      const cy = (s % 20) + 6;
      // Cluster 4×4 dourado
      ctx.fillStyle = '#D4A017';
      ctx.fillRect(x0 + cx, y0 + cy, 4, 4);
      // Highlight superior
      ctx.fillStyle = '#FFE680';
      ctx.fillRect(x0 + cx + 1, y0 + cy + 1, 2, 1);
      // Sombra inferior
      ctx.fillStyle = '#9C7A0A';
      ctx.fillRect(x0 + cx, y0 + cy + 3, 4, 1);
      // Highlight diagonal
      ctx.fillStyle = '#FFF59D';
      ctx.fillRect(x0 + cx + 1, y0 + cy + 1, 1, 1);
    }
  }

  // Carvão: pedra base + clusters pretos angulares com brilho médio
  function pintarCarvao(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#7E7E7E';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#6E6E6E';
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.25) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    // 4 clusters pretos angulares (formato L)
    let s = idx * 7919 + 1234;
    for (let c = 0; c < 4; c++) {
      s = (s * 9301 + 49297) % 233280;
      const cx = (s % 22) + 4;
      s = (s * 9301 + 49297) % 233280;
      const cy = (s % 22) + 4;
      ctx.fillStyle = '#1a1a1a';
      ctx.fillRect(x0 + cx, y0 + cy, 4, 3);     // bloco h
      ctx.fillRect(x0 + cx, y0 + cy + 3, 2, 2); // bloco v (formato L)
      // Highlight interno cinza-escuro (reflexo)
      ctx.fillStyle = '#3a3a3a';
      ctx.fillRect(x0 + cx + 1, y0 + cy + 1, 2, 1);
      // Borda pixel mais escura ainda
      ctx.fillStyle = '#000000';
      ctx.fillRect(x0 + cx, y0 + cy, 1, 1);
    }
  }

  // Ferro: pedra base + clusters tan/laranja com oxidação visível
  function pintarFerro(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#7E7E7E';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#6E6E6E';
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.25) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    // 3-4 clusters tan/laranja (ferro oxidado)
    let s = idx * 7919 + 1234;
    const n = 3 + (s % 2);
    for (let c = 0; c < n; c++) {
      s = (s * 9301 + 49297) % 233280;
      const cx = (s % 22) + 4;
      s = (s * 9301 + 49297) % 233280;
      const cy = (s % 22) + 4;
      // Cluster 4×3 tan
      ctx.fillStyle = '#C5A28A';
      ctx.fillRect(x0 + cx, y0 + cy, 4, 3);
      // Highlight superior (mais claro)
      ctx.fillStyle = '#E0C09F';
      ctx.fillRect(x0 + cx + 1, y0 + cy, 2, 1);
      // Streak de oxidação (vermelho-marrom inferior)
      ctx.fillStyle = '#8B5A2B';
      ctx.fillRect(x0 + cx, y0 + cy + 2, 4, 1);
      // Pixel laranja brilhante (lustro)
      s = (s * 9301 + 49297) % 233280;
      if ((s % 3) === 0) {
        ctx.fillStyle = '#FF9800';
        ctx.fillRect(x0 + cx + 1, y0 + cy + 1, 1, 1);
      }
    }
  }

  // Areia: dunas + grãos visíveis (dois tons + pontos brilhantes)
  function pintarAreia(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base bege médio
    ctx.fillStyle = '#DBC380';
    ctx.fillRect(x0, y0, CELL, CELL);
    let seed = idx * 9301 + 49297;
    // Camadas de dunas (linhas onduladas claras + escuras)
    for (let py = 0; py < CELL; py += 3) {
      seed = (seed * 9301 + 49297) % 233280;
      const offset = (seed % 4) - 2;
      ctx.fillStyle = '#C7AF6B';
      for (let px = 0; px < CELL; px++) {
        const wave = Math.sin((px + offset) * 0.4) > 0 ? 1 : 0;
        if (wave) ctx.fillRect(x0 + px, y0 + py, 1, 1);
      }
    }
    // Grãos uniformemente distribuídos (sem clusters)
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#FFEFA0', 0.40, 3, 1, seed + 4421);
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#A5904A', 0.55, 3, 1, seed + 7331);
  }

  // Madeira topo: anéis concêntricos de log (paridade Minecraft oak).
  function pintarMadeiraTopo(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#9E7C5C';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.strokeStyle = '#6E5235';
    ctx.lineWidth = 1;
    for (let r = 4; r < 16; r += 4) {
      ctx.beginPath();
      ctx.arc(x0 + 16, y0 + 16, r, 0, Math.PI * 2);
      ctx.stroke();
    }
    ctx.fillStyle = '#4D3A24';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
  }

  // Madeira lateral: bark com grain VERTICAL realista — múltiplas
  // camadas de variação, knots ocasionais, highlight superior.
  function pintarMadeiraLado(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base
    ctx.fillStyle = '#6E5235';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Linhas verticais escuras (bark grain principal)
    ctx.fillStyle = '#4D3A24';
    for (let px = 2; px < CELL; px += 4) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
    // Linhas verticais claras intercaladas (highlight)
    ctx.fillStyle = '#9E7C5C';
    for (let px = 4; px < CELL; px += 6) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
    // Variação tonal em pequenos blocos (grain irregular)
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        const r = seed / 233280;
        if (r < 0.10)       ctx.fillStyle = '#3D2A18'; // sombra profunda
        else if (r < 0.20)  ctx.fillStyle = '#7A5C3A'; // tom médio
        else                continue;
        ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    // 1 knot (nó da madeira) — círculo escuro com centro mais escuro
    seed = (seed * 9301 + 49297) % 233280;
    const knotX = (seed % (CELL - 8)) + 4;
    seed = (seed * 9301 + 49297) % 233280;
    const knotY = (seed % (CELL - 8)) + 4;
    ctx.fillStyle = '#3D2A18';
    ctx.fillRect(x0 + knotX, y0 + knotY, 4, 3);
    ctx.fillRect(x0 + knotX + 1, y0 + knotY - 1, 2, 1);
    ctx.fillRect(x0 + knotX + 1, y0 + knotY + 3, 2, 1);
    ctx.fillStyle = '#1F1308';
    ctx.fillRect(x0 + knotX + 1, y0 + knotY + 1, 2, 1);
  }

  // Folhas: verde escuro com chaos de tons (paridade oak leaves).
  function pintarFolha(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#3F7029';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#5C9B45';
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.30) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    ctx.fillStyle = '#2E5520';
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.20) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
  }

  // Vidro: claro com moldura escura (frame).
  function pintarVidro(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#D6F0FF';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#FFFFFF';
    for (let i = 0; i < CELL; i += 2) {
      if ((i % 8) < 2) ctx.fillRect(x0 + i, y0 + i, 1, 1);
    }
    ctx.fillStyle = '#7AB8D9';
    ctx.fillRect(x0, y0, CELL, 2);
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0, y0, 2, CELL);
    ctx.fillRect(x0 + CELL - 2, y0, 2, CELL);
  }

  // Cacto: verde com cannelura vertical + bordas escuras + espinhos.
  function pintarCacto(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#37782D';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#4DA03B';
    ctx.fillRect(x0 + 4,  y0, 1, CELL);
    ctx.fillRect(x0 + 12, y0, 1, CELL);
    ctx.fillRect(x0 + 20, y0, 1, CELL);
    ctx.fillRect(x0 + 28, y0, 1, CELL);
    ctx.fillStyle = '#E8C39E';
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 4) {
      seed = (seed * 9301 + 49297) % 233280;
      const positions = [4, 12, 20, 28];
      const x = positions[seed % 4];
      ctx.fillRect(x0 + x, y0 + py + 1, 1, 1);
    }
    ctx.fillStyle = '#2E5E26';
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Água: azul com ondas horizontais.
  function pintarAgua(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#2C8FCF';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#1B6EA8';
    for (let py = 2; py < CELL; py += 4) {
      ctx.fillRect(x0, y0 + py, CELL, 1);
    }
    ctx.fillStyle = '#7AC0E5';
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.10) ctx.fillRect(x0 + px, y0 + py, 1, 1);
      }
    }
  }

  // Lava: laranja-amarelo caótico com bolhas brilhantes.
  function pintarLava(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#D44515';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#FFA830';
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.30) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    ctx.fillStyle = '#FFEB47';
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.10) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
  }

  // Obsidiana: muito escuro com toques violeta (paridade MC).
  function pintarObsidiana(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1A1126';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#3D2950';
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.30) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    ctx.fillStyle = '#0E0815';
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.20) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
  }

  // Glowstone (luz): amarelo brilhante com células granuladas.
  function pintarGlowstone(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#E8B547';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#FFE680';
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.25) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    ctx.fillStyle = '#A07A28';
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.10) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
  }

  // Lã: branco com leve granulação cinza.
  function pintarLa(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#F0F0F0';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#E0E0E0';
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.20) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
  }

  // Tocha: pau marrom centrado com chama no topo.
  function pintarTocha(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#2A1F12';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#9C7848';
    ctx.fillRect(x0 + 14, y0 + 12, 4, 16);
    ctx.fillStyle = '#6E5232';
    ctx.fillRect(x0 + 14, y0 + 14, 1, 14);
    ctx.fillRect(x0 + 17, y0 + 14, 1, 14);
    ctx.fillStyle = '#FFCB47';
    ctx.fillRect(x0 + 13, y0 + 6, 6, 6);
    ctx.fillStyle = '#FF8A2A';
    ctx.fillRect(x0 + 14, y0 + 4, 4, 6);
    ctx.fillStyle = '#FFEB80';
    ctx.fillRect(x0 + 15, y0 + 8, 2, 4);
  }

  // Baú: planks de madeira com dobradiças metálicas e fechadura dourada.
  function pintarBau(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#A07242';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#7C5630';
    ctx.fillRect(x0, y0 + 12, CELL, 1);
    ctx.fillRect(x0 + 8, y0, 1, CELL);
    ctx.fillRect(x0 + 24, y0, 1, CELL);
    ctx.fillStyle = '#3A3A3A';
    ctx.fillRect(x0 + 4,  y0 + 2, 4, 6);
    ctx.fillRect(x0 + 24, y0 + 2, 4, 6);
    ctx.fillRect(x0 + 14, y0 + 13, 4, 6);
    ctx.fillStyle = '#FFD54F';
    ctx.fillRect(x0 + 15, y0 + 14, 2, 2);
    ctx.fillStyle = '#7C5630';
    let seed = idx * 9301 + 49297;
    for (let py = 14; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        if (px === 8 || px === 24) continue;
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.10) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
  }

  // Fornalha: pedra com abertura preta + brasa laranja.
  function pintarFornalha(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#6E6E6E';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#5E5E5E';
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.30) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0 + 8, y0 + 14, 16, 14);
    ctx.fillStyle = '#FF6F00';
    ctx.fillRect(x0 + 10, y0 + 24, 12, 4);
    ctx.fillStyle = '#FFAB40';
    ctx.fillRect(x0 + 12, y0 + 25, 8, 2);
    ctx.fillStyle = '#909090';
    ctx.fillRect(x0 + 7, y0 + 13, 18, 1);
    ctx.fillRect(x0 + 7, y0 + 13, 1, 16);
    ctx.fillRect(x0 + 24, y0 + 13, 1, 16);
  }

  // Cama: travesseiro branco no topo, manta vermelha, frame de madeira.
  function pintarCama(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#D32F2F';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#F0F0F0';
    ctx.fillRect(x0 + 4, y0 + 4, 24, 8);
    ctx.fillStyle = '#D0D0D0';
    ctx.fillRect(x0 + 4, y0 + 11, 24, 1);
    ctx.fillStyle = '#6E4F2E';
    ctx.fillRect(x0,             y0,             2, CELL);
    ctx.fillRect(x0 + CELL - 2,  y0,             2, CELL);
    ctx.fillRect(x0,             y0 + CELL - 4, CELL, 4);
    ctx.fillStyle = '#A02525';
    let seed = idx * 9301 + 49297;
    for (let py = 14; py < CELL - 4; py += 2) {
      for (let px = 2; px < CELL - 2; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.15) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
  }

  // Workbench topo: grid 3x3 de crafting.
  function pintarWorkbenchTopo(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#8B5E2F';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#5D3F1E';
    ctx.fillRect(x0 + 10, y0,      1, CELL);
    ctx.fillRect(x0 + 21, y0,      1, CELL);
    ctx.fillRect(x0,      y0 + 10, CELL, 1);
    ctx.fillRect(x0,      y0 + 21, CELL, 1);
    ctx.fillStyle = '#4A3018';
    ctx.fillRect(x0,            y0,            CELL, 2);
    ctx.fillRect(x0,            y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0,            y0,            2, CELL);
    ctx.fillRect(x0 + CELL - 2, y0,            2, CELL);
  }

  // Workbench lado: planks com serra estilizada no centro.
  function pintarWorkbenchLado(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#8B5E2F';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#5D3F1E';
    ctx.fillRect(x0, y0 + 10, CELL, 1);
    ctx.fillRect(x0, y0 + 21, CELL, 1);
    // Serra (corpo cinza)
    ctx.fillStyle = '#B0BEC5';
    ctx.fillRect(x0 + 10, y0 + 14, 16, 4);
    // Cabo da serra
    ctx.fillStyle = '#4A3018';
    ctx.fillRect(x0 + 6, y0 + 14, 4, 4);
  }

  // Bedrock: chunky 4-pixel blocks com pattern escuro caótico.
  function pintarBedrock(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#525252';
    ctx.fillRect(x0, y0, CELL, CELL);
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 4) {
      for (let px = 0; px < CELL; px += 4) {
        seed = (seed * 9301 + 49297) % 233280;
        const r = seed / 233280;
        let cor = null;
        if (r < 0.30)      cor = '#3a3a3a';
        else if (r < 0.55) cor = '#666666';
        if (cor) {
          ctx.fillStyle = cor;
          ctx.fillRect(x0 + px, y0 + py, 4, 4);
        }
      }
    }
    ctx.fillStyle = '#2a2a2a';
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.10) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
  }

  // Pumpkin: laranja com ridges + talo verde no topo (cell 34) OU
  // face jack-o-lantern (cell 35 — talhada).
  function pintarPumpkin(idx, talhada) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#e65100';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Ridges verticais (relevo da abóbora)
    ctx.fillStyle = '#bf360c';
    for (let px = 4; px < CELL; px += 8) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
    ctx.fillStyle = '#ff9800';
    for (let px = 1; px < CELL; px += 8) {
      ctx.fillRect(x0 + px, y0, 2, CELL);
    }
    if (talhada) {
      // Face jack-o-lantern: 2 olhos triangulares + boca dentada
      ctx.fillStyle = '#fff59d'; // luz interna amarela
      // Olho esquerdo
      ctx.fillRect(x0 + 6, y0 + 10, 5, 4);
      ctx.fillRect(x0 + 7, y0 + 9, 3, 1);
      // Olho direito
      ctx.fillRect(x0 + 21, y0 + 10, 5, 4);
      ctx.fillRect(x0 + 22, y0 + 9, 3, 1);
      // Boca dentada
      ctx.fillRect(x0 + 8, y0 + 20, 16, 4);
      ctx.fillStyle = '#e65100';
      ctx.fillRect(x0 + 11, y0 + 20, 1, 2); // dente 1
      ctx.fillRect(x0 + 14, y0 + 20, 1, 2); // dente 2
      ctx.fillRect(x0 + 17, y0 + 20, 1, 2); // dente 3
      ctx.fillRect(x0 + 20, y0 + 20, 1, 2); // dente 4
    } else {
      // Topo: talo verde
      ctx.fillStyle = '#4caf50';
      ctx.fillRect(x0 + 14, y0 + 12, 4, 8);
      ctx.fillStyle = '#388e3c';
      ctx.fillRect(x0 + 13, y0 + 14, 1, 4);
      ctx.fillRect(x0 + 18, y0 + 14, 1, 4);
    }
  }
  // Bolo: topo creme com cereja vermelha + decoração
  function pintarBoloTopo(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base creme (cobertura)
    ctx.fillStyle = '#fff8e1';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Borda dourada (massa do bolo aparecendo)
    ctx.fillStyle = '#d4a574';
    ctx.fillRect(x0, y0, CELL, 2);
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0, y0, 2, CELL);
    ctx.fillRect(x0 + CELL - 2, y0, 2, CELL);
    // Glacê branco
    ctx.fillStyle = '#ffffff';
    let seed = idx * 9301 + 49297;
    for (let py = 4; py < CELL - 4; py += 3) {
      for (let px = 4; px < CELL - 4; px += 3) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.45) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    // Cereja no centro
    ctx.fillStyle = '#c62828';
    ctx.fillRect(x0 + 13, y0 + 13, 6, 6);
    ctx.fillStyle = '#e53935';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#ff8a80';
    ctx.fillRect(x0 + 14, y0 + 14, 2, 2);
    // Talo verde da cereja
    ctx.fillStyle = '#2e7d32';
    ctx.fillRect(x0 + 16, y0 + 11, 1, 3);
  }
  // Bolo lado: 1/3 creme em cima + 2/3 massa marrom (camadas)
  function pintarBoloLado(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base massa marrom
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Pontos de chocolate/textura
    ctx.fillStyle = '#5d4037';
    let seed = idx * 9301 + 49297;
    for (let py = 10; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.20) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    // Recheio rosa (camada do meio)
    ctx.fillStyle = '#f8bbd0';
    ctx.fillRect(x0, y0 + 18, CELL, 3);
    ctx.fillStyle = '#f48fb1';
    ctx.fillRect(x0, y0 + 19, CELL, 1);
    // Cobertura creme em cima (8px)
    ctx.fillStyle = '#fff8e1';
    ctx.fillRect(x0, y0, CELL, 9);
    // Drips brancos descendo (efeito glace pingando)
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 4,  y0 + 9, 2, 2);
    ctx.fillRect(x0 + 12, y0 + 9, 1, 4);
    ctx.fillRect(x0 + 20, y0 + 9, 2, 3);
    ctx.fillRect(x0 + 27, y0 + 9, 1, 2);
    // Borda escura no topo
    ctx.fillStyle = '#d4a574';
    ctx.fillRect(x0, y0 + 8, CELL, 1);
  }
  // Bigorna: preto metálico com riscos verticais (estilo MC anvil)
  function pintarBigornaTopo(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base cinza escuro
    ctx.fillStyle = '#3a3a3a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Borda preta espessa (forma da bigorna no topo)
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0 + 4, y0 + 6, CELL - 8, CELL - 12);
    // Plataforma de trabalho (mais clara, brilho de aço)
    ctx.fillStyle = '#5a5a5a';
    ctx.fillRect(x0 + 8, y0 + 10, CELL - 16, CELL - 20);
    // Riscos brancos (highlight de aço)
    ctx.fillStyle = '#888888';
    ctx.fillRect(x0 + 9,  y0 + 11, CELL - 18, 1);
    ctx.fillRect(x0 + 9,  y0 + 13, 4, 1);
    ctx.fillRect(x0 + 19, y0 + 13, 4, 1);
    // Marcas de uso (riscos diagonais)
    ctx.fillStyle = '#202020';
    ctx.fillRect(x0 + 12, y0 + 16, 8, 1);
    ctx.fillRect(x0 + 14, y0 + 18, 4, 1);
  }
  function pintarBigornaLado(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Forma de bigorna: base larga embaixo + cintura estreita + topo médio
    ctx.fillStyle = '#3a3a3a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Base (parte de baixo, ampla)
    ctx.fillStyle = '#2a2a2a';
    ctx.fillRect(x0 + 2, y0 + 22, CELL - 4, 8);
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0,     y0 + 28, CELL,    4);
    // Cintura (meio fino)
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0 + 10, y0 + 14, CELL - 20, 8);
    // Topo (yunque estendido)
    ctx.fillStyle = '#2a2a2a';
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, 10);
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0 + 2, y0,     CELL - 4, 4);
    // Highlights laterais (aço polido)
    ctx.fillStyle = '#666666';
    ctx.fillRect(x0 + 5, y0 + 5, 1, 8);
    ctx.fillRect(x0 + 4, y0 + 23, 2, 5);
  }
  // Colmeia topo: padrão hexagonal de mel (favo) com gotas douradas
  function pintarColmeiaTopo(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base bege da madeira de cobre
    ctx.fillStyle = '#a1887f';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão hexagonal central (favo) — 9 hexágonos pequenos
    ctx.fillStyle = '#fdd835';
    const hexSize = 8;
    for (let row2 = 0; row2 < 3; row2++) {
      for (let col2 = 0; col2 < 3; col2++) {
        const cx = 6 + col2 * 9;
        const cy = 6 + row2 * 8 + (col2 % 2 === 1 ? 4 : 0);
        if (cx + hexSize < CELL && cy + hexSize < CELL) {
          ctx.fillRect(x0 + cx, y0 + cy, hexSize, hexSize - 2);
          ctx.fillRect(x0 + cx + 1, y0 + cy + hexSize - 2, hexSize - 2, 1);
        }
      }
    }
    // Gotas escuras nos hexágonos (mel mais escuro = bordas)
    ctx.fillStyle = '#f57f17';
    for (let row2 = 0; row2 < 3; row2++) {
      for (let col2 = 0; col2 < 3; col2++) {
        const cx = 6 + col2 * 9;
        const cy = 6 + row2 * 8 + (col2 % 2 === 1 ? 4 : 0);
        if (cx + 4 < CELL && cy + 4 < CELL) {
          ctx.fillRect(x0 + cx + 2, y0 + cy + 2, 2, 2);
        }
      }
    }
    // Borda escura
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0, y0, CELL, 2);
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0, y0, 2, CELL);
    ctx.fillRect(x0 + CELL - 2, y0, 2, CELL);
  }
  // Colmeia lateral: madeira marrom + entrada hexagonal central + tábuas
  function pintarColmeiaLado(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base madeira clara
    ctx.fillStyle = '#a1887f';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Listras horizontais (tábuas)
    ctx.fillStyle = '#8d6e63';
    for (let py = 5; py < CELL; py += 7) {
      ctx.fillRect(x0, y0 + py, CELL, 1);
    }
    // Grão da madeira (linhas verticais sutis)
    ctx.fillStyle = '#7a5b50';
    for (let px = 6; px < CELL; px += 9) {
      ctx.fillRect(x0 + px, y0 + 4, 1, CELL - 8);
    }
    // Entrada hexagonal escura (porta da colmeia)
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0 + 12, y0 + 18, 8, 8);
    ctx.fillStyle = '#1a0f0a';
    ctx.fillRect(x0 + 13, y0 + 19, 6, 6);
    // Mel pingando da entrada (gota dourada)
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 14, y0 + 25, 2, 2);
    ctx.fillRect(x0 + 17, y0 + 26, 2, 1);
    // Borda
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0, y0, CELL, 2);
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0, y0, 2, CELL);
    ctx.fillRect(x0 + CELL - 2, y0, 2, CELL);
  }

  // Melancia: verde escuro com padrão de listras + sementes
  function pintarMelancia(idx, dourada) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    if (dourada) {
      // Melancia dourada: amarelo brilhante
      ctx.fillStyle = '#fdd835';
      ctx.fillRect(x0, y0, CELL, CELL);
      ctx.fillStyle = '#ffeb3b';
      for (let py = 4; py < CELL; py += 7) {
        ctx.fillRect(x0, y0 + py, CELL, 2);
      }
      // Sementes douradas brilhantes
      ctx.fillStyle = '#fff176';
      spawnPontosUniforme(x0, y0, CELL, CELL, '#fff176', 0.30, 5, 2, idx * 9301 + 49297);
      ctx.fillStyle = '#ffffff';
      spawnPontosUniforme(x0, y0, CELL, CELL, '#ffffff', 0.20, 7, 1, idx * 9301 + 7331);
    } else {
      // Melancia normal: verde com listras
      ctx.fillStyle = '#388e3c';
      ctx.fillRect(x0, y0, CELL, CELL);
      // Listras verticais escuras (verde escuro)
      ctx.fillStyle = '#1b5e20';
      for (let px = 4; px < CELL; px += 4) {
        ctx.fillRect(x0 + px, y0, 2, CELL);
      }
      // Listras claras (verde claro)
      ctx.fillStyle = '#66bb6a';
      for (let px = 6; px < CELL; px += 4) {
        ctx.fillRect(x0 + px, y0, 1, CELL);
      }
      // Sementes pretas no centro (3x3)
      ctx.fillStyle = '#000000';
      ctx.fillRect(x0 + 12, y0 + 8,  2, 1);
      ctx.fillRect(x0 + 18, y0 + 12, 2, 1);
      ctx.fillRect(x0 + 14, y0 + 16, 2, 1);
      ctx.fillRect(x0 + 20, y0 + 20, 2, 1);
      ctx.fillRect(x0 + 10, y0 + 24, 2, 1);
    }
  }

  // Abacaxi: amarelo com padrão diamante + folhas verdes em cima
  function pintarAbacaxi(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base amarela
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão diamante (escamas do abacaxi)
    ctx.fillStyle = '#a1887f';
    for (let py = 4; py < CELL - 4; py += 6) {
      for (let px = 4; px < CELL - 4; px += 6) {
        const off = (py / 6) % 2 === 0 ? 0 : 3;
        ctx.fillRect(x0 + px + off, y0 + py, 3, 1);
        ctx.fillRect(x0 + px + off, y0 + py + 1, 3, 1);
      }
    }
    // Highlights amarelos
    ctx.fillStyle = '#fff176';
    spawnPontosUniforme(x0, y0, CELL, CELL, '#fff176', 0.25, 5, 1, idx * 9301 + 49297);
    // Coroa de folhas verdes em cima
    ctx.fillStyle = '#2e7d32';
    ctx.fillRect(x0 + 12, y0 + 1, 8, 4);
    ctx.fillStyle = '#1b5e20';
    for (const sx of [-1, 1]) {
      ctx.fillRect(x0 + 16 + sx * 5, y0 + 1, 1, 4);
    }
    ctx.fillStyle = '#66bb6a';
    ctx.fillRect(x0 + 14, y0 + 2, 2, 2);
    ctx.fillRect(x0 + 17, y0 + 2, 2, 2);
  }

  // Pedra Esculpida (chiseled): cor base + padrão geométrico central
  function pintarChiseled(idx, base, escuro, claro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão central elevado (estilo "pillar" chiseled)
    ctx.fillStyle = escuro;
    // Borda externa do padrão
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, 1);
    ctx.fillRect(x0 + 4, y0 + CELL - 5, CELL - 8, 1);
    ctx.fillRect(x0 + 4, y0 + 4, 1, CELL - 8);
    ctx.fillRect(x0 + CELL - 5, y0 + 4, 1, CELL - 8);
    // Inner box
    ctx.fillRect(x0 + 6, y0 + 6, CELL - 12, 1);
    ctx.fillRect(x0 + 6, y0 + CELL - 7, CELL - 12, 1);
    // Pilares verticais (3 colunas)
    ctx.fillRect(x0 + 10, y0 + 7, 1, CELL - 14);
    ctx.fillRect(x0 + 15, y0 + 7, 1, CELL - 14);
    ctx.fillRect(x0 + CELL - 11, y0 + 7, 1, CELL - 14);
    // Highlights claros
    ctx.fillStyle = claro;
    ctx.fillRect(x0 + 5, y0 + 5, 1, CELL - 10);
    ctx.fillRect(x0 + 5, y0 + 5, CELL - 10, 1);
    // Centro decorativo
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + CELL/2 - 1, y0 + CELL/2 - 1, 2, 2);
  }

  // Hyphae (caule sem casca): grão em todas as direções (texture vertical+horizontal)
  function pintarHyphae(idx, base, escuro, claro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão circular interno (corte transversal do caule)
    ctx.fillStyle = escuro;
    // Anéis concêntricos
    for (let r = 4; r < 16; r += 4) {
      ctx.fillRect(x0 + 16 - r, y0 + 16 - r, r * 2, 1);
      ctx.fillRect(x0 + 16 - r, y0 + 16 + r - 1, r * 2, 1);
      ctx.fillRect(x0 + 16 - r, y0 + 16 - r, 1, r * 2);
      ctx.fillRect(x0 + 16 + r - 1, y0 + 16 - r, 1, r * 2);
    }
    // Centro claro (medula)
    ctx.fillStyle = claro;
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
    // Manchas escuras pseudo-aleatórias
    spawnPontosUniforme(x0, y0, CELL, CELL, escuro, 0.20, 6, 1, idx * 9301 + 49297);
  }

  // Froglight: cilindro brilhante interior + 4 nodos colorid + ranhuras
  function pintarFroglight(idx, base, claro, brilho) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Listras horizontais escuras (segmentos do cilindro)
    ctx.fillStyle = claro;
    for (let py = 4; py < CELL; py += 7) {
      ctx.fillRect(x0, y0 + py, CELL, 1);
    }
    // Núcleo brilhante central
    ctx.fillStyle = brilho;
    ctx.fillRect(x0 + 8, y0 + 8, 16, 16);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#fffde7';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    // 4 pontos brilhantes nos cantos
    ctx.fillStyle = brilho;
    for (const [cx, cy] of [[3, 3], [CELL-4, 3], [3, CELL-4], [CELL-4, CELL-4]]) {
      ctx.fillRect(x0 + cx, y0 + cy, 2, 2);
    }
    // Borda escura sutil
    ctx.fillStyle = claro;
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Bone Block: branco com listras horizontais e padrão de osso
  function pintarBoneBlock(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#eceff1';
    ctx.fillRect(x0, y0, CELL, CELL);
    // 3 listras horizontais (segmentos do osso)
    ctx.fillStyle = '#bdbdbd';
    ctx.fillRect(x0, y0 + 8,  CELL, 2);
    ctx.fillRect(x0, y0 + 16, CELL, 2);
    ctx.fillRect(x0, y0 + 24, CELL, 2);
    // Listras verticais finas (textura óssea)
    ctx.fillStyle = '#9e9e9e';
    for (let px = 4; px < CELL; px += 6) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
    // Manchas escuras (poros do osso)
    spawnPontosUniforme(x0, y0, CELL, CELL, '#757575', 0.20, 5, 1, idx * 9301 + 49297);
    // Borda escura
    ctx.fillStyle = '#757575';
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
  }

  // Rooted Dirt: marrom com raízes finas escuras espalhadas
  function pintarRootedDirt(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Ruído de terra
    let seed = idx * 9301 + 49297;
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#5d4037', 0.40, 4, 2, seed);
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#a1887f', 0.30, 5, 1, seed + 4441);
    // Raízes (linhas curvas escuras)
    ctx.fillStyle = '#3e2723';
    // Raiz 1 (zigzag horizontal)
    ctx.fillRect(x0 + 4,  y0 + 8,  3, 1);
    ctx.fillRect(x0 + 6,  y0 + 9,  3, 1);
    ctx.fillRect(x0 + 8,  y0 + 10, 3, 1);
    // Raiz 2 (zigzag diagonal)
    ctx.fillRect(x0 + 18, y0 + 4,  3, 1);
    ctx.fillRect(x0 + 20, y0 + 5,  3, 1);
    ctx.fillRect(x0 + 22, y0 + 7,  3, 1);
    // Raiz 3 (vertical fina)
    ctx.fillRect(x0 + 12, y0 + 18, 1, 8);
    ctx.fillRect(x0 + 13, y0 + 25, 2, 1);
    // Raiz 4 (mais à direita)
    ctx.fillRect(x0 + 24, y0 + 16, 1, 6);
    ctx.fillRect(x0 + 25, y0 + 22, 2, 1);
    // Pontos brancos (fungos/sementes)
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#fafafa', 0.10, 8, 1, seed + 7331);
  }

  // Glazed Terracota: cor vibrante com padrão geométrico (paridade MC)
  function pintarGlazed(idx, base, claro, escuro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão central diamante (X)
    ctx.fillStyle = claro;
    ctx.fillRect(x0 + 6, y0 + 6, 20, 4);
    ctx.fillRect(x0 + 6, y0 + CELL - 10, 20, 4);
    ctx.fillRect(x0 + 6, y0 + 6, 4, 20);
    ctx.fillRect(x0 + CELL - 10, y0 + 6, 4, 20);
    // Centro grande contrastante
    ctx.fillStyle = escuro;
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    // 4 cantos com pontos decorativos
    ctx.fillStyle = '#ffffff';
    for (const [cx, cy] of [[3, 3], [CELL-4, 3], [3, CELL-4], [CELL-4, CELL-4]]) {
      ctx.fillRect(x0 + cx, y0 + cy, 2, 2);
    }
    // Cruz na borda
    ctx.fillStyle = escuro;
    ctx.fillRect(x0 + CELL/2 - 1, y0 + 2, 2, 2);
    ctx.fillRect(x0 + CELL/2 - 1, y0 + CELL - 4, 2, 2);
    ctx.fillRect(x0 + 2, y0 + CELL/2 - 1, 2, 2);
    ctx.fillRect(x0 + CELL - 4, y0 + CELL/2 - 1, 2, 2);
    // Borda escura
    ctx.fillStyle = escuro;
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Conduit: cristal aquático ciano-prismarine com 4 nodos brilhantes
  function pintarConduit(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base ciano escuro
    ctx.fillStyle = '#00838f';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de "casca" em volta
    ctx.fillStyle = '#4dd0e1';
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, CELL - 8);
    ctx.fillStyle = '#80deea';
    ctx.fillRect(x0 + 8, y0 + 8, CELL - 16, CELL - 16);
    // Núcleo branco-azulado
    ctx.fillStyle = '#b2ebf2';
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#e0f7fa';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
    // 4 olhos nos cantos (caracteristica do conduit)
    ctx.fillStyle = '#ffeb3b';
    for (const [cx, cy] of [[6, 6], [22, 6], [6, 22], [22, 22]]) {
      ctx.fillRect(x0 + cx, y0 + cy, 4, 4);
      ctx.fillStyle = '#ffffff';
      ctx.fillRect(x0 + cx + 1, y0 + cy + 1, 2, 2);
      ctx.fillStyle = '#000000';
      ctx.fillRect(x0 + cx + 1, y0 + cy + 1, 1, 1);
      ctx.fillStyle = '#ffeb3b';
    }
  }

  // Head genérico (mob): cabeça simplificada com cor + olhos
  function pintarHead(idx, base, sombra, corOlhos) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#0a0a0a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Cabeça (cubo)
    ctx.fillStyle = base;
    ctx.fillRect(x0 + 6, y0 + 6, 20, 20);
    // Sombra/borda
    ctx.fillStyle = sombra;
    ctx.fillRect(x0 + 6,  y0 + 6,  20, 1);
    ctx.fillRect(x0 + 6,  y0 + 25, 20, 1);
    ctx.fillRect(x0 + 6,  y0 + 6,  1,  20);
    ctx.fillRect(x0 + 25, y0 + 6,  1,  20);
    // Olhos
    ctx.fillStyle = corOlhos;
    ctx.fillRect(x0 + 9,  y0 + 11, 5, 5);
    ctx.fillRect(x0 + 18, y0 + 11, 5, 5);
    // Ruído (textura)
    spawnPontosUniforme(x0 + 7, y0 + 7, 18, 18, sombra, 0.30, 4, 1, idx * 9301 + 49297);
  }

  // Soul Lantern: lanterna mas com janela ciano (alma)
  function pintarSoulLantern(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#212121';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Janela ciano brilhante (almas)
    ctx.fillStyle = '#40c4ff';
    ctx.fillRect(x0 + 6, y0 + 8, 20, 18);
    ctx.fillStyle = '#80deea';
    ctx.fillRect(x0 + 10, y0 + 12, 12, 10);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 6);
    // Grades horizontais
    ctx.fillStyle = '#424242';
    ctx.fillRect(x0 + 6, y0 + 13, 20, 1);
    ctx.fillRect(x0 + 6, y0 + 18, 20, 1);
    ctx.fillRect(x0 + 6, y0 + 22, 20, 1);
    // Verticais
    ctx.fillRect(x0 + 14, y0 + 8, 1, 18);
    ctx.fillRect(x0 + 17, y0 + 8, 1, 18);
    // Topo
    ctx.fillStyle = '#424242';
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, 4);
    ctx.fillStyle = '#616161';
    ctx.fillRect(x0 + 8, y0 + 2, CELL - 16, 2);
    // Anel pra pendurar
    ctx.fillStyle = '#9e9e9e';
    ctx.fillRect(x0 + 14, y0,     4, 2);
    ctx.fillRect(x0 + 13, y0 + 1, 6, 1);
  }

  // Lâmpada Redstone: madeira marrom com luz amarela quando acesa
  function pintarLampadaRed(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base marrom (madeira)
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão xadrez de luz amarela (acesa)
    ctx.fillStyle = '#fdd835';
    for (let by = 4; by < CELL - 4; by += 6) {
      for (let bx = 4; bx < CELL - 4; bx += 6) {
        if ((bx + by) % 12 === 0) {
          ctx.fillRect(x0 + bx, y0 + by, 4, 4);
        }
      }
    }
    // Núcleos brancos brilhantes (efeito luz interna)
    ctx.fillStyle = '#ffffff';
    for (let by = 5; by < CELL - 5; by += 6) {
      for (let bx = 5; bx < CELL - 5; bx += 6) {
        if ((bx + by) % 12 === 1) {
          ctx.fillRect(x0 + bx, y0 + by, 1, 1);
        }
      }
    }
    // Bordas escuras
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0, y0, CELL, 2);
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0, y0, 2, CELL);
    ctx.fillRect(x0 + CELL - 2, y0, 2, CELL);
  }

  // Blaze Block: amarelo-laranja com chamas e raios saindo
  function pintarBlazeBlock(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#e65100';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Manchas amarelas brilhantes (fogo)
    ctx.fillStyle = '#ff9800';
    for (let by = 0; by < CELL; by += 5) {
      for (let bx = 0; bx < CELL; bx += 5) {
        if ((bx + by) % 10 === 0) {
          ctx.fillRect(x0 + bx, y0 + by, 4, 4);
        }
      }
    }
    // Núcleos amarelos super-brilhantes
    ctx.fillStyle = '#fdd835';
    spawnPontosUniforme(x0, y0, CELL, CELL, '#fdd835', 0.30, 5, 2, idx * 9301 + 49297);
    spawnPontosUniforme(x0, y0, CELL, CELL, '#fff176', 0.20, 6, 1, idx * 9301 + 7331);
    spawnPontosUniforme(x0, y0, CELL, CELL, '#ffffff', 0.10, 8, 1, idx * 9301 + 12347);
  }

  // Ender Chest: verde-escuro com pontos/estrelas (gradient End)
  function pintarEnderChest(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#004d40';
    ctx.fillRect(x0, y0, CELL, CELL);
    spawnPontosUniforme(x0, y0, CELL, CELL, '#00251f', 0.40, 4, 2, idx * 9301 + 49297);
    // Estrelinhas brancas (estilo End)
    ctx.fillStyle = '#80cbc4';
    spawnPontosUniforme(x0, y0, CELL, CELL, '#80cbc4', 0.30, 5, 1, idx * 9301 + 7331);
    ctx.fillStyle = '#ffffff';
    spawnPontosUniforme(x0, y0, CELL, CELL, '#ffffff', 0.15, 7, 1, idx * 9301 + 12347);
    // Centro + dobradiças
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0 + 14, y0 + 12, 4, 8);
    ctx.fillStyle = '#FFD700';
    ctx.fillRect(x0 + 15, y0 + 14, 2, 2);
  }

  // Shulker Box colorido (genérico): cor base + placas escamares + bordas
  function pintarShulkerCor(idx, base, escuro, claro, borda) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = escuro;
    for (let by = 0; by < CELL; by += 8) {
      for (let bx = 0; bx < CELL; bx += 8) {
        ctx.fillRect(x0 + bx, y0 + by, 7, 1);
        ctx.fillRect(x0 + bx, y0 + by, 1, 7);
      }
    }
    ctx.fillStyle = claro;
    for (let by = 2; by < CELL; by += 8) {
      for (let bx = 2; bx < CELL; bx += 8) {
        ctx.fillRect(x0 + bx, y0 + by, 2, 2);
      }
    }
    ctx.fillStyle = borda;
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Shulker Box: roxo com padrão de placas/escamas
  function pintarShulkerBox(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#9c27b0';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Placas escamares (4x4 grid)
    ctx.fillStyle = '#6a1b9a';
    for (let by = 0; by < CELL; by += 8) {
      for (let bx = 0; bx < CELL; bx += 8) {
        ctx.fillRect(x0 + bx, y0 + by, 7, 1);
        ctx.fillRect(x0 + bx, y0 + by, 1, 7);
      }
    }
    // Highlights
    ctx.fillStyle = '#ce93d8';
    for (let by = 2; by < CELL; by += 8) {
      for (let bx = 2; bx < CELL; bx += 8) {
        ctx.fillRect(x0 + bx, y0 + by, 2, 2);
      }
    }
    // Borda
    ctx.fillStyle = '#4a148c';
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Anvil Damaged: bigorna com rachaduras visíveis (mais escuras)
  function pintarAnvilDamaged(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Reusa lógica básica da bigorna (yunque) mas com rachaduras
    ctx.fillStyle = '#3a3a3a';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0 + 4, y0 + 6, CELL - 8, CELL - 12);
    ctx.fillStyle = '#5a5a5a';
    ctx.fillRect(x0 + 8, y0 + 10, CELL - 16, CELL - 20);
    // Rachaduras zigzag
    ctx.fillStyle = '#0a0a0a';
    ctx.fillRect(x0 + 9,  y0 + 11, 1, 4);
    ctx.fillRect(x0 + 10, y0 + 14, 1, 3);
    ctx.fillRect(x0 + 11, y0 + 16, 1, 4);
    ctx.fillRect(x0 + 18, y0 + 12, 1, 6);
    ctx.fillRect(x0 + 17, y0 + 17, 2, 1);
    // Marcas vermelhas (ferrugem/danos)
    ctx.fillStyle = '#5d2535';
    ctx.fillRect(x0 + 12, y0 + 18, 2, 1);
    ctx.fillRect(x0 + 19, y0 + 19, 2, 1);
  }

  // Decorated Pot: vaso marrom com padrão decorativo
  function pintarDecoratedPot(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro
    ctx.fillStyle = '#0a0a0a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Pote ovalado (parte central marrom)
    ctx.fillStyle = '#a1887f';
    ctx.fillRect(x0 + 8, y0 + 10, 16, 16);
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0 + 10, y0 + 12, 12, 12);
    // Borda superior decorada
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 6, y0 + 8, 20, 2);
    // Padrão decorativo central (cruz dourada)
    ctx.fillStyle = '#FFD700';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 8);
    ctx.fillRect(x0 + 12, y0 + 16, 8, 4);
    // Reflexo branco
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 17, 2, 2);
    // Base decorada
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 8, y0 + 25, 16, 1);
  }

  // 🎯 Command Block (Marco 400!): laranja-marrom com circuito/seta característica
  function pintarCommandBlock(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base laranja-marrom
    ctx.fillStyle = '#a05a30';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão diagonal sutil (textura "metal/circuito")
    ctx.fillStyle = '#7d3e1c';
    for (let i = 0; i < CELL; i += 4) {
      for (let j = 0; j < CELL; j += 4) {
        if (((i + j) >> 2) & 1) ctx.fillRect(x0 + i, y0 + j, 2, 2);
      }
    }
    // Tons mais claros (relevo)
    ctx.fillStyle = '#c97a4d';
    ctx.fillRect(x0 + 3, y0 + 3, CELL - 6, 1);
    ctx.fillRect(x0 + 3, y0 + 3, 1, CELL - 6);
    // Circle/ring central (símbolo command)
    ctx.fillStyle = '#3a1a08';
    ctx.fillRect(x0 + 8,  y0 + 11, 16, 1);
    ctx.fillRect(x0 + 8,  y0 + 20, 16, 1);
    ctx.fillRect(x0 + 7,  y0 + 12, 1, 8);
    ctx.fillRect(x0 + 24, y0 + 12, 1, 8);
    // Seta direcional (Command Block característico)
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 11, y0 + 15, 8, 2);
    ctx.fillRect(x0 + 17, y0 + 13, 2, 2);
    ctx.fillRect(x0 + 19, y0 + 14, 2, 4);
    ctx.fillRect(x0 + 17, y0 + 18, 2, 2);
    // Brilho dourado (LED ligado)
    ctx.fillStyle = '#fff8e1';
    ctx.fillRect(x0 + 19, y0 + 15, 1, 2);
    // Sombra inferior/direita
    ctx.fillStyle = '#5a3018';
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Respawn Anchor: obsidiana com glowstone interna em camadas
  function pintarRespawnAnchor(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#311b92';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#4a148c';
    for (let i = 2; i < CELL - 2; i += 4) {
      for (let j = 2; j < CELL - 2; j += 4) {
        ctx.fillRect(x0 + i, y0 + j, 2, 2);
      }
    }
    ctx.fillStyle = '#fff176';
    ctx.fillRect(x0 + 10, y0 + 10, 12, 12);
    ctx.fillStyle = '#ffeb3b';
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#fffde7';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#1a0a3a';
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Lodestone: deepslate cinza com símbolo de bússola central
  function pintarLodestone(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#9e9e9e';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#bdbdbd';
    for (let i = 0; i < CELL; i += 8) {
      ctx.fillRect(x0 + i, y0, 1, CELL);
      ctx.fillRect(x0, y0 + i, CELL, 1);
    }
    ctx.fillStyle = '#616161';
    ctx.fillRect(x0 + 6, y0 + 6, CELL - 12, CELL - 12);
    ctx.fillStyle = '#bdbdbd';
    ctx.fillRect(x0 + 8, y0 + 8, CELL - 16, CELL - 16);
    // N/S/E/W (4 pequenas marcas)
    ctx.fillStyle = '#c62828';
    ctx.fillRect(x0 + 15, y0 + 9, 2, 6);
    ctx.fillStyle = '#1565c0';
    ctx.fillRect(x0 + 15, y0 + 17, 2, 6);
    ctx.fillStyle = '#fafafa';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
  }

  // Reinforced Deepslate: deepslate escuro com runas brilhantes (bloco do Warden)
  function pintarReinforcedDS(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#2a2a2a';
    for (let i = 0; i < CELL; i += 4) {
      for (let j = 0; j < CELL; j += 4) {
        if (((i + j) >> 2) & 1) ctx.fillRect(x0 + i, y0 + j, 4, 4);
      }
    }
    // Runas verde-azuladas (efeito Warden)
    ctx.fillStyle = '#00bcd4';
    ctx.fillRect(x0 + 7, y0 + 8, 6, 1);
    ctx.fillRect(x0 + 9, y0 + 9, 1, 6);
    ctx.fillRect(x0 + 18, y0 + 18, 1, 6);
    ctx.fillRect(x0 + 18, y0 + 22, 6, 1);
    ctx.fillStyle = '#80deea';
    ctx.fillRect(x0 + 9, y0 + 11, 1, 1);
    ctx.fillRect(x0 + 22, y0 + 22, 1, 1);
    ctx.fillStyle = '#000000';
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Moss Block: musgo verde com manchas mais escuras
  function pintarMossBlock(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#558b2f';
    ctx.fillRect(x0, y0, CELL, CELL);
    let s = idx * 9301 + 49297;
    for (let i = 0; i < 60; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const pick = (s / 233280);
      ctx.fillStyle = pick < 0.4 ? '#33691e' : pick < 0.7 ? '#7cb342' : '#1b5e20';
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
    // Topo levemente mais claro (luz)
    ctx.fillStyle = '#7cb342';
    ctx.fillRect(x0, y0, CELL, 1);
  }

  // Big Dripleaf: planta tropical (haste verde + folha grande)
  function pintarBigDripleaf(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a2515';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Haste vertical
    ctx.fillStyle = '#388e3c';
    ctx.fillRect(x0 + 14, y0 + 12, 4, 18);
    ctx.fillStyle = '#2e7d32';
    ctx.fillRect(x0 + 14, y0 + 12, 1, 18);
    // Folha grande no topo
    ctx.fillStyle = '#66bb6a';
    ctx.fillRect(x0 + 6, y0 + 6, 20, 8);
    ctx.fillStyle = '#43a047';
    ctx.fillRect(x0 + 8, y0 + 8, 16, 4);
    ctx.fillStyle = '#388e3c';
    ctx.fillRect(x0 + 6, y0 + 12, 20, 1);
    // Veias
    ctx.fillStyle = '#1b5e20';
    ctx.fillRect(x0 + 16, y0 + 6, 1, 7);
    ctx.fillRect(x0 + 10, y0 + 9, 12, 1);
  }

  // Chorus Flower: planta do End (roxo + branca)
  function pintarChorusFlower(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a0a2e';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Bulbo central (roxo claro)
    ctx.fillStyle = '#ce93d8';
    ctx.fillRect(x0 + 10, y0 + 10, 12, 12);
    ctx.fillStyle = '#ab47bc';
    ctx.fillRect(x0 + 11, y0 + 11, 10, 10);
    // 4 pétalas (cantos)
    ctx.fillStyle = '#e1bee7';
    ctx.fillRect(x0 + 6,  y0 + 6,  6, 6);
    ctx.fillRect(x0 + 20, y0 + 6,  6, 6);
    ctx.fillRect(x0 + 6,  y0 + 20, 6, 6);
    ctx.fillRect(x0 + 20, y0 + 20, 6, 6);
    // Centro branco (estame)
    ctx.fillStyle = '#fafafa';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    // Sombras nos cantos das pétalas
    ctx.fillStyle = '#6a1b9a';
    ctx.fillRect(x0 + 7,  y0 + 7,  1, 4);
    ctx.fillRect(x0 + 24, y0 + 7,  1, 4);
    ctx.fillRect(x0 + 7,  y0 + 24, 1, 1);
    ctx.fillRect(x0 + 24, y0 + 24, 1, 1);
  }

  // Pistão: madeira top + ferro central + base laranja
  function pintarPiston(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base laranja-marrom
    ctx.fillStyle = '#a1887f';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    // Face frontal (face do pistão — superfície de madeira clara)
    ctx.fillStyle = '#bcaaa4';
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, CELL - 8);
    ctx.fillStyle = '#fdd835';
    // X central (parafusos)
    ctx.fillRect(x0 + 14, y0 + 6, 4, 2);
    ctx.fillRect(x0 + 14, y0 + 24, 4, 2);
    ctx.fillRect(x0 + 6, y0 + 14, 2, 4);
    ctx.fillRect(x0 + 24, y0 + 14, 2, 4);
    // Vigas verticais (madeira escura)
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 6, y0 + 6, 1, CELL - 12);
    ctx.fillRect(x0 + CELL - 7, y0 + 6, 1, CELL - 12);
    // Centro com placa de ferro
    ctx.fillStyle = '#cfd8dc';
    ctx.fillRect(x0 + 11, y0 + 11, 10, 10);
    ctx.fillStyle = '#90a4ae';
    ctx.fillRect(x0 + 13, y0 + 13, 6, 6);
  }

  // Sticky Piston: igual pistão mas face verde (slime sticky)
  function pintarStickyPiston(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#a1887f';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    // Face frontal (slime verde)
    ctx.fillStyle = '#8bc34a';
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, CELL - 8);
    ctx.fillStyle = '#558b2f';
    for (let i = 6; i < CELL - 6; i += 4) {
      for (let j = 6; j < CELL - 6; j += 4) {
        ctx.fillRect(x0 + i, y0 + j, 2, 2);
      }
    }
    ctx.fillStyle = '#aed581';
    ctx.fillRect(x0 + 5, y0 + 5, CELL - 10, 1);
    ctx.fillRect(x0 + 5, y0 + 5, 1, CELL - 10);
    // Vigas verticais
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 6, y0 + 6, 1, CELL - 12);
    ctx.fillRect(x0 + CELL - 7, y0 + 6, 1, CELL - 12);
  }

  // Repeater: pedra clara + 2 tochas redstone
  function pintarRepeater(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#9e9e9e';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#bcaaa4';
    ctx.fillRect(x0 + 2, y0 + 2, CELL - 4, CELL - 4);
    // 2 tochas (frente e trás)
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 13, y0 + 4, 2, 6);
    ctx.fillRect(x0 + 13, y0 + 22, 2, 6);
    ctx.fillStyle = '#c62828';
    ctx.fillRect(x0 + 12, y0 + 4, 4, 3);
    ctx.fillRect(x0 + 12, y0 + 22, 4, 3);
    ctx.fillStyle = '#ff5252';
    ctx.fillRect(x0 + 13, y0 + 5, 2, 1);
    ctx.fillRect(x0 + 13, y0 + 23, 2, 1);
    // Linha central de redstone
    ctx.fillStyle = '#8b0000';
    ctx.fillRect(x0 + 14, y0 + 10, 1, 12);
    // Slider (delay)
    ctx.fillStyle = '#616161';
    ctx.fillRect(x0 + 18, y0 + 14, 4, 4);
  }

  // Comparator: similar mas com 3 tochas + cristal quartzo
  function pintarComparator(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#9e9e9e';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#bcaaa4';
    ctx.fillRect(x0 + 2, y0 + 2, CELL - 4, CELL - 4);
    // 3 tochas (2 traseiras + 1 frontal)
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 6,  y0 + 22, 2, 5);
    ctx.fillRect(x0 + 22, y0 + 22, 2, 5);
    ctx.fillRect(x0 + 13, y0 + 5,  2, 5);
    ctx.fillStyle = '#c62828';
    ctx.fillRect(x0 + 5,  y0 + 22, 4, 3);
    ctx.fillRect(x0 + 21, y0 + 22, 4, 3);
    ctx.fillRect(x0 + 12, y0 + 5,  4, 3);
    // Cristal de quartzo central
    ctx.fillStyle = '#fafafa';
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 13, y0 + 13, 6, 6);
    ctx.fillStyle = '#bdbdbd';
    ctx.fillRect(x0 + 18, y0 + 18, 1, 1);
  }

  // Crafter: bloco com workbench grid (3x3) + ferro
  function pintarCrafter(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#424242';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#9e9e9e';
    ctx.fillRect(x0 + 1, y0 + 1, CELL - 2, CELL - 2);
    // Grid 3x3 de slots
    ctx.fillStyle = '#616161';
    for (let r = 0; r < 3; r++) {
      for (let c = 0; c < 3; c++) {
        const sx = x0 + 4 + c * 8;
        const sy = y0 + 4 + r * 8;
        ctx.fillRect(sx, sy, 7, 7);
      }
    }
    // Slots inner highlights
    ctx.fillStyle = '#bdbdbd';
    for (let r = 0; r < 3; r++) {
      for (let c = 0; c < 3; c++) {
        const sx = x0 + 5 + c * 8;
        const sy = y0 + 5 + r * 8;
        ctx.fillRect(sx, sy, 5, 1);
        ctx.fillRect(sx, sy, 1, 5);
      }
    }
    // Borda escura
    ctx.fillStyle = '#212121';
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Trapped Chest: igual baú mas com vermelho central
  function pintarTrappedChest(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Madeira marrom (corpo do baú)
    ctx.fillStyle = '#a1887f';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
    // Linha central horizontal (separação tampa/corpo)
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0, y0 + 10, CELL, 2);
    // Fechadura central com tinta vermelha (trapped!)
    ctx.fillStyle = '#c62828';
    ctx.fillRect(x0 + 13, y0 + 13, 6, 6);
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
    // Pranchas (tabuões verticais simulados)
    ctx.fillStyle = '#6d4c41';
    ctx.fillRect(x0 + 8,  y0 + 2, 1, 8);
    ctx.fillRect(x0 + 16, y0 + 2, 1, 8);
    ctx.fillRect(x0 + 23, y0 + 2, 1, 8);
    ctx.fillRect(x0 + 8,  y0 + 13, 1, CELL - 15);
    ctx.fillRect(x0 + 23, y0 + 13, 1, CELL - 15);
  }

  // Mangrove Log: vermelho-marrom com anéis de tronco
  function pintarMangroveLog(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#6d4c41';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Listras verticais de casca (mangrove é avermelhado)
    ctx.fillStyle = '#4e342e';
    for (let i = 0; i < CELL; i += 4) {
      ctx.fillRect(x0 + i, y0, 1, CELL);
    }
    // Manchas vermelhas (característico do mangrove)
    ctx.fillStyle = '#8d4a3a';
    let s = idx * 17 + 31;
    for (let i = 0; i < 30; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * (CELL - 2));
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * (CELL - 2));
      ctx.fillRect(x0 + px, y0 + py, 2, 1);
    }
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Mangrove Pranchas: similar mas mais claro + grão de prancha
  function pintarMangrovePrancha(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#6d4c41';
    // 4 fileiras horizontais de pranchas
    ctx.fillRect(x0, y0 + 7,  CELL, 1);
    ctx.fillRect(x0, y0 + 15, CELL, 1);
    ctx.fillRect(x0, y0 + 23, CELL, 1);
    // Divisões verticais (alternadas)
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 11, y0,      1, 7);
    ctx.fillRect(x0 + 21, y0 + 8,  1, 7);
    ctx.fillRect(x0 + 11, y0 + 16, 1, 7);
    ctx.fillRect(x0 + 21, y0 + 24, 1, CELL - 24);
    // Manchas avermelhadas
    ctx.fillStyle = '#a1605a';
    let s = idx * 7 + 11;
    for (let i = 0; i < 18; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
  }

  // Cherry Log: rosa pastel com listras claras (cerejeira)
  function pintarCherryLog(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#c2185b';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Listras verticais rosa claro
    ctx.fillStyle = '#f48fb1';
    for (let i = 0; i < CELL; i += 4) {
      ctx.fillRect(x0 + i, y0, 1, CELL);
    }
    ctx.fillStyle = '#e91e63';
    for (let i = 2; i < CELL; i += 4) {
      ctx.fillRect(x0 + i, y0, 1, CELL);
    }
    // Pintinhas brancas (flores caídas)
    ctx.fillStyle = '#fce4ec';
    let s = idx * 13 + 29;
    for (let i = 0; i < 20; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
    ctx.fillStyle = '#880e4f';
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Cherry Pranchas: rosa pastel com grão de prancha rosa
  function pintarCherryPrancha(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#f8bbd0';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#ec407a';
    // 4 fileiras horizontais
    ctx.fillRect(x0, y0 + 7,  CELL, 1);
    ctx.fillRect(x0, y0 + 15, CELL, 1);
    ctx.fillRect(x0, y0 + 23, CELL, 1);
    // Divisões verticais
    ctx.fillStyle = '#c2185b';
    ctx.fillRect(x0 + 11, y0,      1, 7);
    ctx.fillRect(x0 + 21, y0 + 8,  1, 7);
    ctx.fillRect(x0 + 11, y0 + 16, 1, 7);
    ctx.fillRect(x0 + 21, y0 + 24, 1, CELL - 24);
    // Pintinhas brancas
    ctx.fillStyle = '#fce4ec';
    let s = idx * 11 + 23;
    for (let i = 0; i < 16; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
  }

  // Cherry Folha: folhas rosa pastel + flores brancas
  function pintarCherryFolha(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#f48fb1';
    ctx.fillRect(x0, y0, CELL, CELL);
    let s = idx * 17 + 41;
    for (let i = 0; i < 80; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const pick = (s / 233280);
      ctx.fillStyle = pick < 0.3 ? '#f06292' : pick < 0.6 ? '#fce4ec' : pick < 0.85 ? '#ffffff' : '#c2185b';
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
  }

  // Mangrove Folha: verde-escuro com gotas (raízes pendentes)
  function pintarMangroveFolha(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#33691e';
    ctx.fillRect(x0, y0, CELL, CELL);
    let s = idx * 13 + 37;
    for (let i = 0; i < 70; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const pick = (s / 233280);
      ctx.fillStyle = pick < 0.4 ? '#558b2f' : pick < 0.7 ? '#1b5e20' : pick < 0.9 ? '#7cb342' : '#827717';
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
    // Raízes pendentes (gotas marrons)
    ctx.fillStyle = '#5d4037';
    for (let i = 4; i < CELL; i += 8) {
      ctx.fillRect(x0 + i, y0 + CELL - 4, 1, 4);
    }
  }

  // Mangrove Raiz: feixe de raízes finas verticais
  function pintarMangroveRaiz(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Várias raízes verticais
    ctx.fillStyle = '#6d4c41';
    for (let i = 2; i < CELL; i += 3) {
      ctx.fillRect(x0 + i, y0 + ((i * 7) % 6), 1, CELL - ((i * 7) % 6));
    }
    ctx.fillStyle = '#8d6e63';
    for (let i = 1; i < CELL; i += 3) {
      ctx.fillRect(x0 + i, y0 + ((i * 11) % 8) + 8, 1, 6);
    }
    // Conexões horizontais (fios)
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0, y0 + 12, CELL, 1);
    ctx.fillRect(x0, y0 + 24, CELL, 1);
  }

  // Azaléia: arbusto verde compacto
  function pintarAzalea(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a2515';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Folhagem central
    ctx.fillStyle = '#2e7d32';
    ctx.fillRect(x0 + 6, y0 + 8, 20, 20);
    ctx.fillStyle = '#388e3c';
    ctx.fillRect(x0 + 8, y0 + 10, 16, 16);
    ctx.fillStyle = '#43a047';
    ctx.fillRect(x0 + 10, y0 + 12, 12, 12);
    // Pontos de folhas mais claras
    ctx.fillStyle = '#66bb6a';
    let s = idx * 7 + 17;
    for (let i = 0; i < 30; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = 8 + Math.floor((s / 233280) * 16);
      s = (s * 9301 + 49297) % 233280;
      const py = 8 + Math.floor((s / 233280) * 18);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
    // Tronco curto na base
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 14, y0 + 26, 4, 5);
  }

  // Azaléia Florida: igual mas com flores rosa por cima
  function pintarAzaleaFlower(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a2515';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#388e3c';
    ctx.fillRect(x0 + 6, y0 + 8, 20, 20);
    ctx.fillStyle = '#43a047';
    ctx.fillRect(x0 + 8, y0 + 10, 16, 16);
    // Flores rosa (4 ao redor + 1 central)
    const flores = [[10, 12], [20, 12], [10, 22], [20, 22], [15, 17]];
    for (const [px, py] of flores) {
      ctx.fillStyle = '#f06292';
      ctx.fillRect(x0 + px, y0 + py, 4, 4);
      ctx.fillStyle = '#f48fb1';
      ctx.fillRect(x0 + px + 1, y0 + py + 1, 2, 2);
      ctx.fillStyle = '#fdd835';
      ctx.fillRect(x0 + px + 1, y0 + py + 1, 1, 1);
    }
    // Tronco curto
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 14, y0 + 26, 4, 5);
  }

  // Pink Petals: pétalas rosa caídas (carpet)
  function pintarPinkPetals(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#558b2f';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Várias pétalas rosa de tamanhos pequenos
    let s = idx * 23 + 43;
    for (let i = 0; i < 25; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * (CELL - 4));
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * (CELL - 4));
      s = (s * 9301 + 49297) % 233280;
      const tipo = (s / 233280);
      ctx.fillStyle = tipo < 0.3 ? '#f48fb1' : tipo < 0.6 ? '#f06292' : tipo < 0.85 ? '#fce4ec' : '#ec407a';
      ctx.fillRect(x0 + px, y0 + py, 3, 2);
      ctx.fillStyle = '#fdd835';
      if (tipo < 0.4) ctx.fillRect(x0 + px + 1, y0 + py, 1, 1);
    }
  }

  // Cactus Flower: flor amarela pequena no topo de cacto
  function pintarCactusFlower(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a2515';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Cacto verde no centro
    ctx.fillStyle = '#388e3c';
    ctx.fillRect(x0 + 12, y0 + 14, 8, 16);
    ctx.fillStyle = '#2e7d32';
    ctx.fillRect(x0 + 13, y0 + 14, 1, 16);
    ctx.fillRect(x0 + 19, y0 + 14, 1, 16);
    // Flor amarela no topo
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 10, y0 + 8, 12, 6);
    ctx.fillStyle = '#fff176';
    ctx.fillRect(x0 + 12, y0 + 9, 8, 4);
    ctx.fillStyle = '#ff9800';
    ctx.fillRect(x0 + 14, y0 + 10, 4, 2);
    // Espinhos
    ctx.fillStyle = '#fafafa';
    ctx.fillRect(x0 + 11, y0 + 18, 1, 1);
    ctx.fillRect(x0 + 20, y0 + 18, 1, 1);
    ctx.fillRect(x0 + 11, y0 + 24, 1, 1);
    ctx.fillRect(x0 + 20, y0 + 24, 1, 1);
  }

  // Bamboo Mosaic: padrão entrelaçado de bambu (1.20 — bonito decorativo)
  function pintarBambooMosaic(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#c8a951';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão entrelaçado (4 quadrantes alternados)
    ctx.fillStyle = '#a0863e';
    for (let i = 0; i < CELL; i += 8) {
      for (let j = 0; j < CELL; j += 8) {
        if (((i + j) >> 3) & 1) {
          ctx.fillRect(x0 + i, y0 + j, 8, 8);
        }
      }
    }
    // Linhas de junta (efeito tear)
    ctx.fillStyle = '#7d6932';
    for (let i = 0; i < CELL; i += 8) {
      ctx.fillRect(x0 + i, y0, 1, CELL);
      ctx.fillRect(x0, y0 + i, CELL, 1);
    }
    // Pontos brilhantes (verniz)
    ctx.fillStyle = '#fff8e1';
    for (let i = 4; i < CELL; i += 8) {
      for (let j = 4; j < CELL; j += 8) {
        ctx.fillRect(x0 + i, y0 + j, 1, 1);
      }
    }
  }

  // Crimson Roots: raízes vermelhas finas (Nether)
  function pintarCrimsonRoots(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#3a1a1a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Várias raízes verticais finas
    ctx.fillStyle = '#8a3a4d';
    let s = idx * 11 + 19;
    for (let i = 0; i < 12; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * (CELL - 2));
      s = (s * 9301 + 49297) % 233280;
      const altura = 8 + Math.floor((s / 233280) * 16);
      ctx.fillRect(x0 + px, y0 + CELL - altura, 1, altura);
    }
    // Bulbo na ponta de algumas
    ctx.fillStyle = '#d75a72';
    s = idx * 7 + 17;
    for (let i = 0; i < 6; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * (CELL - 3));
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * (CELL - 3));
      ctx.fillRect(x0 + px, y0 + py, 2, 2);
    }
  }

  // Warped Roots: raízes verdes-azuladas (Nether warped)
  function pintarWarpedRoots(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#0a2a2a';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#2c8a8a';
    let s = idx * 13 + 23;
    for (let i = 0; i < 12; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * (CELL - 2));
      s = (s * 9301 + 49297) % 233280;
      const altura = 8 + Math.floor((s / 233280) * 16);
      ctx.fillRect(x0 + px, y0 + CELL - altura, 1, altura);
    }
    ctx.fillStyle = '#4cb8b8';
    s = idx * 5 + 13;
    for (let i = 0; i < 6; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * (CELL - 3));
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * (CELL - 3));
      ctx.fillRect(x0 + px, y0 + py, 2, 2);
    }
  }

  // Frosted Ice: gelo com cristais geométricos (frostwalker)
  function pintarFrostedIce(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#b3e5fc';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#81d4fa';
    // Padrão de cristais geométricos
    for (let i = 0; i < CELL; i += 6) {
      ctx.fillRect(x0 + i, y0, 1, CELL);
      ctx.fillRect(x0, y0 + i, CELL, 1);
    }
    // Manchas brilhantes
    ctx.fillStyle = '#e1f5fe';
    for (let i = 3; i < CELL; i += 6) {
      for (let j = 3; j < CELL; j += 6) {
        ctx.fillRect(x0 + i, y0 + j, 2, 2);
      }
    }
    // Reflexos (azul claro)
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 2, y0 + 2, 4, 1);
    ctx.fillRect(x0 + 2, y0 + 2, 1, 4);
    ctx.fillRect(x0 + 24, y0 + 24, 4, 1);
    ctx.fillRect(x0 + 26, y0 + 24, 1, 4);
  }

  // Vine: cipó verde tradicional pendendo
  function pintarVine(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a2510';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Folhagem de cipó (verde)
    ctx.fillStyle = '#33691e';
    for (let i = 2; i < CELL; i += 4) {
      ctx.fillRect(x0 + i, y0, 1, CELL);
    }
    ctx.fillStyle = '#558b2f';
    for (let i = 4; i < CELL; i += 4) {
      ctx.fillRect(x0 + i, y0 + 2, 1, CELL - 2);
    }
    // Folhinhas
    ctx.fillStyle = '#7cb342';
    let s = idx * 7 + 11;
    for (let i = 0; i < 30; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 2, 1);
    }
  }

  // Twisting Vines: cipó torcido azul-ciano (Nether warped)
  function pintarTwistingVines(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#0a2a2a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Espiral central torcida (cresce pra cima)
    ctx.fillStyle = '#00bcd4';
    for (let y = 4; y < CELL; y += 2) {
      const offset = Math.sin(y * 0.5) * 3;
      ctx.fillRect(x0 + 14 + Math.floor(offset), y0 + y, 4, 1);
    }
    // Folhinhas brilhantes
    ctx.fillStyle = '#80deea';
    for (let y = 6; y < CELL - 4; y += 4) {
      const offset = Math.sin(y * 0.5) * 3;
      ctx.fillRect(x0 + 12 + Math.floor(offset), y0 + y, 1, 1);
      ctx.fillRect(x0 + 19 + Math.floor(offset), y0 + y, 1, 1);
    }
    // Topo (broto)
    ctx.fillStyle = '#4dd0e1';
    ctx.fillRect(x0 + 14, y0 + 2, 4, 4);
    ctx.fillStyle = '#e0f7fa';
    ctx.fillRect(x0 + 15, y0 + 3, 2, 2);
  }

  // Weeping Vines: cipó pendente vermelho (Nether crimson)
  function pintarWeepingVines(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#3a1a1a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Cipó pendente (cresce pra baixo)
    ctx.fillStyle = '#c62828';
    for (let y = 0; y < CELL - 4; y += 2) {
      const offset = Math.sin(y * 0.4) * 3;
      ctx.fillRect(x0 + 14 + Math.floor(offset), y0 + y, 4, 1);
    }
    ctx.fillStyle = '#ef5350';
    for (let y = 2; y < CELL - 4; y += 4) {
      const offset = Math.sin(y * 0.4) * 3;
      ctx.fillRect(x0 + 12 + Math.floor(offset), y0 + y, 1, 1);
      ctx.fillRect(x0 + 19 + Math.floor(offset), y0 + y, 1, 1);
    }
    // Pontas pendentes (gotas)
    ctx.fillStyle = '#8b0000';
    ctx.fillRect(x0 + 14, y0 + CELL - 4, 4, 4);
    ctx.fillStyle = '#b71c1c';
    ctx.fillRect(x0 + 15, y0 + CELL - 3, 2, 2);
  }

  // Scaffolding: andaime de bambu (estrutura aberta)
  function pintarScaffolding(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro (ar entre as barras)
    ctx.fillStyle = '#1a1a0a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Estrutura de bambu: 4 verticais + 4 horizontais
    ctx.fillStyle = '#c8a951';
    ctx.fillRect(x0,           y0, 3, CELL);
    ctx.fillRect(x0 + CELL - 3, y0, 3, CELL);
    ctx.fillRect(x0, y0,           CELL, 3);
    ctx.fillRect(x0, y0 + CELL - 3, CELL, 3);
    // Diagonal X (cordas)
    ctx.fillStyle = '#6d4c41';
    for (let i = 4; i < CELL - 4; i++) {
      ctx.fillRect(x0 + i, y0 + i, 1, 1);
      ctx.fillRect(x0 + i, y0 + (CELL - 1 - i), 1, 1);
    }
    // Highlights de bambu (claros)
    ctx.fillStyle = '#fff8e1';
    ctx.fillRect(x0 + 1, y0 + 1, 1, CELL - 2);
    ctx.fillRect(x0 + CELL - 2, y0 + 1, 1, CELL - 2);
    ctx.fillRect(x0 + 1, y0 + 1, CELL - 2, 1);
    ctx.fillRect(x0 + 1, y0 + CELL - 2, CELL - 2, 1);
  }

  // Hanging Roots: raízes pendentes marrom (lush caves)
  function pintarHangingRoots(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a1010';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Raízes pendentes do topo
    ctx.fillStyle = '#8d6e63';
    let s = idx * 11 + 13;
    for (let i = 0; i < 14; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * (CELL - 2));
      s = (s * 9301 + 49297) % 233280;
      const altura = 6 + Math.floor((s / 233280) * 14);
      ctx.fillRect(x0 + px, y0, 1, altura);
    }
    // Texturas mais escuras
    ctx.fillStyle = '#5d4037';
    s = idx * 7 + 17;
    for (let i = 0; i < 10; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * (CELL - 2));
      s = (s * 9301 + 49297) % 233280;
      const altura = 4 + Math.floor((s / 233280) * 10);
      ctx.fillRect(x0 + px, y0, 1, altura);
    }
    // Pontas mais grossas
    ctx.fillStyle = '#a1887f';
    for (let i = 4; i < CELL; i += 6) {
      ctx.fillRect(x0 + i, y0 + 8, 2, 1);
    }
  }

  // Glow Berries: vinhas verdes com frutas laranja brilhantes
  function pintarGlowBerries(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a2510';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Folhagem (verde escura)
    ctx.fillStyle = '#33691e';
    let s = idx * 9 + 23;
    for (let i = 0; i < 50; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
    // Frutas laranja brilhantes (3 destaques)
    const frutas = [[6, 10], [16, 18], [22, 8]];
    for (const [px, py] of frutas) {
      ctx.fillStyle = '#e65100';
      ctx.fillRect(x0 + px, y0 + py, 4, 4);
      ctx.fillStyle = '#ff9800';
      ctx.fillRect(x0 + px + 1, y0 + py + 1, 2, 2);
      ctx.fillStyle = '#fff176';
      ctx.fillRect(x0 + px + 1, y0 + py + 1, 1, 1);
    }
  }

  // Amethyst Budding: bloco rocha com cristais ametista nascendo
  function pintarAmethystBudding(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#3a1a4a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Manchas roxas (geode)
    ctx.fillStyle = '#7b1fa2';
    let s = idx * 13 + 27;
    for (let i = 0; i < 40; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
    // Brotos de cristais (4 cantos)
    const brotos = [[3, 3], [25, 3], [3, 25], [25, 25]];
    for (const [px, py] of brotos) {
      ctx.fillStyle = '#ab47bc';
      ctx.fillRect(x0 + px, y0 + py, 4, 4);
      ctx.fillStyle = '#ce93d8';
      ctx.fillRect(x0 + px + 1, y0 + py + 1, 2, 2);
      ctx.fillStyle = '#ffffff';
      ctx.fillRect(x0 + px + 1, y0 + py + 1, 1, 1);
    }
  }

  // Amethyst Cluster: cristais grandes em grupo (gemas)
  function pintarAmethystCluster(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a0a2a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Cristais grandes (forma diamante 3D)
    ctx.fillStyle = '#7b1fa2';
    ctx.fillRect(x0 + 12, y0 + 8, 8, 16);
    ctx.fillStyle = '#9c27b0';
    ctx.fillRect(x0 + 13, y0 + 9, 6, 14);
    ctx.fillStyle = '#ab47bc';
    ctx.fillRect(x0 + 14, y0 + 10, 4, 12);
    ctx.fillStyle = '#ce93d8';
    ctx.fillRect(x0 + 14, y0 + 12, 1, 8);
    ctx.fillRect(x0 + 17, y0 + 12, 1, 8);
    // Pontas (topo + base)
    ctx.fillStyle = '#ce93d8';
    ctx.fillRect(x0 + 14, y0 + 6, 4, 2);
    ctx.fillRect(x0 + 14, y0 + 24, 4, 2);
    // Cristais laterais menores
    ctx.fillStyle = '#9c27b0';
    ctx.fillRect(x0 + 4, y0 + 14, 4, 8);
    ctx.fillRect(x0 + 24, y0 + 14, 4, 8);
    ctx.fillStyle = '#e1bee7';
    ctx.fillRect(x0 + 5, y0 + 15, 2, 2);
    ctx.fillRect(x0 + 25, y0 + 15, 2, 2);
    // Brilho central
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 14, 2, 2);
  }

  // Pointed Dripstone: estalactite/estalagmite (pingente de pedra)
  function pintarPointedDripstone(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#2a2018';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Estalactite triangular (cresce para baixo)
    ctx.fillStyle = '#8d6e63';
    for (let y = 0; y < CELL; y++) {
      const meio = CELL / 2;
      const largura = Math.floor((CELL - y) / 2);
      if (largura > 0) {
        ctx.fillRect(x0 + meio - largura, y0 + y, largura * 2, 1);
      }
    }
    // Highlight central
    ctx.fillStyle = '#a1887f';
    for (let y = 0; y < CELL; y++) {
      const largura = Math.max(1, Math.floor((CELL - y) / 4));
      const meio = CELL / 2 - 1;
      ctx.fillRect(x0 + meio, y0 + y, 1, 1);
    }
    // Sombra lateral
    ctx.fillStyle = '#5d4037';
    for (let y = 0; y < CELL; y++) {
      const meio = CELL / 2;
      const largura = Math.floor((CELL - y) / 2);
      if (largura > 0) {
        ctx.fillRect(x0 + meio + largura - 1, y0 + y, 1, 1);
      }
    }
  }

  // Mossy Cobblestone: cobble cinza com manchas verdes de musgo
  function pintarMossyCobblestone(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#9e9e9e';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão cobble (irregular)
    ctx.fillStyle = '#757575';
    for (let i = 0; i < CELL; i += 6) {
      for (let j = 0; j < CELL; j += 6) {
        if (((i + j) >> 1) & 1) ctx.fillRect(x0 + i, y0 + j, 5, 5);
      }
    }
    // Manchas verdes de musgo (cresce)
    ctx.fillStyle = '#558b2f';
    let s = idx * 17 + 31;
    for (let i = 0; i < 25; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const tipo = (s / 233280);
      ctx.fillStyle = tipo < 0.5 ? '#558b2f' : tipo < 0.8 ? '#33691e' : '#7cb342';
      ctx.fillRect(x0 + px, y0 + py, 2, 1);
    }
    // Bordas
    ctx.fillStyle = '#424242';
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Cracked Stone Bricks: tijolos rachados (perigosa estrutura)
  function pintarCrackedStoneBricks(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#808080';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de tijolos (4 horizontal × 2 vertical)
    ctx.fillStyle = '#606060';
    ctx.fillRect(x0, y0 + 7,  CELL, 1);
    ctx.fillRect(x0, y0 + 15, CELL, 1);
    ctx.fillRect(x0, y0 + 23, CELL, 1);
    // Divisões verticais alternadas
    ctx.fillRect(x0 + 7,  y0,      1, 7);
    ctx.fillRect(x0 + 15, y0,      1, 7);
    ctx.fillRect(x0 + 23, y0,      1, 7);
    ctx.fillRect(x0 + 11, y0 + 8,  1, 7);
    ctx.fillRect(x0 + 21, y0 + 8,  1, 7);
    ctx.fillRect(x0 + 7,  y0 + 16, 1, 7);
    ctx.fillRect(x0 + 15, y0 + 16, 1, 7);
    ctx.fillRect(x0 + 23, y0 + 16, 1, 7);
    ctx.fillRect(x0 + 11, y0 + 24, 1, CELL - 24);
    ctx.fillRect(x0 + 21, y0 + 24, 1, CELL - 24);
    // RACHADURAS (preto, diagonais aleatórias)
    ctx.fillStyle = '#3a3a3a';
    ctx.fillRect(x0 + 4,  y0 + 4,  1, 8);
    ctx.fillRect(x0 + 5,  y0 + 5,  1, 4);
    ctx.fillRect(x0 + 18, y0 + 12, 6, 1);
    ctx.fillRect(x0 + 20, y0 + 13, 4, 1);
    ctx.fillRect(x0 + 12, y0 + 20, 1, 6);
    ctx.fillRect(x0 + 13, y0 + 21, 1, 4);
    ctx.fillRect(x0 + 24, y0 + 26, 5, 1);
  }

  // Mossy Stone Bricks: tijolos com musgo verde (clássico)
  function pintarMossyStoneBricks(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#6e8050';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de tijolos
    ctx.fillStyle = '#4d5e35';
    ctx.fillRect(x0, y0 + 7,  CELL, 1);
    ctx.fillRect(x0, y0 + 15, CELL, 1);
    ctx.fillRect(x0, y0 + 23, CELL, 1);
    ctx.fillRect(x0 + 7,  y0,      1, 7);
    ctx.fillRect(x0 + 15, y0,      1, 7);
    ctx.fillRect(x0 + 23, y0,      1, 7);
    ctx.fillRect(x0 + 11, y0 + 8,  1, 7);
    ctx.fillRect(x0 + 21, y0 + 8,  1, 7);
    ctx.fillRect(x0 + 7,  y0 + 16, 1, 7);
    ctx.fillRect(x0 + 15, y0 + 16, 1, 7);
    ctx.fillRect(x0 + 23, y0 + 16, 1, 7);
    ctx.fillRect(x0 + 11, y0 + 24, 1, CELL - 24);
    ctx.fillRect(x0 + 21, y0 + 24, 1, CELL - 24);
    // Manchas de musgo
    ctx.fillStyle = '#33691e';
    let s = idx * 19 + 41;
    for (let i = 0; i < 30; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
    // Highlights de pedra cinza
    ctx.fillStyle = '#9e9e9e';
    for (let i = 2; i < CELL; i += 8) {
      ctx.fillRect(x0 + i, y0 + 2, 2, 1);
      ctx.fillRect(x0 + i, y0 + 18, 2, 1);
    }
  }

  // Tuff Bricks: tijolos cinza sólidos (1.21)
  function pintarTuffBricks(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#707070';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de tijolos
    ctx.fillStyle = '#505050';
    ctx.fillRect(x0, y0 + 7,  CELL, 1);
    ctx.fillRect(x0, y0 + 15, CELL, 1);
    ctx.fillRect(x0, y0 + 23, CELL, 1);
    ctx.fillRect(x0 + 7,  y0,      1, 7);
    ctx.fillRect(x0 + 15, y0,      1, 7);
    ctx.fillRect(x0 + 23, y0,      1, 7);
    ctx.fillRect(x0 + 11, y0 + 8,  1, 7);
    ctx.fillRect(x0 + 21, y0 + 8,  1, 7);
    ctx.fillRect(x0 + 7,  y0 + 16, 1, 7);
    ctx.fillRect(x0 + 15, y0 + 16, 1, 7);
    ctx.fillRect(x0 + 23, y0 + 16, 1, 7);
    ctx.fillRect(x0 + 11, y0 + 24, 1, CELL - 24);
    ctx.fillRect(x0 + 21, y0 + 24, 1, CELL - 24);
    // Manchas de granito (tuff tem partículas escuras)
    ctx.fillStyle = '#404040';
    let s = idx * 17 + 31;
    for (let i = 0; i < 18; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
    ctx.fillStyle = '#909090';
    s = idx * 11 + 17;
    for (let i = 0; i < 14; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
  }

  // Chiseled Tuff: tuff esculpido com colunas verticais
  function pintarChiseledTuff(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#707070';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Coluna central (vertical decorativa)
    ctx.fillStyle = '#909090';
    ctx.fillRect(x0 + 8, y0 + 2, 16, CELL - 4);
    ctx.fillStyle = '#505050';
    ctx.fillRect(x0 + 8, y0 + 2, 1, CELL - 4);
    ctx.fillRect(x0 + 23, y0 + 2, 1, CELL - 4);
    // Linhas horizontais decorativas
    ctx.fillStyle = '#404040';
    ctx.fillRect(x0 + 6, y0 + 6,  20, 1);
    ctx.fillRect(x0 + 6, y0 + 25, 20, 1);
    // Centro com diamante decorativo
    ctx.fillStyle = '#bdbdbd';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#fafafa';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
    // Pontos cinzas
    ctx.fillStyle = '#404040';
    let s = idx * 13 + 19;
    for (let i = 0; i < 12; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
  }

  // Chiseled Tuff Bricks: tijolos esculpidos com padrão central
  function pintarChiseledTuffBricks(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#707070';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Borda externa em moldura
    ctx.fillStyle = '#505050';
    ctx.fillRect(x0 + 2, y0 + 2, CELL - 4, 1);
    ctx.fillRect(x0 + 2, y0 + CELL - 3, CELL - 4, 1);
    ctx.fillRect(x0 + 2, y0 + 2, 1, CELL - 4);
    ctx.fillRect(x0 + CELL - 3, y0 + 2, 1, CELL - 4);
    // Diamante central
    ctx.fillStyle = '#909090';
    ctx.fillRect(x0 + 12, y0 + 6,  8, 1);
    ctx.fillRect(x0 + 10, y0 + 8,  12, 1);
    ctx.fillRect(x0 + 8,  y0 + 12, 16, 8);
    ctx.fillRect(x0 + 10, y0 + 22, 12, 1);
    ctx.fillRect(x0 + 12, y0 + 24, 8, 1);
    ctx.fillStyle = '#505050';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#bdbdbd';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
    // Manchas
    ctx.fillStyle = '#404040';
    let s = idx * 17 + 23;
    for (let i = 0; i < 10; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
  }

  // Chiseled Copper: cobre esculpido com hexágonos
  function pintarChiseledCopper(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#c97a4d';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão diagonal (gravação)
    ctx.fillStyle = '#a45a30';
    for (let i = 0; i < CELL; i += 4) {
      ctx.fillRect(x0 + i, y0, 1, CELL);
    }
    // Hexágono central decorativo
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 12, y0 + 8,  8, 1);
    ctx.fillRect(x0 + 10, y0 + 9,  12, 1);
    ctx.fillRect(x0 + 8,  y0 + 12, 16, 8);
    ctx.fillRect(x0 + 10, y0 + 22, 12, 1);
    ctx.fillRect(x0 + 12, y0 + 23, 8, 1);
    // Centro com gema
    ctx.fillStyle = '#fff8e1';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#a45a30';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
    // Highlight superior
    ctx.fillStyle = '#e8a070';
    ctx.fillRect(x0 + 2, y0 + 2, CELL - 4, 1);
  }

  // Copper Bulb: bulbo brilhante (luz 15)
  function pintarCopperBulb(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Cobre escuro como base
    ctx.fillStyle = '#a45a30';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Anel de cobre
    ctx.fillStyle = '#c97a4d';
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, CELL - 8);
    // Bulbo brilhante (esfera amarela)
    ctx.fillStyle = '#f57f17';
    ctx.fillRect(x0 + 8, y0 + 8, 16, 16);
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 10, y0 + 10, 12, 12);
    ctx.fillStyle = '#ffeb3b';
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#fffde7';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
    // Halo brilhante (cruz)
    ctx.fillStyle = '#fff176';
    ctx.fillRect(x0 + 15, y0 + 4, 2, 4);
    ctx.fillRect(x0 + 15, y0 + 24, 2, 4);
    ctx.fillRect(x0 + 4, y0 + 15, 4, 2);
    ctx.fillRect(x0 + 24, y0 + 15, 4, 2);
  }

  // Copper Grate: grade de cobre (estrutura aberta)
  function pintarCopperGrate(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro (espaços abertos)
    ctx.fillStyle = '#1a1008';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Barras horizontais
    ctx.fillStyle = '#c97a4d';
    for (let y = 0; y < CELL; y += 6) {
      ctx.fillRect(x0, y0 + y, CELL, 2);
    }
    // Barras verticais
    for (let x = 0; x < CELL; x += 6) {
      ctx.fillRect(x0 + x, y0, 2, CELL);
    }
    // Highlights (cobre claro nas junções)
    ctx.fillStyle = '#e8a070';
    for (let y = 0; y < CELL; y += 6) {
      for (let x = 0; x < CELL; x += 6) {
        ctx.fillRect(x0 + x, y0 + y, 1, 1);
      }
    }
    // Sombras
    ctx.fillStyle = '#a45a30';
    for (let y = 1; y < CELL; y += 6) {
      ctx.fillRect(x0, y0 + y, CELL, 1);
    }
  }

  // Trial Spawner: caixa preta com olho/cristal central
  function pintarTrialSpawner(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#212121';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de obsidiana
    ctx.fillStyle = '#0a0a0a';
    for (let i = 0; i < CELL; i += 4) {
      for (let j = 0; j < CELL; j += 4) {
        if (((i + j) >> 2) & 1) ctx.fillRect(x0 + i, y0 + j, 2, 2);
      }
    }
    // Borda de runas (laranja-marrom)
    ctx.fillStyle = '#a05a30';
    ctx.fillRect(x0 + 2, y0 + 2, CELL - 4, 1);
    ctx.fillRect(x0 + 2, y0 + CELL - 3, CELL - 4, 1);
    ctx.fillRect(x0 + 2, y0 + 2, 1, CELL - 4);
    ctx.fillRect(x0 + CELL - 3, y0 + 2, 1, CELL - 4);
    // Cristal central (laranja brilhante)
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 8, y0 + 8, 16, 16);
    ctx.fillStyle = '#ff9800';
    ctx.fillRect(x0 + 10, y0 + 10, 12, 12);
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#fffde7';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    // Pontos de luz (4 cantos do cristal)
    ctx.fillStyle = '#ff5252';
    ctx.fillRect(x0 + 8, y0 + 8, 1, 1);
    ctx.fillRect(x0 + 23, y0 + 8, 1, 1);
    ctx.fillRect(x0 + 8, y0 + 23, 1, 1);
    ctx.fillRect(x0 + 23, y0 + 23, 1, 1);
  }

  // Vault: cofre com chave/fechadura (1.21)
  function pintarVault(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#212121';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Borda de metal escuro
    ctx.fillStyle = '#424242';
    ctx.fillRect(x0 + 2, y0 + 2, CELL - 4, CELL - 4);
    // Frente do vault (placa pesada)
    ctx.fillStyle = '#616161';
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, CELL - 8);
    ctx.fillStyle = '#9e9e9e';
    ctx.fillRect(x0 + 6, y0 + 6, CELL - 12, 1);
    ctx.fillRect(x0 + 6, y0 + 6, 1, CELL - 12);
    // Fechadura/buraco de chave central
    ctx.fillStyle = '#0a0a0a';
    ctx.fillRect(x0 + 12, y0 + 10, 8, 12);
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0 + 13, y0 + 11, 6, 10);
    // Buraco da chave
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 14, y0 + 13, 4, 4);
    ctx.fillRect(x0 + 15, y0 + 17, 2, 4);
    ctx.fillStyle = '#fff8e1';
    ctx.fillRect(x0 + 15, y0 + 14, 2, 2);
    // 4 parafusos nos cantos
    ctx.fillStyle = '#a45a30';
    ctx.fillRect(x0 + 7,  y0 + 7,  2, 2);
    ctx.fillRect(x0 + 23, y0 + 7,  2, 2);
    ctx.fillRect(x0 + 7,  y0 + 23, 2, 2);
    ctx.fillRect(x0 + 23, y0 + 23, 2, 2);
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 7,  y0 + 7,  1, 1);
    ctx.fillRect(x0 + 23, y0 + 7,  1, 1);
    ctx.fillRect(x0 + 7,  y0 + 23, 1, 1);
    ctx.fillRect(x0 + 23, y0 + 23, 1, 1);
  }

  // Pitcher Plant: planta carnívora roxa (1.20)
  function pintarPitcherPlant(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a0a2a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Caule verde central
    ctx.fillStyle = '#2e7d32';
    ctx.fillRect(x0 + 14, y0 + 18, 4, 12);
    ctx.fillStyle = '#1b5e20';
    ctx.fillRect(x0 + 14, y0 + 18, 1, 12);
    // "Jarra" roxa central (forma de pitcher)
    ctx.fillStyle = '#4a148c';
    ctx.fillRect(x0 + 9, y0 + 8, 14, 12);
    ctx.fillStyle = '#6a1b9a';
    ctx.fillRect(x0 + 10, y0 + 9, 12, 10);
    ctx.fillStyle = '#7b1fa2';
    ctx.fillRect(x0 + 11, y0 + 10, 10, 8);
    // Topo aberto da jarra (escuro)
    ctx.fillStyle = '#1a0a2a';
    ctx.fillRect(x0 + 11, y0 + 6, 10, 4);
    // Borda da abertura
    ctx.fillStyle = '#9c27b0';
    ctx.fillRect(x0 + 11, y0 + 6, 10, 1);
    ctx.fillRect(x0 + 11, y0 + 9, 10, 1);
    // Padrão decorativo (linhas verticais)
    ctx.fillStyle = '#ce93d8';
    ctx.fillRect(x0 + 13, y0 + 11, 1, 6);
    ctx.fillRect(x0 + 18, y0 + 11, 1, 6);
  }

  // Pitcher Crop: planta brotando (cresce em fases)
  function pintarPitcherCrop(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a2510';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Solo marrom
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0, y0 + CELL - 4, CELL, 4);
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0, y0 + CELL - 4, CELL, 1);
    // Brotos verdes saindo
    ctx.fillStyle = '#388e3c';
    ctx.fillRect(x0 + 8,  y0 + 18, 2, 10);
    ctx.fillRect(x0 + 14, y0 + 14, 2, 14);
    ctx.fillRect(x0 + 22, y0 + 20, 2, 8);
    // Folhinhas brotando (verdes)
    ctx.fillStyle = '#66bb6a';
    ctx.fillRect(x0 + 6,  y0 + 18, 5, 2);
    ctx.fillRect(x0 + 12, y0 + 14, 6, 2);
    ctx.fillRect(x0 + 20, y0 + 20, 5, 2);
    // Pontos roxos (botões)
    ctx.fillStyle = '#7b1fa2';
    ctx.fillRect(x0 + 14, y0 + 12, 2, 2);
    ctx.fillStyle = '#ce93d8';
    ctx.fillRect(x0 + 14, y0 + 12, 1, 1);
  }

  // Torchflower: flor laranja brilhante como tocha
  function pintarTorchflower(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a2510';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Caule verde
    ctx.fillStyle = '#2e7d32';
    ctx.fillRect(x0 + 14, y0 + 18, 4, 12);
    ctx.fillStyle = '#388e3c';
    ctx.fillRect(x0 + 14, y0 + 18, 1, 12);
    // Folhas laterais
    ctx.fillStyle = '#66bb6a';
    ctx.fillRect(x0 + 8,  y0 + 22, 4, 2);
    ctx.fillRect(x0 + 20, y0 + 22, 4, 2);
    // Flor "tocha" laranja (cabeça grande)
    ctx.fillStyle = '#e65100';
    ctx.fillRect(x0 + 10, y0 + 6,  12, 12);
    ctx.fillStyle = '#ff9800';
    ctx.fillRect(x0 + 11, y0 + 7,  10, 10);
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 12, y0 + 8,  8, 8);
    ctx.fillStyle = '#fff176';
    ctx.fillRect(x0 + 14, y0 + 10, 4, 4);
    // Chama no topo
    ctx.fillStyle = '#ff5252';
    ctx.fillRect(x0 + 14, y0 + 4, 4, 2);
    ctx.fillStyle = '#fff8e1';
    ctx.fillRect(x0 + 15, y0 + 11, 2, 2);
  }

  // Torchflower Crop: muda da torchflower (verde com botão laranja)
  function pintarTorchflowerCrop(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a2510';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Solo
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0, y0 + CELL - 4, CELL, 4);
    // Caule curto
    ctx.fillStyle = '#388e3c';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 14);
    // Folhinhas pequenas
    ctx.fillStyle = '#66bb6a';
    ctx.fillRect(x0 + 10, y0 + 18, 4, 2);
    ctx.fillRect(x0 + 18, y0 + 18, 4, 2);
    ctx.fillRect(x0 + 12, y0 + 22, 8, 2);
    // Botão laranja (ainda fechado)
    ctx.fillStyle = '#bf360c';
    ctx.fillRect(x0 + 12, y0 + 8, 8, 6);
    ctx.fillStyle = '#e65100';
    ctx.fillRect(x0 + 13, y0 + 9, 6, 4);
    ctx.fillStyle = '#ff9800';
    ctx.fillRect(x0 + 14, y0 + 10, 4, 2);
  }

  // Sniffer Egg: ovo grande marrom-escuro com manchas (1.20)
  function pintarSnifferEgg(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a0a05';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Forma oval do ovo (largura crescente)
    ctx.fillStyle = '#7d3e1c';
    for (let y = 0; y < CELL; y++) {
      const alturaRel = y / CELL;
      const largura = Math.floor(8 + Math.sin(alturaRel * Math.PI) * 12);
      const meio = CELL / 2;
      ctx.fillRect(x0 + meio - largura / 2, y0 + y, largura, 1);
    }
    // Highlights
    ctx.fillStyle = '#a05a30';
    for (let y = 4; y < CELL - 4; y++) {
      const alturaRel = y / CELL;
      const largura = Math.floor(6 + Math.sin(alturaRel * Math.PI) * 9);
      const meio = CELL / 2;
      ctx.fillRect(x0 + meio - largura / 2, y0 + y, largura, 1);
    }
    // Manchas verdes (algas da pré-história)
    ctx.fillStyle = '#33691e';
    let s = idx * 17 + 33;
    for (let i = 0; i < 14; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = 8 + Math.floor((s / 233280) * 16);
      s = (s * 9301 + 49297) % 233280;
      const py = 4 + Math.floor((s / 233280) * 24);
      ctx.fillRect(x0 + px, y0 + py, 2, 2);
    }
    // Brilho superior
    ctx.fillStyle = '#c97a4d';
    ctx.fillRect(x0 + 12, y0 + 6, 4, 2);
    ctx.fillRect(x0 + 13, y0 + 7, 2, 1);
  }

  // Suspicious Sand: areia normal com pontos arqueológicos
  function pintarSuspiciousSand(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de areia
    ctx.fillStyle = '#f9a825';
    let s = idx * 11 + 19;
    for (let i = 0; i < 60; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
    // Marcas suspeitas (rachaduras retangulares)
    ctx.fillStyle = '#bf360c';
    ctx.fillRect(x0 + 8,  y0 + 8,  16, 1);
    ctx.fillRect(x0 + 8,  y0 + 8,  1,  16);
    ctx.fillRect(x0 + 8,  y0 + 23, 16, 1);
    ctx.fillRect(x0 + 23, y0 + 8,  1,  16);
    // X central (artefato escondido)
    ctx.fillStyle = '#8b0000';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 1);
    ctx.fillRect(x0 + 14, y0 + 17, 4, 1);
    ctx.fillRect(x0 + 14, y0 + 14, 1, 4);
    ctx.fillRect(x0 + 17, y0 + 14, 1, 4);
  }

  // Suspicious Gravel: cascalho cinza com marcas arqueológicas
  function pintarSuspiciousGravel(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#9e9e9e';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de cascalho
    ctx.fillStyle = '#757575';
    let s = idx * 13 + 23;
    for (let i = 0; i < 50; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 2, 2);
    }
    // Marcas suspeitas
    ctx.fillStyle = '#3a3a3a';
    ctx.fillRect(x0 + 8,  y0 + 8,  16, 1);
    ctx.fillRect(x0 + 8,  y0 + 8,  1,  16);
    ctx.fillRect(x0 + 8,  y0 + 23, 16, 1);
    ctx.fillRect(x0 + 23, y0 + 8,  1,  16);
    // X central
    ctx.fillStyle = '#000000';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 1);
    ctx.fillRect(x0 + 14, y0 + 17, 4, 1);
    ctx.fillRect(x0 + 14, y0 + 14, 1, 4);
    ctx.fillRect(x0 + 17, y0 + 14, 1, 4);
  }

  // Calibrated Sculk: sensor sculk calibrado (azul brilhante c/ ametista)
  function pintarCalibratedSculk(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#0a1a2a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Manchas sculk (azul-escuro)
    ctx.fillStyle = '#051018';
    let s = idx * 19 + 41;
    for (let i = 0; i < 40; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 2, 2);
    }
    // Bordas calibradas (ametista)
    ctx.fillStyle = '#ce93d8';
    ctx.fillRect(x0 + 2, y0 + 2, CELL - 4, 1);
    ctx.fillRect(x0 + 2, y0 + CELL - 3, CELL - 4, 1);
    ctx.fillRect(x0 + 2, y0 + 2, 1, CELL - 4);
    ctx.fillRect(x0 + CELL - 3, y0 + 2, 1, CELL - 4);
    // Sensor central (azul brilhante)
    ctx.fillStyle = '#40c4ff';
    ctx.fillRect(x0 + 8, y0 + 8, 16, 16);
    ctx.fillStyle = '#80d4ff';
    ctx.fillRect(x0 + 10, y0 + 10, 12, 12);
    ctx.fillStyle = '#e1f5fe';
    ctx.fillRect(x0 + 13, y0 + 13, 6, 6);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
    // 4 antenas (cantos com ametistas)
    ctx.fillStyle = '#ab47bc';
    ctx.fillRect(x0 + 4,  y0 + 4,  3, 3);
    ctx.fillRect(x0 + 25, y0 + 4,  3, 3);
    ctx.fillRect(x0 + 4,  y0 + 25, 3, 3);
    ctx.fillRect(x0 + 25, y0 + 25, 3, 3);
    ctx.fillStyle = '#e1bee7';
    ctx.fillRect(x0 + 5,  y0 + 5,  1, 1);
    ctx.fillRect(x0 + 26, y0 + 5,  1, 1);
    ctx.fillRect(x0 + 5,  y0 + 26, 1, 1);
    ctx.fillRect(x0 + 26, y0 + 26, 1, 1);
  }

  // Genérico: pinta log de madeira variante (casca + anéis verticais)
  function pintarLogVariante(idx, corBase, corCasca, corHigh, corAnel) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = corBase;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Listras verticais de casca
    ctx.fillStyle = corCasca;
    for (let i = 0; i < CELL; i += 4) {
      ctx.fillRect(x0 + i, y0, 1, CELL);
    }
    // Highlights claros
    ctx.fillStyle = corHigh;
    for (let i = 2; i < CELL; i += 4) {
      ctx.fillRect(x0 + i, y0 + ((i * 3) % 4), 1, CELL - ((i * 3) % 4));
    }
    // Manchas (anéis variados)
    ctx.fillStyle = corAnel;
    let s = idx * 17 + 31;
    for (let i = 0; i < 22; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 2, 1);
    }
  }

  // Genérico: pinta tronco descascado (anéis horizontais, sem casca)
  function pintarStrippedLog(idx, corBase, corAnel, corHigh) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = corBase;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Listras verticais sutis (grão da madeira)
    ctx.fillStyle = corAnel;
    for (let i = 0; i < CELL; i += 5) {
      ctx.fillRect(x0 + i, y0, 1, CELL);
    }
    // Anéis horizontais (interior do tronco)
    ctx.fillStyle = corHigh;
    ctx.fillRect(x0, y0 + 6,  CELL, 1);
    ctx.fillRect(x0, y0 + 14, CELL, 1);
    ctx.fillRect(x0, y0 + 22, CELL, 1);
    // Manchas claras
    ctx.fillStyle = corHigh;
    let s = idx * 13 + 25;
    for (let i = 0; i < 18; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
  }

  // Genérico: planta vertical fina (grama alta, samambaia, dead bush, etc)
  function pintarPlantaVertical(idx, corBase, corClaro, corEscuro, comTopo) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#0a0a05';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Várias hastes verticais finas com pontas
    let s = idx * 11 + 17;
    for (let i = 0; i < 8; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = 4 + Math.floor((s / 233280) * (CELL - 8));
      s = (s * 9301 + 49297) % 233280;
      const altura = 14 + Math.floor((s / 233280) * 14);
      ctx.fillStyle = corBase;
      ctx.fillRect(x0 + px, y0 + CELL - altura, 1, altura);
      // Folhinha lateral
      ctx.fillStyle = corClaro;
      ctx.fillRect(x0 + px - 1, y0 + CELL - altura + 4, 3, 1);
      ctx.fillRect(x0 + px - 1, y0 + CELL - altura + 8, 3, 1);
      // Topo
      if (comTopo) {
        ctx.fillStyle = corEscuro;
        ctx.fillRect(x0 + px - 1, y0 + CELL - altura, 3, 2);
      }
    }
    // Solo na base (escuro)
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
  }

  // Genérico: pinta folha variante (textura granulada de folhagem)
  function pintarFolhaVariante(idx, corBase, corClaro, corEscuro, corExtra) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = corBase;
    ctx.fillRect(x0, y0, CELL, CELL);
    let s = idx * 13 + 29;
    for (let i = 0; i < 90; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const pick = (s / 233280);
      ctx.fillStyle = pick < 0.4 ? corClaro : pick < 0.75 ? corEscuro : pick < 0.9 ? corExtra : corBase;
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
  }

  // Genérico: pinta pranchas (4 fileiras horizontais com divisões verticais alternadas)
  function pintarPranchaVariante(idx, corBase, corDiv, corMancha) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = corBase;
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = corDiv;
    // 4 fileiras horizontais
    ctx.fillRect(x0, y0 + 7,  CELL, 1);
    ctx.fillRect(x0, y0 + 15, CELL, 1);
    ctx.fillRect(x0, y0 + 23, CELL, 1);
    // Divisões verticais alternadas
    ctx.fillRect(x0 + 11, y0,      1, 7);
    ctx.fillRect(x0 + 21, y0 + 8,  1, 7);
    ctx.fillRect(x0 + 11, y0 + 16, 1, 7);
    ctx.fillRect(x0 + 21, y0 + 24, 1, CELL - 24);
    // Manchas
    ctx.fillStyle = corMancha;
    let s = idx * 11 + 19;
    for (let i = 0; i < 16; i++) {
      s = (s * 9301 + 49297) % 233280;
      const px = Math.floor((s / 233280) * CELL);
      s = (s * 9301 + 49297) % 233280;
      const py = Math.floor((s / 233280) * CELL);
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
  }

  // Bookshelf Chiseled: estante com 1 livro central destacado
  function pintarBookshelfChiseled(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0 + 2, y0 + 2, CELL - 4, CELL - 4);
    // Espaço dos livros (mais escuro)
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0 + 4, y0 + 5, CELL - 8, 22);
    // 1 livro central destacado (mais largo, dourado)
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 12, y0 + 6, 8, 20);
    ctx.fillStyle = '#fff176';
    ctx.fillRect(x0 + 13, y0 + 7, 1, 18);
    // Faixas douradas decorativas
    ctx.fillStyle = '#a05a30';
    ctx.fillRect(x0 + 12, y0 + 10, 8, 1);
    ctx.fillRect(x0 + 12, y0 + 22, 8, 1);
    // Livros laterais menores (vermelhos/azuis)
    ctx.fillStyle = '#c62828';
    ctx.fillRect(x0 + 5, y0 + 6, 5, 20);
    ctx.fillStyle = '#1565c0';
    ctx.fillRect(x0 + 22, y0 + 6, 5, 20);
  }

  // Jukebox: madeira escura com gemstone azul/diamante no topo
  function pintarJukebox(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#6d4c41';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Borda escura
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0, y0, CELL, 2);
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0, y0, 2, CELL);
    ctx.fillRect(x0 + CELL - 2, y0, 2, CELL);
    // Gemstone diamante central
    ctx.fillStyle = '#4dd0e1';
    ctx.fillRect(x0 + 10, y0 + 10, 12, 12);
    ctx.fillStyle = '#80deea';
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    // Linhas decorativas (madeira tipo amplificador)
    ctx.fillStyle = '#8d6e63';
    for (let py = 26; py < CELL - 2; py += 2) {
      ctx.fillRect(x0 + 4, y0 + py, CELL - 8, 1);
    }
  }

  // Daylight Detector: vidro azul-claro semi-transparente sobre madeira
  function pintarDaylightDetector(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base de madeira
    ctx.fillStyle = '#6d4c41';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Vidro detector central
    ctx.fillStyle = '#80deea';
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, CELL - 8);
    ctx.fillStyle = '#b3e5fc';
    ctx.fillRect(x0 + 6, y0 + 6, CELL - 12, CELL - 12);
    // Reflexos brancos (cristal)
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 8, y0 + 8, 4, 1);
    ctx.fillRect(x0 + 8, y0 + 9, 2, 1);
    // Bordas escuras
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Note Block: madeira com pauta musical no topo (5 linhas + nota)
  function pintarNoteBlock(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Pauta musical (5 linhas horizontais)
    ctx.fillStyle = '#3e2723';
    for (let i = 0; i < 5; i++) {
      ctx.fillRect(x0 + 4, y0 + 6 + i * 4, CELL - 8, 1);
    }
    // Nota musical (círculo + haste)
    ctx.fillStyle = '#212121';
    ctx.fillRect(x0 + 12, y0 + 16, 4, 4);
    ctx.fillRect(x0 + 16, y0 + 6,  1, 14);
    // Borda escura
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0, y0, CELL, 2);
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
  }

  // Bell: sino dourado com base preta
  function pintarBell(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Sino dourado (campana)
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 8,  y0 + 6,  16, 16);
    ctx.fillStyle = '#fff176';
    ctx.fillRect(x0 + 10, y0 + 8,  12, 10);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 12, y0 + 10, 8, 4);
    // Topo (alça)
    ctx.fillStyle = '#a05a30';
    ctx.fillRect(x0 + 14, y0 + 2,  4, 4);
    ctx.fillRect(x0 + 12, y0 + 4,  8, 2);
    // Base/badalo
    ctx.fillStyle = '#a05a30';
    ctx.fillRect(x0 + 14, y0 + 22, 4, 6);
    ctx.fillStyle = '#212121';
    ctx.fillRect(x0 + 15, y0 + 26, 2, 2);
  }

  // Target Block: branco com 4 anéis vermelhos concêntricos (alvo)
  function pintarTarget(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#fafafa';
    ctx.fillRect(x0, y0, CELL, CELL);
    // 4 anéis concêntricos vermelhos
    const cores = ['#fafafa', '#ef9a9a', '#e57373', '#ef5350', '#c62828'];
    for (let r = 14; r >= 2; r -= 3) {
      ctx.fillStyle = cores[Math.floor((14 - r) / 3)];
      ctx.fillRect(x0 + 16 - r, y0 + 16 - r, r * 2, r * 2);
    }
    // Centro (bullseye)
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
  }

  // Ancient Debris: marrom com manchas roxas brilhantes (raríssimo)
  function pintarAncientDebris(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#6d4c41';
    ctx.fillRect(x0, y0, CELL, CELL);
    spawnPontosUniforme(x0, y0, CELL, CELL, '#4e342e', 0.40, 4, 2, idx * 9301 + 49297);
    // Centro com cluster netherite (preto-roxo)
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0 + 8, y0 + 8, 16, 16);
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#9c27b0';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 15, 1, 1);
  }

  // Honeycomb Block: padrão hexagonal de favos
  function pintarHoneycombBlock(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#ff9800';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão hexagonal (3x3 grid)
    ctx.fillStyle = '#fdd835';
    for (let row2 = 0; row2 < 3; row2++) {
      for (let col2 = 0; col2 < 3; col2++) {
        const cx = 4 + col2 * 9;
        const cy = 4 + row2 * 8 + (col2 % 2 === 1 ? 4 : 0);
        if (cx + 7 < CELL && cy + 7 < CELL) {
          ctx.fillRect(x0 + cx, y0 + cy, 7, 6);
        }
      }
    }
    // Bordas escuras
    ctx.fillStyle = '#e65100';
    for (let row2 = 0; row2 < 3; row2++) {
      for (let col2 = 0; col2 < 3; col2++) {
        const cx = 4 + col2 * 9;
        const cy = 4 + row2 * 8 + (col2 % 2 === 1 ? 4 : 0);
        if (cx + 7 < CELL && cy + 7 < CELL) {
          ctx.fillRect(x0 + cx, y0 + cy, 7, 1);
          ctx.fillRect(x0 + cx, y0 + cy + 5, 7, 1);
        }
      }
    }
  }

  // Composter: madeira com topo aberto (caixa)
  function pintarComposter(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Topo aberto (interior escuro)
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, CELL - 8);
    // Tábuas verticais
    ctx.fillStyle = '#5d4037';
    for (let px = 4; px < CELL; px += 6) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
  }

  // Lectern (atril): madeira com livro aberto em cima
  function pintarLectern(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Inclinação superior (área de livro)
    ctx.fillStyle = '#a1887f';
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, 14);
    // Livro central (vermelho)
    ctx.fillStyle = '#c62828';
    ctx.fillRect(x0 + 8, y0 + 6, CELL - 16, 10);
    // Páginas (linhas brancas)
    ctx.fillStyle = '#fafafa';
    ctx.fillRect(x0 + 10, y0 + 8, CELL - 20, 2);
    ctx.fillRect(x0 + 10, y0 + 12, CELL - 20, 2);
    // Base com tábuas
    ctx.fillStyle = '#5d4037';
    for (let py = 20; py < CELL; py += 4) {
      ctx.fillRect(x0, y0 + py, CELL, 1);
    }
  }

  // Barrel: barril de madeira com aros de ferro
  function pintarBarrel(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Tábuas verticais (madeira)
    ctx.fillStyle = '#6d4c41';
    for (let px = 5; px < CELL; px += 5) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
    // 2 aros de ferro horizontais
    ctx.fillStyle = '#424242';
    ctx.fillRect(x0, y0 + 6,        CELL, 3);
    ctx.fillRect(x0, y0 + CELL - 9, CELL, 3);
    // Highlight dos aros
    ctx.fillStyle = '#9e9e9e';
    ctx.fillRect(x0, y0 + 6,        CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 9, CELL, 1);
  }

  // Campfire: 3 paus em X com chama amarela no topo
  function pintarCampfire(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // 3 paus em X
    ctx.fillStyle = '#5d4037';
    for (let i = 0; i < CELL - 2; i++) {
      ctx.fillRect(x0 + i, y0 + 22 - i / 4, 2, 2); // diagonal
      ctx.fillRect(x0 + (CELL - 2 - i), y0 + 22 - i / 4, 2, 2); // anti-diag
    }
    // Centro: brasa amarela
    ctx.fillStyle = '#ff9800';
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
    // Chamas no topo
    ctx.fillStyle = '#ff6f00';
    ctx.fillRect(x0 + 10, y0 + 4,  4, 8);
    ctx.fillRect(x0 + 18, y0 + 4,  4, 8);
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 11, y0 + 5,  2, 6);
    ctx.fillRect(x0 + 19, y0 + 5,  2, 6);
  }

  // Workstation genérica: madeira/pedra com painel central decorativo
  function pintarWorkstation(idx, base, escuro, claro, simbolo) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Borda escura (frame da workstation)
    ctx.fillStyle = escuro;
    ctx.fillRect(x0, y0, CELL, 2);
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0, y0, 2, CELL);
    ctx.fillRect(x0 + CELL - 2, y0, 2, CELL);
    // Painel central (área de trabalho)
    ctx.fillStyle = claro;
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, CELL - 8);
    // Símbolo central (caractere especial visual)
    ctx.fillStyle = escuro;
    if (simbolo === 'hammer') {
      // Martelo (smithing): retângulo + cabo
      ctx.fillRect(x0 + 10, y0 + 10, 12, 4);
      ctx.fillRect(x0 + 14, y0 + 14, 4, 12);
    } else if (simbolo === 'flask') {
      // Frasco (brewing): forma de garrafa
      ctx.fillRect(x0 + 14, y0 + 8,  4, 4);
      ctx.fillRect(x0 + 12, y0 + 12, 8, 4);
      ctx.fillRect(x0 + 10, y0 + 16, 12, 8);
    } else if (simbolo === 'fire') {
      // Chama (furnace/smoker)
      ctx.fillRect(x0 + 12, y0 + 18, 8, 4);
      ctx.fillStyle = '#ff9800';
      ctx.fillRect(x0 + 13, y0 + 14, 6, 4);
      ctx.fillStyle = '#fdd835';
      ctx.fillRect(x0 + 14, y0 + 12, 4, 2);
    } else if (simbolo === 'map') {
      // Mapa (cartography)
      ctx.fillRect(x0 + 10, y0 + 10, 12, 1);
      ctx.fillRect(x0 + 10, y0 + 14, 8, 1);
      ctx.fillRect(x0 + 10, y0 + 18, 12, 1);
      ctx.fillRect(x0 + 10, y0 + 22, 6, 1);
    } else if (simbolo === 'arrow') {
      // Flecha (fletching)
      ctx.fillRect(x0 + 10, y0 + 16, 12, 2);
      ctx.fillRect(x0 + 8,  y0 + 14, 2, 6);
      ctx.fillRect(x0 + 22, y0 + 14, 2, 6);
    } else if (simbolo === 'loom') {
      // Tear (linhas verticais)
      for (const px of [10, 14, 18, 22]) ctx.fillRect(x0 + px, y0 + 8, 1, CELL - 16);
      ctx.fillRect(x0 + 8, y0 + 14, CELL - 16, 1);
    } else if (simbolo === 'saw') {
      // Serra (stonecutter)
      ctx.fillRect(x0 + 8, y0 + 16, CELL - 16, 1);
      for (const px of [9, 12, 15, 18, 21]) {
        ctx.fillRect(x0 + px, y0 + 14, 2, 2);
      }
    }
  }

  // Hopper: caixa preta com buraco central (formato funil)
  function pintarHopper(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#212121';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Borda metálica
    ctx.fillStyle = '#424242';
    ctx.fillRect(x0 + 2, y0 + 2, CELL - 4, CELL - 4);
    // Buraco central (funil convergente)
    ctx.fillStyle = '#0a0a0a';
    ctx.fillRect(x0 + 8, y0 + 8, 16, 16);
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#000000';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    // Rebites nos cantos
    ctx.fillStyle = '#616161';
    for (const [cx, cy] of [[3, 3], [CELL-5, 3], [3, CELL-5], [CELL-5, CELL-5]]) {
      ctx.fillRect(x0 + cx, y0 + cy, 2, 2);
    }
  }

  // Dispenser: pedra com face circular (mira) + ranhura
  function pintarDispenser(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#6E6E6E';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Ruído de pedra
    spawnPontosUniforme(x0, y0, CELL, CELL, '#5E5E5E', 0.30, 4, 2, idx * 9301 + 49297);
    // Face circular escura (mira do dispenser)
    ctx.fillStyle = '#212121';
    ctx.fillRect(x0 + 8, y0 + 8, 16, 16);
    ctx.fillStyle = '#000000';
    ctx.fillRect(x0 + 10, y0 + 10, 12, 12);
    // Núcleo (cruz central)
    ctx.fillStyle = '#424242';
    ctx.fillRect(x0 + CELL/2 - 1, y0 + 11, 2, 10);
    ctx.fillRect(x0 + 11, y0 + CELL/2 - 1, 10, 2);
    // Brilho metálico no centro
    ctx.fillStyle = '#9e9e9e';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
  }

  // Observer: pedra com 1 olho vermelho central
  function pintarObserver(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#4a4a4a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Ruído de pedra escura
    spawnPontosUniforme(x0, y0, CELL, CELL, '#2a2a2a', 0.40, 4, 2, idx * 9301 + 49297);
    // Olho vermelho central (sensor)
    ctx.fillStyle = '#c62828';
    ctx.fillRect(x0 + 10, y0 + 10, 12, 12);
    ctx.fillStyle = '#ef5350';
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#ff8a80';
    ctx.fillRect(x0 + 13, y0 + 13, 6, 6);
    // Pupila preta
    ctx.fillStyle = '#000000';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    // Reflexo branco
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 14, y0 + 14, 1, 1);
  }

  // Soul Torch: tocha com chama azul-ciano
  function pintarSoulTorch(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 14, y0 + 12, 4, 18);
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0 + 14, y0 + 12, 1, 18);
    // Topo azul-ciano (chama soul fire)
    ctx.fillStyle = '#0288d1';
    ctx.fillRect(x0 + 12, y0 + 4,  8, 9);
    ctx.fillStyle = '#40c4ff';
    ctx.fillRect(x0 + 13, y0 + 5,  6, 7);
    ctx.fillStyle = '#80deea';
    ctx.fillRect(x0 + 14, y0 + 6,  4, 5);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 7,  2, 2);
    // Glow translúcido azul
    ctx.fillStyle = 'rgba(100, 200, 255, 0.20)';
    ctx.fillRect(x0 + 11, y0 + 3, 10, 11);
  }

  // Tocha Redstone: igual tocha mas chama vermelha
  function pintarTochaRedstone(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Cabo de madeira centralizado
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0 + 14, y0 + 12, 4, 18);
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 14, y0 + 12, 1, 18);
    // Topo vermelho (chama redstone)
    ctx.fillStyle = '#c62828';
    ctx.fillRect(x0 + 12, y0 + 4,  8, 9);
    ctx.fillStyle = '#ef5350';
    ctx.fillRect(x0 + 13, y0 + 5,  6, 7);
    ctx.fillStyle = '#ff8a80';
    ctx.fillRect(x0 + 14, y0 + 6,  4, 5);
    // Núcleo brilhante branco
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 7,  2, 2);
    // Glow translúcido
    ctx.fillStyle = 'rgba(255, 100, 100, 0.20)';
    ctx.fillRect(x0 + 11, y0 + 3, 10, 11);
  }

  // Cogumelo pequeno: chapéu colorido + caule branco
  function pintarCogumeloPeq(idx, corChapeu, comBolinhas) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro
    ctx.fillStyle = '#0a0a0a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Caule branco vertical
    ctx.fillStyle = '#fafafa';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 14);
    ctx.fillStyle = '#bdbdbd';
    ctx.fillRect(x0 + 14, y0 + 14, 1, 14);
    // Chapéu (semicírculo aproximado)
    ctx.fillStyle = corChapeu;
    ctx.fillRect(x0 + 8,  y0 + 6,  16, 8);
    ctx.fillRect(x0 + 10, y0 + 4,  12, 2);
    // Borda escura do chapéu
    ctx.fillStyle = '#000000';
    ctx.fillRect(x0 + 8,  y0 + 14, 16, 1);
    ctx.fillStyle = '#212121';
    ctx.fillRect(x0 + 10, y0 + 4,  12, 1);
    if (comBolinhas) {
      // Bolinhas brancas no chapéu (cogumelo amanita)
      ctx.fillStyle = '#fafafa';
      ctx.fillRect(x0 + 11, y0 + 8,  2, 2);
      ctx.fillRect(x0 + 17, y0 + 7,  2, 2);
      ctx.fillRect(x0 + 14, y0 + 11, 2, 2);
      ctx.fillRect(x0 + 19, y0 + 11, 2, 2);
    }
  }

  // Caveira de esqueleto: branca com 2 olhos pretos + boca
  function pintarCaveira(idx, wither) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro
    ctx.fillStyle = '#0a0a0a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Crânio (cubo principal)
    const corBase = wither ? '#424242' : '#eceff1';
    const corSombra = wither ? '#212121' : '#bdbdbd';
    ctx.fillStyle = corBase;
    ctx.fillRect(x0 + 6, y0 + 6, 20, 20);
    // Sombras
    ctx.fillStyle = corSombra;
    ctx.fillRect(x0 + 6,  y0 + 6,  20, 1);
    ctx.fillRect(x0 + 6,  y0 + 25, 20, 1);
    ctx.fillRect(x0 + 6,  y0 + 6,  1,  20);
    ctx.fillRect(x0 + 25, y0 + 6,  1,  20);
    // 2 olhos pretos grandes
    const corOlho = wither ? '#1a1a1a' : '#000000';
    ctx.fillStyle = corOlho;
    ctx.fillRect(x0 + 9,  y0 + 11, 5, 5);
    ctx.fillRect(x0 + 18, y0 + 11, 5, 5);
    if (wither) {
      // Olhos vermelhos para wither
      ctx.fillStyle = '#c62828';
      ctx.fillRect(x0 + 10, y0 + 12, 3, 3);
      ctx.fillRect(x0 + 19, y0 + 12, 3, 3);
    }
    // Boca (linha horizontal preta com dentes)
    ctx.fillStyle = corOlho;
    ctx.fillRect(x0 + 9, y0 + 19, 14, 3);
    // Dentes (linhas verticais cortando a boca)
    ctx.fillStyle = corBase;
    ctx.fillRect(x0 + 12, y0 + 19, 1, 3);
    ctx.fillRect(x0 + 15, y0 + 19, 1, 3);
    ctx.fillRect(x0 + 18, y0 + 19, 1, 3);
  }

  // TNT: vermelho com listras pretas + texto "TNT" branco
  function pintarTNT(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#c62828';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Listras pretas top/bot (cinto explosivo)
    ctx.fillStyle = '#212121';
    ctx.fillRect(x0, y0,           CELL, 4);
    ctx.fillRect(x0, y0 + CELL - 4, CELL, 4);
    // Texto "TNT" central (3 letras estilizadas pixel art)
    ctx.fillStyle = '#fafafa';
    // T
    ctx.fillRect(x0 + 4,  y0 + 12, 5, 1);
    ctx.fillRect(x0 + 6,  y0 + 12, 1, 8);
    // N
    ctx.fillRect(x0 + 12, y0 + 12, 1, 8);
    ctx.fillRect(x0 + 17, y0 + 12, 1, 8);
    ctx.fillRect(x0 + 13, y0 + 13, 1, 1);
    ctx.fillRect(x0 + 14, y0 + 14, 1, 1);
    ctx.fillRect(x0 + 15, y0 + 15, 1, 1);
    ctx.fillRect(x0 + 16, y0 + 16, 1, 1);
    // T
    ctx.fillRect(x0 + 21, y0 + 12, 5, 1);
    ctx.fillRect(x0 + 23, y0 + 12, 1, 8);
    // Bordas escuras nas listras
    ctx.fillStyle = '#000000';
    ctx.fillRect(x0, y0 + 4,        CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 5, CELL, 1);
    // Manchas vermelhas mais escuras (textura)
    spawnPontosUniforme(x0, y0 + 4, CELL, CELL - 8, '#8b0000', 0.30, 4, 1, idx * 9301 + 49297);
  }

  // Flor: haste verde fina + pétalas coloridas no topo
  function pintarFlor(idx, corPet, corMiolo) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro pra realçar
    ctx.fillStyle = '#0a0a0a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Haste verde fina vertical (centralizada)
    ctx.fillStyle = '#2e7d32';
    ctx.fillRect(x0 + 15, y0 + 14, 2, 16);
    // Sombra da haste
    ctx.fillStyle = '#1b5e20';
    ctx.fillRect(x0 + 16, y0 + 14, 1, 16);
    // 4 folhas saindo da haste
    ctx.fillStyle = '#388e3c';
    ctx.fillRect(x0 + 12, y0 + 18, 3, 1);
    ctx.fillRect(x0 + 17, y0 + 22, 3, 1);
    ctx.fillRect(x0 + 13, y0 + 26, 3, 1);
    // Pétalas coloridas (5 quadrados ao redor do miolo)
    ctx.fillStyle = corPet;
    ctx.fillRect(x0 + 12, y0 + 5,  4, 4);  // esq
    ctx.fillRect(x0 + 16, y0 + 5,  4, 4);  // dir
    ctx.fillRect(x0 + 14, y0 + 2,  4, 4);  // top
    ctx.fillRect(x0 + 12, y0 + 9,  4, 4);  // esq-bot
    ctx.fillRect(x0 + 16, y0 + 9,  4, 4);  // dir-bot
    // Sombras das pétalas
    ctx.fillStyle = '#000000';
    ctx.fillRect(x0 + 12, y0 + 5, 1, 4);
    ctx.fillRect(x0 + 19, y0 + 5, 1, 4);
    ctx.fillRect(x0 + 14, y0 + 2, 1, 4);
    // Miolo amarelo central
    ctx.fillStyle = corMiolo;
    ctx.fillRect(x0 + 14, y0 + 6, 4, 4);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 7, 2, 2);
  }

  // Vaso de flor: pote de tijolo marrom (vasinho cônico)
  function pintarVasoFlor(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro
    ctx.fillStyle = '#0a0a0a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Pote (parte central marrom)
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0 + 8, y0 + 14, 16, 12);
    // Borda superior do pote (mais clara)
    ctx.fillStyle = '#a1887f';
    ctx.fillRect(x0 + 6, y0 + 12, 20, 2);
    // Sombra interna do pote
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 8, y0 + 14, 16, 1);
    ctx.fillRect(x0 + 8, y0 + 14, 1, 12);
    ctx.fillRect(x0 + 23, y0 + 14, 1, 12);
    ctx.fillRect(x0 + 8, y0 + 25, 16, 1);
    // Padrão decorativo (3 linhas claras horizontais)
    ctx.fillStyle = '#bcaaa4';
    ctx.fillRect(x0 + 9, y0 + 17, 14, 1);
    ctx.fillRect(x0 + 9, y0 + 21, 14, 1);
  }

  // Grade de Ferro: padrão de barras verticais + horizontal central
  function pintarGradeFerro(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro
    ctx.fillStyle = '#0a0a0a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // 4 barras verticais
    ctx.fillStyle = '#cfd8dc';
    for (const px of [4, 12, 20, 28]) {
      ctx.fillRect(x0 + px - 1, y0, 2, CELL);
    }
    // Highlights
    ctx.fillStyle = '#eceff1';
    for (const px of [4, 12, 20, 28]) {
      ctx.fillRect(x0 + px - 1, y0, 1, CELL);
    }
    // Sombras
    ctx.fillStyle = '#90a4ae';
    for (const px of [5, 13, 21, 29]) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
    // Barra horizontal central (cruzando)
    ctx.fillStyle = '#cfd8dc';
    ctx.fillRect(x0, y0 + 14, CELL, 2);
    ctx.fillStyle = '#eceff1';
    ctx.fillRect(x0, y0 + 14, CELL, 1);
  }

  // Porta colorida (genérico): tábuas verticais + maçaneta + dobradiças
  function pintarPortaCor(idx, base, escuro, claro, mac) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // 3 tábuas verticais (separadas por linhas escuras)
    ctx.fillStyle = escuro;
    ctx.fillRect(x0 + 10, y0, 1, CELL);
    ctx.fillRect(x0 + 21, y0, 1, CELL);
    // Highlights claros nas tábuas
    ctx.fillStyle = claro;
    ctx.fillRect(x0 + 5,  y0, 1, CELL);
    ctx.fillRect(x0 + 16, y0, 1, CELL);
    ctx.fillRect(x0 + 26, y0, 1, CELL);
    // 3 dobradiças (lado esquerdo)
    ctx.fillStyle = mac;
    ctx.fillRect(x0 + 1, y0 + 4,  3, 4);
    ctx.fillRect(x0 + 1, y0 + 14, 3, 4);
    ctx.fillRect(x0 + 1, y0 + 24, 3, 4);
    // Maçaneta dourada (lado direito, altura média)
    ctx.fillStyle = '#FFD700';
    ctx.fillRect(x0 + CELL - 4, y0 + 14, 3, 3);
    ctx.fillStyle = '#fff8e1';
    ctx.fillRect(x0 + CELL - 3, y0 + 15, 1, 1);
    // Borda escura
    ctx.fillStyle = escuro;
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Trapdoor: padrão de tábuas + 2 dobradiças
  function pintarTrapdoor(idx, base, escuro, ferro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    if (ferro) {
      // Trapdoor de ferro: padrão grade metálica
      ctx.fillStyle = escuro;
      // Cruz central
      for (let i = 4; i < CELL; i += 6) {
        ctx.fillRect(x0 + i, y0, 1, CELL);
        ctx.fillRect(x0, y0 + i, CELL, 1);
      }
      // Rebites nos cantos
      ctx.fillStyle = '#212121';
      for (const [cx, cy] of [[3, 3], [CELL-4, 3], [3, CELL-4], [CELL-4, CELL-4]]) {
        ctx.fillRect(x0 + cx, y0 + cy, 2, 2);
      }
    } else {
      // Trapdoor de madeira: 4 tábuas horizontais + grão vertical
      ctx.fillStyle = escuro;
      ctx.fillRect(x0, y0 + 7,  CELL, 1);
      ctx.fillRect(x0, y0 + 15, CELL, 1);
      ctx.fillRect(x0, y0 + 23, CELL, 1);
      // Grão vertical
      ctx.fillStyle = '#7a5b50';
      for (let px = 5; px < CELL; px += 7) {
        ctx.fillRect(x0 + px, y0, 1, CELL);
      }
      // 2 dobradiças metálicas no topo
      ctx.fillStyle = '#424242';
      ctx.fillRect(x0 + 6,  y0 + 1, 5, 3);
      ctx.fillRect(x0 + 21, y0 + 1, 5, 3);
    }
    // Borda escura
    ctx.fillStyle = escuro;
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Placa de madeira: textura tábua com 3 linhas horizontais (texto futuro)
  function pintarSign(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#a1887f';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Topo da placa (área de texto)
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0 + 2, y0 + 2, CELL - 4, 18);
    // 3 linhas horizontais escuras (texto stylized)
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + 4,  y0 + 6,  CELL - 8, 2);
    ctx.fillRect(x0 + 4,  y0 + 11, CELL - 14, 2);
    ctx.fillRect(x0 + 4,  y0 + 16, CELL - 6, 2);
    // Estaca embaixo (suporte)
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0 + CELL/2 - 1, y0 + 20, 2, CELL - 20);
    // Borda
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0, y0, CELL, 2);
    ctx.fillRect(x0, y0 + 20, CELL, 1);
    ctx.fillRect(x0, y0, 2, 20);
    ctx.fillRect(x0 + CELL - 2, y0, 2, 20);
  }

  // Sculk: azul-escuro com pontos brilhantes ciano (orgânico)
  function pintarSculk(idx, variante) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base preto-azulada
    ctx.fillStyle = '#0a1a2a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Manchas mais escuras
    spawnPontosUniforme(x0, y0, CELL, CELL, '#051018', 0.45, 4, 2, idx * 9301 + 49297);
    // Padrão orgânico (manchas azuis claras espalhadas)
    spawnPontosUniforme(x0, y0, CELL, CELL, '#1a3a5a', 0.50, 4, 2, idx * 9301 + 7331);
    // Pontos super-brilhantes ciano (estrutura sculk)
    if (variante === 'plain') {
      spawnPontosUniforme(x0, y0, CELL, CELL, '#40c4ff', 0.20, 5, 1, idx * 9301 + 12347);
      spawnPontosUniforme(x0, y0, CELL, CELL, '#ffffff', 0.10, 7, 1, idx * 9301 + 19999);
    } else if (variante === 'shrieker') {
      // Shrieker: padrão central de "boca" azul-claro
      ctx.fillStyle = '#40c4ff';
      ctx.fillRect(x0 + 8, y0 + 12, 16, 8);
      ctx.fillStyle = '#0288d1';
      ctx.fillRect(x0 + 10, y0 + 14, 12, 4);
      // Dentes/projeções amarelas
      ctx.fillStyle = '#fff176';
      for (let bx = 11; bx < 22; bx += 3) {
        ctx.fillRect(x0 + bx, y0 + 13, 1, 2);
        ctx.fillRect(x0 + bx, y0 + 18, 1, 2);
      }
      ctx.fillStyle = '#ffffff';
      ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
    } else if (variante === 'sensor') {
      // Sensor: 2 antenas ciano + nodo central
      ctx.fillStyle = '#40c4ff';
      ctx.fillRect(x0 + 14, y0 + 4,  4, 8);
      ctx.fillRect(x0 + 14, y0 + 20, 4, 8);
      ctx.fillRect(x0 + 4,  y0 + 14, 8, 4);
      ctx.fillRect(x0 + 20, y0 + 14, 8, 4);
      // Núcleo central
      ctx.fillStyle = '#80deea';
      ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
      ctx.fillStyle = '#ffffff';
      ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    } else if (variante === 'catalyst') {
      // Catalyst: 4 nodos brilhantes nos cantos + cruz central
      ctx.fillStyle = '#4dd0e1';
      ctx.fillRect(x0 + 4,  y0 + 4,  4, 4);
      ctx.fillRect(x0 + 24, y0 + 4,  4, 4);
      ctx.fillRect(x0 + 4,  y0 + 24, 4, 4);
      ctx.fillRect(x0 + 24, y0 + 24, 4, 4);
      ctx.fillStyle = '#80deea';
      ctx.fillRect(x0 + CELL/2 - 2, y0 + 8,  4, 16);
      ctx.fillRect(x0 + 8, y0 + CELL/2 - 2,  16, 4);
      ctx.fillStyle = '#ffffff';
      ctx.fillRect(x0 + CELL/2 - 1, y0 + CELL/2 - 1, 2, 2);
    } else if (variante === 'vein') {
      // Vein: padrão de veias finas (curvas)
      ctx.fillStyle = '#1a3a5a';
      ctx.fillRect(x0 + 4, y0 + 8,  4, 1);
      ctx.fillRect(x0 + 8, y0 + 9,  6, 1);
      ctx.fillRect(x0 + 14, y0 + 10, 8, 1);
      ctx.fillRect(x0 + 22, y0 + 11, 6, 1);
      ctx.fillRect(x0 + 4, y0 + 22, 6, 1);
      ctx.fillRect(x0 + 10, y0 + 21, 8, 1);
      ctx.fillRect(x0 + 18, y0 + 22, 6, 1);
      ctx.fillStyle = '#40c4ff';
      ctx.fillRect(x0 + 8, y0 + 15, 1, 1);
      ctx.fillRect(x0 + 16, y0 + 18, 1, 1);
      ctx.fillRect(x0 + 24, y0 + 14, 1, 1);
    }
  }

  // Cama colorida: padrão simples com travesseiro claro + manta colorida
  function pintarCama(idx, base, escuro, claro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Manta colorida (parte principal)
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Travesseiro branco-claro no topo (terceiro superior)
    ctx.fillStyle = '#fafafa';
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, 8);
    // Borda escura do travesseiro
    ctx.fillStyle = '#9e9e9e';
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, 1);
    ctx.fillRect(x0 + 4, y0 + 11, CELL - 8, 1);
    // Listras horizontais na manta (textura tecida)
    ctx.fillStyle = escuro;
    ctx.fillRect(x0, y0 + 16, CELL, 1);
    ctx.fillRect(x0, y0 + 22, CELL, 1);
    // Highlights claros nas listras
    ctx.fillStyle = claro;
    ctx.fillRect(x0, y0 + 18, CELL, 1);
    ctx.fillRect(x0, y0 + 24, CELL, 1);
    // Borda escura do bloco
    ctx.fillStyle = escuro;
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Pranchas (Crimson/Warped): tábuas horizontais com grão vertical
  function pintarPlanksColorida(idx, base, escuro, claro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // 4 tábuas horizontais (linhas escuras separando)
    ctx.fillStyle = escuro;
    ctx.fillRect(x0, y0 + 7,  CELL, 1);
    ctx.fillRect(x0, y0 + 15, CELL, 1);
    ctx.fillRect(x0, y0 + 23, CELL, 1);
    // Grão vertical sutil (linhas claras alternadas)
    ctx.fillStyle = claro;
    for (let px = 4; px < CELL; px += 6) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
    // Borda escura dos cantos
    ctx.fillStyle = escuro;
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Esponja: amarela com 9 buracos pretos (esponja seca) ou marrom (molhada)
  function pintarEsponja(idx, base, buraco) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // 9 buracos em grid 3x3 (estilo esponja MC)
    ctx.fillStyle = buraco;
    for (let by = 4; by < CELL - 4; by += 9) {
      for (let bx = 4; bx < CELL - 4; bx += 9) {
        ctx.fillRect(x0 + bx, y0 + by, 4, 4);
      }
    }
    // Highlights claros entre buracos
    spawnPontosUniforme(x0, y0, CELL, CELL, '#ffffff', 0.20, 5, 1, idx * 9301 + 49297);
  }

  // Jack-o-Lantern: pumpkin carved com chama amarela emissiva
  function pintarJackOLantern(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base laranja
    ctx.fillStyle = '#e65100';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Ridges verticais
    ctx.fillStyle = '#bf360c';
    for (let px = 4; px < CELL; px += 8) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
    ctx.fillStyle = '#ff9800';
    for (let px = 1; px < CELL; px += 8) {
      ctx.fillRect(x0 + px, y0, 2, CELL);
    }
    // Face brilhante (olhos + boca em chama amarela)
    ctx.fillStyle = '#fff176';
    ctx.fillRect(x0 + 6, y0 + 10, 5, 4);
    ctx.fillRect(x0 + 21, y0 + 10, 5, 4);
    ctx.fillRect(x0 + 8, y0 + 20, 16, 4);
    // Núcleo branco super-brilhante (efeito de luz)
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 8, y0 + 11, 1, 1);
    ctx.fillRect(x0 + 23, y0 + 11, 1, 1);
    ctx.fillRect(x0 + 15, y0 + 21, 2, 1);
    // Halo difuso ao redor da face (glow)
    ctx.fillStyle = 'rgba(255, 235, 59, 0.3)';
    ctx.fillRect(x0 + 4, y0 + 8, CELL - 8, CELL - 12);
  }

  // Tinted Glass: vidro escuro (cinza-quase-preto) com reflexos sutis
  function pintarTintedGlass(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#424242';
    ctx.fillRect(x0 + 2, y0 + 2, CELL - 4, CELL - 4);
    // Borda
    ctx.fillStyle = '#000000';
    ctx.fillRect(x0, y0, CELL, 2);
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0, y0, 2, CELL);
    ctx.fillRect(x0 + CELL - 2, y0, 2, CELL);
    // Cruz central (caixilho)
    ctx.fillRect(x0 + CELL / 2 - 1, y0, 2, CELL);
    ctx.fillRect(x0, y0 + CELL / 2 - 1, CELL, 2);
    // Reflexo sutil (vidro mesmo escuro reflete um pouco)
    ctx.fillStyle = 'rgba(255, 255, 255, 0.10)';
    ctx.fillRect(x0 + 4, y0 + 4, 4, 1);
    ctx.fillRect(x0 + 4, y0 + 5, 2, 1);
  }

  // Snow Block / Powder Snow: branco puro com cristais de neve
  function pintarSnow(idx, comCristais) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#fafafa';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Sombras suaves (textura granular)
    spawnPontosUniforme(x0, y0, CELL, CELL, '#eceff1', 0.50, 4, 2, idx * 9301 + 49297);
    if (comCristais) {
      // Cristais de neve (estrelas pequenas)
      ctx.fillStyle = '#ffffff';
      for (let i = 0; i < 8; i++) {
        const xp = (i * 7 + 3) % (CELL - 6);
        const yp = (i * 11 + 5) % (CELL - 6);
        ctx.fillRect(x0 + xp,     y0 + yp + 2, 5, 1);
        ctx.fillRect(x0 + xp + 2, y0 + yp,     1, 5);
      }
    }
  }

  // Glow Lichen: padrão de líquen verde-claro brilhante
  function pintarGlowLichen(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#2e7d32';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de "musgo" orgânico (galhos)
    ctx.fillStyle = '#a5d6a7';
    spawnPontosUniforme(x0, y0, CELL, CELL, '#a5d6a7', 0.65, 3, 2, idx * 9301 + 49297);
    // Pontos super-brilhantes
    spawnPontosUniforme(x0, y0, CELL, CELL, '#fff176', 0.30, 5, 1, idx * 9301 + 7331);
  }

  // Spore Blossom: rosa com 5 pétalas + centro amarelo
  function pintarSporeBlossom(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // 5 pétalas grandes em volta
    ctx.fillStyle = '#f06292';
    const cx = 16, cy = 16, r = 11;
    for (let a = 0; a < 5; a++) {
      const ang = (a / 5) * Math.PI * 2;
      const px = Math.floor(cx + Math.cos(ang) * r);
      const py = Math.floor(cy + Math.sin(ang) * r);
      ctx.fillRect(x0 + px - 3, y0 + py - 3, 7, 7);
      // Sombra interna da pétala
      ctx.fillStyle = '#c2185b';
      ctx.fillRect(x0 + px - 1, y0 + py - 1, 3, 3);
      ctx.fillStyle = '#f06292';
    }
    // Centro amarelo (pólen)
    ctx.fillStyle = '#fdd835';
    ctx.fillRect(x0 + 13, y0 + 13, 6, 6);
    ctx.fillStyle = '#ffeb3b';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
  }

  // Slime Block: verde gelatinoso com padrão de bolhas + reflexos
  function pintarSlimeBlock(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#8bc34a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Bolhas escuras (efeito gelatinoso)
    ctx.fillStyle = '#558b2f';
    const bolhas = [
      { x: 6, y: 8, r: 5 },
      { x: 18, y: 6, r: 4 },
      { x: 22, y: 18, r: 5 },
      { x: 4, y: 22, r: 4 },
      { x: 14, y: 22, r: 3 },
    ];
    for (const b of bolhas) {
      ctx.fillRect(x0 + b.x, y0 + b.y, b.r, b.r);
    }
    // Highlights claros (brilho gelatinoso translúcido)
    ctx.fillStyle = '#aed581';
    for (const b of bolhas) {
      ctx.fillRect(x0 + b.x, y0 + b.y, 1, 1);
      ctx.fillRect(x0 + b.x + 1, y0 + b.y + 1, 1, 1);
    }
    // Reflexo branco diagonal
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 3, y0 + 3, 3, 1);
    ctx.fillRect(x0 + 4, y0 + 4, 2, 1);
    // Borda escura
    ctx.fillStyle = '#33691e';
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Crying Obsidian: obsidiana com gotas roxo-claro caindo
  function pintarCryingObsidian(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base obsidiana (roxo-escuro)
    ctx.fillStyle = '#311b92';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Manchas mais escuras
    spawnPontosUniforme(x0, y0, CELL, CELL, '#1a0a4a', 0.45, 4, 2, idx * 9301 + 49297);
    // 4 gotas roxo-claro caindo (com cauda vertical)
    const gotas = [{ x: 6, y: 5 }, { x: 14, y: 8 }, { x: 22, y: 4 }, { x: 26, y: 14 }];
    for (const g of gotas) {
      ctx.fillStyle = '#9c27b0';
      ctx.fillRect(x0 + g.x, y0 + g.y, 3, 3);
      ctx.fillStyle = '#ba68c8';
      ctx.fillRect(x0 + g.x + 1, y0 + g.y + 1, 1, 1);
      // Cauda da gota descendo
      ctx.fillStyle = '#7b1fa2';
      ctx.fillRect(x0 + g.x + 1, y0 + g.y + 4, 1, 6);
    }
    // Brilho central (energia)
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 7, y0 + 6, 1, 1);
    ctx.fillRect(x0 + 23, y0 + 5, 1, 1);
  }

  // Nether Wart Block: cor sólida com padrão orgânico (textura tipo musgo)
  function pintarNetherWart(idx, base, escuro, claro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Textura orgânica (manchas escuras + claras)
    let seed = idx * 9301 + 49297;
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, escuro, 0.50, 4, 3, seed);
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, claro, 0.40, 4, 2, seed + 4441);
    // Pontinhos brilhantes (esporos)
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#ffffff', 0.10, 7, 1, seed + 7331);
  }

  // Shroomlight: laranja brilhante com padrão de poros
  function pintarShroomlight(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#ff9800';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de poros radial (saindo do centro)
    ctx.fillStyle = '#fff176';
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#ffeb3b';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
    // Anéis radiais (poros do fungo)
    ctx.fillStyle = '#f57c00';
    for (const r of [4, 8]) {
      ctx.fillRect(x0 + 16 - r, y0 + 16 - r, r * 2, 1);
      ctx.fillRect(x0 + 16 - r, y0 + 16 + r - 1, r * 2, 1);
      ctx.fillRect(x0 + 16 - r, y0 + 16 - r, 1, r * 2);
      ctx.fillRect(x0 + 16 + r - 1, y0 + 16 - r, 1, r * 2);
    }
    // Pontos brilhantes ao redor (esporos)
    spawnPontosUniforme(x0, y0, CELL, CELL, '#ffeb3b', 0.20, 5, 1, idx * 9301 + 49297);
  }

  // End Brick: tijolos amarelos do end com mortar escuro
  function pintarEndBrick(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#e8d886';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Mortar escuro entre tijolos
    ctx.fillStyle = '#a08254';
    ctx.fillRect(x0, y0 + 15, CELL, 2);
    ctx.fillRect(x0 + 10, y0,      2, 15);
    ctx.fillRect(x0 + 22, y0,      2, 15);
    ctx.fillRect(x0 + 4,  y0 + 17, 2, 15);
    ctx.fillRect(x0 + 16, y0 + 17, 2, 15);
    ctx.fillRect(x0 + 28, y0 + 17, 2, 15);
    // Highlights claros
    spawnPontosUniforme(x0, y0, CELL, CELL, '#fff8e1', 0.20, 5, 1, idx * 9301 + 49297);
  }

  // Purpur: roxo manchado com padrão diamante
  function pintarPurpur(idx, pilar) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#7b1fa2';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de manchas claras
    spawnPontosUniforme(x0, y0, CELL, CELL, '#ab47bc', 0.50, 4, 2, idx * 9301 + 49297);
    spawnPontosUniforme(x0, y0, CELL, CELL, '#e1bee7', 0.30, 5, 1, idx * 9301 + 7331);
    if (pilar) {
      // Pilar: linhas verticais nas bordas (efeito coluna)
      ctx.fillStyle = '#4a148c';
      ctx.fillRect(x0 + 4,  y0, 1, CELL);
      ctx.fillRect(x0 + CELL - 5, y0, 1, CELL);
      ctx.fillStyle = '#ce93d8';
      ctx.fillRect(x0 + 6,  y0, 1, CELL);
      ctx.fillRect(x0 + CELL - 7, y0, 1, CELL);
    }
  }

  // Prismarine: turquesa com padrão tabuleiro xadrez sutil
  function pintarPrismarine(idx, base, escuro, claro, brick) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    if (brick) {
      // Padrão tijolo (3x3 grid de blocos)
      ctx.fillStyle = escuro;
      ctx.fillRect(x0, y0 + 10, CELL, 1);
      ctx.fillRect(x0, y0 + 21, CELL, 1);
      ctx.fillRect(x0 + 10, y0,      1, 11);
      ctx.fillRect(x0 + 21, y0,      1, 11);
      ctx.fillRect(x0 + 4,  y0 + 11, 1, 10);
      ctx.fillRect(x0 + 26, y0 + 11, 1, 10);
      ctx.fillRect(x0 + 14, y0 + 22, 1, 10);
      ctx.fillStyle = claro;
      // Highlights diagonais
      for (let py = 4; py < CELL; py += 11) {
        ctx.fillRect(x0 + py, y0 + py, 2, 2);
      }
    } else {
      // Padrão xadrez 4x4 sutil
      ctx.fillStyle = escuro;
      for (let by = 0; by < CELL; by += 8) {
        for (let bx = 0; bx < CELL; bx += 8) {
          if ((bx + by) % 16 === 0) {
            ctx.fillRect(x0 + bx, y0 + by, 4, 4);
            ctx.fillRect(x0 + bx + 4, y0 + by + 4, 4, 4);
          }
        }
      }
      ctx.fillStyle = claro;
      for (let i = 0; i < CELL; i += 4) {
        ctx.fillRect(x0 + i, y0 + i, 1, 1);
      }
    }
  }

  // Sea Lantern: cristalino branco-turquesa com 4 nodos brilhantes centrais
  function pintarSeaLantern(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#80cbc4';
    ctx.fillRect(x0, y0, CELL, CELL);
    // 4 nodos brilhantes (cristal-branco)
    ctx.fillStyle = '#b2dfdb';
    ctx.fillRect(x0 + 4,  y0 + 4,  10, 10);
    ctx.fillRect(x0 + 18, y0 + 4,  10, 10);
    ctx.fillRect(x0 + 4,  y0 + 18, 10, 10);
    ctx.fillRect(x0 + 18, y0 + 18, 10, 10);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 7,  y0 + 7,  4, 4);
    ctx.fillRect(x0 + 21, y0 + 7,  4, 4);
    ctx.fillRect(x0 + 7,  y0 + 21, 4, 4);
    ctx.fillRect(x0 + 21, y0 + 21, 4, 4);
    // Núcleo super brilhante
    ctx.fillStyle = '#fff8e1';
    ctx.fillRect(x0 + 8,  y0 + 8,  1, 1);
    ctx.fillRect(x0 + 22, y0 + 8,  1, 1);
    ctx.fillRect(x0 + 8,  y0 + 22, 1, 1);
    ctx.fillRect(x0 + 22, y0 + 22, 1, 1);
  }

  // Minério em pedra normal (base cinza + clusters da cor do minério)
  function pintarMinerio(idx, corCluster, corClusterClaro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#7E7E7E';
    ctx.fillRect(x0, y0, CELL, CELL);
    let seed = idx * 9301 + 49297;
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#5E5E5E', 0.40, 4, 2, seed);
    const clusters = [
      { x: 6,  y: 8  }, { x: 22, y: 5  }, { x: 12, y: 18 },
      { x: 24, y: 22 }, { x: 4,  y: 26 },
    ];
    for (const c of clusters) {
      ctx.fillStyle = corCluster;
      ctx.fillRect(x0 + c.x, y0 + c.y, 4, 4);
      ctx.fillStyle = corClusterClaro;
      ctx.fillRect(x0 + c.x + 1, y0 + c.y + 1, 2, 2);
      ctx.fillStyle = '#ffffff';
      ctx.fillRect(x0 + c.x + 1, y0 + c.y + 1, 1, 1);
    }
  }

  // Minério deepslate genérico (base ardósia + clusters da cor do minério)
  function pintarMinerioDeep(idx, corCluster, corClusterClaro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base deepslate (cinza-escuro)
    ctx.fillStyle = '#4a4a52';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Listras verticais finas (textura ardósia)
    ctx.fillStyle = '#35353d';
    for (let px = 2; px < CELL; px += 4) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
    // 5 clusters do minério em posições pseudo-aleatórias
    const clusters = [
      { x: 6,  y: 8  }, { x: 22, y: 5  }, { x: 12, y: 18 },
      { x: 24, y: 22 }, { x: 4,  y: 26 },
    ];
    for (const c of clusters) {
      ctx.fillStyle = corCluster;
      ctx.fillRect(x0 + c.x, y0 + c.y, 4, 4);
      ctx.fillStyle = corClusterClaro;
      ctx.fillRect(x0 + c.x + 1, y0 + c.y + 1, 2, 2);
      ctx.fillStyle = '#ffffff';
      ctx.fillRect(x0 + c.x + 1, y0 + c.y + 1, 1, 1);
    }
  }

  // Bloco compactado (storage): cor sólida com padrão geométrico de chanfros
  function pintarBlocoCompacto(idx, base, claro, escuro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão diagonal (acabamento metálico premium)
    ctx.fillStyle = claro;
    for (let i = 0; i < CELL; i += 4) {
      ctx.fillRect(x0 + i, y0 + i, 2, 2);
      if (CELL - i > 2) ctx.fillRect(x0 + (CELL - i - 2), y0 + i, 2, 2);
    }
    // 4 cantos com chanfro (efeito "moldado")
    ctx.fillStyle = claro;
    ctx.fillRect(x0 + 2,  y0 + 2,  4, 1);
    ctx.fillRect(x0 + 2,  y0 + 2,  1, 4);
    ctx.fillRect(x0 + CELL - 6, y0 + 2,  4, 1);
    ctx.fillRect(x0 + CELL - 3, y0 + 2,  1, 4);
    ctx.fillRect(x0 + 2,  y0 + CELL - 3, 4, 1);
    ctx.fillRect(x0 + 2,  y0 + CELL - 6, 1, 4);
    ctx.fillRect(x0 + CELL - 6, y0 + CELL - 3, 4, 1);
    ctx.fillRect(x0 + CELL - 3, y0 + CELL - 6, 1, 4);
    // Sombra interna (relevo)
    ctx.fillStyle = escuro;
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
    // Borda externa
    ctx.fillStyle = claro;
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
  }

  // Lama: marrom úmido com gotas escuras + manchas mais claras
  function pintarLama(idx, base, escuro, claro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    let seed = idx * 9301 + 49297;
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, escuro, 0.50, 4, 2, seed);
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, claro, 0.35, 5, 2, seed + 4441);
  }

  // Tufo: cinza-esverdeado com manchas brancas (textura volcânica)
  function pintarTuff(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#6b6e6c';
    ctx.fillRect(x0, y0, CELL, CELL);
    let seed = idx * 9301 + 49297;
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#55585a', 0.45, 4, 2, seed);
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#9b9e9c', 0.30, 5, 1, seed + 4441);
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#e0e0e0', 0.15, 8, 1, seed + 7331);
  }

  // Dripstone: laranja-marrom com listras horizontais (camadas estratigráficas)
  function pintarDripstone(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#c28560';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Listras horizontais (camadas)
    ctx.fillStyle = '#a56a4c';
    for (let py = 4; py < CELL; py += 6) {
      ctx.fillRect(x0, y0 + py, CELL, 1);
    }
    ctx.fillStyle = '#d49a78';
    for (let py = 7; py < CELL; py += 6) {
      ctx.fillRect(x0, y0 + py, CELL, 1);
    }
    // Pontos pseudo-aleatórios
    spawnPontosUniforme(x0, y0, CELL, CELL, '#7a4d36', 0.30, 5, 1, idx * 9301 + 49297);
  }

  // Tijolo de Lama: padrão de tijolos com tons de areia/lama
  function pintarTijoloLama(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#a0855e';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Mortar mais escuro
    ctx.fillStyle = '#6b5337';
    ctx.fillRect(x0, y0 + 15, CELL, 2);
    ctx.fillRect(x0 + 10, y0,      2, 15);
    ctx.fillRect(x0 + 22, y0,      2, 15);
    ctx.fillRect(x0 + 4,  y0 + 17, 2, 15);
    ctx.fillRect(x0 + 16, y0 + 17, 2, 15);
    ctx.fillRect(x0 + 28, y0 + 17, 2, 15);
    // Highlights claros
    spawnPontosUniforme(x0, y0, CELL, CELL, '#c2a07a', 0.25, 5, 1, idx * 9301 + 49297);
  }

  // Soul Sand: marrom escuro com 3 faces tristes (almas presas no Nether)
  function pintarSoulSand(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#4e342e';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Ruído escuro distribuído
    spawnPontosUniforme(x0, y0, CELL, CELL, '#3e2723', 0.40, 4, 2, idx * 9301 + 49297);
    // 3 "rostos" tristes pequenos (ovais com olhos + boca)
    const faces = [{ x: 6, y: 4 }, { x: 18, y: 14 }, { x: 8, y: 22 }];
    for (const f of faces) {
      // Cabeça oval marrom-claro
      ctx.fillStyle = '#6d4c41';
      ctx.fillRect(x0 + f.x, y0 + f.y, 7, 6);
      // 2 olhos pretos
      ctx.fillStyle = '#000000';
      ctx.fillRect(x0 + f.x + 1, y0 + f.y + 2, 1, 1);
      ctx.fillRect(x0 + f.x + 5, y0 + f.y + 2, 1, 1);
      // Boca triste (linha curva pra baixo)
      ctx.fillRect(x0 + f.x + 2, y0 + f.y + 4, 3, 1);
    }
  }

  // Soul Soil: marrom muito escuro com textura terrosa + manchas roxas
  function pintarSoulSoil(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0, y0, CELL, CELL);
    let seed = idx * 9301 + 49297;
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#2e1810', 0.55, 4, 2, seed);
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#5d4037', 0.30, 5, 1, seed + 4441);
    // Manchas roxas sutis (alma residual)
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#6a1b9a', 0.10, 6, 1, seed + 7331);
  }

  // Crimson/Warped Stem: tronco com casca colorida
  function pintarStem(idx, base, escuro, claro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Linhas verticais (grão da madeira nether)
    ctx.fillStyle = escuro;
    for (let px = 3; px < CELL; px += 5) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
    // Anéis horizontais (nodosidades)
    ctx.fillStyle = claro;
    for (let py = 6; py < CELL; py += 10) {
      ctx.fillRect(x0, y0 + py, CELL, 1);
    }
    // Pontos brilhantes (suco/seiva)
    spawnPontosUniforme(x0, y0, CELL, CELL, claro, 0.20, 5, 2, idx * 9301 + 49297);
  }

  // Blackstone: pedra preta com ruído cinza-escuro
  function pintarBlackstone(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0, y0, CELL, CELL);
    let seed = idx * 9301 + 49297;
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#0a0a0a', 0.45, 4, 2, seed);
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#3a3a3a', 0.30, 5, 1, seed + 4441);
    // Veios dourados ocasionais (gilded blackstone)
    spawnPontosUniforme(x0, y0, CELL, CELL, '#FFD700', 0.05, 8, 1, seed + 7331);
  }

  // Deepslate: cinza-escuro com listras verticais (textura de ardósia)
  function pintarDeepslate(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#4a4a52';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Listras verticais finas (ardósia natural)
    ctx.fillStyle = '#35353d';
    for (let px = 2; px < CELL; px += 4) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
    // Highlights claros entre as listras
    ctx.fillStyle = '#5a5a62';
    for (let px = 4; px < CELL; px += 4) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
    // Ruído sutil
    spawnPontosUniforme(x0, y0, CELL, CELL, '#2a2a32', 0.30, 4, 2, idx * 9301 + 49297);
  }

  // Amethyst: cristal roxo com facetas + brilhos
  function pintarAmethyst(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base roxa
    ctx.fillStyle = '#7b1fa2';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Facetas roxas claras (cristais grandes)
    ctx.fillStyle = '#ab47bc';
    ctx.fillRect(x0 + 4,  y0 + 4,  10, 10);
    ctx.fillRect(x0 + 18, y0 + 4,  10, 10);
    ctx.fillRect(x0 + 4,  y0 + 18, 10, 10);
    ctx.fillRect(x0 + 18, y0 + 18, 10, 10);
    // Centros brilhantes
    ctx.fillStyle = '#e1bee7';
    ctx.fillRect(x0 + 7,  y0 + 7,  4, 4);
    ctx.fillRect(x0 + 21, y0 + 7,  4, 4);
    ctx.fillRect(x0 + 7,  y0 + 21, 4, 4);
    ctx.fillRect(x0 + 21, y0 + 21, 4, 4);
    // Highlights brancos
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 8,  y0 + 8,  1, 1);
    ctx.fillRect(x0 + 22, y0 + 8,  1, 1);
    ctx.fillRect(x0 + 8,  y0 + 22, 1, 1);
    ctx.fillRect(x0 + 22, y0 + 22, 1, 1);
  }

  // Calcite: branca quase pura com pontinhos cinza
  function pintarCalcite(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#eceff1';
    ctx.fillRect(x0, y0, CELL, CELL);
    spawnPontosUniforme(x0, y0, CELL, CELL, '#cfd8dc', 0.45, 4, 2, idx * 9301 + 49297);
    spawnPontosUniforme(x0, y0, CELL, CELL, '#ffffff', 0.30, 5, 1, idx * 9301 + 7331);
  }

  // Gelo: azul claro cristalino com reflexos brancos diagonais
  function pintarGelo(idx, base, claro, escuro, intensidade = 1.0) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de cristais (linhas diagonais escuras)
    ctx.fillStyle = escuro;
    for (let i = 0; i < CELL; i += 6) {
      ctx.fillRect(x0 + i, y0, 1, CELL);
      ctx.fillRect(x0, y0 + i, CELL, 1);
    }
    // Reflexos brancos (diagonais brilhantes)
    ctx.fillStyle = claro;
    for (let i = 0; i < CELL; i += 4) {
      const k = Math.floor(i * intensidade);
      if (k < CELL) {
        ctx.fillRect(x0 + k, y0 + k, 2, 1);
      }
    }
    // Pontos brancos brilhantes (estrelas no gelo)
    ctx.fillStyle = '#ffffff';
    spawnPontosUniforme(x0, y0, CELL, CELL, '#ffffff', 0.20 * intensidade, 6, 1, idx * 9301 + 49297);
    // Borda
    ctx.fillStyle = escuro;
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Basalto: rocha vulcânica escura com listras verticais (caracteristica MC)
  function pintarBasalto(idx, polido) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = polido ? '#5a5a5a' : '#424242';
    ctx.fillRect(x0, y0, CELL, CELL);
    if (polido) {
      // Polido: listras finas + bordas chanfradas
      ctx.fillStyle = '#3a3a3a';
      for (let py = 4; py < CELL; py += 6) {
        ctx.fillRect(x0, y0 + py, CELL, 1);
      }
      ctx.fillStyle = '#7a7a7a';
      ctx.fillRect(x0, y0, CELL, 1);
      ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    } else {
      // Padrão: faixas verticais escuras (basalto colunar real)
      ctx.fillStyle = '#1a1a1a';
      for (let px = 4; px < CELL; px += 6) {
        ctx.fillRect(x0 + px, y0, 2, CELL);
      }
      // Highlights laterais (relevo)
      ctx.fillStyle = '#5e5e5e';
      for (let px = 7; px < CELL; px += 6) {
        ctx.fillRect(x0 + px, y0, 1, CELL);
      }
      // Manchas escuras pequenas
      spawnPontosUniforme(x0, y0, CELL, CELL, '#0a0a0a', 0.25, 4, 1, idx * 9301 + 49297);
    }
  }

  // Arenito (sandstone): bege com grãos pseudo-aleatórios
  function pintarArenito(idx, variante) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base bege
    ctx.fillStyle = '#fde2b2';
    ctx.fillRect(x0, y0, CELL, CELL);
    if (variante === 'liso') {
      // Liso: gradiente sutil (top mais claro)
      ctx.fillStyle = '#fff8e1';
      ctx.fillRect(x0, y0, CELL, 8);
      ctx.fillStyle = '#fdd7a8';
      ctx.fillRect(x0, y0 + CELL - 8, CELL, 8);
      ctx.fillStyle = '#e6c389';
      ctx.fillRect(x0, y0, CELL, 1);
      ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    } else if (variante === 'cortado') {
      // Cortado: símbolo central (espiral/glifo)
      ctx.fillStyle = '#a08254';
      ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, CELL - 8);
      ctx.fillStyle = '#fde2b2';
      ctx.fillRect(x0 + 6, y0 + 6, CELL - 12, CELL - 12);
      // Símbolo cruz central
      ctx.fillStyle = '#a08254';
      ctx.fillRect(x0 + CELL/2 - 1, y0 + 9, 2, CELL - 18);
      ctx.fillRect(x0 + 9, y0 + CELL/2 - 1, CELL - 18, 2);
      ctx.fillRect(x0 + CELL/2 - 3, y0 + CELL/2 - 3, 6, 6);
      ctx.fillStyle = '#fde2b2';
      ctx.fillRect(x0 + CELL/2 - 2, y0 + CELL/2 - 2, 4, 4);
    } else {
      // Padrão: grãos pequenos uniformes (stratified)
      let seed = idx * 9301 + 49297;
      seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#e6c389', 0.55, 4, 2, seed);
      seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#fff8e1', 0.40, 5, 1, seed + 4441);
    }
  }

  // Tijolo do Nether: padrão de tijolos vermelho-escuro com mortar preto
  function pintarTijoloNether(idx, cortado) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#4a0e0e';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#1a0000';
    if (cortado) {
      // Cortado: padrão central de cruz + bordas
      ctx.fillRect(x0, y0, CELL, 2);
      ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
      ctx.fillRect(x0, y0, 2, CELL);
      ctx.fillRect(x0 + CELL - 2, y0, 2, CELL);
      ctx.fillRect(x0 + CELL/2 - 1, y0 + 4, 2, CELL - 8);
      ctx.fillRect(x0 + 4, y0 + CELL/2 - 1, CELL - 8, 2);
      // Centro elevado mais claro
      ctx.fillStyle = '#7a1a1a';
      ctx.fillRect(x0 + CELL/2 - 4, y0 + CELL/2 - 4, 8, 8);
    } else {
      // Padrão de tijolos (mortar preto)
      ctx.fillRect(x0, y0 + 15, CELL, 2);
      ctx.fillRect(x0 + 10, y0,      2, 15);
      ctx.fillRect(x0 + 22, y0,      2, 15);
      ctx.fillRect(x0 + 4,  y0 + 17, 2, 15);
      ctx.fillRect(x0 + 16, y0 + 17, 2, 15);
      ctx.fillRect(x0 + 28, y0 + 17, 2, 15);
      // Highlights vermelhos sutis
      spawnPontosUniforme(x0, y0, CELL, CELL, '#7a1a1a', 0.30, 6, 1, idx * 9301 + 49297);
    }
  }

  // Pavimento (cobblestone): pedras irregulares cinza com mortar escuro
  function pintarPavimento(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Mortar escuro como base
    ctx.fillStyle = '#3a3a3a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // 8 "pedras" irregulares (retângulos diversos)
    const pedras = [
      { x: 1,  y: 1,  w: 12, h: 9  },
      { x: 14, y: 1,  w: 9,  h: 8  },
      { x: 24, y: 1,  w: 7,  h: 12 },
      { x: 1,  y: 11, w: 8,  h: 7  },
      { x: 10, y: 10, w: 11, h: 10 },
      { x: 22, y: 14, w: 9,  h: 8  },
      { x: 1,  y: 19, w: 14, h: 12 },
      { x: 16, y: 21, w: 15, h: 10 },
    ];
    for (const p of pedras) {
      // Pedra principal (cinza médio)
      ctx.fillStyle = '#7a7a7a';
      ctx.fillRect(x0 + p.x, y0 + p.y, p.w, p.h);
      // Highlight superior (luz cima)
      ctx.fillStyle = '#a0a0a0';
      ctx.fillRect(x0 + p.x, y0 + p.y, p.w, 1);
      ctx.fillRect(x0 + p.x, y0 + p.y, 1, p.h);
      // Sombra inferior direita
      ctx.fillStyle = '#5e5e5e';
      ctx.fillRect(x0 + p.x + p.w - 1, y0 + p.y, 1, p.h);
      ctx.fillRect(x0 + p.x, y0 + p.y + p.h - 1, p.w, 1);
    }
  }

  // Variante polida: cor base + faixas verticais escuras finas (acabamento)
  function pintarPolido(idx, base, escuro, claro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Borda escura espessa (efeito chanfrado)
    ctx.fillStyle = escuro;
    ctx.fillRect(x0, y0,            CELL, 2);
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0,            y0, 2, CELL);
    ctx.fillRect(x0 + CELL - 2, y0, 2, CELL);
    // Highlight superior (luz cima)
    ctx.fillStyle = claro;
    ctx.fillRect(x0 + 2, y0 + 2, CELL - 4, 1);
    ctx.fillRect(x0 + 2, y0 + 2, 1, CELL - 4);
    // Linhas internas finas (4 quadrantes — efeito laje refinada)
    ctx.fillStyle = escuro;
    ctx.fillRect(x0 + CELL / 2 - 1, y0 + 4, 1, CELL - 8);
    ctx.fillRect(x0 + 4, y0 + CELL / 2 - 1, CELL - 8, 1);
  }

  // Pedra Lisa (smooth stone): cinza uniforme com top/bottom em cor mais clara
  function pintarPedraLisa(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#b8b8b8';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Bandas top/bot mais escuras (efeito de slab compactado)
    ctx.fillStyle = '#9e9e9e';
    ctx.fillRect(x0, y0,            CELL, 3);
    ctx.fillRect(x0, y0 + CELL - 3, CELL, 3);
    // Highlight de borda superior (brilho)
    ctx.fillStyle = '#d0d0d0';
    ctx.fillRect(x0 + 2, y0 + 4, CELL - 4, 1);
  }

  // Tijolo com musgo: tijolos clássicos com manchas verdes orgânicas
  function pintarTijoloMusgo(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base de tijolo vermelho
    ctx.fillStyle = '#a13b22';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de tijolos (mortar branco-cinza)
    ctx.fillStyle = '#888888';
    // Linha horizontal meio
    ctx.fillRect(x0, y0 + 15, CELL, 2);
    // Linhas verticais alternadas (offset por linha)
    ctx.fillRect(x0 + 10, y0,      2, 15);
    ctx.fillRect(x0 + 22, y0,      2, 15);
    ctx.fillRect(x0 + 4,  y0 + 17, 2, 15);
    ctx.fillRect(x0 + 16, y0 + 17, 2, 15);
    ctx.fillRect(x0 + 28, y0 + 17, 2, 15);
    // Manchas verdes (musgo distribuído uniformemente)
    spawnPontosUniforme(x0, y0, CELL, CELL, '#558b2f', 0.50, 4, 3, idx * 9301 + 49297);
    spawnPontosUniforme(x0, y0, CELL, CELL, '#7cb342', 0.30, 5, 2, idx * 9301 + 7331);
  }

  // Argila: azul-cinza uniforme com manchas mais claras (textura suave)
  function pintarArgila(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#a0a4b8';
    ctx.fillRect(x0, y0, CELL, CELL);
    let seed = idx * 9301 + 49297;
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#8a8e9e', 0.50, 4, 2, seed);
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#b8bccc', 0.40, 5, 1, seed + 4441);
  }

  // Bambu: tronco verde claro com nós marcados em forma de anel
  function pintarBambu(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro pra dar contraste
    ctx.fillStyle = '#1b5e20';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Tronco vertical centrado (ocupa ~12px de largura)
    ctx.fillStyle = '#8bc34a';
    ctx.fillRect(x0 + 10, y0, 12, CELL);
    // Sombra direita do tronco (3D)
    ctx.fillStyle = '#558b2f';
    ctx.fillRect(x0 + 19, y0, 3, CELL);
    // Highlight esquerdo (brilho)
    ctx.fillStyle = '#aed581';
    ctx.fillRect(x0 + 11, y0, 2, CELL);
    // 3 nós (anéis horizontais escuros)
    ctx.fillStyle = '#33691e';
    for (let py = 5; py < CELL; py += 11) {
      ctx.fillRect(x0 + 10, y0 + py, 12, 2);
    }
    // Folhinhas verdes saindo dos nós (decoração)
    ctx.fillStyle = '#7cb342';
    ctx.fillRect(x0 + 5,  y0 + 4,  4, 2);
    ctx.fillRect(x0 + 23, y0 + 15, 4, 2);
    ctx.fillRect(x0 + 5,  y0 + 25, 4, 2);
  }

  // Bloco de Mel: dourado translúcido (visualmente) com gotas brilhantes
  function pintarBlocoMel(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base dourada
    ctx.fillStyle = '#ffc107';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de bolhas (efeito mel viscoso)
    ctx.fillStyle = '#ff8f00';
    const bolhas = [
      { x: 5,  y: 6,  r: 5 },
      { x: 18, y: 9,  r: 6 },
      { x: 8,  y: 18, r: 4 },
      { x: 20, y: 22, r: 5 },
      { x: 25, y: 5,  r: 3 },
    ];
    for (const b of bolhas) {
      ctx.fillRect(x0 + b.x, y0 + b.y, b.r, b.r);
    }
    // Highlights claros (brilho translúcido)
    ctx.fillStyle = '#fff8e1';
    for (const b of bolhas) {
      ctx.fillRect(x0 + b.x + 1, y0 + b.y + 1, 2, 1);
    }
    // Reflexo branco diagonal
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 3, y0 + 3, 3, 1);
    ctx.fillRect(x0 + 4, y0 + 4, 2, 1);
    // Borda mais escura sutil
    ctx.fillStyle = '#bf360c';
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Lily Pad: folha verde redonda flutuante + nervuras + 1 flor branca
  function pintarLilyPad(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro (água debaixo)
    ctx.fillStyle = '#1565c0';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Forma circular da folha (verde médio)
    ctx.fillStyle = '#388e3c';
    // Aproximação de círculo com 4 retângulos
    ctx.fillRect(x0 + 4,  y0 + 8,  24, 16);
    ctx.fillRect(x0 + 8,  y0 + 4,  16, 24);
    // Centro mais escuro (sombra natural)
    ctx.fillStyle = '#2e7d32';
    ctx.fillRect(x0 + 8,  y0 + 12, 16, 8);
    // Nervuras radiais (4 linhas saindo do centro)
    ctx.fillStyle = '#1b5e20';
    ctx.fillRect(x0 + 16, y0 + 6,  1, 20); // vertical
    ctx.fillRect(x0 + 6,  y0 + 16, 20, 1); // horizontal
    // Recorte radial pequeno (caracteristica da vitória-régia)
    ctx.fillStyle = '#1565c0';
    ctx.fillRect(x0 + 14, y0 + 4, 4, 6);
    // Flor branca pequena central
    ctx.fillStyle = '#fff8e1';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    ctx.fillStyle = '#FFD700';
    ctx.fillRect(x0 + 15, y0 + 15, 2, 2);
  }

  // Minério de Cobre: pedra base + clusters cor cobre (laranja-marrom)
  function pintarCobreMinerio(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base de pedra (igual à pedra normal mas mais cinza)
    ctx.fillStyle = '#7E7E7E';
    ctx.fillRect(x0, y0, CELL, CELL);
    let seed = idx * 9301 + 49297;
    ctx.fillStyle = '#5E5E5E';
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.30) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    // 5 clusters de cobre (laranja-marrom) espalhados pseudo-aleatoriamente
    const clusters = [
      { x: 6,  y: 8 },
      { x: 22, y: 5 },
      { x: 12, y: 18 },
      { x: 24, y: 22 },
      { x: 4,  y: 26 },
    ];
    for (const c of clusters) {
      // Centro escuro
      ctx.fillStyle = '#a04e1c';
      ctx.fillRect(x0 + c.x, y0 + c.y, 4, 4);
      // Borda mais clara (3D)
      ctx.fillStyle = '#e07a3b';
      ctx.fillRect(x0 + c.x + 1, y0 + c.y + 1, 2, 2);
      ctx.fillStyle = '#ff9d5e';
      ctx.fillRect(x0 + c.x + 1, y0 + c.y + 1, 1, 1);
    }
  }

  // Bandeira: mastro preto à esquerda + pano colorido à direita com onda
  function pintarBandeira(idx, corBase, corEscura, corClara) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro neutro (não-bandeira)
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Mastro preto à esquerda (1/4 da largura)
    ctx.fillStyle = '#212121';
    ctx.fillRect(x0 + 4, y0 + 2, 3, CELL - 4);
    // Topo dourado do mastro (ponta)
    ctx.fillStyle = '#FFD700';
    ctx.fillRect(x0 + 3, y0,     5, 3);
    // Pano colorido (parte direita, ondulada nas bordas)
    ctx.fillStyle = corBase;
    ctx.fillRect(x0 + 9, y0 + 4, 20, 22);
    // Borda escura
    ctx.fillStyle = corEscura;
    ctx.fillRect(x0 + 9, y0 + 4, 20, 1);
    ctx.fillRect(x0 + 9, y0 + 25, 20, 1);
    ctx.fillRect(x0 + 9, y0 + 4, 1, 22);
    ctx.fillRect(x0 + 28, y0 + 4, 1, 22);
    // Padrão decorativo central (cruz simples)
    ctx.fillStyle = corEscura;
    ctx.fillRect(x0 + 18, y0 + 8, 2, 14);
    ctx.fillRect(x0 + 12, y0 + 14, 14, 2);
    // Highlights claros (efeito 3D do tecido)
    ctx.fillStyle = corClara;
    ctx.fillRect(x0 + 11, y0 + 6, 5, 1);
    ctx.fillRect(x0 + 11, y0 + 7, 1, 4);
    // Borda inferior ondulada (efeito vento)
    ctx.fillStyle = corEscura;
    ctx.fillRect(x0 + 9,  y0 + 26, 3, 1);
    ctx.fillRect(x0 + 14, y0 + 27, 3, 1);
    ctx.fillRect(x0 + 19, y0 + 26, 3, 1);
    ctx.fillRect(x0 + 24, y0 + 27, 3, 1);
  }

  // Magma: superfície vermelha-escura com rachaduras laranja-brilhantes
  function pintarMagma(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base preta-vermelha (rocha quente)
    ctx.fillStyle = '#3e0a0a';
    ctx.fillRect(x0, y0, CELL, CELL);
    let seed = idx * 9301 + 49297;
    // Rachaduras pseudo-aleatórias (linhas curtas)
    ctx.fillStyle = '#ff6f00';
    for (let i = 0; i < 12; i++) {
      seed = (seed * 9301 + 49297) % 233280;
      const px = (seed % CELL);
      seed = (seed * 9301 + 49297) % 233280;
      const py = (seed % CELL);
      seed = (seed * 9301 + 49297) % 233280;
      const horizontal = (seed % 2 === 0);
      const tam = 3 + (seed % 4);
      if (horizontal) ctx.fillRect(x0 + px, y0 + py, tam, 1);
      else ctx.fillRect(x0 + px, y0 + py, 1, tam);
    }
    // Brasas amarelas + manchas escuras distribuídas uniformemente
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#ffeb3b', 0.40, 8, 2, seed + 3001);
    seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#1a0000', 0.55, 4, 1, seed + 5001);
  }

  // Lanterna: estrutura escura de ferro com janela de vidro brilhante
  function pintarLanterna(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Estrutura preta de ferro
    ctx.fillStyle = '#212121';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Janela amarela brilhante no centro (luz interna)
    ctx.fillStyle = '#ffeb3b';
    ctx.fillRect(x0 + 6, y0 + 8, 20, 18);
    // Glowing core (mais brilhante no meio)
    ctx.fillStyle = '#fffde7';
    ctx.fillRect(x0 + 10, y0 + 12, 12, 10);
    // Núcleo branco
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 6);
    // Grades de ferro horizontais (3 barras)
    ctx.fillStyle = '#424242';
    ctx.fillRect(x0 + 6, y0 + 13, 20, 1);
    ctx.fillRect(x0 + 6, y0 + 18, 20, 1);
    ctx.fillRect(x0 + 6, y0 + 22, 20, 1);
    // Grades verticais (suporte)
    ctx.fillRect(x0 + 14, y0 + 8, 1, 18);
    ctx.fillRect(x0 + 17, y0 + 8, 1, 18);
    // Topo cônico de ferro (chapéu)
    ctx.fillStyle = '#424242';
    ctx.fillRect(x0 + 4,  y0 + 4, CELL - 8, 4);
    ctx.fillStyle = '#616161';
    ctx.fillRect(x0 + 8,  y0 + 2, CELL - 16, 2);
    // Anel de pendurar (parte de cima)
    ctx.fillStyle = '#9e9e9e';
    ctx.fillRect(x0 + 14, y0,     4, 2);
    ctx.fillRect(x0 + 13, y0 + 1, 6, 1);
  }

  // Vela: cera colorida vertical + chama amarela no topo + pavio escuro
  function pintarVela(idx, corCera, corCeraEscura) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Fundo escuro (espaço ao redor da vela)
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Cera (cilindro vertical centrado, ocupando 8px de largura)
    ctx.fillStyle = corCera;
    ctx.fillRect(x0 + 12, y0 + 12, 8, 18);
    // Borda escura da cera (lateral)
    ctx.fillStyle = corCeraEscura;
    ctx.fillRect(x0 + 12, y0 + 12, 1, 18);
    ctx.fillRect(x0 + 19, y0 + 12, 1, 18);
    // Pingo de cera derretida no topo (round)
    ctx.fillStyle = corCera;
    ctx.fillRect(x0 + 13, y0 + 11, 6, 1);
    // Pavio preto
    ctx.fillStyle = '#212121';
    ctx.fillRect(x0 + 15, y0 + 6,  2, 6);
    // Chama: 3 layers (vermelho-laranja-amarelo-branco)
    ctx.fillStyle = '#ef5350';
    ctx.fillRect(x0 + 14, y0 + 2, 4, 5);
    ctx.fillStyle = '#ffa726';
    ctx.fillRect(x0 + 14, y0 + 3, 4, 3);
    ctx.fillStyle = '#fff176';
    ctx.fillRect(x0 + 15, y0 + 3, 2, 2);
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 15, y0 + 4, 1, 1);
    // Glow ao redor da chama (tom amarelo translúcido)
    ctx.fillStyle = 'rgba(255, 235, 100, 0.18)';
    ctx.fillRect(x0 + 11, y0 + 1, 10, 8);
  }

  // Cobre (3 estados): metálico com padrão de placas + manchas de oxidação
  function pintarCobre(idx, base, claro, escuro, manchaOx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = base;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de placas verticais (rebites/junções)
    ctx.fillStyle = escuro;
    ctx.fillRect(x0 + 10, y0, 1, CELL);
    ctx.fillRect(x0 + 21, y0, 1, CELL);
    ctx.fillRect(x0, y0 + 10, CELL, 1);
    ctx.fillRect(x0, y0 + 21, CELL, 1);
    // Highlights claros (brilho metálico nos cantos das placas)
    ctx.fillStyle = claro;
    ctx.fillRect(x0 + 2,  y0 + 2,  6, 1);
    ctx.fillRect(x0 + 13, y0 + 2,  5, 1);
    ctx.fillRect(x0 + 24, y0 + 2,  5, 1);
    ctx.fillRect(x0 + 2,  y0 + 13, 6, 1);
    ctx.fillRect(x0 + 13, y0 + 13, 5, 1);
    ctx.fillRect(x0 + 24, y0 + 13, 5, 1);
    // Manchas de oxidação distribuídas uniformemente (sem clusters)
    if (manchaOx > 0) {
      spawnPontosUniforme(x0, y0, CELL, CELL, '#5fb89e', manchaOx * 0.7, 4, 2,
        idx * 9301 + 49297);
    }
    // Borda escura sutil
    ctx.fillStyle = escuro;
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Cogumelo gigante: chapéu colorido com bolinhas brancas (vermelho) ou liso (marrom)
  function pintarCogumelo(idx, vermelho) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    const corBase = vermelho ? '#c62828' : '#6d4c41';
    const corEscura = vermelho ? '#8b0000' : '#4e342e';
    ctx.fillStyle = corBase;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Ruído escuro (textura orgânica)
    let seed = idx * 9301 + 49297;
    ctx.fillStyle = corEscura;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.18) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    if (vermelho) {
      // Bolinhas brancas (caracteristica do amanita / cogumelo gigante MC)
      ctx.fillStyle = '#fafafa';
      const dots = [
        { x: 6,  y: 8,  r: 4 },
        { x: 18, y: 6,  r: 3 },
        { x: 24, y: 14, r: 5 },
        { x: 8,  y: 20, r: 4 },
        { x: 16, y: 22, r: 3 },
        { x: 22, y: 24, r: 3 },
      ];
      for (const d of dots) {
        ctx.fillRect(x0 + d.x, y0 + d.y, d.r, d.r);
      }
      // Sombra leve nas bolinhas (3D)
      ctx.fillStyle = '#e0e0e0';
      for (const d of dots) {
        ctx.fillRect(x0 + d.x + d.r, y0 + d.y + d.r - 1, 1, 1);
      }
    } else {
      // Marrom liso: só highlights claros pra dar volume
      ctx.fillStyle = '#8d6e63';
      for (let i = 0; i < 12; i++) {
        seed = (seed * 9301 + 49297) % 233280;
        const px = (seed % CELL);
        seed = (seed * 9301 + 49297) % 233280;
        const py = (seed % CELL);
        ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
  }

  // Quartzo: branco com grão sutil + manchas mais claras (cristalino)
  function pintarQuartzo(idx, polido) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = polido ? '#fff8e1' : '#fafafa';
    ctx.fillRect(x0, y0, CELL, CELL);
    let seed = idx * 9301 + 49297;
    if (polido) {
      // Polido: padrão de brilho diagonal (chevron)
      ctx.fillStyle = '#ffffff';
      for (let py = 0; py < CELL; py += 4) {
        ctx.fillRect(x0, y0 + py, CELL, 1);
      }
      ctx.fillStyle = '#f5f5dc';
      ctx.fillRect(x0, y0,            CELL, 1);
      ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    } else {
      // Quartzo natural: ruído + brilhos cristalinos uniformes
      seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#eeeeee', 0.55, 4, 2, seed);
      seed = spawnPontosUniforme(x0, y0, CELL, CELL, '#ffffff', 0.40, 8, 3, seed + 9001);
    }
    // Borda escura sutil pra delimitar o bloco (todos)
    ctx.fillStyle = '#bdbdbd';
    ctx.fillRect(x0, y0, CELL, 1);
    ctx.fillRect(x0, y0 + CELL - 1, CELL, 1);
    ctx.fillRect(x0, y0, 1, CELL);
    ctx.fillRect(x0 + CELL - 1, y0, 1, CELL);
  }

  // Vidro colorido (genérico): cor saturada com molduras escuras + reflexo
  function pintarVidroColorido(idx, corBase, corBorda) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Cor preenchida (translúcida visualmente, mas opaca)
    ctx.fillStyle = corBase;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Borda externa (moldura escura tipo metal)
    ctx.fillStyle = corBorda;
    ctx.fillRect(x0,            y0,            CELL, 2);
    ctx.fillRect(x0,            y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0,            y0,            2,    CELL);
    ctx.fillRect(x0 + CELL - 2, y0,            2,    CELL);
    // Cruz central (caixilho)
    ctx.fillRect(x0 + CELL / 2 - 1, y0, 2, CELL);
    ctx.fillRect(x0, y0 + CELL / 2 - 1, CELL, 2);
    // Reflexo branco diagonal (efeito vidro)
    ctx.fillStyle = 'rgba(255,255,255,0.4)';
    ctx.fillRect(x0 + 4,  y0 + 4,  4, 1);
    ctx.fillRect(x0 + 5,  y0 + 5,  3, 1);
    ctx.fillRect(x0 + 18, y0 + 18, 4, 1);
    ctx.fillRect(x0 + 19, y0 + 19, 3, 1);
  }

  // Lã colorida (genérica): padrão de fios distribuídos uniformemente
  function pintarLaColorida(idx, corBase, corClaro, corEscuro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = corBase;
    ctx.fillRect(x0, y0, CELL, CELL);
    const seed1 = idx * 9301 + 49297;
    let seed = spawnPontosUniforme(x0, y0, CELL, CELL, corEscuro, 0.55, 4, 2, seed1);
    seed     = spawnPontosUniforme(x0, y0, CELL, CELL, corClaro, 0.45, 5, 1, seed + 4441);
  }

  // Estante de Livros: faces laterais com fileira de livros coloridos
  function pintarEstanteLado(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Frame de madeira (topo + base + laterais)
    ctx.fillStyle = '#5d4037';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0 + 2, y0 + 2, CELL - 4, CELL - 4);
    // Espaço interno onde ficam os livros (cor escura — fundo da estante)
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0 + 4, y0 + 5, CELL - 8, 22);
    // Livros: 6 livros verticais com cores variadas
    const cores = ['#c62828', '#2e7d32', '#1565c0', '#f9a825', '#6a1b9a', '#00838f'];
    let seed = idx * 9301 + 49297;
    let bx = x0 + 4;
    while (bx < x0 + CELL - 4) {
      seed = (seed * 9301 + 49297) % 233280;
      const lw = 3 + (seed % 3); // largura 3-5
      const cor = cores[seed % cores.length];
      // Livro
      ctx.fillStyle = cor;
      ctx.fillRect(bx, y0 + 5, lw, 22);
      // Faixa dourada no meio (lombada)
      ctx.fillStyle = '#FFD700';
      ctx.fillRect(bx, y0 + 13, lw, 1);
      ctx.fillRect(bx, y0 + 18, lw, 1);
      // Highlight superior (3D)
      ctx.fillStyle = '#ffffff';
      ctx.fillRect(bx, y0 + 5, 1, 22);
      bx += lw + 1;
    }
  }
  function pintarEstanteTopo(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Madeira (igual à madeira lado mas sem livros — só topo)
    ctx.fillStyle = '#8d6e63';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão de grão (linhas horizontais escuras)
    ctx.fillStyle = '#5d4037';
    for (let py = 4; py < CELL; py += 7) {
      ctx.fillRect(x0, y0 + py, CELL, 1);
    }
    ctx.fillStyle = '#6d4c41';
    for (let py = 2; py < CELL; py += 5) {
      ctx.fillRect(x0, y0 + py, CELL, 1);
    }
    // Borda escura (frame)
    ctx.fillStyle = '#3e2723';
    ctx.fillRect(x0, y0, CELL, 2);
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0, y0, 2, CELL);
    ctx.fillRect(x0 + CELL - 2, y0, 2, CELL);
  }

  // Trilho: dormentes marrom + 2 rails de aço paralelos
  function pintarRail(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base escura (sombra abaixo do trilho — fica embaixo da slab)
    ctx.fillStyle = '#3a2818';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Dormentes (ties) — barras horizontais marrom
    ctx.fillStyle = '#6d4c41';
    for (let py = 4; py < CELL; py += 8) {
      ctx.fillRect(x0 + 4, y0 + py, CELL - 8, 4);
    }
    // Detalhe escuro entre dormentes
    ctx.fillStyle = '#4e342e';
    for (let py = 0; py < CELL; py += 8) {
      ctx.fillRect(x0 + 4, y0 + py, CELL - 8, 1);
    }
    // 2 trilhos verticais de aço cinza
    ctx.fillStyle = '#cfd8dc';
    ctx.fillRect(x0 + 8,  y0, 3, CELL);
    ctx.fillRect(x0 + 21, y0, 3, CELL);
    // Highlight superior dos trilhos (brilho)
    ctx.fillStyle = '#eceff1';
    ctx.fillRect(x0 + 9,  y0, 1, CELL);
    ctx.fillRect(x0 + 22, y0, 1, CELL);
  }

  // Teia de aranha: branco com fios em X + pontos central + cantos
  function pintarTeia(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Base preta semi-vazia (efeito teia translúcida visualmente)
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Fios brancos cruzados (vertical, horizontal, 2 diagonais)
    ctx.fillStyle = '#fafafa';
    ctx.fillRect(x0 + 15, y0,      2, CELL); // vertical
    ctx.fillRect(x0,      y0 + 15, CELL, 2); // horizontal
    // Diagonais (linha por linha)
    for (let i = 0; i < CELL; i++) {
      ctx.fillRect(x0 + i,        y0 + i,        1, 1);
      ctx.fillRect(x0 + (CELL - 1 - i), y0 + i,  1, 1);
    }
    // Anéis concêntricos da teia (pequenos quadrados nas diagonais)
    ctx.fillStyle = '#e0e0e0';
    for (const r of [4, 9, 14]) {
      ctx.fillRect(x0 + 16 - r, y0 + 16 - r, 2, 2);
      ctx.fillRect(x0 + 16 + r, y0 + 16 - r, 2, 2);
      ctx.fillRect(x0 + 16 - r, y0 + 16 + r, 2, 2);
      ctx.fillRect(x0 + 16 + r, y0 + 16 + r, 2, 2);
    }
  }

  // Beacon: vidro azul cristalino com núcleo brilhante + frame escuro
  function pintarBeacon(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    // Frame externo (obsidiana escura)
    ctx.fillStyle = '#311b92';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Cristal interno azul/ciano
    ctx.fillStyle = '#00bcd4';
    ctx.fillRect(x0 + 4, y0 + 4, CELL - 8, CELL - 8);
    // Brilho central (núcleo radiante)
    ctx.fillStyle = '#80deea';
    ctx.fillRect(x0 + 8, y0 + 8, CELL - 16, CELL - 16);
    ctx.fillStyle = '#e0f7fa';
    ctx.fillRect(x0 + 12, y0 + 12, CELL - 24, CELL - 24);
    // Núcleo branco
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
    // Reflexos diagonais (efeito cristal)
    ctx.fillStyle = '#b2ebf2';
    ctx.fillRect(x0 + 6,  y0 + 6,  2, 2);
    ctx.fillRect(x0 + 24, y0 + 6,  2, 2);
    ctx.fillRect(x0 + 6,  y0 + 24, 2, 2);
    ctx.fillRect(x0 + 24, y0 + 24, 2, 2);
    // Linhas conectando ao núcleo (energia)
    ctx.fillStyle = '#26c6da';
    ctx.fillRect(x0 + 8,  y0 + 16, CELL - 16, 1);
    ctx.fillRect(x0 + 16, y0 + 8,  1, CELL - 16);
  }

  // Lateral abóbora (ridges verticais sem face)
  function pintarPumpkinLado(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#e65100';
    ctx.fillRect(x0, y0, CELL, CELL);
    ctx.fillStyle = '#bf360c';
    for (let px = 4; px < CELL; px += 6) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
    ctx.fillStyle = '#ff9800';
    for (let px = 1; px < CELL; px += 6) {
      ctx.fillRect(x0 + px, y0, 1, CELL);
    }
  }

  // End Crystal: amarelo brilhante com bordas magenta (cristal energético)
  function pintarEndCrystal(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#fff59d';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Padrão diagonal magenta (energia pulsante)
    ctx.fillStyle = '#e040fb';
    for (let i = 0; i < CELL; i += 4) {
      ctx.fillRect(x0 + i, y0, 1, CELL);
      ctx.fillRect(x0, y0 + i, CELL, 1);
    }
    // Centro super brilhante (núcleo)
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(x0 + 12, y0 + 12, 8, 8);
    ctx.fillStyle = '#fffde7';
    ctx.fillRect(x0 + 14, y0 + 14, 4, 4);
  }

  // Dragon Egg: preto com pontos roxos/magenta brilhantes (cristal raro)
  function pintarDragonEgg(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#1a1a1a';
    ctx.fillRect(x0, y0, CELL, CELL);
    let seed = idx * 9301 + 49297;
    // Pontos magenta brilhantes
    for (let i = 0; i < 30; i++) {
      seed = (seed * 9301 + 49297) % 233280;
      const px = (seed % CELL);
      seed = (seed * 9301 + 49297) % 233280;
      const py = (seed % CELL);
      ctx.fillStyle = i % 4 === 0 ? '#e040fb' : (i % 2 === 0 ? '#9c27b0' : '#7b1fa2');
      ctx.fillRect(x0 + px, y0 + py, 2, 2);
    }
    // Sombra arredondada (canto superior + inferior)
    ctx.fillStyle = '#000000';
    ctx.fillRect(x0, y0, 2, 2); ctx.fillRect(x0 + CELL - 2, y0, 2, 2);
    ctx.fillRect(x0, y0 + CELL - 2, 2, 2); ctx.fillRect(x0 + CELL - 2, y0 + CELL - 2, 2, 2);
  }

  // Portal End: verde escuro com pontos verde-claro/branco (estrelas)
  function pintarPortalEnd(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#004d40';
    ctx.fillRect(x0, y0, CELL, CELL);
    let seed = idx * 9301 + 49297;
    // 80 estrelinhas espalhadas (verde-claro brilhante)
    for (let i = 0; i < 80; i++) {
      seed = (seed * 9301 + 49297) % 233280;
      const px = (seed % CELL);
      seed = (seed * 9301 + 49297) % 233280;
      const py = (seed % CELL);
      ctx.fillStyle = i % 5 === 0 ? '#ffffff' : (i % 3 === 0 ? '#69f0ae' : '#26a69a');
      ctx.fillRect(x0 + px, y0 + py, 1, 1);
    }
    // Borda verde escura
    ctx.fillStyle = '#003228';
    ctx.fillRect(x0, y0, CELL, 2);
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0, y0, 2, CELL);
    ctx.fillRect(x0 + CELL - 2, y0, 2, CELL);
  }

  // Portal Nether: swirl roxo/violeta com pontos brancos (efeito etéreo)
  function pintarPortalNether(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = '#4a148c';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Espiral via lerp de pontos com seed
    let seed = idx * 9301 + 49297;
    for (let i = 0; i < 60; i++) {
      seed = (seed * 9301 + 49297) % 233280;
      const r = seed / 233280;
      const ang = r * Math.PI * 2;
      const dist = (i / 60) * 14;
      const px = Math.floor(16 + Math.cos(ang) * dist);
      const py = Math.floor(16 + Math.sin(ang) * dist);
      ctx.fillStyle = i % 3 === 0 ? '#e1bee7' : '#ce93d8';
      ctx.fillRect(x0 + px, y0 + py, 2, 2);
    }
    // Borda escura
    ctx.fillStyle = '#311b92';
    ctx.fillRect(x0, y0, CELL, 2);
    ctx.fillRect(x0, y0 + CELL - 2, CELL, 2);
    ctx.fillRect(x0, y0, 2, CELL);
    ctx.fillRect(x0 + CELL - 2, y0, 2, CELL);
  }

  // Pinta lateral de grass block: marrom embaixo com faixa verde no topo
  // (paridade Minecraft — grama "desce" 8px pelos lados antes de virar terra).
  function pintarGramaLado(idx) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    const FAIXA = 8; // px de grama no topo da lateral
    // Base marrom (igual ao lado de terra) cobrindo toda célula
    ctx.fillStyle = '#8D6E63';
    ctx.fillRect(x0, y0, CELL, CELL);
    // Ruído marrom escuro no corpo (terra)
    ctx.fillStyle = '#6D4C41';
    let seed = idx * 9301 + 49297;
    for (let py = FAIXA; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.18) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    // Faixa verde sólida no topo (a "grama" descendo pela lateral)
    ctx.fillStyle = '#4CAF50';
    ctx.fillRect(x0, y0, CELL, FAIXA);
    // Borda recortada entre verde e marrom (efeito Minecraft "irregular")
    ctx.fillStyle = '#388E3C';
    for (let px = 0; px < CELL; px += 2) {
      seed = (seed * 9301 + 49297) % 233280;
      const extra = (seed / 233280) < 0.5 ? 0 : 2;
      ctx.fillRect(x0 + px, y0 + FAIXA - 2 + extra, 2, 2);
    }
    // Ruído verde escuro na faixa de grama
    for (let py = 0; py < FAIXA; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.20) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
  }

  // === Pinta cada bloco ===
  // Convenção: cada índice é uma célula 32×32 do atlas. Mapeamento de
  // top/side/bottom é feito em `mapa[]` abaixo. Paleta calibrada pra
  // paridade Minecraft (oak, stone, sand, ores, etc).
  pintarGramaTopo(0);                     // grama topo (4 tons + flores ocasionais)
  pintarGramaLado(1);                     // grama lado (terra + faixa verde)
  pintar(2,  '#866043', '#6B4A2D', 0.18); // terra (warm brown MC)
  pintarPedra(3, '#7E7E7E', '#5E5E5E', '#9C9C9C', 0.30); // pedra 2-tone
  pintarAreia(4);                          // areia (dunas + grãos visíveis)
  pintarMadeiraTopo(5);                   // madeira topo (anéis)
  pintarMadeiraLado(6);                   // madeira lado (grain VERTICAL)
  pintarFolha(7);                         // folha (verde escuro caótico)
  pintarTijolo(8);                        // tijolo (mortar + bricks)
  pintarVidro(9);                         // vidro (claro com moldura)
  pintarOuro(10);                          // ouro (clusters metálicos)
  pintarDiamante(11);                      // diamante (cristais losango + sparkles)
  pintarGlowstone(12);                    // luz/glowstone (amarelo brilhante)
  pintar(13, '#F5F5F5', '#E0E0E0', 0.10); // neve (branco)
  pintarCarvao(14);                        // carvão (clusters L pretos com highlight)
  pintarFerro(15);                         // ferro (clusters tan com oxidação)
  pintarCacto(16);                        // cacto (cannelura vertical)
  pintarAgua(17);                         // água (azul com ondas)
  pintarLava(18);                         // lava (laranja com bolhas)
  pintarObsidiana(19);                    // obsidiana (escuro + violeta)
  pintarWorkbenchTopo(20);                // workbench topo (grid)
  pintarWorkbenchLado(21);                // workbench lado (planks + serra)
  pintarLa(22);                           // lã (branco granulado)
  pintarTocha(23);                        // tocha (pau + chama)
  pintarBau(24);                          // baú (planks + dobradiças)
  pintarFornalha(25);                     // fornalha (pedra + abertura)
  pintarCama(26);                         // cama (travesseiro + manta)
  pintarBedrock(27);                      // bedrock (chunky escuro)
  // Sprint 9: Nether
  pintarPedra(28, '#5e2218', '#3a130c', '#7a3024', 0.35); // netherrack vermelho
  pintarPortalNether(29);                                  // portal swirl roxo
  // Sprint End
  pintarPedra(30, '#e8d886', '#c0a866', '#f5e8a0', 0.30); // end stone amarelo
  pintarPortalEnd(31);                                     // portal End verde escuro
  pintarDragonEgg(32);                                     // ovo do dragon (preto + roxo brilho)
  pintarEndCrystal(33);                                    // cristal End amarelo brilhante
  pintarPumpkin(34, false);                                // abóbora natural (top com talo)
  pintarPumpkin(35, true);                                 // abóbora talhada (face jack-o-lantern)
  pintarPumpkinLado(36);                                   // lateral abóbora (ridges verticais)
  pintarBoloTopo(37);                                      // bolo topo (creme + cereja)
  pintarBoloLado(38);                                      // bolo lado (massa + recheio + glace)
  pintarBigornaTopo(39);                                   // bigorna topo (yunque)
  pintarBigornaLado(40);                                   // bigorna lateral (forma da bigorna)
  pintarBeacon(41);                                        // beacon (cristal azul brilhante)
  pintarRail(42);                                          // trilho (dormentes + 2 rails)
  pintarTeia(43);                                          // teia de aranha (cordas em X)
  pintarEstanteTopo(44);                                   // topo da estante (madeira)
  pintarEstanteLado(45);                                   // lateral com livros coloridos
  pintarLaColorida(46, '#c62828', '#ef5350', '#8b0000'); // lã vermelha
  pintarLaColorida(47, '#1565c0', '#4fc3f7', '#0d47a1'); // lã azul
  pintarLaColorida(48, '#2e7d32', '#66bb6a', '#1b5e20'); // lã verde
  pintarLaColorida(49, '#f9a825', '#ffd54f', '#f57f17'); // lã amarela
  pintarVidroColorido(50, '#ef5350', '#8b0000');         // vidro vermelho
  pintarVidroColorido(51, '#4fc3f7', '#0d47a1');         // vidro azul
  pintarVidroColorido(52, '#66bb6a', '#1b5e20');         // vidro verde
  pintarVidroColorido(53, '#ffeb3b', '#f9a825');         // vidro amarelo
  pintarQuartzo(54, false);                               // quartzo natural
  pintarQuartzo(55, true);                                // quartzo polido
  pintarCogumelo(56, true);                               // cogumelo vermelho gigante
  pintarCogumelo(57, false);                              // cogumelo marrom gigante
  pintarCobre(58, '#e07a3b', '#ff9d5e', '#a04e1c', 0);     // cobre novo
  pintarCobre(59, '#b47366', '#d6968b', '#7a4a40', 0.4);   // cobre gasto
  pintarCobre(60, '#5fb89e', '#85d6bc', '#3d8470', 0.9);   // cobre oxidado
  pintarVela(61, '#fafafa', '#bdbdbd');                    // vela branca
  pintarVela(62, '#ef5350', '#b71c1c');                    // vela vermelha
  pintarVela(63, '#4fc3f7', '#0d47a1');                    // vela azul
  pintarMagma(64);                                         // bloco de magma
  pintarLanterna(65);                                      // lanterna de ferro
  pintarBandeira(66, '#c62828', '#8b0000', '#ef5350');     // bandeira vermelha
  pintarBandeira(67, '#1565c0', '#0d47a1', '#4fc3f7');     // bandeira azul
  pintarBandeira(68, '#2e7d32', '#1b5e20', '#66bb6a');     // bandeira verde
  pintarBandeira(69, '#f9a825', '#f57f17', '#ffd54f');     // bandeira amarela
  pintarCobreMinerio(70);                                   // minério de cobre
  pintarColmeiaTopo(71);                                    // colmeia topo (favo)
  pintarColmeiaLado(72);                                    // colmeia lado (entrada)
  pintarLilyPad(73);                                        // vitória-régia
  pintarBlocoMel(74);                                       // bloco de mel
  pintarPedra(75, '#a66556', '#7a3a2c', '#c98575', 0.45);    // granito (rosa-avermelhado)
  pintarPedra(76, '#e0e0e0', '#2a2a2a', '#ffffff', 0.40);    // diorito (branco/preto manchado)
  pintarPedra(77, '#9e9e9e', '#7a7a7a', '#bdbdbd', 0.35);    // andesito (cinza claro suave)
  pintarArgila(78);                                          // argila azul-cinza
  pintarBambu(79);                                           // bambu verde com nós
  pintarPolido(80, '#c98575', '#7a3a2c', '#e8a59a');         // granito polido
  pintarPolido(81, '#eeeeee', '#9e9e9e', '#ffffff');         // diorito polido
  pintarPolido(82, '#b0b0b0', '#7a7a7a', '#d0d0d0');         // andesito polido
  pintarPedraLisa(83);                                       // pedra lisa (smooth)
  pintarTijoloMusgo(84);                                     // tijolo com musgo
  pintarArenito(85, null);                                   // arenito padrão
  pintarArenito(86, 'liso');                                 // arenito liso (gradient)
  pintarArenito(87, 'cortado');                              // arenito cortado (cruz)
  pintarTijoloNether(88, false);                             // tijolo do nether
  pintarTijoloNether(89, true);                              // nether cortado
  pintarPavimento(90);                                       // pavimento (cobblestone)
  pintarGelo(91, '#b3e5fc', '#ffffff', '#90caf9', 0.7);      // gelo padrão
  pintarGelo(92, '#c1d8ff', '#ffffff', '#a0c0ec', 0.5);      // gelo empacotado
  pintarGelo(93, '#40c4ff', '#ffffff', '#0288d1', 1.2);      // gelo azul intenso
  pintarBasalto(94, false);                                  // basalto natural
  pintarBasalto(95, true);                                   // basalto polido
  pintarSoulSand(96);                                        // areia das almas
  pintarSoulSoil(97);                                        // terra das almas
  pintarStem(98,  '#8a3a4d', '#5d2535', '#a85065');          // crimson stem
  pintarStem(99,  '#2c8a8a', '#1d5d5d', '#4cb8b8');          // warped stem
  pintarBlackstone(100);                                     // blackstone
  pintarDeepslate(101);                                      // deepslate
  pintarAmethyst(102);                                       // amethyst
  pintarCalcite(103);                                        // calcite
  pintarPedra(104, '#3a3a42', '#1a1a22', '#5a5a62', 0.40);   // deepslate cobbled
  pintarPolido(105, '#55555f', '#35353d', '#7a7a82');        // deepslate polido
  pintarPolido(106, '#2a2a2a', '#0a0a0a', '#4a4a4a');        // blackstone polido
  pintarLama(107, '#4d3826', '#36281a', '#7a5e44');          // lama escura úmida
  pintarLama(108, '#806746', '#5e4a30', '#a08868');          // lama compacta clara
  pintarTijoloLama(109);                                     // tijolo de lama
  pintarTuff(110);                                           // tufo
  pintarDripstone(111);                                      // dripstone
  // Deepslate ores (cells 112-116) — base ardósia + cluster colorido
  pintarMinerioDeep(112, '#212121', '#424242');              // ds carvão
  pintarMinerioDeep(113, '#a1887f', '#cfd8dc');              // ds ferro
  pintarMinerioDeep(114, '#fdd835', '#fff176');              // ds ouro
  pintarMinerioDeep(115, '#4dd0e1', '#80deea');              // ds diamante
  pintarMinerioDeep(116, '#e07a3b', '#ff9d5e');              // ds cobre
  // Compactados (cells 117-121)
  pintarBlocoCompacto(117, '#cfd8dc', '#eceff1', '#90a4ae'); // ferro
  pintarBlocoCompacto(118, '#fdd835', '#fff59d', '#f9a825'); // ouro
  pintarBlocoCompacto(119, '#4dd0e1', '#b2ebf2', '#00838f'); // diamante
  pintarBlocoCompacto(120, '#212121', '#424242', '#000000'); // carvão
  pintarBlocoCompacto(121, '#1565c0', '#42a5f5', '#0d47a1'); // lápis
  // Esmeralda (cells 122-124)
  pintarMinerio(122, '#00c853', '#69f0ae');                  // esmeralda em pedra
  pintarMinerioDeep(123, '#00c853', '#69f0ae');              // esmeralda em deepslate
  pintarBlocoCompacto(124, '#00c853', '#69f0ae', '#008c44'); // bloco esmeralda
  // Redstone (cells 125-127)
  pintarMinerio(125, '#c62828', '#ef5350');                  // redstone em pedra
  pintarMinerioDeep(126, '#c62828', '#ef5350');              // redstone em deepslate
  pintarBlocoCompacto(127, '#c62828', '#ef5350', '#8b0000'); // bloco redstone
  // Prismarine (cells 128-130)
  pintarPrismarine(128, '#4db6ac', '#00897b', '#80cbc4', false); // prismarine
  pintarPrismarine(129, '#009688', '#00695c', '#4db6ac', true);  // prismarine bricks
  pintarSeaLantern(130);                                          // sea lantern
  pintarSlimeBlock(131);                                          // slime block
  pintarCryingObsidian(132);                                      // crying obsidian
  pintarNetherWart(133, '#6a0d0d', '#3d0707', '#a01818');         // nether wart vermelho
  pintarNetherWart(134, '#0d6a6a', '#073d3d', '#18a0a0');         // warped wart azul
  pintarShroomlight(135);                                         // shroomlight
  pintarEndBrick(136);                                            // end brick
  pintarPurpur(137, false);                                       // purpur block
  pintarPurpur(138, true);                                        // purpur pillar
  pintarPlanksColorida(139, '#8a3a4d', '#5d2535', '#a85065');     // crimson planks
  pintarPlanksColorida(140, '#2c8a8a', '#1d5d5d', '#4cb8b8');     // warped planks
  pintarEsponja(141, '#fdd835', '#5d4037');                      // sponge seca
  pintarEsponja(142, '#a1887f', '#3e2723');                      // sponge molhada
  pintarJackOLantern(143);                                        // jack-o-lantern
  pintarTintedGlass(144);                                         // tinted glass
  pintarSnow(145, true);                                          // snow block (com cristais)
  pintarGlowLichen(146);                                          // glow lichen
  pintarSporeBlossom(147);                                        // spore blossom
  pintarSnow(148, false);                                         // powder snow (puro)
  pintarSculk(149, 'plain');                                      // sculk
  pintarSculk(150, 'vein');                                       // sculk vein
  pintarSculk(151, 'shrieker');                                   // sculk shrieker
  pintarSculk(152, 'sensor');                                     // sculk sensor
  pintarSculk(153, 'catalyst');                                   // sculk catalyst
  pintarCama(154, '#1565c0', '#0d47a1', '#42a5f5');              // cama azul
  pintarCama(155, '#2e7d32', '#1b5e20', '#66bb6a');              // cama verde
  pintarCama(156, '#f9a825', '#f57f17', '#ffd54f');              // cama amarela
  pintarCama(157, '#7b1fa2', '#4a148c', '#ce93d8');              // cama roxa
  pintarPortaCor(158, '#8a3a4d', '#5d2535', '#a85065', '#424242'); // porta crimson
  pintarPortaCor(159, '#2c8a8a', '#1d5d5d', '#4cb8b8', '#424242'); // porta warped
  pintarPortaCor(160, '#cfd8dc', '#90a4ae', '#eceff1', '#5e5e5e'); // porta ferro
  pintarTrapdoor(161, '#a1887f', '#5d4037', false);              // trapdoor madeira
  pintarTrapdoor(162, '#cfd8dc', '#5e5e5e', true);               // trapdoor ferro
  pintarPortaCor(163, '#a1887f', '#5d4037', '#bcaaa4', '#424242'); // portão madeira (reusa pintor porta)
  pintarPortaCor(164, '#8a3a4d', '#5d2535', '#a85065', '#424242'); // portão crimson
  pintarSign(165);                                                 // placa
  pintarTNT(166);                                                  // TNT
  pintarFlor(167, '#c62828', '#fdd835');                          // rosa vermelha
  pintarFlor(168, '#fdd835', '#fff176');                          // dente-leão amarelo
  pintarFlor(169, '#42a5f5', '#fff176');                          // cornflower azul
  pintarFlor(170, '#fafafa', '#fdd835');                          // margarida branca
  pintarFlor(171, '#ab47bc', '#fdd835');                          // allium roxa
  pintarVasoFlor(172);                                             // vaso de flor
  pintarGradeFerro(173);                                           // grade de ferro
  pintarHopper(174);                                               // hopper
  pintarDispenser(175);                                            // dispenser
  pintarObserver(176);                                             // observer
  pintarTochaRedstone(177);                                        // tocha redstone
  pintarCogumeloPeq(178, '#c62828', true);                        // cogumelo vermelho pequeno
  pintarCogumeloPeq(179, '#6d4c41', false);                       // cogumelo marrom pequeno
  pintarCaveira(180, false);                                       // caveira esqueleto
  pintarCaveira(181, true);                                        // crânio wither
  pintarConduit(182);                                              // conduit
  pintarHead(183, '#2e7d32', '#1b5e20', '#000000');               // creeper head
  pintarHead(184, '#4caf50', '#2e7d32', '#ff3d00');               // zumbi head
  pintarHead(185, '#121212', '#000000', '#b388ff');               // dragon head
  pintarSoulTorch(186);                                            // soul torch chama azul
  pintarSoulLantern(187);                                          // soul lantern
  pintarLampadaRed(188);                                           // lâmpada redstone
  pintarBlazeBlock(189);                                           // blaze block
  // 6 lãs coloridas adicionais (cells 190-195)
  pintarLaColorida(190, '#ff9800', '#ffb74d', '#e65100');          // lã laranja
  pintarLaColorida(191, '#f06292', '#f48fb1', '#c2185b');          // lã rosa
  pintarLaColorida(192, '#4dd0e1', '#80deea', '#00838f');          // lã ciano
  pintarLaColorida(193, '#6d4c41', '#8d6e63', '#3e2723');          // lã marrom
  pintarLaColorida(194, '#424242', '#616161', '#212121');          // lã preta
  pintarLaColorida(195, '#9e9e9e', '#bdbdbd', '#616161');          // lã cinza
  // 2 concretos (cells 196-197)
  pintar(196, '#c62828', '#8b0000', 0.45);                        // concreto vermelho
  pintar(197, '#1565c0', '#0d47a1', 0.45);                        // concreto azul
  pintar(198, '#2e7d32', '#1b5e20', 0.45);                        // concreto verde
  pintar(199, '#f9a825', '#f57f17', 0.45);                        // concreto amarelo
  pintar(200, '#fafafa', '#cfd8dc', 0.45);                        // concreto branco
  pintar(201, '#212121', '#000000', 0.45);                        // concreto preto
  // Terracotas (cor mais terrosa, com manchas via pintarPedra)
  pintarPedra(202, '#b55a3a', '#8b3e23', '#d6755a', 0.40);        // terracota vermelha
  pintarPedra(203, '#4a5e9a', '#2c3d6c', '#7385bb', 0.40);        // terracota azul
  pintarPedra(204, '#c9a05a', '#a67d3a', '#e8c280', 0.40);        // terracota amarela
  pintarPedra(205, '#d6c8b8', '#b09f88', '#f0e5d4', 0.30);        // terracota branca
  // 4 concretos adicionais (cells 206-209)
  pintar(206, '#ff9800', '#e65100', 0.45);                        // concreto laranja
  pintar(207, '#f06292', '#c2185b', 0.45);                        // concreto rosa
  pintar(208, '#4dd0e1', '#00838f', 0.45);                        // concreto ciano
  pintar(209, '#6d4c41', '#4e342e', 0.45);                        // concreto marrom
  // 4 terracotas adicionais (cells 210-213)
  pintarPedra(210, '#4d6233', '#344020', '#7d8f50', 0.40);        // terracota verde
  pintarPedra(211, '#764467', '#5a3050', '#9c6d8d', 0.40);        // terracota roxa
  pintarPedra(212, '#a05a30', '#7d3e1c', '#c97a4d', 0.40);        // terracota laranja
  pintarPedra(213, '#251610', '#150a05', '#3d2820', 0.40);        // terracota preta
  // 4 painéis de vidro coloridos (cells 214-217) — reusam pintor vidro
  pintarVidroColorido(214, '#ef5350', '#8b0000');                 // painel vidro vermelho
  pintarVidroColorido(215, '#4fc3f7', '#0d47a1');                 // painel vidro azul
  pintarVidroColorido(216, '#66bb6a', '#1b5e20');                 // painel vidro verde
  pintarVidroColorido(217, '#ffeb3b', '#f9a825');                 // painel vidro amarelo
  // 4 glazed terracotas (cells 218-221)
  pintarGlazed(218, '#c62828', '#ef5350', '#8b0000');             // glazed vermelha
  pintarGlazed(219, '#1565c0', '#4fc3f7', '#0d47a1');             // glazed azul
  pintarGlazed(220, '#2e7d32', '#66bb6a', '#1b5e20');             // glazed verde
  pintarGlazed(221, '#f9a825', '#ffd54f', '#f57f17');             // glazed amarela
  pintarGlazed(222, '#ff9800', '#ffb74d', '#e65100');             // glazed laranja
  pintarGlazed(223, '#f06292', '#f48fb1', '#c2185b');             // glazed rosa
  pintarGlazed(224, '#fafafa', '#ffffff', '#bdbdbd');             // glazed branca
  pintarGlazed(225, '#424242', '#616161', '#000000');             // glazed preta
  pintarBoneBlock(226);                                           // bone block
  pintarRootedDirt(227);                                          // rooted dirt
  pintarChiseled(228, '#9E9E9E', '#5E5E5E', '#bdbdbd');           // chiseled stone
  pintarChiseled(229, '#fafafa', '#bdbdbd', '#ffffff');           // chiseled quartzo
  pintarChiseled(230, '#4a4a52', '#1a1a22', '#7a7a82');           // chiseled deepslate
  pintarChiseled(231, '#1a1a1a', '#000000', '#3a3a3a');           // chiseled blackstone
  pintarHyphae(232, '#8a3a4d', '#5d2535', '#a85065');             // crimson hyphae
  pintarHyphae(233, '#2c8a8a', '#1d5d5d', '#4cb8b8');             // warped hyphae
  pintarFroglight(234, '#a5d6a7', '#66bb6a', '#c5e1a5');          // froglight verde
  pintarFroglight(235, '#ce93d8', '#ab47bc', '#e1bee7');          // froglight roxo
  pintarMelancia(236, false);                                     // melancia
  pintarMelancia(237, true);                                      // melancia dourada
  pintarFlor(238, '#ffeb3b', '#a05a30');                         // girassol amarelo
  pintarAbacaxi(239);                                             // abacaxi
  // 6 painéis vidro adicionais (cells 240-245)
  pintarVidroColorido(240, '#ff9800', '#e65100');                 // painel laranja
  pintarVidroColorido(241, '#f06292', '#c2185b');                 // painel rosa
  pintarVidroColorido(242, '#4dd0e1', '#00838f');                 // painel ciano
  pintarVidroColorido(243, '#fafafa', '#bdbdbd');                 // painel branco
  pintarVidroColorido(244, '#424242', '#000000');                 // painel preto
  pintarVidroColorido(245, '#9e9e9e', '#616161');                 // painel cinza
  // Blocos compactados bambu/cacto (cells 246-247)
  pintar(246, '#8bc34a', '#558b2f', 0.50);                        // bambu compactado
  pintar(247, '#388E3C', '#1b5e20', 0.50);                        // cacto compactado
  // 8 workstations (cells 248-255)
  pintarWorkstation(248, '#424242', '#212121', '#9e9e9e', 'hammer'); // smithing
  pintarWorkstation(249, '#a1887f', '#5d4037', '#fdd835', 'flask');  // brewing
  pintarWorkstation(250, '#424242', '#212121', '#ff9800', 'fire');   // blast furnace
  pintarWorkstation(251, '#6d4c41', '#3e2723', '#ff9800', 'fire');   // smoker
  pintarWorkstation(252, '#a1887f', '#5d4037', '#fff8e1', 'map');    // cartography
  pintarWorkstation(253, '#a1887f', '#5d4037', '#fafafa', 'arrow');  // fletching
  pintarWorkstation(254, '#a1887f', '#5d4037', '#fafafa', 'loom');   // loom
  pintarWorkstation(255, '#9e9e9e', '#424242', '#bdbdbd', 'saw');    // stonecutter
  // Blocos especiais novos (cells 256-263)
  pintarTarget(256);
  pintarAncientDebris(257);
  pintarHoneycombBlock(258);
  pintarComposter(259);
  pintarLectern(260);
  pintarBarrel(261);
  pintarCampfire(262);
  pintar(263, '#33691e', '#1b5e20', 0.40);                          // dried kelp
  pintarBookshelfChiseled(264);                                     // bookshelf chiseled
  pintarJukebox(265);                                               // jukebox
  // End Rod reusa pintor da tocha branca com glow (cell 266)
  pintarVela(266, '#fafafa', '#bdbdbd');                           // end rod (visual tocha branca)
  pintar(267, '#fff59d', '#ffeb3b', 0.30);                         // light block (amarelo claro)
  pintarDaylightDetector(268);                                     // daylight detector
  pintarNoteBlock(269);                                             // note block
  pintarBell(270);                                                  // bell
  pintar(271, '#558b2f', '#33691e', 0.50);                         // sea pickle (verde-escuro)
  pintarEnderChest(272);                                            // ender chest
  pintarShulkerBox(273);                                            // shulker box
  pintarAnvilDamaged(274);                                          // anvil damaged
  pintarDecoratedPot(275);                                          // decorated pot
  // 4 Shulker coloridos (cells 276-279)
  pintarShulkerCor(276, '#c62828', '#8b0000', '#ef5350', '#5d1212');
  pintarShulkerCor(277, '#1565c0', '#0d47a1', '#42a5f5', '#082b58');
  pintarShulkerCor(278, '#2e7d32', '#1b5e20', '#66bb6a', '#0f3a14');
  pintarShulkerCor(279, '#f9a825', '#f57f17', '#ffd54f', '#a35200');
  pintarShulkerCor(280, '#fafafa', '#bdbdbd', '#ffffff', '#9e9e9e'); // shulker branco
  pintarShulkerCor(281, '#424242', '#212121', '#616161', '#000000'); // shulker preto
  pintarShulkerCor(282, '#ff9800', '#e65100', '#ffb74d', '#bf360c'); // shulker laranja
  pintarShulkerCor(283, '#f06292', '#c2185b', '#f48fb1', '#880e4f'); // shulker rosa
  pintarCommandBlock(284);                                            // 🎯 Marco 400! Command Block
  // Sprint paridade MC (cells 285-292)
  pintarRespawnAnchor(285);
  pintarLodestone(286);
  pintarReinforcedDS(287);
  pintarMossBlock(288);
  pintarBigDripleaf(289);
  pintarChorusFlower(290);
  pintarPiston(291);
  // Sprint redstone+wood (cells 292-299)
  pintarStickyPiston(292);
  pintarRepeater(293);
  pintarComparator(294);
  pintarCrafter(295);
  pintarTrappedChest(296);
  pintarMangroveLog(297);
  pintarMangrovePrancha(298);
  pintarCherryLog(299);
  // Sprint 4: madeiras+plantas (cells 300-307)
  pintarCherryPrancha(300);
  pintarCherryFolha(301);
  pintarMangroveFolha(302);
  pintarMangroveRaiz(303);
  pintarAzalea(304);
  pintarAzaleaFlower(305);
  pintarPinkPetals(306);
  pintarCactusFlower(307);
  // Sprint 5: Nether plants + cipós (cells 308-315)
  pintarBambooMosaic(308);
  pintarCrimsonRoots(309);
  pintarWarpedRoots(310);
  pintarFrostedIce(311);
  pintarVine(312);
  pintarTwistingVines(313);
  pintarWeepingVines(314);
  pintarScaffolding(315);
  // Sprint 6: cavernas+gemas (cells 316-323)
  pintarHangingRoots(316);
  pintarGlowBerries(317);
  pintarAmethystBudding(318);
  pintarAmethystCluster(319);
  pintarPointedDripstone(320);
  pintarMossyCobblestone(321);
  pintarCrackedStoneBricks(322);
  pintarMossyStoneBricks(323);
  // Sprint 7: MC 1.21 Tricky Trials (cells 324-331)
  pintarTuffBricks(324);
  pintarChiseledTuff(325);
  pintarChiseledTuffBricks(326);
  pintarChiseledCopper(327);
  pintarCopperBulb(328);
  pintarCopperGrate(329);
  pintarTrialSpawner(330);
  pintarVault(331);
  // Sprint 8: Pottery + arqueologia + 1.20 (cells 332-339)
  pintarPitcherPlant(332);
  pintarPitcherCrop(333);
  pintarTorchflower(334);
  pintarTorchflowerCrop(335);
  pintarSnifferEgg(336);
  pintarSuspiciousSand(337);
  pintarSuspiciousGravel(338);
  pintarCalibratedSculk(339);
  // Sprint 9: madeiras variantes (cells 340-347)
  pintarLogVariante(340, '#eceff1', '#bcaaa4', '#fafafa', '#212121'); // birch (branca + listras pretas)
  pintarPranchaVariante(341, '#fff8e1', '#bcaaa4', '#eceff1');         // birch pranchas
  pintarLogVariante(342, '#3e2723', '#1a0e08', '#5d4037', '#8d6e63'); // spruce (escuro)
  pintarPranchaVariante(343, '#6d4c41', '#3e2723', '#8d6e63');         // spruce pranchas
  pintarLogVariante(344, '#7d3e1c', '#5d2510', '#bcaaa4', '#a05a30'); // acacia
  pintarPranchaVariante(345, '#ff7043', '#bf360c', '#ff8a65');         // acacia pranchas (laranja vivo)
  pintarLogVariante(346, '#4e3d10', '#33270a', '#827717', '#9e9d24'); // jungle (verde-marrom)
  pintarLogVariante(347, '#1a0e08', '#000000', '#3e2723', '#5d4037'); // dark oak (quase preto)
  // Sprint 10: pranchas+folhas+stripped (cells 348-355)
  pintarPranchaVariante(348, '#8d6e63', '#6d4c41', '#a1887f');                            // jungle pranchas
  pintarPranchaVariante(349, '#3e2723', '#1a0e08', '#5d4037');                            // dark oak pranchas
  pintarFolhaVariante(350, '#9ccc65', '#7cb342', '#558b2f', '#fafafa');                   // birch folha (verde claro + flores brancas)
  pintarFolhaVariante(351, '#33691e', '#1b5e20', '#0d3d10', '#3e2723');                   // spruce folha (verde escuro + cones)
  pintarFolhaVariante(352, '#9e9d24', '#827717', '#33691e', '#fdd835');                   // acacia folha (verde-amarelo)
  pintarFolhaVariante(353, '#66bb6a', '#388e3c', '#1b5e20', '#fdd835');                   // jungle folha (verde vivo)
  pintarFolhaVariante(354, '#33691e', '#0e2a08', '#1b5e20', '#5d4037');                   // dark oak folha
  pintarLogVariante(355, '#a1875a', '#7d6932', '#d7b57c', '#5d4037');                     // stripped oak (interior amarelo claro)
  // Sprint 11: stripped + vegetação (cells 356-363)
  pintarStrippedLog(356, '#fff8e1', '#eceff1', '#bcaaa4');                  // stripped birch
  pintarStrippedLog(357, '#6d4c41', '#4e342e', '#8d6e63');                  // stripped spruce
  pintarStrippedLog(358, '#e65100', '#bf360c', '#ff8a65');                  // stripped acacia
  pintarStrippedLog(359, '#c8a951', '#a0863e', '#fff8e1');                  // stripped jungle
  pintarStrippedLog(360, '#5d4037', '#3e2723', '#8d6e63');                  // stripped dark oak
  pintarPlantaVertical(361, '#8d6e63', '#a1887f', '#5d4037', false);        // dead bush (marrom seco)
  pintarPlantaVertical(362, '#7cb342', '#9ccc65', '#33691e', true);         // tall grass (verde claro)
  pintarPlantaVertical(363, '#33691e', '#558b2f', '#1b5e20', false);        // fern (verde escuro)

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
  // Sprint 2: building blocks reaproveitam texturas existentes
  mapa[BLOCO.SLAB_PEDRA]    = { top: 3,  side: 3,  bottom: 3  };
  mapa[BLOCO.SLAB_MADEIRA]  = { top: 5,  side: 6,  bottom: 5  };
  mapa[BLOCO.SLAB_TIJOLO]   = { top: 8,  side: 8,  bottom: 8  };
  mapa[BLOCO.FENCE_MADEIRA] = { top: 6,  side: 6,  bottom: 6  };
  mapa[BLOCO.LADDER]        = { top: 6,  side: 6,  bottom: 6  };
  mapa[BLOCO.DOOR_MADEIRA]  = { top: 5,  side: 6,  bottom: 5  };
  mapa[BLOCO.MESA_ENCANT]   = { top: 19, side: 19, bottom: 3  }; // obsidiana top + side, pedra bottom
  mapa[BLOCO.DOOR_ABERTA]   = { top: 5,  side: 6,  bottom: 5  }; // mesma textura da fechada
  mapa[BLOCO.NETHERRACK]    = { top: 28, side: 28, bottom: 28 }; // nova célula
  mapa[BLOCO.PORTAL_NETHER] = { top: 29, side: 29, bottom: 29 };
  mapa[BLOCO.END_STONE]     = { top: 30, side: 30, bottom: 30 };
  mapa[BLOCO.PORTAL_END]    = { top: 31, side: 31, bottom: 31 };
  mapa[BLOCO.DRAGON_EGG]    = { top: 32, side: 32, bottom: 32 };
  mapa[BLOCO.END_CRYSTAL]   = { top: 33, side: 33, bottom: 33 };
  mapa[BLOCO.PUMPKIN]        = { top: 34, side: 36, bottom: 36 }; // talo cima, ridges lado
  mapa[BLOCO.CARVED_PUMPKIN] = { top: 34, side: 35, bottom: 36 }; // face na frente (lado)
  mapa[BLOCO.BOLO]           = { top: 37, side: 38, bottom: 38 }; // creme cima, lateral em camadas
  mapa[BLOCO.BIGORNA]        = { top: 39, side: 40, bottom: 40 }; // yunque cima, forma lateral
  mapa[BLOCO.BEACON]         = { top: 41, side: 41, bottom: 41 }; // cristal em todas as faces
  mapa[BLOCO.RAIL]           = { top: 42, side: 42, bottom: 42 }; // trilho (slab fina)
  mapa[BLOCO.TEIA]           = { top: 43, side: 43, bottom: 43 }; // teia em todas as faces
  mapa[BLOCO.ESTANTE]        = { top: 44, side: 45, bottom: 44 }; // madeira topo, livros lateral
  mapa[BLOCO.LA_VERMELHA]    = { top: 46, side: 46, bottom: 46 };
  mapa[BLOCO.LA_AZUL]        = { top: 47, side: 47, bottom: 47 };
  mapa[BLOCO.LA_VERDE]       = { top: 48, side: 48, bottom: 48 };
  mapa[BLOCO.LA_AMARELA]     = { top: 49, side: 49, bottom: 49 };
  mapa[BLOCO.VIDRO_VERMELHO] = { top: 50, side: 50, bottom: 50 };
  mapa[BLOCO.VIDRO_AZUL]     = { top: 51, side: 51, bottom: 51 };
  mapa[BLOCO.VIDRO_VERDE]    = { top: 52, side: 52, bottom: 52 };
  mapa[BLOCO.VIDRO_AMARELO]  = { top: 53, side: 53, bottom: 53 };
  mapa[BLOCO.QUARTZO]        = { top: 54, side: 54, bottom: 54 };
  mapa[BLOCO.QUARTZO_POLIDO] = { top: 55, side: 55, bottom: 55 };
  mapa[BLOCO.COGUMELO_VERM]  = { top: 56, side: 56, bottom: 56 };
  mapa[BLOCO.COGUMELO_MARROM]= { top: 57, side: 57, bottom: 57 };
  mapa[BLOCO.COBRE]          = { top: 58, side: 58, bottom: 58 };
  mapa[BLOCO.COBRE_GASTO]    = { top: 59, side: 59, bottom: 59 };
  mapa[BLOCO.COBRE_OXIDADO]  = { top: 60, side: 60, bottom: 60 };
  mapa[BLOCO.VELA]           = { top: 61, side: 61, bottom: 61 };
  mapa[BLOCO.VELA_VERMELHA]  = { top: 62, side: 62, bottom: 62 };
  mapa[BLOCO.VELA_AZUL]      = { top: 63, side: 63, bottom: 63 };
  mapa[BLOCO.MAGMA]          = { top: 64, side: 64, bottom: 64 };
  mapa[BLOCO.LANTERNA]       = { top: 65, side: 65, bottom: 65 };
  mapa[BLOCO.BANDEIRA_R]     = { top: 66, side: 66, bottom: 66 };
  mapa[BLOCO.BANDEIRA_A]     = { top: 67, side: 67, bottom: 67 };
  mapa[BLOCO.BANDEIRA_V]     = { top: 68, side: 68, bottom: 68 };
  mapa[BLOCO.BANDEIRA_AM]    = { top: 69, side: 69, bottom: 69 };
  mapa[BLOCO.COBRE_MINERIO]  = { top: 70, side: 70, bottom: 70 };
  mapa[BLOCO.COLMEIA]        = { top: 71, side: 72, bottom: 71 };
  mapa[BLOCO.LILY_PAD]       = { top: 73, side: 73, bottom: 73 };
  mapa[BLOCO.BLOCO_MEL]      = { top: 74, side: 74, bottom: 74 };
  mapa[BLOCO.GRANITO]        = { top: 75, side: 75, bottom: 75 };
  mapa[BLOCO.DIORITO]        = { top: 76, side: 76, bottom: 76 };
  mapa[BLOCO.ANDESITO]       = { top: 77, side: 77, bottom: 77 };
  mapa[BLOCO.ARGILA]         = { top: 78, side: 78, bottom: 78 };
  mapa[BLOCO.BAMBU]          = { top: 79, side: 79, bottom: 79 };
  mapa[BLOCO.GRANITO_POL]    = { top: 80, side: 80, bottom: 80 };
  mapa[BLOCO.DIORITO_POL]    = { top: 81, side: 81, bottom: 81 };
  mapa[BLOCO.ANDESITO_POL]   = { top: 82, side: 82, bottom: 82 };
  mapa[BLOCO.PEDRA_LISA]     = { top: 83, side: 83, bottom: 83 };
  mapa[BLOCO.TIJOLO_MUSGO]   = { top: 84, side: 84, bottom: 84 };
  mapa[BLOCO.ARENITO]        = { top: 85, side: 85, bottom: 85 };
  mapa[BLOCO.ARENITO_LISO]   = { top: 86, side: 86, bottom: 86 };
  mapa[BLOCO.ARENITO_CORTADO]= { top: 87, side: 87, bottom: 87 };
  mapa[BLOCO.TIJOLO_NETHER]  = { top: 88, side: 88, bottom: 88 };
  mapa[BLOCO.NETHER_CORTADO] = { top: 89, side: 89, bottom: 89 };
  mapa[BLOCO.PAVIMENTO]      = { top: 90, side: 90, bottom: 90 };
  mapa[BLOCO.GELO]           = { top: 91, side: 91, bottom: 91 };
  mapa[BLOCO.GELO_EMPACOTADO]= { top: 92, side: 92, bottom: 92 };
  mapa[BLOCO.GELO_AZUL]      = { top: 93, side: 93, bottom: 93 };
  mapa[BLOCO.BASALTO]        = { top: 94, side: 94, bottom: 94 };
  mapa[BLOCO.BASALTO_POLIDO] = { top: 95, side: 95, bottom: 95 };
  mapa[BLOCO.SOUL_SAND]      = { top: 96, side: 96, bottom: 96 };
  mapa[BLOCO.SOUL_SOIL]      = { top: 97, side: 97, bottom: 97 };
  mapa[BLOCO.CRIMSON_STEM]   = { top: 98, side: 98, bottom: 98 };
  mapa[BLOCO.WARPED_STEM]    = { top: 99, side: 99, bottom: 99 };
  mapa[BLOCO.BLACKSTONE]     = { top: 100, side: 100, bottom: 100 };
  mapa[BLOCO.DEEPSLATE]      = { top: 101, side: 101, bottom: 101 };
  mapa[BLOCO.AMETHYST]       = { top: 102, side: 102, bottom: 102 };
  mapa[BLOCO.CALCITE]        = { top: 103, side: 103, bottom: 103 };
  mapa[BLOCO.DEEPSLATE_PAV]  = { top: 104, side: 104, bottom: 104 };
  mapa[BLOCO.DEEPSLATE_POL]  = { top: 105, side: 105, bottom: 105 };
  mapa[BLOCO.BLACKSTONE_POL] = { top: 106, side: 106, bottom: 106 };
  mapa[BLOCO.LAMA]           = { top: 107, side: 107, bottom: 107 };
  mapa[BLOCO.LAMA_COMPACTA]  = { top: 108, side: 108, bottom: 108 };
  mapa[BLOCO.TIJOLO_LAMA]    = { top: 109, side: 109, bottom: 109 };
  mapa[BLOCO.TUFF]           = { top: 110, side: 110, bottom: 110 };
  mapa[BLOCO.DRIPSTONE]      = { top: 111, side: 111, bottom: 111 };
  mapa[BLOCO.DS_CARVAO]      = { top: 112, side: 112, bottom: 112 };
  mapa[BLOCO.DS_FERRO]       = { top: 113, side: 113, bottom: 113 };
  mapa[BLOCO.DS_OURO]        = { top: 114, side: 114, bottom: 114 };
  mapa[BLOCO.DS_DIAMANTE]    = { top: 115, side: 115, bottom: 115 };
  mapa[BLOCO.DS_COBRE]       = { top: 116, side: 116, bottom: 116 };
  mapa[BLOCO.BLOCO_FERRO]    = { top: 117, side: 117, bottom: 117 };
  mapa[BLOCO.BLOCO_OURO]     = { top: 118, side: 118, bottom: 118 };
  mapa[BLOCO.BLOCO_DIAMANTE] = { top: 119, side: 119, bottom: 119 };
  mapa[BLOCO.BLOCO_CARVAO]   = { top: 120, side: 120, bottom: 120 };
  mapa[BLOCO.BLOCO_LAPIS]    = { top: 121, side: 121, bottom: 121 };
  mapa[BLOCO.ESMERALDA_MIN]  = { top: 122, side: 122, bottom: 122 };
  mapa[BLOCO.DS_ESMERALDA]   = { top: 123, side: 123, bottom: 123 };
  mapa[BLOCO.BLOCO_ESMERALDA]= { top: 124, side: 124, bottom: 124 };
  mapa[BLOCO.REDSTONE_MIN]   = { top: 125, side: 125, bottom: 125 };
  mapa[BLOCO.DS_REDSTONE]    = { top: 126, side: 126, bottom: 126 };
  mapa[BLOCO.BLOCO_REDSTONE] = { top: 127, side: 127, bottom: 127 };
  mapa[BLOCO.PRISMARINE]     = { top: 128, side: 128, bottom: 128 };
  mapa[BLOCO.PRISMARINE_BRK] = { top: 129, side: 129, bottom: 129 };
  mapa[BLOCO.SEA_LANTERN]    = { top: 130, side: 130, bottom: 130 };
  mapa[BLOCO.SLIME_BLOCK]    = { top: 131, side: 131, bottom: 131 };
  mapa[BLOCO.CRYING_OBSIDIAN]= { top: 132, side: 132, bottom: 132 };
  mapa[BLOCO.NETHER_WART_R]  = { top: 133, side: 133, bottom: 133 };
  mapa[BLOCO.NETHER_WART_A]  = { top: 134, side: 134, bottom: 134 };
  mapa[BLOCO.SHROOMLIGHT]    = { top: 135, side: 135, bottom: 135 };
  mapa[BLOCO.END_BRICK]      = { top: 136, side: 136, bottom: 136 };
  mapa[BLOCO.PURPUR_BLOCK]   = { top: 137, side: 137, bottom: 137 };
  mapa[BLOCO.PURPUR_PILLAR]  = { top: 138, side: 138, bottom: 138 };
  mapa[BLOCO.CRIMSON_PLANKS] = { top: 139, side: 139, bottom: 139 };
  mapa[BLOCO.WARPED_PLANKS]  = { top: 140, side: 140, bottom: 140 };
  mapa[BLOCO.SPONGE]         = { top: 141, side: 141, bottom: 141 };
  mapa[BLOCO.SPONGE_WET]     = { top: 142, side: 142, bottom: 142 };
  mapa[BLOCO.JACK_O_LANTERN] = { top: 143, side: 143, bottom: 143 };
  mapa[BLOCO.TINTED_GLASS]   = { top: 144, side: 144, bottom: 144 };
  mapa[BLOCO.SNOW_BLOCK]     = { top: 145, side: 145, bottom: 145 };
  mapa[BLOCO.GLOW_LICHEN]    = { top: 146, side: 146, bottom: 146 };
  mapa[BLOCO.SPORE_BLOSSOM]  = { top: 147, side: 147, bottom: 147 };
  mapa[BLOCO.POWDER_SNOW]    = { top: 148, side: 148, bottom: 148 };
  mapa[BLOCO.SCULK]          = { top: 149, side: 149, bottom: 149 };
  mapa[BLOCO.SCULK_VEIN]     = { top: 150, side: 150, bottom: 150 };
  mapa[BLOCO.SCULK_SHRIEKER] = { top: 151, side: 151, bottom: 151 };
  mapa[BLOCO.SCULK_SENSOR]   = { top: 152, side: 152, bottom: 152 };
  mapa[BLOCO.SCULK_CATALYST] = { top: 153, side: 153, bottom: 153 };
  mapa[BLOCO.CAMA_AZUL]      = { top: 154, side: 154, bottom: 154 };
  mapa[BLOCO.CAMA_VERDE]     = { top: 155, side: 155, bottom: 155 };
  mapa[BLOCO.CAMA_AMARELA]   = { top: 156, side: 156, bottom: 156 };
  mapa[BLOCO.CAMA_ROXA]      = { top: 157, side: 157, bottom: 157 };
  mapa[BLOCO.PORTA_CRIMSON]  = { top: 158, side: 158, bottom: 158 };
  mapa[BLOCO.PORTA_WARPED]   = { top: 159, side: 159, bottom: 159 };
  mapa[BLOCO.PORTA_FERRO]    = { top: 160, side: 160, bottom: 160 };
  mapa[BLOCO.TRAPDOOR_M]     = { top: 161, side: 161, bottom: 161 };
  mapa[BLOCO.TRAPDOOR_F]     = { top: 162, side: 162, bottom: 162 };
  mapa[BLOCO.PORTAO_M]       = { top: 163, side: 163, bottom: 163 };
  mapa[BLOCO.PORTAO_C]       = { top: 164, side: 164, bottom: 164 };
  mapa[BLOCO.SIGN_MADEIRA]   = { top: 165, side: 165, bottom: 165 };
  // Escadas: reusam textura dos blocos base (pedra=3, madeira topo=5/lado=6, tijolo=8)
  mapa[BLOCO.ESCADA_PEDRA]   = { top: 3, side: 3, bottom: 3 };
  mapa[BLOCO.ESCADA_MADEIRA] = { top: 5, side: 6, bottom: 5 };
  mapa[BLOCO.ESCADA_TIJOLO]  = { top: 8, side: 8, bottom: 8 };
  // Paredes: idem
  mapa[BLOCO.PAREDE_PEDRA]    = { top: 3,  side: 3,  bottom: 3  };
  mapa[BLOCO.PAREDE_TIJOLO]   = { top: 8,  side: 8,  bottom: 8  };
  mapa[BLOCO.PAREDE_PAVIMENTO]= { top: 90, side: 90, bottom: 90 };
  // Botões/placas/alavanca reusam textura do material base
  mapa[BLOCO.BTN_PEDRA]      = { top: 3,  side: 3,  bottom: 3  };
  mapa[BLOCO.BTN_MADEIRA]    = { top: 5,  side: 6,  bottom: 5  };
  mapa[BLOCO.BTN_OURO]       = { top: 10, side: 10, bottom: 10 };
  mapa[BLOCO.PLATE_PEDRA]    = { top: 3,  side: 3,  bottom: 3  };
  mapa[BLOCO.PLATE_MADEIRA]  = { top: 5,  side: 6,  bottom: 5  };
  mapa[BLOCO.ALAVANCA]       = { top: 6,  side: 6,  bottom: 3  };
  mapa[BLOCO.TNT]            = { top: 166, side: 166, bottom: 166 };
  mapa[BLOCO.FLOR_VERMELHA]  = { top: 167, side: 167, bottom: 167 };
  mapa[BLOCO.FLOR_AMARELA]   = { top: 168, side: 168, bottom: 168 };
  mapa[BLOCO.FLOR_AZUL]      = { top: 169, side: 169, bottom: 169 };
  mapa[BLOCO.FLOR_BRANCA]    = { top: 170, side: 170, bottom: 170 };
  mapa[BLOCO.FLOR_ROXA]      = { top: 171, side: 171, bottom: 171 };
  mapa[BLOCO.VASO_FLOR]      = { top: 172, side: 172, bottom: 172 };
  mapa[BLOCO.GRADE_FERRO]    = { top: 173, side: 173, bottom: 173 };
  mapa[BLOCO.HOPPER]         = { top: 174, side: 174, bottom: 174 };
  mapa[BLOCO.DISPENSER]      = { top: 175, side: 175, bottom: 175 };
  mapa[BLOCO.OBSERVER]       = { top: 176, side: 176, bottom: 176 };
  mapa[BLOCO.TOCHA_REDSTONE] = { top: 177, side: 177, bottom: 177 };
  mapa[BLOCO.COGUMELO_VERM_P]= { top: 178, side: 178, bottom: 178 };
  mapa[BLOCO.COGUMELO_MARROM_P]= { top: 179, side: 179, bottom: 179 };
  mapa[BLOCO.CAVEIRA]        = { top: 180, side: 180, bottom: 180 };
  mapa[BLOCO.CRANIO_WITHER]  = { top: 181, side: 181, bottom: 181 };
  mapa[BLOCO.CONDUIT]        = { top: 182, side: 182, bottom: 182 };
  mapa[BLOCO.HEAD_CREEPER]   = { top: 183, side: 183, bottom: 183 };
  mapa[BLOCO.HEAD_ZUMBI]     = { top: 184, side: 184, bottom: 184 };
  mapa[BLOCO.HEAD_DRAGON]    = { top: 185, side: 185, bottom: 185 };
  mapa[BLOCO.SOUL_TORCH]     = { top: 186, side: 186, bottom: 186 };
  mapa[BLOCO.SOUL_LANTERN]   = { top: 187, side: 187, bottom: 187 };
  mapa[BLOCO.LAMPADA_RED]    = { top: 188, side: 188, bottom: 188 };
  mapa[BLOCO.BLAZE_BLOCK]    = { top: 189, side: 189, bottom: 189 };
  mapa[BLOCO.LA_LARANJA]     = { top: 190, side: 190, bottom: 190 };
  mapa[BLOCO.LA_ROSA]        = { top: 191, side: 191, bottom: 191 };
  mapa[BLOCO.LA_CIANO]       = { top: 192, side: 192, bottom: 192 };
  mapa[BLOCO.LA_MARROM]      = { top: 193, side: 193, bottom: 193 };
  mapa[BLOCO.LA_PRETA]       = { top: 194, side: 194, bottom: 194 };
  mapa[BLOCO.LA_CINZA]       = { top: 195, side: 195, bottom: 195 };
  mapa[BLOCO.CONCRETO_R]     = { top: 196, side: 196, bottom: 196 };
  mapa[BLOCO.CONCRETO_A]     = { top: 197, side: 197, bottom: 197 };
  mapa[BLOCO.CONCRETO_V]     = { top: 198, side: 198, bottom: 198 };
  mapa[BLOCO.CONCRETO_AM]    = { top: 199, side: 199, bottom: 199 };
  mapa[BLOCO.CONCRETO_BR]    = { top: 200, side: 200, bottom: 200 };
  mapa[BLOCO.CONCRETO_PR]    = { top: 201, side: 201, bottom: 201 };
  mapa[BLOCO.TERRACOTA_R]    = { top: 202, side: 202, bottom: 202 };
  mapa[BLOCO.TERRACOTA_A]    = { top: 203, side: 203, bottom: 203 };
  mapa[BLOCO.TERRACOTA_AM]   = { top: 204, side: 204, bottom: 204 };
  mapa[BLOCO.TERRACOTA_BR]   = { top: 205, side: 205, bottom: 205 };
  mapa[BLOCO.CONCRETO_LR]    = { top: 206, side: 206, bottom: 206 };
  mapa[BLOCO.CONCRETO_RS]    = { top: 207, side: 207, bottom: 207 };
  mapa[BLOCO.CONCRETO_CN]    = { top: 208, side: 208, bottom: 208 };
  mapa[BLOCO.CONCRETO_MR]    = { top: 209, side: 209, bottom: 209 };
  mapa[BLOCO.TERRACOTA_V]    = { top: 210, side: 210, bottom: 210 };
  mapa[BLOCO.TERRACOTA_RX]   = { top: 211, side: 211, bottom: 211 };
  mapa[BLOCO.TERRACOTA_LR]   = { top: 212, side: 212, bottom: 212 };
  mapa[BLOCO.TERRACOTA_PR]   = { top: 213, side: 213, bottom: 213 };
  mapa[BLOCO.PAINEL_VIDRO_R] = { top: 214, side: 214, bottom: 214 };
  mapa[BLOCO.PAINEL_VIDRO_A] = { top: 215, side: 215, bottom: 215 };
  mapa[BLOCO.PAINEL_VIDRO_V] = { top: 216, side: 216, bottom: 216 };
  mapa[BLOCO.PAINEL_VIDRO_AM]= { top: 217, side: 217, bottom: 217 };
  mapa[BLOCO.GLAZED_R]       = { top: 218, side: 218, bottom: 218 };
  mapa[BLOCO.GLAZED_A]       = { top: 219, side: 219, bottom: 219 };
  mapa[BLOCO.GLAZED_V]       = { top: 220, side: 220, bottom: 220 };
  mapa[BLOCO.GLAZED_AM]      = { top: 221, side: 221, bottom: 221 };
  mapa[BLOCO.GLAZED_LR]      = { top: 222, side: 222, bottom: 222 };
  mapa[BLOCO.GLAZED_RS]      = { top: 223, side: 223, bottom: 223 };
  mapa[BLOCO.GLAZED_BR]      = { top: 224, side: 224, bottom: 224 };
  mapa[BLOCO.GLAZED_PR]      = { top: 225, side: 225, bottom: 225 };
  // Lajes reusam texturas dos blocos base (cells existentes)
  mapa[BLOCO.SLAB_ARENITO]   = { top: 85,  side: 85,  bottom: 85  };
  mapa[BLOCO.SLAB_QUARTZO]   = { top: 54,  side: 54,  bottom: 54  };
  mapa[BLOCO.SLAB_DEEPSLATE] = { top: 101, side: 101, bottom: 101 };
  mapa[BLOCO.SLAB_BLACKSTONE]= { top: 100, side: 100, bottom: 100 };
  // Escadas adicionais
  mapa[BLOCO.ESCADA_ARENITO]   = { top: 85,  side: 85,  bottom: 85  };
  mapa[BLOCO.ESCADA_QUARTZO]   = { top: 54,  side: 54,  bottom: 54  };
  mapa[BLOCO.ESCADA_DEEPSLATE] = { top: 101, side: 101, bottom: 101 };
  mapa[BLOCO.ESCADA_BLACKSTONE]= { top: 100, side: 100, bottom: 100 };
  // Paredes adicionais
  mapa[BLOCO.PAREDE_ANDESITO]  = { top: 77,  side: 77,  bottom: 77  };
  mapa[BLOCO.PAREDE_BLACKSTONE]= { top: 100, side: 100, bottom: 100 };
  // Blocos novos
  mapa[BLOCO.BONE_BLOCK]       = { top: 226, side: 226, bottom: 226 };
  mapa[BLOCO.ROOTED_DIRT]      = { top: 227, side: 227, bottom: 227 };
  mapa[BLOCO.CHISELED_STONE]   = { top: 228, side: 228, bottom: 228 };
  mapa[BLOCO.CHISELED_QUARTZO] = { top: 229, side: 229, bottom: 229 };
  mapa[BLOCO.CHISELED_DEEPSLATE]= { top: 230, side: 230, bottom: 230 };
  mapa[BLOCO.CHISELED_BLACKSTONE]={top: 231, side: 231, bottom: 231 };
  mapa[BLOCO.CRIMSON_HYPHAE]   = { top: 232, side: 232, bottom: 232 };
  mapa[BLOCO.WARPED_HYPHAE]    = { top: 233, side: 233, bottom: 233 };
  mapa[BLOCO.FROGLIGHT_VERDE]  = { top: 234, side: 234, bottom: 234 };
  mapa[BLOCO.FROGLIGHT_ROXO]   = { top: 235, side: 235, bottom: 235 };
  mapa[BLOCO.MELANCIA]         = { top: 236, side: 236, bottom: 236 };
  mapa[BLOCO.MELANCIA_GLISTER] = { top: 237, side: 237, bottom: 237 };
  mapa[BLOCO.GIRASSOL]         = { top: 238, side: 238, bottom: 238 };
  mapa[BLOCO.ABACAXI]          = { top: 239, side: 239, bottom: 239 };
  mapa[BLOCO.PAINEL_VIDRO_LR]  = { top: 240, side: 240, bottom: 240 };
  mapa[BLOCO.PAINEL_VIDRO_RS]  = { top: 241, side: 241, bottom: 241 };
  mapa[BLOCO.PAINEL_VIDRO_CN]  = { top: 242, side: 242, bottom: 242 };
  mapa[BLOCO.PAINEL_VIDRO_BR]  = { top: 243, side: 243, bottom: 243 };
  mapa[BLOCO.PAINEL_VIDRO_PR]  = { top: 244, side: 244, bottom: 244 };
  mapa[BLOCO.PAINEL_VIDRO_CZ]  = { top: 245, side: 245, bottom: 245 };
  mapa[BLOCO.BAMBU_BLOCO]      = { top: 246, side: 246, bottom: 246 };
  mapa[BLOCO.CACTO_BLOCO]      = { top: 247, side: 247, bottom: 247 };
  // Reusam texturas dos blocos base
  mapa[BLOCO.ESCADA_COBRE]     = { top: 58,  side: 58,  bottom: 58  };
  mapa[BLOCO.ESCADA_NETHER]    = { top: 88,  side: 88,  bottom: 88  };
  mapa[BLOCO.ESCADA_PAVIMENTO] = { top: 90,  side: 90,  bottom: 90  };
  mapa[BLOCO.ESCADA_LAMA]      = { top: 109, side: 109, bottom: 109 };
  mapa[BLOCO.PAREDE_ARENITO]   = { top: 85,  side: 85,  bottom: 85  };
  mapa[BLOCO.PAREDE_LAMA]      = { top: 109, side: 109, bottom: 109 };
  mapa[BLOCO.SLAB_PAVIMENTO]   = { top: 90,  side: 90,  bottom: 90  };
  mapa[BLOCO.SLAB_CALCITE]     = { top: 103, side: 103, bottom: 103 };
  mapa[BLOCO.ESCADA_GRANITO]   = { top: 75,  side: 75,  bottom: 75  };
  mapa[BLOCO.ESCADA_DIORITO]   = { top: 76,  side: 76,  bottom: 76  };
  mapa[BLOCO.ESCADA_ANDESITO]  = { top: 77,  side: 77,  bottom: 77  };
  mapa[BLOCO.ESCADA_PRISMARINE]= { top: 128, side: 128, bottom: 128 };
  mapa[BLOCO.PAREDE_GRANITO]   = { top: 75,  side: 75,  bottom: 75  };
  mapa[BLOCO.PAREDE_DIORITO]   = { top: 76,  side: 76,  bottom: 76  };
  mapa[BLOCO.SLAB_GRANITO]     = { top: 75,  side: 75,  bottom: 75  };
  mapa[BLOCO.SLAB_DIORITO]     = { top: 76,  side: 76,  bottom: 76  };
  mapa[BLOCO.ESCADA_GRANITO_POL] = { top: 80, side: 80, bottom: 80 };
  mapa[BLOCO.ESCADA_DIORITO_POL] = { top: 81, side: 81, bottom: 81 };
  mapa[BLOCO.ESCADA_ANDESITO_POL]= { top: 82, side: 82, bottom: 82 };
  mapa[BLOCO.ESCADA_PEDRA_LISA]  = { top: 83, side: 83, bottom: 83 };
  mapa[BLOCO.PAREDE_ANDESITO_POL]= { top: 82, side: 82, bottom: 82 };
  mapa[BLOCO.PAREDE_BLACKSTONE_POL]= { top: 106, side: 106, bottom: 106 };
  mapa[BLOCO.SLAB_ANDESITO_POL]  = { top: 82, side: 82, bottom: 82 };
  mapa[BLOCO.SLAB_BLACKSTONE_POL]= { top: 106, side: 106, bottom: 106 };
  // Variantes End/Purpur/Nether/Mossy reusam texturas (cells 136/137/89/84)
  mapa[BLOCO.ESCADA_END_BRICK]   = { top: 136, side: 136, bottom: 136 };
  mapa[BLOCO.ESCADA_PURPUR]      = { top: 137, side: 137, bottom: 137 };
  mapa[BLOCO.ESCADA_NETHER_BRICK]= { top: 89,  side: 89,  bottom: 89  };
  mapa[BLOCO.ESCADA_MUSGO]       = { top: 84,  side: 84,  bottom: 84  };
  mapa[BLOCO.PAREDE_END_BRICK]   = { top: 136, side: 136, bottom: 136 };
  mapa[BLOCO.PAREDE_NETHER_BRICK]= { top: 89,  side: 89,  bottom: 89  };
  mapa[BLOCO.SLAB_END_BRICK]     = { top: 136, side: 136, bottom: 136 };
  mapa[BLOCO.SLAB_PURPUR]        = { top: 137, side: 137, bottom: 137 };
  // Variantes Deepslate/Obsidiana/Basalto reusam cells 19/94/104/105
  mapa[BLOCO.ESCADA_DEEPSLATE_PAV]= { top: 104, side: 104, bottom: 104 };
  mapa[BLOCO.ESCADA_DEEPSLATE_POL]= { top: 105, side: 105, bottom: 105 };
  mapa[BLOCO.ESCADA_OBSIDIANA]    = { top: 19,  side: 19,  bottom: 19  };
  mapa[BLOCO.ESCADA_BASALTO]      = { top: 94,  side: 94,  bottom: 94  };
  mapa[BLOCO.PAREDE_DEEPSLATE_POL]= { top: 105, side: 105, bottom: 105 };
  mapa[BLOCO.PAREDE_BASALTO]      = { top: 94,  side: 94,  bottom: 94  };
  mapa[BLOCO.SLAB_DEEPSLATE_PAV]  = { top: 104, side: 104, bottom: 104 };
  mapa[BLOCO.SLAB_BASALTO]        = { top: 94,  side: 94,  bottom: 94  };
  // Variantes Crimson/Warped/Bambu/Cobre reusam cells 58/59/60/79/139/140/246
  mapa[BLOCO.ESCADA_CRIMSON]      = { top: 139, side: 139, bottom: 139 };
  mapa[BLOCO.ESCADA_WARPED]       = { top: 140, side: 140, bottom: 140 };
  mapa[BLOCO.ESCADA_BAMBU]        = { top: 246, side: 246, bottom: 246 };
  mapa[BLOCO.ESCADA_COBRE_GASTO]  = { top: 59,  side: 59,  bottom: 59  };
  mapa[BLOCO.PAREDE_COBRE]        = { top: 58,  side: 58,  bottom: 58  };
  mapa[BLOCO.PAREDE_COBRE_OXIDADO]= { top: 60,  side: 60,  bottom: 60  };
  mapa[BLOCO.SLAB_CRIMSON]        = { top: 139, side: 139, bottom: 139 };
  mapa[BLOCO.SLAB_WARPED]         = { top: 140, side: 140, bottom: 140 };
  // Variantes concreto (cells 196=verm, 197=azul, 198=verde, 200=branco, 201=preto)
  mapa[BLOCO.ESCADA_CONCRETO_R]   = { top: 196, side: 196, bottom: 196 };
  mapa[BLOCO.ESCADA_CONCRETO_A]   = { top: 197, side: 197, bottom: 197 };
  mapa[BLOCO.ESCADA_CONCRETO_V]   = { top: 198, side: 198, bottom: 198 };
  mapa[BLOCO.ESCADA_CONCRETO_BR]  = { top: 200, side: 200, bottom: 200 };
  mapa[BLOCO.PAREDE_CONCRETO_R]   = { top: 196, side: 196, bottom: 196 };
  mapa[BLOCO.PAREDE_CONCRETO_PR]  = { top: 201, side: 201, bottom: 201 };
  mapa[BLOCO.SLAB_CONCRETO_R]     = { top: 196, side: 196, bottom: 196 };
  mapa[BLOCO.SLAB_CONCRETO_A]     = { top: 197, side: 197, bottom: 197 };
  // Cobre cortado/liso reusam cells 58/59/60
  mapa[BLOCO.COBRE_CORTADO]        = { top: 58, side: 58, bottom: 58 };
  mapa[BLOCO.COBRE_GASTO_CORTADO]  = { top: 59, side: 59, bottom: 59 };
  mapa[BLOCO.COBRE_OXIDADO_CORTADO]= { top: 60, side: 60, bottom: 60 };
  mapa[BLOCO.COBRE_LISO]           = { top: 58, side: 58, bottom: 58 };
  // Variantes purpur reusam cell 137 (pillar) e 138 (block)
  mapa[BLOCO.ESCADA_PURPUR_PILLAR] = { top: 138, side: 138, bottom: 138 };
  mapa[BLOCO.PAREDE_PURPUR]        = { top: 137, side: 137, bottom: 137 };
  mapa[BLOCO.SLAB_PURPUR_PILLAR]   = { top: 138, side: 138, bottom: 138 };
  mapa[BLOCO.PURPUR_LIMPO]         = { top: 137, side: 137, bottom: 137 };
  mapa[BLOCO.SMITHING_TABLE]       = { top: 248, side: 248, bottom: 248 };
  mapa[BLOCO.BREWING_STAND]        = { top: 249, side: 249, bottom: 249 };
  mapa[BLOCO.BLAST_FURNACE]        = { top: 250, side: 250, bottom: 250 };
  mapa[BLOCO.SMOKER]               = { top: 251, side: 251, bottom: 251 };
  mapa[BLOCO.CARTOGRAPHY]          = { top: 252, side: 252, bottom: 252 };
  mapa[BLOCO.FLETCHING]            = { top: 253, side: 253, bottom: 253 };
  mapa[BLOCO.LOOM]                 = { top: 254, side: 254, bottom: 254 };
  mapa[BLOCO.STONECUTTER]          = { top: 255, side: 255, bottom: 255 };
  mapa[BLOCO.TARGET_BLOCK]         = { top: 256, side: 256, bottom: 256 };
  mapa[BLOCO.ANCIENT_DEBRIS]       = { top: 257, side: 257, bottom: 257 };
  mapa[BLOCO.HONEYCOMB_BLOCK]      = { top: 258, side: 258, bottom: 258 };
  mapa[BLOCO.COMPOSTER]            = { top: 259, side: 259, bottom: 259 };
  mapa[BLOCO.LECTERN]              = { top: 260, side: 260, bottom: 260 };
  mapa[BLOCO.BARREL]               = { top: 261, side: 261, bottom: 261 };
  mapa[BLOCO.CAMPFIRE]             = { top: 262, side: 262, bottom: 262 };
  mapa[BLOCO.DRIED_KELP_BLOCK]     = { top: 263, side: 263, bottom: 263 };
  mapa[BLOCO.BOOKSHELF_CHISELED]   = { top: 44, side: 264, bottom: 44 };
  mapa[BLOCO.JUKEBOX]              = { top: 265, side: 265, bottom: 265 };
  mapa[BLOCO.END_ROD]              = { top: 266, side: 266, bottom: 266 };
  mapa[BLOCO.LIGHT_BLOCK]          = { top: 267, side: 267, bottom: 267 };
  mapa[BLOCO.DAYLIGHT_DETECTOR]    = { top: 268, side: 268, bottom: 268 };
  mapa[BLOCO.NOTE_BLOCK]           = { top: 269, side: 269, bottom: 269 };
  mapa[BLOCO.BELL]                 = { top: 270, side: 270, bottom: 270 };
  mapa[BLOCO.SEA_PICKLE]           = { top: 271, side: 271, bottom: 271 };
  mapa[BLOCO.ENDER_CHEST]          = { top: 272, side: 272, bottom: 272 };
  mapa[BLOCO.SHULKER_BOX]          = { top: 273, side: 273, bottom: 273 };
  mapa[BLOCO.ANVIL_DAMAGED]        = { top: 274, side: 274, bottom: 274 };
  mapa[BLOCO.DECORATED_POT]        = { top: 275, side: 275, bottom: 275 };
  // Variantes Prismarine reusam cells 128/129
  mapa[BLOCO.ESCADA_PRISMARINE_BRK]= { top: 129, side: 129, bottom: 129 };
  mapa[BLOCO.SLAB_PRISMARINE]      = { top: 128, side: 128, bottom: 128 };
  mapa[BLOCO.SLAB_PRISMARINE_BRK]  = { top: 129, side: 129, bottom: 129 };
  mapa[BLOCO.PAREDE_PRISMARINE]    = { top: 128, side: 128, bottom: 128 };
  mapa[BLOCO.SHULKER_R]            = { top: 276, side: 276, bottom: 276 };
  mapa[BLOCO.SHULKER_A]            = { top: 277, side: 277, bottom: 277 };
  mapa[BLOCO.SHULKER_V]            = { top: 278, side: 278, bottom: 278 };
  mapa[BLOCO.SHULKER_AM]           = { top: 279, side: 279, bottom: 279 };
  // Variantes Arenito reusam cells 86 (liso) e 87 (cortado)
  mapa[BLOCO.ESCADA_ARENITO_LISO]  = { top: 86, side: 86, bottom: 86 };
  mapa[BLOCO.SLAB_ARENITO_LISO]    = { top: 86, side: 86, bottom: 86 };
  mapa[BLOCO.PAREDE_ARENITO_LISO]  = { top: 86, side: 86, bottom: 86 };
  mapa[BLOCO.ESCADA_ARENITO_CORT]  = { top: 87, side: 87, bottom: 87 };
  mapa[BLOCO.SHULKER_BR]           = { top: 280, side: 280, bottom: 280 };
  mapa[BLOCO.SHULKER_PR]           = { top: 281, side: 281, bottom: 281 };
  mapa[BLOCO.SHULKER_LR]           = { top: 282, side: 282, bottom: 282 };
  mapa[BLOCO.SHULKER_RS]           = { top: 283, side: 283, bottom: 283 };
  // Variantes Terracota reusam cells 202/203
  mapa[BLOCO.ESCADA_TERRACOTA_R]   = { top: 202, side: 202, bottom: 202 };
  mapa[BLOCO.SLAB_TERRACOTA_R]     = { top: 202, side: 202, bottom: 202 };
  mapa[BLOCO.PAREDE_TERRACOTA_R]   = { top: 202, side: 202, bottom: 202 };
  mapa[BLOCO.ESCADA_TERRACOTA_A]   = { top: 203, side: 203, bottom: 203 };
  // Tijolo Nether (cell 88)
  mapa[BLOCO.SLAB_NETHER]          = { top: 88, side: 88, bottom: 88 };
  mapa[BLOCO.PAREDE_NETHER]        = { top: 88, side: 88, bottom: 88 };
  // Glazed Terracotas (cells 218/219/220/221)
  mapa[BLOCO.ESCADA_GLAZED_R]      = { top: 218, side: 218, bottom: 218 };
  mapa[BLOCO.SLAB_GLAZED_R]        = { top: 218, side: 218, bottom: 218 };
  mapa[BLOCO.ESCADA_GLAZED_A]      = { top: 219, side: 219, bottom: 219 };
  mapa[BLOCO.SLAB_GLAZED_A]        = { top: 219, side: 219, bottom: 219 };
  mapa[BLOCO.ESCADA_GLAZED_V]      = { top: 220, side: 220, bottom: 220 };
  mapa[BLOCO.ESCADA_GLAZED_AM]     = { top: 221, side: 221, bottom: 221 };
  mapa[BLOCO.SLAB_BAMBU]           = { top: 246, side: 246, bottom: 246 };
  mapa[BLOCO.PAREDE_BAMBU]         = { top: 246, side: 246, bottom: 246 };
  mapa[BLOCO.ESCADA_DRIED_KELP]    = { top: 263, side: 263, bottom: 263 };
  mapa[BLOCO.SLAB_DRIED_KELP]      = { top: 263, side: 263, bottom: 263 };
  mapa[BLOCO.ESCADA_QUARTZO_POL]   = { top: 55, side: 55, bottom: 55 };
  mapa[BLOCO.SLAB_QUARTZO_POL]     = { top: 55, side: 55, bottom: 55 };
  mapa[BLOCO.PAREDE_QUARTZO]       = { top: 54, side: 54, bottom: 54 };
  mapa[BLOCO.ESCADA_BLOCO_OURO]    = { top: 118, side: 118, bottom: 118 };
  // 🎯 Marco 400 blocos! Command Block (cell 284 nova) + 7 escadas/lajes premium reusam cells dos blocos compactos
  mapa[BLOCO.COMMAND_BLOCK]         = { top: 284, side: 284, bottom: 284 };
  mapa[BLOCO.ESCADA_BLOCO_FERRO]    = { top: 117, side: 117, bottom: 117 };
  mapa[BLOCO.SLAB_BLOCO_FERRO]      = { top: 117, side: 117, bottom: 117 };
  mapa[BLOCO.ESCADA_BLOCO_DIAMANTE] = { top: 119, side: 119, bottom: 119 };
  mapa[BLOCO.SLAB_BLOCO_DIAMANTE]   = { top: 119, side: 119, bottom: 119 };
  mapa[BLOCO.ESCADA_BLOCO_LAPIS]    = { top: 121, side: 121, bottom: 121 };
  mapa[BLOCO.SLAB_BLOCO_LAPIS]      = { top: 121, side: 121, bottom: 121 };
  mapa[BLOCO.ESCADA_BLOCO_REDSTONE] = { top: 127, side: 127, bottom: 127 };
  // Sprint paridade MC (cells 285-291; moss carpet reusa cell 288)
  mapa[BLOCO.RESPAWN_ANCHOR]        = { top: 285, side: 285, bottom: 285 };
  mapa[BLOCO.LODESTONE]             = { top: 286, side: 286, bottom: 286 };
  mapa[BLOCO.REINFORCED_DS]         = { top: 287, side: 287, bottom: 287 };
  mapa[BLOCO.MOSS_BLOCK]            = { top: 288, side: 288, bottom: 288 };
  mapa[BLOCO.MOSS_CARPET]           = { top: 288, side: 288, bottom: 288 };
  mapa[BLOCO.BIG_DRIPLEAF]          = { top: 289, side: 289, bottom: 289 };
  mapa[BLOCO.CHORUS_FLOWER]         = { top: 290, side: 290, bottom: 290 };
  mapa[BLOCO.PISTON]                = { top: 291, side: 291, bottom: 291 };
  // Sprint redstone+wood (cells 292-299)
  mapa[BLOCO.STICKY_PISTON]         = { top: 292, side: 292, bottom: 292 };
  mapa[BLOCO.REPEATER]              = { top: 293, side: 293, bottom: 293 };
  mapa[BLOCO.COMPARATOR]            = { top: 294, side: 294, bottom: 294 };
  mapa[BLOCO.CRAFTER]               = { top: 295, side: 295, bottom: 295 };
  mapa[BLOCO.TRAPPED_CHEST]         = { top: 296, side: 296, bottom: 296 };
  mapa[BLOCO.MANGROVE_LOG]          = { top: 297, side: 297, bottom: 297 };
  mapa[BLOCO.MANGROVE_PRANCHA]      = { top: 298, side: 298, bottom: 298 };
  mapa[BLOCO.CHERRY_LOG]            = { top: 299, side: 299, bottom: 299 };
  // Sprint 4: madeiras+plantas (cells 300-307)
  mapa[BLOCO.CHERRY_PRANCHA]        = { top: 300, side: 300, bottom: 300 };
  mapa[BLOCO.CHERRY_FOLHA]          = { top: 301, side: 301, bottom: 301 };
  mapa[BLOCO.MANGROVE_FOLHA]        = { top: 302, side: 302, bottom: 302 };
  mapa[BLOCO.MANGROVE_RAIZ]         = { top: 303, side: 303, bottom: 303 };
  mapa[BLOCO.AZALEA]                = { top: 304, side: 304, bottom: 304 };
  mapa[BLOCO.AZALEA_FLOWER]         = { top: 305, side: 305, bottom: 305 };
  mapa[BLOCO.PINK_PETALS]           = { top: 306, side: 306, bottom: 306 };
  mapa[BLOCO.CACTUS_FLOWER]         = { top: 307, side: 307, bottom: 307 };
  // Sprint 5: Nether plants + cipós (cells 308-315)
  mapa[BLOCO.BAMBOO_MOSAIC]         = { top: 308, side: 308, bottom: 308 };
  mapa[BLOCO.CRIMSON_ROOTS]         = { top: 309, side: 309, bottom: 309 };
  mapa[BLOCO.WARPED_ROOTS]          = { top: 310, side: 310, bottom: 310 };
  mapa[BLOCO.FROSTED_ICE]           = { top: 311, side: 311, bottom: 311 };
  mapa[BLOCO.VINE]                  = { top: 312, side: 312, bottom: 312 };
  mapa[BLOCO.TWISTING_VINES]        = { top: 313, side: 313, bottom: 313 };
  mapa[BLOCO.WEEPING_VINES]         = { top: 314, side: 314, bottom: 314 };
  mapa[BLOCO.SCAFFOLDING]           = { top: 315, side: 315, bottom: 315 };
  // Sprint 6: cavernas+gemas (cells 316-323)
  mapa[BLOCO.HANGING_ROOTS]         = { top: 316, side: 316, bottom: 316 };
  mapa[BLOCO.GLOW_BERRIES]          = { top: 317, side: 317, bottom: 317 };
  mapa[BLOCO.AMETHYST_BUDDING]      = { top: 318, side: 318, bottom: 318 };
  mapa[BLOCO.AMETHYST_CLUSTER]      = { top: 319, side: 319, bottom: 319 };
  mapa[BLOCO.POINTED_DRIPSTONE]     = { top: 320, side: 320, bottom: 320 };
  mapa[BLOCO.MOSSY_COBBLESTONE]     = { top: 321, side: 321, bottom: 321 };
  mapa[BLOCO.CRACKED_STONE_BRICKS]  = { top: 322, side: 322, bottom: 322 };
  mapa[BLOCO.MOSSY_STONE_BRICKS]    = { top: 323, side: 323, bottom: 323 };
  // Sprint 7: MC 1.21 Tricky Trials (cells 324-331)
  mapa[BLOCO.TUFF_BRICKS]           = { top: 324, side: 324, bottom: 324 };
  mapa[BLOCO.CHISELED_TUFF]         = { top: 325, side: 325, bottom: 325 };
  mapa[BLOCO.CHISELED_TUFF_BRICKS]  = { top: 326, side: 326, bottom: 326 };
  mapa[BLOCO.CHISELED_COPPER]       = { top: 327, side: 327, bottom: 327 };
  mapa[BLOCO.COPPER_BULB]           = { top: 328, side: 328, bottom: 328 };
  mapa[BLOCO.COPPER_GRATE]          = { top: 329, side: 329, bottom: 329 };
  mapa[BLOCO.TRIAL_SPAWNER]         = { top: 330, side: 330, bottom: 330 };
  mapa[BLOCO.VAULT]                 = { top: 331, side: 331, bottom: 331 };
  // Sprint 8: Pottery + arqueologia + 1.20 (cells 332-339)
  mapa[BLOCO.PITCHER_PLANT]         = { top: 332, side: 332, bottom: 332 };
  mapa[BLOCO.PITCHER_CROP]          = { top: 333, side: 333, bottom: 333 };
  mapa[BLOCO.TORCHFLOWER]           = { top: 334, side: 334, bottom: 334 };
  mapa[BLOCO.TORCHFLOWER_CROP]      = { top: 335, side: 335, bottom: 335 };
  mapa[BLOCO.SNIFFER_EGG]           = { top: 336, side: 336, bottom: 336 };
  mapa[BLOCO.SUSPICIOUS_SAND]       = { top: 337, side: 337, bottom: 337 };
  mapa[BLOCO.SUSPICIOUS_GRAVEL]     = { top: 338, side: 338, bottom: 338 };
  mapa[BLOCO.CALIBRATED_SCULK]      = { top: 339, side: 339, bottom: 339 };
  // Sprint 9: madeiras variantes (cells 340-347)
  mapa[BLOCO.BIRCH_LOG]             = { top: 340, side: 340, bottom: 340 };
  mapa[BLOCO.BIRCH_PRANCHA]         = { top: 341, side: 341, bottom: 341 };
  mapa[BLOCO.SPRUCE_LOG]            = { top: 342, side: 342, bottom: 342 };
  mapa[BLOCO.SPRUCE_PRANCHA]        = { top: 343, side: 343, bottom: 343 };
  mapa[BLOCO.ACACIA_LOG]            = { top: 344, side: 344, bottom: 344 };
  mapa[BLOCO.ACACIA_PRANCHA]        = { top: 345, side: 345, bottom: 345 };
  mapa[BLOCO.JUNGLE_LOG]            = { top: 346, side: 346, bottom: 346 };
  mapa[BLOCO.DARK_OAK_LOG]          = { top: 347, side: 347, bottom: 347 };
  // Sprint 10: pranchas+folhas+stripped (cells 348-355)
  mapa[BLOCO.JUNGLE_PRANCHA]        = { top: 348, side: 348, bottom: 348 };
  mapa[BLOCO.DARK_OAK_PRANCHA]      = { top: 349, side: 349, bottom: 349 };
  mapa[BLOCO.BIRCH_FOLHA]           = { top: 350, side: 350, bottom: 350 };
  mapa[BLOCO.SPRUCE_FOLHA]          = { top: 351, side: 351, bottom: 351 };
  mapa[BLOCO.ACACIA_FOLHA]          = { top: 352, side: 352, bottom: 352 };
  mapa[BLOCO.JUNGLE_FOLHA]          = { top: 353, side: 353, bottom: 353 };
  mapa[BLOCO.DARK_OAK_FOLHA]        = { top: 354, side: 354, bottom: 354 };
  mapa[BLOCO.STRIPPED_OAK_LOG]      = { top: 355, side: 355, bottom: 355 };
  // Sprint 11: stripped + vegetação (cells 356-363)
  mapa[BLOCO.STRIPPED_BIRCH]        = { top: 356, side: 356, bottom: 356 };
  mapa[BLOCO.STRIPPED_SPRUCE]       = { top: 357, side: 357, bottom: 357 };
  mapa[BLOCO.STRIPPED_ACACIA]       = { top: 358, side: 358, bottom: 358 };
  mapa[BLOCO.STRIPPED_JUNGLE]       = { top: 359, side: 359, bottom: 359 };
  mapa[BLOCO.STRIPPED_DARK_OAK]     = { top: 360, side: 360, bottom: 360 };
  mapa[BLOCO.DEAD_BUSH]             = { top: 361, side: 361, bottom: 361 };
  mapa[BLOCO.TALL_GRASS]            = { top: 362, side: 362, bottom: 362 };
  mapa[BLOCO.FERN]                  = { top: 363, side: 363, bottom: 363 };

  const texture = new THREE.CanvasTexture(cnv);
  texture.magFilter = THREE.NearestFilter;
  // NearestMipmapLinear preserva pixel-art mas usa mipmap pra evitar
  // shimmer/aliasing em distâncias longas. Combina nitidez com perf.
  texture.minFilter = THREE.NearestMipmapLinearFilter;
  texture.generateMipmaps = true;
  texture.wrapS = THREE.ClampToEdgeWrapping;
  texture.wrapT = THREE.ClampToEdgeWrapping;
  texture.colorSpace = THREE.SRGBColorSpace;
  // Anisotropic filtering aplicado depois (ver Renderer constructor —
  // precisa do this.renderer.capabilities)
  // side: DoubleSide garante que a face seja visível dos 2 lados — elimina
  // qualquer chance de "ver através" do bloco devido a backface culling
  // quando winding está oposta à normal declarada (caso da nossa addFace).
  const material = new THREE.MeshLambertMaterial({
    map: texture,
    vertexColors: true,
    side: THREE.DoubleSide,
  });

  // === Animação de água/lava (UV scroll fake via repaint) ===
  // Cada frame, repinta as células 17 (água) e 18 (lava) com offset
  // baseado no tempo. texture.needsUpdate=true atualiza GPU.
  function atualizarAnimacao(frame) {
    // Água: ondas horizontais que rolam
    const idxA = 17, colA = idxA % COLS, rowA = Math.floor(idxA / COLS);
    const xA = colA * CELL, yA = rowA * CELL;
    ctx.fillStyle = '#2C8FCF'; ctx.fillRect(xA, yA, CELL, CELL);
    ctx.fillStyle = '#1B6EA8';
    for (let py = 2; py < CELL; py += 4) {
      const off = (frame * 2) % CELL;
      ctx.fillRect(xA + off, yA + py, CELL, 1);
      if (off > 0) ctx.fillRect(xA, yA + py, off, 1); // wrap
    }
    ctx.fillStyle = '#7AC0E5';
    let s = (frame * 137 + 1) % 233280;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        s = (s * 9301 + 49297) % 233280;
        if ((s / 233280) < 0.10) ctx.fillRect(xA + px, yA + py, 1, 1);
      }
    }
    // Tocha: chama amarela/laranja pulsante (flicker)
    const idxT = 23, colT = idxT % COLS, rowT = Math.floor(idxT / COLS);
    const xT = colT * CELL, yT = rowT * CELL;
    ctx.fillStyle = '#2A1F12'; ctx.fillRect(xT, yT, CELL, CELL); // fundo
    // Pau central marrom
    ctx.fillStyle = '#9C7848'; ctx.fillRect(xT + 14, yT + 12, 4, 16);
    ctx.fillStyle = '#6E5232';
    ctx.fillRect(xT + 14, yT + 14, 1, 14);
    ctx.fillRect(xT + 17, yT + 14, 1, 14);
    // Chama animada (varia tamanho + posição por frame)
    const flicker = Math.sin(frame * 0.7) * 1.5;
    ctx.fillStyle = '#FFCB47';
    ctx.fillRect(xT + 13 + Math.floor(flicker * 0.3), yT + 6, 6, 6);
    ctx.fillStyle = '#FF8A2A';
    ctx.fillRect(xT + 14, yT + 4 - Math.floor(flicker * 0.5), 4, 6);
    ctx.fillStyle = '#FFEB80';
    ctx.fillRect(xT + 15, yT + 8, 2, 4);
    // Sparkle ocasional acima
    if (frame % 3 === 0) {
      ctx.fillStyle = '#FFEB80';
      ctx.fillRect(xT + 15, yT + 2, 2, 1);
    }

    // Lava: bolhas que pulsam
    const idxL = 18, colL = idxL % COLS, rowL = Math.floor(idxL / COLS);
    const xL = colL * CELL, yL = rowL * CELL;
    ctx.fillStyle = '#D44515'; ctx.fillRect(xL, yL, CELL, CELL);
    ctx.fillStyle = '#FFA830';
    s = (frame * 211 + 7) % 233280;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        s = (s * 9301 + 49297) % 233280;
        if ((s / 233280) < 0.30) ctx.fillRect(xL + px, yL + py, 2, 2);
      }
    }
    ctx.fillStyle = '#FFEB47';
    s = (frame * 313 + 13) % 233280;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        s = (s * 9301 + 49297) % 233280;
        if ((s / 233280) < 0.10) ctx.fillRect(xL + px, yL + py, 2, 2);
      }
    }
    texture.needsUpdate = true;
  }

  return { texture, material, mapa, cols: COLS, rows: ROWS, atualizarAnimacao };
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
  cnv.width = 128; cnv.height = 128;
  const ctx = cnv.getContext('2d');
  // Halo radial gradient (suave, vai pra transparente nas bordas)
  const grad = ctx.createRadialGradient(64, 64, raio * 3, 64, 64, 56);
  const corHex = '#' + cor.toString(16).padStart(6, '0');
  grad.addColorStop(0,    corHex + 'ff'); // núcleo opaco
  grad.addColorStop(0.35, corHex + '66'); // halo médio
  grad.addColorStop(0.75, corHex + '15'); // halo fraco
  grad.addColorStop(1,    corHex + '00'); // borda transparente
  ctx.fillStyle = grad;
  ctx.fillRect(0, 0, 128, 128);
  // Disco sólido central (mais brilhante)
  ctx.fillStyle = '#ffffff';
  ctx.beginPath(); ctx.arc(64, 64, raio * 3.2, 0, Math.PI * 2); ctx.fill();
  ctx.fillStyle = corHex;
  ctx.beginPath(); ctx.arc(64, 64, raio * 2.6, 0, Math.PI * 2); ctx.fill();
  const tex = new THREE.CanvasTexture(cnv);
  const mat = new THREE.SpriteMaterial({ map: tex, transparent: true, depthWrite: false });
  const sprite = new THREE.Sprite(mat);
  sprite.scale.set(40, 40, 1); // halo maior pra glow visível
  return sprite;
}

export class Renderer {
  constructor(canvas) {
    this.canvas = canvas;
    this.camera = new THREE.PerspectiveCamera(70, window.innerWidth / window.innerHeight, 0.1, 400);
    this.scene = new THREE.Scene();
    // Settings são lidos de state.quality (sistema adaptativo). Default
    // conservador (medium) se quality.js ainda não rodou.
    const q = state.quality || { antialias: true, pixelRatio: 2 };
    this.renderer = new THREE.WebGLRenderer({
      canvas,
      antialias: q.antialias,
      powerPreference: 'high-performance',
      stencil: false,
      preserveDrawingBuffer: true, // necessário pra F2 screenshot via toDataURL
    });
    this.renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, q.pixelRatio));
    this.renderer.setSize(window.innerWidth, window.innerHeight, false);
    this.renderer.outputColorSpace = THREE.SRGBColorSpace;
    this.renderer.toneMapping = THREE.ACESFilmicToneMapping;
    this.renderer.toneMappingExposure = 1.0;
    // Cor inicial — atualizada por atualizarCeu.
    this.scene.background = new THREE.Color(0x87CEEB);
    // FogExp2: densidade exponencial (mais natural que linear). Densidade
    // calculada pra dar transição suave dentro do view radius.
    const fogDensidade = 0.018 * (8 / Math.max(4, q.viewRadius || 6));
    this.scene.fog = new THREE.FogExp2(0x87CEEB, fogDensidade);

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

    // Pool de PointLights (tochas/lava perto do player) + glow sprites
    // grudados (efeito bloom-like sem precisar de post-processing)
    this.poolLuzes = [];
    this.poolGlow = [];
    // Canvas pré-renderizado de halo radial (reusado por todos)
    const glowCnv = document.createElement('canvas');
    glowCnv.width = 64; glowCnv.height = 64;
    const gctx = glowCnv.getContext('2d');
    const grd = gctx.createRadialGradient(32, 32, 0, 32, 32, 32);
    grd.addColorStop(0,    'rgba(255,255,255,0.95)');
    grd.addColorStop(0.20, 'rgba(255,200,100,0.55)');
    grd.addColorStop(0.55, 'rgba(255,160,60,0.20)');
    grd.addColorStop(1,    'rgba(255,140,40,0)');
    gctx.fillStyle = grd;
    gctx.fillRect(0, 0, 64, 64);
    const glowTex = new THREE.CanvasTexture(glowCnv);
    for (let i = 0; i < 8; i++) {
      const l = new THREE.PointLight(0xffaa44, 0.0, 12, 2);
      l.visible = false;
      this.scene.add(l);
      this.poolLuzes.push(l);
      // Glow sprite pareado
      const mat = new THREE.SpriteMaterial({
        map: glowTex,
        transparent: true,
        depthWrite: false,
        blending: THREE.AdditiveBlending,
      });
      const s = new THREE.Sprite(mat);
      s.scale.set(2.5, 2.5, 1);
      s.visible = false;
      this.scene.add(s);
      this.poolGlow.push(s);
    }
    // Sombra circular do player (decal escuro embaixo)
    const shadowCnv = document.createElement('canvas');
    shadowCnv.width = 64; shadowCnv.height = 64;
    const sctx = shadowCnv.getContext('2d');
    const sgrd = sctx.createRadialGradient(32, 32, 0, 32, 32, 28);
    sgrd.addColorStop(0,    'rgba(0,0,0,0.55)');
    sgrd.addColorStop(0.55, 'rgba(0,0,0,0.30)');
    sgrd.addColorStop(1,    'rgba(0,0,0,0)');
    sctx.fillStyle = sgrd;
    sctx.fillRect(0, 0, 64, 64);
    const shadowTex = new THREE.CanvasTexture(shadowCnv);
    const shadowMat = new THREE.MeshBasicMaterial({
      map: shadowTex, transparent: true, depthWrite: false,
    });
    this.playerShadow = new THREE.Mesh(new THREE.PlaneGeometry(0.9, 0.9), shadowMat);
    this.playerShadow.rotation.x = -Math.PI / 2;
    this.playerShadow.visible = false;
    this.scene.add(this.playerShadow);

    // Atlas + materials
    this.atlas = criarAtlas();
    // Anisotropic filtering: melhora nitidez em ângulos rasantes (paredes
    // vistas de lado, longa distância). Tier low pula pra economizar.
    if (this.atlas?.texture && this.renderer.capabilities) {
      const maxAniso = this.renderer.capabilities.getMaxAnisotropy();
      this.atlas.texture.anisotropy = Math.min(maxAniso, q.tier === 'low' ? 1 : 4);
      this.atlas.texture.needsUpdate = true;
    }
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

    // === OTIMIZAÇÃO 1: pre-cache solid lookup (Uint8 por block ID) ===
    // BLOCO_INFO[t].solido é hash lookup; cache local Uint8Array é
    // bem mais rápido (acessado milhares de vezes por chunk).
    const solidArr = (this._solidCache ||= (() => {
      const arr = new Uint8Array(N_BLOCOS);
      for (let i = 0; i < N_BLOCOS; i++) arr[i] = BLOCO_INFO[i]?.solido ? 1 : 0;
      return arr;
    })());
    // Shapes não-cubo (slab, fence etc) também não devem culling normal —
    // tabela auxiliar.
    const customShapeArr = (this._shapeCache ||= (() => {
      const arr = new Uint8Array(N_BLOCOS);
      for (let i = 0; i < N_BLOCOS; i++) arr[i] = BLOCO_INFO[i]?.shape ? 1 : 0;
      return arr;
    })());

    const faceVisivel = (x, y, z, blocoAtual) => {
      const v = world.get(x, y, z);
      if (v === BLOCO.AR) return true;
      if (!solidArr[v]) return true;
      // Custom shapes não cobrem face inteira — sempre renderiza vizinho
      if (customShapeArr[v]) return true;
      // Folhas-folha: paridade MC fast graphics
      if (blocoAtual === BLOCO.FOLHA && v === BLOCO.FOLHA) return true;
      return false;
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
      // OTIMIZAÇÃO 3: vertex color em Uint8 (0-255 normalizado em vez de
      // Float32 0-1). 4× menos memória GPU + upload mais rápido.
      const s0 = (baseShade * AO_FACTOR[ao0] * 255) | 0;
      const s1 = (baseShade * AO_FACTOR[ao1] * 255) | 0;
      const s2 = (baseShade * AO_FACTOR[ao2] * 255) | 0;
      const s3 = (baseShade * AO_FACTOR[ao3] * 255) | 0;
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
          // === OTIMIZAÇÃO 2: skip fully-buried blocks ===
          // Se TODOS 6 vizinhos são sólidos cubos normais (não FOLHA, não
          // custom shape), bloco está enterrado — nenhuma face visível.
          // Pula iteração inteira pra economizar 6 lookups + 6 addFace skip.
          if (t !== BLOCO.FOLHA && !customShapeArr[t]) {
            const u = world.get(x, y+1, z);
            const d = world.get(x, y-1, z);
            const ee = world.get(x+1, y, z);
            const ww = world.get(x-1, y, z);
            const ss = world.get(x, y, z+1);
            const nn = world.get(x, y, z-1);
            if (solidArr[u] && solidArr[d] && solidArr[ee] && solidArr[ww] && solidArr[ss] && solidArr[nn]
                && !customShapeArr[u] && !customShapeArr[d] && !customShapeArr[ee] && !customShapeArr[ww] && !customShapeArr[ss] && !customShapeArr[nn]) {
              continue; // bloco enterrado, skip
            }
          }
          const idxTop = cellMap.top, idxSide = cellMap.side, idxBot = cellMap.bottom;
          // === Shapes customizadas (slab, fence, ladder, door) ===
          if (info.shape === 'slab') {
            // Meia altura inferior (y a y+0.5). Sempre emite top/bottom.
            addFace(SHADE.top, idxTop, 0, x, y, z, x, y+0.5, z, 0,1,0, 1,0,0, 0,0,1);
            addFace(SHADE.bottom, idxBot, 1, x, y, z, x, y, z+1, 0,-1,0, 1,0,0, 0,0,-1);
            addFace(SHADE.sideX, idxSide, 2, x, y, z, x+1, y, z,    1,0,0,  0,0,1,  0,0.5,0);
            addFace(SHADE.sideX, idxSide, 3, x, y, z, x,   y, z+1, -1,0,0,  0,0,-1, 0,0.5,0);
            addFace(SHADE.sideZ, idxSide, 4, x, y, z, x+1, y, z+1,  0,0,1, -1,0,0,  0,0.5,0);
            addFace(SHADE.sideZ, idxSide, 5, x, y, z, x,   y, z,    0,0,-1, 1,0,0,  0,0.5,0);
            continue;
          }
          if (info.shape === 'fence') {
            // Pillar central 0.4×1.0×0.4 (centrado em 0.3..0.7 ambos)
            const a = 0.3, b = 0.7, w = b - a;
            // top/bottom (quad central)
            addFace(SHADE.top,    idxTop,  0, x, y, z, x+a, y+1, z+a, 0,1,0,  w,0,0, 0,0,w);
            addFace(SHADE.bottom, idxBot,  1, x, y, z, x+a, y,   z+b, 0,-1,0, w,0,0, 0,0,-w);
            addFace(SHADE.sideX,  idxSide, 2, x, y, z, x+b, y,   z+a, 1,0,0,  0,0,w, 0,1,0);
            addFace(SHADE.sideX,  idxSide, 3, x, y, z, x+a, y,   z+b,-1,0,0,  0,0,-w,0,1,0);
            addFace(SHADE.sideZ,  idxSide, 4, x, y, z, x+b, y,   z+b, 0,0,1, -w,0,0, 0,1,0);
            addFace(SHADE.sideZ,  idxSide, 5, x, y, z, x+a, y,   z+a, 0,0,-1, w,0,0, 0,1,0);
            continue;
          }
          if (info.shape === 'ladder') {
            // Chapinha vertical 1×1×0.1 colada na face -Z (frente). MVP: sempre orientada.
            const d = 0.10;
            addFace(SHADE.sideZ, idxSide, 4, x, y, z, x+1, y, z+d, 0,0,1, -1,0,0, 0,1,0);
            addFace(SHADE.sideZ, idxSide, 5, x, y, z, x,   y, z,   0,0,-1, 1,0,0, 0,1,0);
            continue;
          }
          if (info.shape === 'door') {
            // Porta fechada: chapinha 1×1×0.18 colada na face -Z (frente do bloco).
            const d = 0.18;
            addFace(SHADE.top,    idxTop,  0, x, y, z, x,   y+1, z,    0,1,0,  1,0,0, 0,0,d);
            addFace(SHADE.bottom, idxBot,  1, x, y, z, x,   y,   z+d,  0,-1,0, 1,0,0, 0,0,-d);
            addFace(SHADE.sideX,  idxSide, 2, x, y, z, x+1, y,   z,    1,0,0,  0,0,d, 0,1,0);
            addFace(SHADE.sideX,  idxSide, 3, x, y, z, x,   y,   z+d, -1,0,0,  0,0,-d,0,1,0);
            addFace(SHADE.sideZ,  idxSide, 4, x, y, z, x+1, y,   z+d,  0,0,1, -1,0,0, 0,1,0);
            addFace(SHADE.sideZ,  idxSide, 5, x, y, z, x,   y,   z,    0,0,-1, 1,0,0, 0,1,0);
            continue;
          }
          if (info.shape === 'stairs') {
            // Escada: slab inferior (full XZ × 0.5 alta) + meio cubo
            // superior atrás (XZ 0.5 traseiro × 0.5 alto). Visual de
            // 2 degraus 0.5 cada (paridade Minecraft real, simplificado
            // sem rotação por orientação — sempre vira pra +Z).
            // === SLAB INFERIOR ===
            addFace(SHADE.top,    idxTop, 0, x, y, z,  x,   y+0.5, z+0.5,  0,1,0,  1,0,0, 0,0,0.5); // topo do degrau frontal (z..z+0.5)
            addFace(SHADE.bottom, idxBot, 1, x, y, z,  x,   y,     z+1,    0,-1,0, 1,0,0, 0,0,-1);
            addFace(SHADE.sideX,  idxSide,2, x, y, z,  x+1, y,     z,      1,0,0,  0,0,1, 0,0.5,0);
            addFace(SHADE.sideX,  idxSide,3, x, y, z,  x,   y,     z+1,   -1,0,0,  0,0,-1,0,0.5,0);
            addFace(SHADE.sideZ,  idxSide,4, x, y, z,  x+1, y,     z+1,    0,0,1, -1,0,0, 0,0.5,0);
            addFace(SHADE.sideZ,  idxSide,5, x, y, z,  x,   y,     z,      0,0,-1, 1,0,0, 0,0.5,0);
            // === MEIO CUBO SUPERIOR (atrás, z+0.5..z+1) ===
            addFace(SHADE.top,    idxTop, 0, x, y, z,  x,   y+1,   z+0.5,  0,1,0,  1,0,0, 0,0,0.5);
            addFace(SHADE.sideX,  idxSide,2, x, y, z,  x+1, y+0.5, z+0.5,  1,0,0,  0,0,0.5, 0,0.5,0);
            addFace(SHADE.sideX,  idxSide,3, x, y, z,  x,   y+0.5, z+1,   -1,0,0,  0,0,-0.5,0,0.5,0);
            addFace(SHADE.sideZ,  idxSide,4, x, y, z,  x+1, y+0.5, z+1,    0,0,1, -1,0,0,  0,0.5,0);
            // Face frontal do degrau superior (em z+0.5, y+0.5..y+1)
            addFace(SHADE.sideZ,  idxSide,5, x, y, z,  x,   y+0.5, z+0.5,  0,0,-1, 1,0,0,  0,0.5,0);
            continue;
          }
          if (info.shape === 'flower') {
            // Flor: chapinha vertical estreita 1×0.75 centralizada (x+0.25..x+0.75)
            // Visual: 2 chapas perpendiculares formando X (paridade MC sapling)
            const a = 0.5, ht = 0.75;
            // Quad 1: plano X (face perpendicular ao eixo Z, centrada em z+0.5)
            addFace(SHADE.sideZ, idxSide, 4, x, y, z, x+0.85, y, z+a, 0,0,1, -0.7,0,0, 0,ht,0);
            addFace(SHADE.sideZ, idxSide, 5, x, y, z, x+0.15, y, z+a, 0,0,-1, 0.7,0,0, 0,ht,0);
            // Quad 2: plano Z (face perpendicular ao eixo X, centrada em x+0.5)
            addFace(SHADE.sideX, idxSide, 2, x, y, z, x+a, y, z+0.15, 1,0,0, 0,0,0.7, 0,ht,0);
            addFace(SHADE.sideX, idxSide, 3, x, y, z, x+a, y, z+0.85,-1,0,0, 0,0,-0.7,0,ht,0);
            continue;
          }
          if (info.shape === 'pot') {
            // Vaso: cubo pequeno 0.5×0.5×0.5 no chão (centralizado)
            const a = 0.25, b = 0.75, w = b - a, h = 0.5;
            addFace(SHADE.top,    idxTop,  0, x, y, z, x+a, y+h, z+a, 0,1,0,  w,0,0, 0,0,w);
            addFace(SHADE.bottom, idxBot,  1, x, y, z, x+a, y,   z+b, 0,-1,0, w,0,0, 0,0,-w);
            addFace(SHADE.sideX,  idxSide, 2, x, y, z, x+b, y,   z+a, 1,0,0,  0,0,w, 0,h,0);
            addFace(SHADE.sideX,  idxSide, 3, x, y, z, x+a, y,   z+b,-1,0,0,  0,0,-w,0,h,0);
            addFace(SHADE.sideZ,  idxSide, 4, x, y, z, x+b, y,   z+b, 0,0,1, -w,0,0, 0,h,0);
            addFace(SHADE.sideZ,  idxSide, 5, x, y, z, x+a, y,   z+a, 0,0,-1, w,0,0, 0,h,0);
            continue;
          }
          if (info.shape === 'bars') {
            // Grade de ferro: 2 chapas finas perpendiculares (X+Z) full altura
            // Visual: cruz de barras finas estilo iron bars MC
            const a = 0.4375, b = 0.5625, w = b - a;
            // Chapa eixo Z (perpendicular X)
            addFace(SHADE.sideZ, idxSide, 4, x, y, z, x+1, y, z+b, 0,0,1, -1,0,0, 0,1,0);
            addFace(SHADE.sideZ, idxSide, 5, x, y, z, x,   y, z+a, 0,0,-1, 1,0,0, 0,1,0);
            // Chapa eixo X (perpendicular Z)
            addFace(SHADE.sideX, idxSide, 2, x, y, z, x+b, y, z,   1,0,0,  0,0,1, 0,1,0);
            addFace(SHADE.sideX, idxSide, 3, x, y, z, x+a, y, z+1,-1,0,0,  0,0,-1,0,1,0);
            // Topo (cruz)
            addFace(SHADE.top, idxTop, 0, x, y, z, x, y+1, z+a, 0,1,0, 1,0,0, 0,0,w);
            addFace(SHADE.top, idxTop, 0, x, y, z, x+a, y+1, z, 0,1,0, w,0,0, 0,0,1);
            continue;
          }
          if (info.shape === 'button') {
            // Botão: cubinho fino centralizado no chão (0.375x0.125x0.25)
            const ax = 0.3125, bx = 0.6875, w = bx - ax;       // largura 0.375
            const az = 0.4375, bz = 0.5625, d = bz - az;       // prof 0.125
            const h = 0.125;
            addFace(SHADE.top,    idxTop,  0, x, y, z, x+ax, y+h, z+az, 0,1,0,  w,0,0, 0,0,d);
            addFace(SHADE.bottom, idxBot,  1, x, y, z, x+ax, y,   z+bz, 0,-1,0, w,0,0, 0,0,-d);
            addFace(SHADE.sideX,  idxSide, 2, x, y, z, x+bx, y,   z+az, 1,0,0,  0,0,d, 0,h,0);
            addFace(SHADE.sideX,  idxSide, 3, x, y, z, x+ax, y,   z+bz,-1,0,0,  0,0,-d,0,h,0);
            addFace(SHADE.sideZ,  idxSide, 4, x, y, z, x+bx, y,   z+bz, 0,0,1, -w,0,0, 0,h,0);
            addFace(SHADE.sideZ,  idxSide, 5, x, y, z, x+ax, y,   z+az, 0,0,-1, w,0,0, 0,h,0);
            continue;
          }
          if (info.shape === 'plate') {
            // Placa de pressão: chapinha 1×0.0625×1 no chão (paridade MC)
            const h = 0.0625;
            addFace(SHADE.top,    idxTop, 0, x, y, z, x,   y+h, z,    0,1,0,  1,0,0, 0,0,1);
            addFace(SHADE.bottom, idxBot, 1, x, y, z, x,   y,   z+1,  0,-1,0, 1,0,0, 0,0,-1);
            addFace(SHADE.sideX,  idxSide,2, x, y, z, x+1, y,   z,    1,0,0,  0,0,1, 0,h,0);
            addFace(SHADE.sideX,  idxSide,3, x, y, z, x,   y,   z+1, -1,0,0,  0,0,-1,0,h,0);
            addFace(SHADE.sideZ,  idxSide,4, x, y, z, x+1, y,   z+1,  0,0,1, -1,0,0, 0,h,0);
            addFace(SHADE.sideZ,  idxSide,5, x, y, z, x,   y,   z,    0,0,-1, 1,0,0, 0,h,0);
            continue;
          }
          if (info.shape === 'lever') {
            // Alavanca: base pequena (0.25×0.0625×0.25) + cabo vertical
            // (0.0625×0.5×0.0625) inclinado a partir do centro
            // Base
            const ba = 0.375, bb = 0.625, bw = bb - ba;
            const bh = 0.0625;
            addFace(SHADE.top,    idxTop,  0, x, y, z, x+ba, y+bh, z+ba, 0,1,0,  bw,0,0, 0,0,bw);
            addFace(SHADE.bottom, idxBot,  1, x, y, z, x+ba, y,    z+bb, 0,-1,0, bw,0,0, 0,0,-bw);
            addFace(SHADE.sideX,  idxSide, 2, x, y, z, x+bb, y,    z+ba, 1,0,0,  0,0,bw, 0,bh,0);
            addFace(SHADE.sideX,  idxSide, 3, x, y, z, x+ba, y,    z+bb,-1,0,0,  0,0,-bw,0,bh,0);
            addFace(SHADE.sideZ,  idxSide, 4, x, y, z, x+bb, y,    z+bb, 0,0,1, -bw,0,0, 0,bh,0);
            addFace(SHADE.sideZ,  idxSide, 5, x, y, z, x+ba, y,    z+ba, 0,0,-1, bw,0,0, 0,bh,0);
            // Cabo vertical (mais fino)
            const ca = 0.4375, cb = 0.5625, cw = cb - ca;
            const ch = 0.5;
            const cy = bh; // começa no topo da base
            addFace(SHADE.sideX, idxSide, 2, x, y, z, x+cb, y+cy, z+ca,  1,0,0,  0,0,cw, 0,ch,0);
            addFace(SHADE.sideX, idxSide, 3, x, y, z, x+ca, y+cy, z+cb, -1,0,0,  0,0,-cw,0,ch,0);
            addFace(SHADE.sideZ, idxSide, 4, x, y, z, x+cb, y+cy, z+cb,  0,0,1, -cw,0,0, 0,ch,0);
            addFace(SHADE.sideZ, idxSide, 5, x, y, z, x+ca, y+cy, z+ca,  0,0,-1, cw,0,0, 0,ch,0);
            // Topo do cabo
            addFace(SHADE.top,   idxTop,  0, x, y, z, x+ca, y+cy+ch, z+ca, 0,1,0, cw,0,0, 0,0,cw);
            continue;
          }
          if (info.shape === 'wall') {
            // Pared baixinha: pillar central 0.5×1×0.5 (mais alta que fence
            // 0.4×1×0.4, ainda atravessável visualmente — usado em decoração
            // tipo muro de jardim)
            const a = 0.25, b = 0.75, w = b - a;
            addFace(SHADE.top,    idxTop,  0, x, y, z, x+a, y+1, z+a, 0,1,0,  w,0,0, 0,0,w);
            addFace(SHADE.bottom, idxBot,  1, x, y, z, x+a, y,   z+b, 0,-1,0, w,0,0, 0,0,-w);
            addFace(SHADE.sideX,  idxSide, 2, x, y, z, x+b, y,   z+a, 1,0,0,  0,0,w, 0,1,0);
            addFace(SHADE.sideX,  idxSide, 3, x, y, z, x+a, y,   z+b,-1,0,0,  0,0,-w,0,1,0);
            addFace(SHADE.sideZ,  idxSide, 4, x, y, z, x+b, y,   z+b, 0,0,1, -w,0,0, 0,1,0);
            addFace(SHADE.sideZ,  idxSide, 5, x, y, z, x+a, y,   z+a, 0,0,-1, w,0,0, 0,1,0);
            continue;
          }
          if (info.shape === 'torch') {
            // Haste fina central (0.125 wide × 0.625 alta). Centralizada
            // em XZ no bloco. Usa idxSide pra haste e idxTop pra topo da
            // chama (visual estilo Minecraft real — não é cubo cheio).
            const a = 0.4375, b = 0.5625; // 1/16 grid (~ 9-7 = 0.125)
            const w = b - a;              // largura da haste = 0.125
            const ht = 0.625;             // altura total
            const yt = y + ht;
            // Haste: 4 faces laterais
            addFace(SHADE.sideX, idxSide, 2, x, y, z,  x+b, y, z+a,   1,0,0,  0,0,w,  0,ht,0);
            addFace(SHADE.sideX, idxSide, 3, x, y, z,  x+a, y, z+b,  -1,0,0,  0,0,-w, 0,ht,0);
            addFace(SHADE.sideZ, idxSide, 4, x, y, z,  x+b, y, z+b,   0,0,1, -w,0,0,  0,ht,0);
            addFace(SHADE.sideZ, idxSide, 5, x, y, z,  x+a, y, z+a,   0,0,-1, w,0,0,  0,ht,0);
            // Topo (chama) e base (sob a torch)
            addFace(SHADE.top,    idxTop, 0, x, y, z,  x+a, yt, z+a,  0,1,0,  w,0,0,  0,0,w);
            addFace(SHADE.bottom, idxBot, 1, x, y, z,  x+a, y,  z+b,  0,-1,0, w,0,0,  0,0,-w);
            continue;
          }
          if (info.shape === 'door_open') {
            // Porta aberta: chapinha 0.18×1×1 colada na face -X (lateral esquerda).
            const d = 0.18;
            addFace(SHADE.top,    idxTop,  0, x, y, z, x,   y+1, z,   0,1,0,  d,0,0, 0,0,1);
            addFace(SHADE.bottom, idxBot,  1, x, y, z, x,   y,   z+1, 0,-1,0, d,0,0, 0,0,-1);
            addFace(SHADE.sideX,  idxSide, 2, x, y, z, x+d, y,   z,   1,0,0,  0,0,1, 0,1,0);
            addFace(SHADE.sideX,  idxSide, 3, x, y, z, x,   y,   z+1,-1,0,0,  0,0,-1,0,1,0);
            addFace(SHADE.sideZ,  idxSide, 4, x, y, z, x+d, y,   z+1, 0,0,1, -d,0,0, 0,1,0);
            addFace(SHADE.sideZ,  idxSide, 5, x, y, z, x,   y,   z,   0,0,-1, d,0,0, 0,1,0);
            continue;
          }
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
    // Color em Uint8 + normalized=true: GPU lê 0-255 como 0-1 (sem
    // alocação extra), 4× menor que Float32 mas mesmo fidelity visual.
    geo.setAttribute('color',    new THREE.BufferAttribute(new Uint8Array(colors), 3, true));
    geo.setAttribute('uv',       new THREE.BufferAttribute(new Float32Array(uvs), 2));
    geo.setIndex(indices);
    geo.computeBoundingSphere();
    chunk.mesh = new THREE.Mesh(geo, this.atlas.material);
    chunk.mesh.frustumCulled = false;
    chunk.facesCount = positions.length / 12; // 4 verts × 3 = 12 floats por face
    this.scene.add(chunk.mesh);
    chunk.dirty = false;
  }
  // Total de faces renderizadas em todos os chunks loaded — F3 perf.
  contagemFacesTotal() {
    let total = 0, chunks = 0;
    if (!state.world) return { total: 0, chunks: 0 };
    for (const c of state.world.chunks.values()) {
      if (c.mesh && c.facesCount) { total += c.facesCount; chunks++; }
    }
    return { total, chunks };
  }

  liberarChunkMesh(chunk) {
    if (chunk.mesh) {
      this.scene.remove(chunk.mesh);
      // Dispose explícito de geometry (BufferAttribute em GPU + arrays JS).
      // Material é compartilhado (atlas global) — NÃO disposar.
      const g = chunk.mesh.geometry;
      if (g) {
        if (g.index) g.index.array = null;
        for (const k of Object.keys(g.attributes)) {
          g.attributes[k].array = null;
        }
        g.dispose();
      }
      chunk.mesh = null;
      chunk.lights = []; // libera lista de luzes do chunk
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
  // Tickado do main loop pra animar texturas dinâmicas (água/lava).
  // Acumula dt e dispara repaint a cada 150ms (6.6Hz, suave + barato).
  atualizarTexturasAnimadas(dt) {
    this._animAcc = (this._animAcc || 0) + dt;
    if (this._animAcc < 0.15) return;
    this._animAcc = 0;
    this._animFrame = ((this._animFrame || 0) + 1) % 16;
    this.atlas.atualizarAnimacao?.(this._animFrame);
  }

  atualizarFOV(dt, correndo, zooming) {
    const base = this.fovBase || 70;
    // Zoom da luneta tem prioridade sobre sprint FOV
    const alvo = zooming ? 18 : (base + (correndo ? 8 : 0));
    const atual = this.camera.fov;
    if (Math.abs(atual - alvo) < 0.01) return;
    const k = zooming ? Math.min(1, 18 * dt) : Math.min(1, 10 * dt);
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
    // === Sky gradient multi-stop ===
    // 6 keypoints — produz transições ricas: noite escura (azul-violeta),
    // crepúsculo púrpura, sunrise/sunset laranja saturado, golden hour
    // dourado, dia azul claro, meio-dia ciano vibrante.
    const stops = [
      [0.00, 0x0a0a2a], // deep night
      [0.12, 0x2a1d56], // twilight violet
      [0.30, 0xff5a2f], // sunrise/sunset rich orange
      [0.45, 0xffc873], // golden hour
      [0.70, 0x87CEEB], // mid day sky
      [1.00, 0x9adcff], // noon vibrant
    ];
    let bg = new THREE.Color(stops[0][1]);
    for (let i = 0; i < stops.length - 1; i++) {
      const [t0, c0] = stops[i];
      const [t1, c1] = stops[i + 1];
      if (sun >= t0 && sun <= t1) {
        const t = (sun - t0) / (t1 - t0);
        bg = new THREE.Color(c0).lerp(new THREE.Color(c1), t);
        break;
      }
    }
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
    // Estrelas: fade noturno + twinkle leve (pulso aleatório do campo)
    if (this.estrelas) {
      this.estrelas.position.set(playerPos.x, playerPos.y, playerPos.z);
      const opaBase = Math.max(0, Math.min(0.95, (0.3 - sun) * 3.8));
      // Twinkle: pulso 4Hz com 15% de amplitude
      const t = (typeof performance !== 'undefined' ? performance.now() : Date.now()) * 0.001;
      const twinkle = 0.85 + 0.15 * Math.sin(t * 4);
      this.estrelas.material.opacity = opaBase * twinkle;
      this.estrelas.visible = opaBase > 0.01;
      // Slow rotation pra dar movimento celeste
      this.estrelas.rotation.y = t * 0.005;
    }
    // Lua: glow halo emissivo durante a noite
    if (this.discoLua && this.discoLua.material) {
      const noite = 1 - sun;
      this.discoLua.material.opacity = Math.max(0.4, noite);
      this.discoLua.material.transparent = true;
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
      const g = this.poolGlow?.[i];
      const c = candidatas[i];
      if (c) {
        l.visible = true;
        l.position.set(c.x, c.y, c.z);
        l.intensity = c.nivel / 15 * 0.8;
        l.distance = c.nivel + 1;
        l.color.setHex(c.nivel >= 15 ? 0xff6622 : 0xffaa55);
        // Glow sprite acompanha (escala proporcional à intensidade)
        if (g) {
          g.visible = true;
          g.position.set(c.x, c.y, c.z);
          const escala = 1.5 + (c.nivel / 15) * 2.5;
          g.scale.set(escala, escala, 1);
          g.material.color.setHex(c.nivel >= 15 ? 0xff8855 : 0xffcc77);
        }
      } else {
        l.visible = false;
        if (g) g.visible = false;
      }
    }
  }
  // Sombra circular do player projetada no chão (terceira pessoa ou
  // visível pra outros multiplayer). Colocada 0.05 acima do bloco abaixo.
  atualizarSombraPlayer(world, playerPos) {
    if (!this.playerShadow) return;
    // Encontra o primeiro bloco sólido abaixo
    let y = Math.floor(playerPos.y) - 1;
    let found = -1;
    for (let i = 0; i < 20; i++) {
      if (world.isSolido(Math.floor(playerPos.x), y, Math.floor(playerPos.z))) {
        found = y; break;
      }
      y--;
    }
    if (found < 0) {
      this.playerShadow.visible = false;
      return;
    }
    const dist = playerPos.y - (found + 1);
    // Esmaece + encolhe quanto mais alto o player estiver
    if (dist > 6) {
      this.playerShadow.visible = false;
      return;
    }
    this.playerShadow.visible = true;
    this.playerShadow.position.set(playerPos.x, found + 1.02, playerPos.z);
    const escala = Math.max(0.4, 1.0 - dist * 0.12);
    this.playerShadow.scale.set(escala, escala, 1);
    this.playerShadow.material.opacity = Math.max(0.2, 1.0 - dist * 0.15);
  }

  // === Beacon beams ===
  // Cilindro azul transparente alto subindo do bloco do beacon até o céu.
  // _beamMeshes: Map<key, Mesh>. Recurso global mantido pelo renderer.
  criarBeaconBeam(x, y, z) {
    if (!this._beamMeshes) this._beamMeshes = new Map();
    const k = `${x}_${y}_${z}`;
    if (this._beamMeshes.has(k)) return;
    const altura = 80;
    const geo = new THREE.CylinderGeometry(0.3, 0.3, altura, 8, 1, true);
    const mat = new THREE.MeshBasicMaterial({
      color: 0x80deea,
      transparent: true,
      opacity: 0.55,
      side: THREE.DoubleSide,
      depthWrite: false,
    });
    const mesh = new THREE.Mesh(geo, mat);
    mesh.position.set(x + 0.5, y + 0.5 + altura / 2, z + 0.5);
    this.scene.add(mesh);
    // Halo interno mais brilhante (cilindro menor opaco)
    const geoCore = new THREE.CylinderGeometry(0.10, 0.10, altura, 6, 1, false);
    const matCore = new THREE.MeshBasicMaterial({ color: 0xe0f7fa, transparent: true, opacity: 0.85, depthWrite: false });
    const core = new THREE.Mesh(geoCore, matCore);
    core.position.copy(mesh.position);
    this.scene.add(core);
    this._beamMeshes.set(k, { mesh, core });
  }
  removerBeaconBeam(x, y, z) {
    if (!this._beamMeshes) return;
    const k = `${x}_${y}_${z}`;
    const e = this._beamMeshes.get(k);
    if (!e) return;
    this.scene.remove(e.mesh); e.mesh.geometry.dispose(); e.mesh.material.dispose();
    this.scene.remove(e.core); e.core.geometry.dispose(); e.core.material.dispose();
    this._beamMeshes.delete(k);
  }

  render() { this.renderer.render(this.scene, this.camera); }
}
