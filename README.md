<div align="center">

# 🧱 Construção Criativa da Rebeca — 3D

### *Voxel sandbox 3D inspirado em Minecraft, rodando 100% no navegador*

<br>

<a href="https://construcao-criativa.pages.dev">
  <img src="https://img.shields.io/badge/▶%20%20JOGAR%20AGORA%20%20—%20%20100%25%20FREE-4CAF50?style=for-the-badge&logoColor=white&labelColor=2E7D32&color=43A047" alt="JOGAR AGORA" height="80">
</a>

<br><br>

### 👉 [**construcao-criativa.pages.dev**](https://construcao-criativa.pages.dev) 👈

<br>

![status](https://img.shields.io/badge/status-em%20produção-success?style=flat-square)
![tests](https://img.shields.io/badge/smoke%20tests-124%2F124-brightgreen?style=flat-square)
![license](https://img.shields.io/badge/license-MIT-blue?style=flat-square)
![mobs](https://img.shields.io/badge/mobs-16-blue?style=flat-square)
![blocos](https://img.shields.io/badge/blocos-36-orange?style=flat-square)
![dimensões](https://img.shields.io/badge/dimensões-2-purple?style=flat-square)
![multiplayer](https://img.shields.io/badge/multiplayer-WebSocket%20%2B%20BroadcastChannel-magenta?style=flat-square)

<br>

**Mundo voxel infinito · 16 mobs com IA · Encantamentos · Poções · Vilas · Dungeons · Nether · Multiplayer cross-device**

**Autora:** Rebeca Alves Moreira

</div>

---

## 📚 Índice

- [✨ Por que jogar](#-por-que-jogar)
- [🎮 Como jogar](#-como-jogar)
- [⌨️ Controles](#️-controles-completos)
- [🌍 Conteúdo de jogo](#-conteúdo-de-jogo)
- [🌐 Multiplayer](#-multiplayer)
- [🤖 Sistemas adaptativos](#-sistemas-adaptativos)
- [🏛 Arquitetura](#-arquitetura)
- [🔧 Rodar local](#-rodar-local)
- [☁️ Deploy](#️-deploy)
- [📜 Histórico de sprints](#-histórico-de-sprints)
- [📚 Documentação](#-documentação)
- [🏆 Créditos](#-créditos)

---

## ✨ Por que jogar

> **TL;DR**: Minecraft no browser, sem instalar nada, com Nether + multiplayer cross-device.

| Categoria | O que tem |
|-----------|-----------|
| **🌐 Acesso** | 100% browser. Desktop, tablet, celular. Sem download, sem login, sem ads. |
| **🎨 Visual 4K-ready** | Atlas procedural, ACES Filmic Tonemapping, antialiasing, sky gradient 6-stops, pixel ratio até 4× para Retina/8K. |
| **⚙️ Performance adaptiva** | Auto-detecta CPU/GPU/RAM e aplica preset (low/medium/high/ultra). Adaptive FPS monitor reduz qualidade se cair < 28fps. |
| **🌍 Mundo infinito** | Chunks 16×16×64 carregados sob demanda com **predictive load** (chunks na direção do movimento carregam primeiro). |
| **🌳 Geração viva** | 4 biomas (deserto/planicies/floresta/taiga), vilas habitadas, ravinas, dungeons subterrâneas com baú, icebergs em terra fria. |
| **🧟 16 mobs** com IA | A* pathfinding pra hostis melee, line-of-sight (não atacam através de paredes), zumbis queimam ao sol, creeper foge de gato, esqueleto + witch atiram à distância. |
| **⚔️ Combate profundo** | Bow charge time, crítico de queda (+50%), knockback velocity-based, sneak não cai de borda, drop ao morrer. |
| **🏗️ Construção rica** | 36 blocos: cubos completos + lajes, cercas, escadas, portas (toggleable), portal Nether. |
| **💎 Endgame** | Mesa de encantamento (Sharpness/Efficiency/Protection), 4 poções (Heal/Speed/Strength/Regen), Nether dimension explorável. |
| **🌐 Multiplayer real** | Cross-device via Cloudflare Worker + WebSocket (deployado e ativo) + local via BroadcastChannel. |
| **💾 Multi-save** | Vários mundos com nome + jogador identificado. Export/import JSON pra compartilhar. |
| **🔊 Áudio rico** | ~40 SFX procedurais via Web Audio (passos por superfície, mob calls, ambient cave/wind, UI), música ambiente em loop. |

---

## 🎮 Como jogar

1. Acesse **[construcao-criativa.pages.dev](https://construcao-criativa.pages.dev)**
2. Digite seu nome e nome do mundo
3. Clique **▶ Jogar** (entra em fullscreen + pointer lock no desktop, paisagem no celular)
4. Pra jogar com amigo: clique **👥 Multiplayer** → escolha sala → mande o nome da sala pro amigo

### Primeira partida em 3 minutos

1. Quebre **árvores** (madeira) — F na hotbar pra usar machado
2. Crafte **pranchas** (1 madeira → 4 pranchas)
3. Crafte **workbench** (4 pranchas)
4. Coloque workbench, fique perto, abra **C** (crafting)
5. Crafte **picareta de madeira** (3 pranchas + 2 paus)
6. Mine **pedra** → upgrade pra picareta de pedra → ferro → diamante
7. À noite, **acenda tochas** (carvão + pau) pra impedir spawn de mobs hostis
8. Eventualmente: 4 obsidiana + isqueiro = **portal pro Nether**

---

## ⌨️ Controles completos

### Desktop

| Tecla | Ação |
|-------|------|
| `Mouse` | Olhar (pointer lock automático) |
| `W A S D` | Mover |
| `Espaço` | Pular / subir (Criativo) / nadar pra cima |
| `Shift` | Sprint (Sobrevivência) / descer (Criativo) |
| `Ctrl` | Agachar — impede cair de borda |
| `Click esq.` | Quebrar bloco (segurar = quebra progressiva com 5 estágios de cracks) |
| `Click dir.` | Colocar bloco / interagir (porta, baú, fornalha, cama, villager, mesa de encantamento, etc.) |
| `Scroll` ou `1`–`9` | Trocar slot da hotbar |
| `E` | Inventário (no Criativo: 8 abas + busca) |
| `C` | Painel de crafting |
| `F` | Atacar mob (segura pra carregar arco se for o caso) |
| `Q` | Comer item / beber poção |
| `G` | Alternar Criativo / Sobrevivência |
| `F1` | Esconder/mostrar HUD |
| `F2` | 📸 Screenshot (baixa PNG) |
| `F3` | Tela de debug (chunk, luz, bioma, stats persistidas, faces meshadas, players online) |
| `F5` | Trocar 1ª/3ª pessoa |
| `Tab` | Liberar mouse sem pausar |
| `Esc` | Pause menu (FOV slider, sensibilidade, volume, qualidade, salvar, sair) |

### Mobile

- **Joystick virtual** à esquerda
- **Drag à direita** pra olhar
- **Botões touch**: pular, quebrar, colocar, atacar, descer
- **HUD escala** automaticamente pra portrait/landscape

---

## 🌍 Conteúdo de jogo

### 🟫 Blocos (36)

**Naturais:** Grama, Terra, Pedra, Areia, Madeira, Folha, Neve, Cacto, Cascalho (sílex)
**Minérios:** Carvão, Ferro, Ouro, Diamante, Lápis Lazuli (raro de pedra)
**Fluidos:** Água (escoa 4 blocos), Lava (escoa 2 blocos, queima madeira)
**Especiais:** Bedrock, Obsidiana, Vidro, Tijolo, Lã, Tocha (luz 13), Luz/Glowstone (14)
**Funcionais:** Workbench, Fornalha, Baú, Cama, Mesa de Encantamento (luz 7)
**Building (Sprint 2):** Lajes (pedra/madeira/tijolo) — meia altura, Cerca (pillar central), Escada/Ladder (climb mode), Porta (toggleable open/closed)
**Nether:** Netherrack vermelho, Portal Nether (swirl roxo emissivo)

### 🧟 Mobs (16)

**Passivos:** 🐄 Vaca · 🐔 Galinha (põe ovo a cada 60-120s) · 🐖 Porco · 🐑 Ovelha (tosquiável com right-click) · 🐺 Lobo (domesticável com osso, ataca hostis) · 🐈 Cat (assusta creeper, domesticável com peixe) · 🧑 Villager (right-click → painel de trade com 4 trocas) · 🤖 Iron Golem (HP 60, ataca hostis)

**Hostis:** 🧟 Zumbi (queima ao sol) · 💀 Esqueleto (atira flecha) · 🕷 Aranha (8 olhos, padrão hourglass) · 💥 Creeper (fuse 1.5s antes de explodir, foge se cat <6 blocos) · 🟢 Slime (split em 2-3 menores ao morrer) · 🟣 Enderman (teleporta) · 🧙 Witch (atira poção) · 👻 Ghast (Nether, flutua, tank)

**IA avançada (Sprint 6):**
- A* pathfinding pra hostis melee — contornam obstáculos
- Line-of-sight: não atacam através de paredes
- Stuck detection: se preso 3s, recomputa path + hop
- Mobs reproduzem com pranchas (love mode 30s) → spawn de cria menor

### 💎 Encantamentos (Sprint 3)

| Enchant | Efeito | Item |
|---------|--------|------|
| **Sharpness** 1-3 | +1/+2/+3 dano | Espadas |
| **Efficiency** 1-3 | +20%/+40%/+60% velocidade quebra | Picaretas |
| **Protection** 1-3 | -5%/-10%/-15% dano por peça | Armaduras (4 peças) |

Custo: 10/20/30 XP + 1 LAPIS por nível, na **Mesa de Encantamento** (1 livro + 2 diamante + 4 obsidiana).

### 🧪 Poções (Sprint 3)

Tomar com **Q** (igual comida):
- **Heal**: +5 HP instantâneo
- **Speed**: +30% velocidade por 30s
- **Strength**: +50% dano em ataques por 30s
- **Regen**: +1 HP a cada 1.5s por 30s

Receitas: água + 1 lápis + ingrediente (ouro/pau/ferro/trigo) na bancada.

### 🏘 Estruturas geradas (Sprint 7)

- **Vilas**: 1% por chunk em planicies/floresta — 3 casas com porta + tocha + 1 villager por casa
- **Dungeons**: 2% por chunk subterrâneo — sala 5×5×4 com baú + tochas + loot procedural
- **Ravinas**: 1.5% por chunk — canyon vertical 5×8-13×profundidade total
- **Icebergs**: 4% por chunk em taiga sobre água — cluster esférico de neve

### 🌱 Farming (Sprint 1+5)

- **Sementes** dropam de grama (15% chance)
- Plantar em **terra/grama** com right-click → cresce em 30s → drops trigo + 1-3 sementes
- 3 trigo → 1 **pão** (nutrição 5)
- **Mudas** dropam de folha (6%) → plantar em grama → árvore cresce em 15-25s
- **Dirt → grass spread**: terra exposta com grama vizinha vira grama em ticks de 5s

### 🌧 Clima

- **Chuva** (~30% do tempo) com partículas + ambient
- **Neve acumula** durante chuva em altitude ≥30 (taiga/montanhas)
- **Trovões** raros (20% por intervalo de 25s durante chuva)

### 🔥 Mecânicas físicas

- **Areia cai** (gravity blocks) ao remover suporte
- **Lava queima madeira** adjacente lentamente, dropando carvão
- **Folha decay**: cortar madeira → folhas órfãs somem em 0.2-3s escalonado
- **Água escoa** 4 blocos horizontal + cai vertical (BFS limit)
- **Lava escoa** 2 blocos similar
- **Mob torch defense**: hostis NÃO spawnam se luz block ≥8 perto (paridade Minecraft)

---

## 🌐 Multiplayer

### Como entrar numa sala online (cross-device)

1. Clique **👥 Multiplayer** no boot screen
2. Digite **nome da sala** (ex: `meu-grupo`)
3. Clique **🌐 Conectar online**
4. Mande o nome da sala pro amigo
5. Ambos digitam o mesmo nome → conectam → vêem um ao outro

### Como funciona

- **Servidor**: Cloudflare Worker com Durable Object SQLite-backed em `construcao-criativa-mp.rebcm-mp.workers.dev`
- **Sync**: posição + rotação + nome a 5Hz via WebSocket
- **Local fallback**: BroadcastChannel sincroniza abas do mesmo browser (sem servidor)
- **Free tier**: 100k req/dia ≈ dezenas de jogadores simultâneos
- **Persistente**: room name fica salvo, reconecta automaticamente

### Limitações honestas

- Sync é **só visual** (posição + rotação + nome)
- Chunks/blocos quebrados **não** se sincronizam — cada player joga seu mundo
- Pra mundo compartilhado: use **Export/Import JSON** (envia save pro amigo via Discord/WhatsApp)

---

## 🤖 Sistemas adaptativos

### Quality auto-detection

Detecta na inicialização: `navigator.deviceMemory` + `hardwareConcurrency` + `WEBGL_debug_renderer_info` + mobile flag → score 1-12 → tier:

| Tier | viewRadius | pixelRatio | AA | maxMobs | particles | snow |
|------|------------|------------|----|---------|-----------|------|
| **low** | 4 chunks | 1.0 | off | 8 | 60 | off |
| **medium** | 6 chunks | 1.5 | on | 14 | 120 | on |
| **high** | 8 chunks | 2.0 | on | 20 | 250 | on |
| **ultra** | 10 chunks | 4.0 | on | 30 | 500 | on |

### Adaptive FPS monitor

Coleta últimos 120 frames. Se média < 28 fps por amostra cheia + modo=auto → baixa 1 tier automaticamente (max 1 troca/8s anti-yo-yo).

### Memory watchdog

A cada 1s lê `performance.memory` (Chrome). Se usado/limite > 85% → libera chunks fora do view radius normal + toast informativo (max 1×/10s).

### Loading overlay

Detecta backlog de chunks (faltando + dirty pendentes) > 50% do view radius → mostra `Carregando cenário…` translúcido sem bloquear input.

### Predictive load

Chunks faltantes ordenados por (distância + alinhamento com vetor de velocidade). Player andando pra +X carrega chunks de +X primeiro — anti-pop-in durante movimento.

### Frame watchdog

Se dt > 50ms (< 20fps), pula trabalho não-essencial nesse frame (clima, ambient, tick de mudas). Recupera framerate antes de retomar.

---

## 🏛 Arquitetura

```
game/
├── README.md ← você está aqui
├── CLAUDE.md             # Instruções pra Claude Code auto-continue
├── AGENTS.md             # Regras pra qualquer agente de IA
├── ARCHITECTURE.md       # Detalhes técnicos
├── .env                  # Cloudflare credentials (NÃO commitado)
├── .github/workflows/
│   └── deploy.yml        # CI/CD (push → deploy automático)
├── docs/
│   ├── MODULES.md        # Referência por módulo
│   ├── walkthrough.md    # Guia de jogabilidade
│   └── SETUP.md          # Setup de dev local
├── scripts/
│   ├── deploy-web3d.sh   # Deploy Cloudflare Pages
│   └── test-web3d-precheck.js  # 124 smoke tests
├── worker/                                ⭐ Multiplayer cross-device
│   ├── src/index.js      # Durable Object Room (WebSocket relay)
│   └── wrangler.toml     # SQLite-backed DO config
└── web3d/                                 ⭐ O JOGO
    ├── index.html        # HUD em DOM + áudio inline (window.rebcm.sfx)
    ├── style.css         # Pixel-perfect com Press Start 2P
    ├── manifest.json     # PWA
    ├── _headers          # Cloudflare cache headers
    ├── favicon.svg/.png
    └── src/              # 18 módulos ES (~6500 LOC total)
        ├── main.js           # Entry: init, loop, handlers de ação
        ├── state.js          # Estado global compartilhado
        ├── constants.js      # 36 BLOCO + ITEM + RECEITAS + dimensões
        ├── utils.js          # Hashes, AO, A* pathfinding, Perlin noise
        ├── audio.js          # Wrapper sobre window.rebcm.sfx
        ├── world.js          # Chunks, World, lighting, geração, dimensões
        ├── render.js         # Renderer Three.js, atlas, mesh builder, sky
        ├── player.js         # Player, física AABB, swim, climb (ladder)
        ├── inventory.js      # Inventario, Drops, Crafting
        ├── mobs.js           # 16 mobs, IA, A*, line-of-sight, panic
        ├── particles.js      # Partículas, ItemDrop, XPOrb, Arrow, ambient
        ├── ui.js             # HUD, paineis, F3, pause, criativo, minimap
        ├── save.js           # Multi-save v5 (rebcm3d_world_<name>)
        ├── input.js          # Keyboard + mouse + touch + settings sliders
        ├── achievements.js   # 12 conquistas com toast verde
        ├── weather.js        # Chuva, neve acumula, trovão, sky tinting
        ├── multiplayer.js    # BroadcastChannel + WebSocket ghosts
        └── quality.js        # 4-tier adaptive quality + FPS monitor
```

### Decisões de design chave

- **Sem build step.** `index.html` carrega `src/main.js` direto via importmap CDN (Three.js).
- **ES modules nativos.** Sem Webpack/Vite/Rollup/TypeScript/JSX.
- **Sem dependências runtime extras.** Só Three.js. Sem React/Vue/jQuery/Lodash.
- **Sem transparência em blocos.** Todos opacos — paridade Minecraft fast graphics.
- **Iluminação 15 níveis** (skylight + blocklight) com flood-fill BFS por chunk.
- **Custom shape system**: BLOCO_INFO[t].shape ('slab' | 'fence' | 'ladder' | 'door' | 'door_open') → mesh + colisão specializada.
- **Estado compartilhado** em `state.js` (objeto mutável) — evita ciclos de import.
- **Multi-dimensão**: `world._chunksOverworld` + `_chunksNether` em paralelo, swap em `trocarDimensao()`.

Detalhes em [`ARCHITECTURE.md`](ARCHITECTURE.md) e [`docs/MODULES.md`](docs/MODULES.md).

---

## 🔧 Rodar local

```bash
git clone https://github.com/rebcm/game
cd game/web3d
python3 -m http.server 8000
# Acesse http://localhost:8000
```

**Requisitos:** apenas um browser moderno. **Sem `npm install`** — o `package.json` é intencionalmente ausente.

ES modules exigem HTTP (não funciona via `file://`).

Pra validar antes de commitar:

```bash
# Sintaxe
for f in web3d/src/*.js; do node --check "$f"; done

# 124 smoke tests
TMPDIR=$(mktemp -d) && cp -R web3d/* "$TMPDIR/" && \
  cp scripts/test-web3d-precheck.js "$TMPDIR/_p.js" && \
  ( cd "$TMPDIR" && node ./_p.js . ) && rm -rf "$TMPDIR"
```

---

## ☁️ Deploy

### Game (Cloudflare Pages)

```bash
# .env precisa ter CLOUDFLARE_API_TOKEN + CLOUDFLARE_ACCOUNT_ID
set -a; source .env; set +a
./scripts/deploy-web3d.sh
```

O script: copia `web3d/` → cache-bust `__BUILD_VERSION__` → valida sintaxe → roda 124 smoke tests → publica via `wrangler pages deploy`. Aborta se algum teste falhar.

A cada `git push origin main`, GitHub Actions executa o mesmo script automaticamente.

### Worker de multiplayer (Cloudflare Workers)

```bash
cd worker
set -a; source ../.env; set +a
npx -y wrangler@latest deploy
```

Deploya `worker/src/index.js` em `https://construcao-criativa-mp.rebcm-mp.workers.dev` (subdomain configurada). Free tier inclui Durable Objects SQLite-backed (compat date 2024-09-23+).

---

## 📜 Histórico de sprints

11 sprints entregues, ~2000 LOC adicionadas, 100% smoke tests passando:

| # | Sprint | Highlights |
|---|--------|------------|
| 1 | **QoL & Survival** | Photo mode (F2), hunger curve real (saturation+regen), minimap 2D, crops/farming, stats persistidas globais |
| 2 | **Building Vocabulary** | Slabs (3 variantes), fence (pillar), ladder (climb mode), door (toggleable) |
| 3 | **Endgame Progression** | Encantamentos (Sharpness/Efficiency/Protection), 4 poções, Mesa de Encantamento, Lápis Lazuli |
| 4 | **Population** | Cat (assusta creeper), Villager (trade UI), Iron Golem (tank), Witch (ranged), Esmeralda |
| 5 | **World Mechanics** | Fluxo de água/lava (BFS), dirt→grass spread, torch detection (mob spawn) |
| 6 | **Engine** | A* pathfinding 2D, stuck detection, mob flutua na água |
| **6.5** | **Performance Pack** | Solid lookup cache, skip buried blocks, vertex color Uint8 (4× menos GPU), F3 perf stats |
| 7 | **Geração** | Vilas (3 casas + 3 villagers), ravinas verticais, icebergs em taiga |
| 8 | **Multiplayer Local** | BroadcastChannel ghosts (cross-tab same browser) com nome flutuante |
| **8.5** | **Multiplayer Cross-Device** | Cloudflare Worker + Durable Object + WebSocket (free tier), persistência de room |
| 9 | **Nether Dimension** | Portal (obsidiana + flint+sílex), gerador Nether (lava+glowstone), Ghast (flying tank) |

Plus inúmeros fixes (BLOCO_INFO import bug, _safeJSON null bug, mob entrando em bloco, spawn em ambiente fechado, etc).

---

## 📚 Documentação

| Arquivo | Conteúdo |
|---------|----------|
| [`README.md`](README.md) | Visão geral pública (você está aqui) |
| [`CLAUDE.md`](CLAUDE.md) | Instruções pra Claude Code em modo auto-continue |
| [`AGENTS.md`](AGENTS.md) | Regras detalhadas pra qualquer agente de IA |
| [`ARCHITECTURE.md`](ARCHITECTURE.md) | Arquitetura técnica detalhada (fluxo, decisões, pipeline) |
| [`docs/MODULES.md`](docs/MODULES.md) | Referência por módulo (18 módulos JS) |
| [`docs/walkthrough.md`](docs/walkthrough.md) | Guia passo-a-passo do jogo |
| [`docs/SETUP.md`](docs/SETUP.md) | Setup de desenvolvimento + troubleshooting |

---

## 🏆 Créditos

**Autora:** **Rebeca Alves Moreira**

**Tecnologias:**
- [Three.js](https://threejs.org/) (BSD-3) — engine 3D WebGL via importmap CDN
- [Cloudflare Pages](https://pages.cloudflare.com) — hospedagem do game (free tier)
- [Cloudflare Workers](https://workers.cloudflare.com) — multiplayer signaling (free tier com Durable Objects SQLite)
- Web Audio API — SFX procedurais + música
- Press Start 2P (Google Fonts) — tipografia pixel-perfect

**Inspirado em** Minecraft (Mojang Studios). Projeto educacional independente, sem afiliação.

**Licença:** [MIT](LICENSE) — livre pra usar, modificar, distribuir, comercializar. Mantenha o copyright original.

---

<div align="center">

### 🎮 [JOGAR AGORA →](https://construcao-criativa.pages.dev)

*"Construa mundos. Não há limites."* 🧱✨

</div>
