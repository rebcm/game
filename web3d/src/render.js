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
  const COLS = 8, ROWS = 8, CELL = 32;
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
    let seed = idx * 9301 + 49297;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        const r = seed / 233280;
        if (r < intensity / 2)        ctx.fillStyle = dark;
        else if (r < intensity)       ctx.fillStyle = light;
        else                          continue;
        ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
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
    // Grãos: pontos individuais 1×1 alternando claro/escuro
    for (let py = 0; py < CELL; py++) {
      for (let px = 0; px < CELL; px++) {
        seed = (seed * 9301 + 49297) % 233280;
        const r = seed / 233280;
        if (r < 0.08)       ctx.fillStyle = '#FFEFA0'; // grão brilhante
        else if (r < 0.18)  ctx.fillStyle = '#A5904A'; // grão escuro
        else continue;
        ctx.fillRect(x0 + px, y0 + py, 1, 1);
      }
    }
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
      // Quartzo natural: ruído sutil + manchas claras + brilho central
      ctx.fillStyle = '#eeeeee';
      for (let py = 0; py < CELL; py += 2) {
        for (let px = 0; px < CELL; px += 2) {
          seed = (seed * 9301 + 49297) % 233280;
          if ((seed / 233280) < 0.20) ctx.fillRect(x0 + px, y0 + py, 2, 2);
        }
      }
      ctx.fillStyle = '#ffffff';
      for (let i = 0; i < 8; i++) {
        seed = (seed * 9301 + 49297) % 233280;
        const px = (seed % CELL);
        seed = (seed * 9301 + 49297) % 233280;
        const py = (seed % CELL);
        ctx.fillRect(x0 + px, y0 + py, 3, 3);
      }
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

  // Lã colorida (genérica): aplica padrão de fios curtos sobre cor base
  function pintarLaColorida(idx, corBase, corClaro, corEscuro) {
    const col = idx % COLS;
    const row = Math.floor(idx / COLS);
    const x0 = col * CELL, y0 = row * CELL;
    ctx.fillStyle = corBase;
    ctx.fillRect(x0, y0, CELL, CELL);
    // Fios escuros (textura de lã)
    let seed = idx * 9301 + 49297;
    ctx.fillStyle = corEscuro;
    for (let py = 0; py < CELL; py += 2) {
      for (let px = 0; px < CELL; px += 2) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.18) ctx.fillRect(x0 + px, y0 + py, 2, 2);
      }
    }
    // Highlights claros
    ctx.fillStyle = corClaro;
    for (let py = 0; py < CELL; py += 3) {
      for (let px = 0; px < CELL; px += 3) {
        seed = (seed * 9301 + 49297) % 233280;
        if ((seed / 233280) < 0.10) ctx.fillRect(x0 + px, y0 + py, 1, 1);
      }
    }
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

  const texture = new THREE.CanvasTexture(cnv);
  texture.magFilter = THREE.NearestFilter;
  texture.minFilter = THREE.NearestFilter;
  texture.wrapS = THREE.ClampToEdgeWrapping;
  texture.wrapT = THREE.ClampToEdgeWrapping;
  texture.colorSpace = THREE.SRGBColorSpace;
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
