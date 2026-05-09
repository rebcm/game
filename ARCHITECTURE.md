# 🏛 Arquitetura — Construção Criativa da Rebeca

**Autora:** Rebeca Alves Moreira
**Versão:** Web3D modular (Three.js + addons postprocessing + ES modules nativos) + Cloudflare Worker pra multiplayer
**Última atualização:** maio/2026 — pós paridade Minecraft 1.21 + sprints VISUAL/AUDIO premium

## 📊 Estado atual (números)

- **1000 blocos** com qualidade visual premium (gradient + bevel + AO)
- **210+ items** (Shield, Crossbow, Mace, Elytra, Totem, 14 poções, 11 discos, spawn eggs)
- **65 mobs** com models 3D + AI ranged dedicada (28 com AI customizada)
- **14 estruturas** geradas (Stronghold, Nether Fortress, End City, Ancient City, Trial Chamber, etc.)
- **10 biomas** (deserto, planicies, floresta, taiga, cherry_grove, mangrove_swamp, bamboo_jungle, mushroom_fields, lush_caves, snowy_*)
- **15 profissões** villager (farmer, butcher, fisherman, etc.)
- **17 efeitos** de status, **60 encantamentos** em 12 categorias
- **64 achievements** com persistência localStorage
- **3 dimensões**: Overworld, Nether (Fortress), End (Cities + Dragon)
- **Sky Shader Custom GLSL** + **Bloom UnrealPass** + **Vignette + Color Grading**
- **Spatial Audio 3D HRTF** + **Reverb procedural** + **6 ambient loops por bioma**
- **19 módulos JS** (~28K LOC total)
- **124/124 smoke tests** ✓

---

## 🎯 Visão geral

O jogo é uma **single-page web app** rodando 100% no navegador, deployado em Cloudflare Pages como arquivos estáticos.

O **multiplayer cross-device** usa um Cloudflare Worker separado (Durable Object SQLite-backed) como WebSocket relay — não há backend de jogo, só sync de posição/nome.

```
┌─────────────────────────────┐         ┌──────────────────────────────┐
│  construcao-criativa.       │         │  construcao-criativa-mp.     │
│  pages.dev                  │ ──WS──→ │  rebcm-mp.workers.dev        │
│                             │         │                              │
│  • Static HTML/JS/CSS       │         │  • Durable Object Room       │
│  • web3d/ deployado         │         │  • WebSocket relay           │
│  • 124 smoke tests pré-push │         │  • Free tier                 │
└─────────────────────────────┘         └──────────────────────────────┘
```

Sem backend de jogo. Cada player roda seu próprio mundo em localStorage; multiplayer só sincroniza posição visual.

---

## 📂 Estrutura de pastas

```
game/
├── README.md                # Visão pública detalhada
├── CLAUDE.md                # Instruções pra Claude Code auto-continue
├── AGENTS.md                # Regras detalhadas pra agentes de IA
├── ARCHITECTURE.md          # Você está aqui
├── .env                     # Cloudflare credentials (NÃO commitado)
├── .env.example
├── .gitignore
├── .github/workflows/
│   └── deploy.yml           # CI/CD: push → deploy automático
├── docs/
│   ├── MODULES.md           # Referência módulo por módulo
│   ├── walkthrough.md       # Como jogar
│   └── SETUP.md             # Setup de desenvolvimento
├── scripts/
│   ├── deploy-web3d.sh      # Cache busting + smoke tests + wrangler pages
│   └── test-web3d-precheck.js  # 124 smoke tests
├── worker/                                ⭐ Multiplayer
│   ├── src/index.js         # Durable Object Room (WebSocket relay)
│   └── wrangler.toml        # SQLite-backed DO config
└── web3d/                                 ⭐ O JOGO
    ├── index.html           # HUD em DOM + áudio inline (window.rebcm.sfx)
    ├── style.css            # Pixel-perfect com Press Start 2P
    ├── manifest.json        # PWA
    ├── _headers             # Cache headers (HTML 60s, JS immutable)
    ├── favicon.svg/.png
    └── src/                 # 18 módulos ES (~6500 LOC total)
        ├── main.js              # Entry: init, loop, handlers
        ├── state.js             # Estado global compartilhado
        ├── constants.js         # 36 BLOCO + ITEM + RECEITAS
        ├── utils.js             # Hashes, AO, A* pathfinding, Perlin
        ├── audio.js             # Wrapper sobre window.rebcm.sfx
        ├── world.js             # Chunks, World, lighting, geração, dimensões
        ├── render.js            # Renderer Three.js, atlas, mesh builder, sky
        ├── player.js            # Player, física AABB, swim, climb
        ├── inventory.js         # Inventario, Drops, Crafting
        ├── mobs.js              # 16 mobs, IA, A*, LOS, panic, breeding
        ├── particles.js         # Partículas, ItemDrop, XPOrb, Arrow, ambient
        ├── ui.js                # HUD, paineis, F3, pause, criativo, minimap
        ├── save.js              # Multi-save v5 (rebcm3d_world_<name>)
        ├── input.js             # Keyboard + mouse + touch + settings
        ├── achievements.js      # 12 conquistas com toast verde
        ├── weather.js           # Chuva, neve, trovão, sky tinting
        ├── multiplayer.js       # BroadcastChannel + WebSocket ghosts
        └── quality.js           # 4-tier adaptive quality + FPS monitor
```

---

## 🔄 Fluxo de execução

```
[Usuário acessa página]
       ↓
Boot screen renderiza (_renderBootSafe)
  ├─ Carrega Save.getPlayer() → preenche input nome
  ├─ Carrega Save.listarMundos() → renderiza lista clicável
  └─ Aguarda click

[Click em "Jogar" ou item de mundo existente]
       ↓
_entrarNoJogo({playerName, worldName, isNew})
  ├─ Salva escolha em window._bootChoice
  ├─ desbloqueia AudioContext (gesto do click)
  ├─ requestFullscreen + screen.orientation.lock('landscape')
  ├─ esconde #boot, mostra #hud
  └─ chama init()

init() (main.js)
  ├─ state.ui = new UI()
  ├─ state.inv = new Inventario() + hotbar inicial
  ├─ initQuality() → detecta tier + aplica preset
  ├─ state.renderer = new Renderer(canvas) [usa state.quality]
  ├─ state.world = new World(seed) [seed da choice ou save]
  ├─ state.player = new Player(camera) + PointerLockControls
  ├─ state.mobMgr = new MobManager(scene)
  ├─ state.particulas = new Particulas(scene)
  ├─ Save.carregarPorNome(worldName) → restaura ou spawn novo
  ├─ Safe-spawn loop (sobe player se está dentro de bloco)
  ├─ setActions({atacarMob, comerSlot, ...})
  ├─ setupInput() + setupTouchControls() + settings sliders
  ├─ Audio.musicaIniciar()
  ├─ Multiplayer.iniciar() [BroadcastChannel + WS auto-reconnect]
  ├─ setInterval(Save.salvar, 30s)
  └─ requestAnimationFrame(loop)

loop(now) [60 fps target]
  ├─ Frame watchdog (state._heavyFrame se dt>50ms)
  ├─ FPS counter + qualityTickFps + memoryCheck
  ├─ Verifica pausa (paineis abertos / morto / pause menu)
  ├─ Se não pausado:
  │   ├─ player.atualizar(dt) → input → física → climb → fome → ar
  │   ├─ Portal Nether check (1.5s pisando → trocarDimensao)
  │   ├─ tempoDia += dt/240
  │   ├─ mobMgr.atualizar(dt) → A* paths, LOS, attacks, breeding
  │   ├─ particulas.atualizar(dt) → ambient (smoke, lava, cave drip)
  │   ├─ Multiplayer.atualizar(dt) → lerp ghosts
  │   ├─ raycastBloco → highlight + quebra/colocar
  │   └─ Spawn villagers de vilas geradas (deferido)
  ├─ Chunks loading (predictive: ordenado por distância+velocidade)
  ├─ Mesh build dirty (orçamento adaptativo do quality tier)
  ├─ Libera chunks fora do view radius (geometry.dispose)
  ├─ Loading overlay update (se backlog > 50%)
  ├─ Tick mudas + crops (dropam ao maturar) + spreadGrama
  ├─ atualizarClima(dt) [chuva, neve acumula, trovão]
  ├─ renderer.atualizarCeu(tempoDia, playerPos)
  ├─ renderer.atualizarLuzesPontuais(...)
  ├─ ui.renderBars() + atualizarOverlays() + atualizarF3 + atualizarMinimap
  ├─ atualizarItemDrops + atualizarXpOrbs + atualizarArrows + atualizarAmbientTriggers
  ├─ Sprint dust particles (se sprintando no chão)
  ├─ Camera bobbing + shake offset
  └─ renderer.render()
```

---

## 💡 Decisões de design chave

### Modularidade
- **18 módulos ES** com responsabilidade única, importados via `import` nativo do browser.
- **Sem ciclos de import**: estado compartilhado fica em [`state.js`](web3d/src/state.js) (objeto mutável); módulos referenciam `state.world`, `state.player` etc.

### Sem build step
- `index.html` define `<script type="importmap">` apontando Three.js para CDN.
- `index.html` carrega `src/main.js?v=__BUILD_VERSION__` (substituído no deploy pelo timestamp UTC).
- Cache headers: HTML `max-age=60`, JS `max-age=31536000 immutable`. Quando deploya algo novo, a URL do JS muda e o browser revalida sozinho.

### Iluminação 15 níveis
- Cada `Chunk` tem `light: Uint8Array` (1 byte por voxel: 4 bits sky + 4 bits block).
- `World.recalcLuzChunk(chunk)`:
  1. **Skylight vertical**: desce do topo, fica em 15 enquanto não bater bloco sólido.
  2. **Blocklight BFS**: enfileira fontes emissivas (lava, luz, tocha, glowstone) e propaga -1 por bloco.
- Mesh builder lê `world.getLightAt(adjacent_voxel)` para cada face → vertex color modulada.
- Recalc local por chunk (não cruza bordas) — simplificação aceitável.

### Custom shape system (Sprint 2)
- `BLOCO_INFO[t].shape` define geometria customizada: `'slab'`, `'fence'`, `'ladder'`, `'door'`, `'door_open'`.
- Mesh builder em `render.js:buildChunkMesh` detecta shape e gera vertices adequados (meia altura, pillar central, chapinha vertical, etc).
- Player + Mob colisão também respeita shape (`colisaoBlocos` / `colideEm` com casos por shape).

### Sistema de dimensões (Sprint 9)
- `world.dimensao` = `'overworld'` ou `'nether'`.
- `world._chunksOverworld` + `_chunksNether` em paralelo.
- `world.trocarDimensao(novaDim)` swap o `chunks` Map atual. Mesh rebuild + mob despawn.
- Geração diferente por dim: `gerarChunk` (overworld) vs `_gerarChunkNether` (vermelho + lava + glowstone teto).

### Multi-save v5 (Sprint 8 boot screen)
- `localStorage`:
  - `rebcm3d_player`: `{name}` — identidade persistida.
  - `rebcm3d_worlds_index`: `[{name, seed, lastPlayed, modo}]` (até 12 mundos).
  - `rebcm3d_world_<name>`: snapshot por mundo (chunks modificados base64 + inv + estados).
- Auto-migração de save legado v4 (`rebcm3d_save_v4`) como "Mundo Antigo".
- Export/import JSON pra compartilhar entre jogadores.

### Sistema de qualidade adaptativa (Sprint 8)
- `quality.js:detectarTier()`: score 1-12 baseado em RAM + CPU + GPU + mobile flag.
- 4 presets (low/medium/high/ultra) controlam: viewRadius, pixelRatio, antialias, maxMobs, maxParticles, chunkLoadBudget.
- `aplicarTier(tier)` hot-swap em runtime (renderer.setPixelRatio, etc).
- `tickFps(dt)` no main loop: se média < 28fps por 2s + modo=auto, baixa 1 tier (max 1×/8s anti-yo-yo).
- UI no pause menu: 5 botões Auto/Baixa/Média/Alta/Ultra com active highlight.

### Multiplayer (Sprint 8 + 8.5)
- `multiplayer.js` mantém **dois canais simultâneos**:
  - **BroadcastChannel** local (`rebcm3d-multiplayer-v1`) — sync entre abas mesma origem.
  - **WebSocket** online (`wss://construcao-criativa-mp.rebcm-mp.workers.dev/ws?room=NAME`) — cross-device.
- Broadcast 5Hz pra ambos canais. Recebe broadcasts → spawna ghost mesh + nome flutuante via canvas sprite.
- Lerp suave (k=dt*8) anti-jitter. Cleanup 5s de ghosts inativos.
- Worker (worker/src/index.js): Durable Object SQLite-backed (free tier). WebSocket relay simples — broadcast pra todos os outros sockets da room.

### Mobs com IA refinada (Sprint 6+)
- 16 espécies em `MOB_INFO` com flags (`hostil`, `amigavel`, `pula`, `teleport`, `explode`, `flutua`, `fuseSegundos`).
- A* pathfinding 2D pra hostis melee (zumbi/aranha/iron golem). Cap 100 nodes, recompute 1.2s.
- Line-of-sight cacheada 0.4-0.7s — só perseguem se vêem player.
- Stuck detection: 3s sem mover > 0.3 bloco → invalida path + hop +0.6y.
- Reprodução: alimentar passivo com pranchas → loveTimer 30s. 2 mesmo-tipo em love mode próximos = spawn de cria (scale 0.6, vira adulto em 60s).
- Sun damage: zumbi/esqueleto em skylight ≥14 perdem 1 HP/1.5s.
- Cat assusta creeper (range 6) → desarma fuse + força panic.

### Estado compartilhado
- [`state.js`](web3d/src/state.js) exporta um objeto único `state` com referências às instâncias.
- Módulos fazem `import { state } from './state.js'` e leem/escrevem `state.world.foo()`.
- Evita ciclos de import e prop drilling.

### HUD em DOM
- Não usa WebGL para HUD. Vinheta/flash/tooltip/F3/pause/minimap/quality são `<div>`/`<canvas>` sobre o canvas WebGL.
- Permite Press Start 2P + emojis + animações CSS + sliders nativos.

### Áudio procedural
- HTML inline `<script>` define `window.rebcm.sfx` com osciladores Web Audio.
- ~40 SFX: passos por material, mob calls, ambient (cave drip/vento), UI (chest, eat, equip), combate (hurt/critical/explosao), weather (chuva/trovão).
- Música: progressão harmônica de 4 acordes (pad sustenido) + melodia em escala diatônica, em loop.
- [`audio.js`](web3d/src/audio.js) faz wrapper com nomes amigáveis.
- **Master volume** via GainNode interceptado em `ctx.destination` (Object.defineProperty) — todo SFX existente passa por master sem reescrita.

### Áudio Spatial 3D (Sprint AUDIO-3D)
- **Web Audio API + HRTF**: PannerNode com `panningModel='HRTF'` (binaural realista)
- **Distance attenuation**: `distanceModel='inverse'`, refDistance 1, maxDistance 16 blocos
- **Listener tracking**: posição + forward + up vector da camera, atualizado a cada frame
- **Reverb procedural**: ConvolverNode com IR gerado em runtime (1.8s decay, wet 0.18)
- **Ambient loops por bioma**: 6 tracks oscilator + LFO modulação + lowpass filter
  - Auto-switch a cada 2s baseado em y/dimension/biome
  - Fade-in 3s + fade-out 1.5s
- **Defensive code**: try/catch + flag `_audio3DErrLogged` previne log spam se Web Audio falhar

### Sky Shader Custom (Sprint VISUAL-1)
- **SphereGeometry 380 raio** com `THREE.ShaderMaterial` custom GLSL
- **Vertex shader**: passa worldPos pro fragment
- **Fragment shader**: gradient horizon→zenith via `pow(viewDir.y + offset, exponent)`
  - Sun bloom radial via `dot(viewDir, normalize(sunPos))`
  - Powers diferentes (32 e 8) pra bloom + halo
- **Uniforms dinâmicos**: sunPos (acompanha tempoDia), topColor/bottomColor/sunColor (mudam por hora do dia)
- **6 stages temporais**: noite deep / twilight violet / sunrise / golden hour / dia / noon
- **Skydome segue camera position** (renderizado atrás de tudo)
- **Defensive**: try/catch na criação + try/catch no update — fallback para `scene.background` solid

### Post-processing pipeline (Sprint VISUAL-3)
- **EffectComposer** + 4 passes em ordem:
  1. **RenderPass**: render base scene → framebuffer
  2. **UnrealBloomPass**: bloom gaussian (strength 0.55, radius 0.6, threshold 0.78) — emissive blocks (lava, glowstone) brilham
  3. **ShaderPass custom Vignette + Color Grading**: darkness 0.65, saturation 1.10, contraste 1.05
  4. **OutputPass**: tone mapping ACES Filmic + sRGB encoding
- **Render**: `composer.render()` se composer existe, senão `renderer.render()`
- **Resize handler** atualiza composer size também
- **Defensive**: try/catch ao criar — se postprocessing falha, fallback graceful

---

## 🚀 Pipeline de deploy

### Game (Cloudflare Pages)
```
git push origin main
       ↓
GitHub Actions (.github/workflows/deploy.yml)
  └─ scripts/deploy-web3d.sh
       ├─ cp web3d/* /tmp/build-XXXX/
       ├─ sed __BUILD_VERSION__ → timestamp UTC (cache busting)
       ├─ for f in src/*.js; node --check "$f"
       ├─ node test-web3d-precheck.js .   # 124 smoke tests
       └─ wrangler pages deploy /tmp/build-XXXX
              └→ construcao-criativa.pages.dev
```

Se algum smoke test falhar, **deploy aborta com exit 1** e o status do PR fica vermelho.

### Worker (Cloudflare Workers)
```
cd worker
set -a; source ../.env; set +a
npx -y wrangler@latest deploy
       └→ construcao-criativa-mp.rebcm-mp.workers.dev
```

Free tier inclui Durable Objects SQLite-backed (compat date 2024-09-23+). Sem custo. Deploy raro (estável após sprint 8.5).

---

## 🛡 Smoke tests (124 invariantes)

[`scripts/test-web3d-precheck.js`](scripts/test-web3d-precheck.js) verifica:

- **Estrutura**: 18 módulos `src/*.js` existem; `game.js` antigo NÃO existe.
- **Sintaxe**: `node --check` em cada módulo.
- **Blocos opacos**: `transp:true` ausente em `constants.js`; `meshT/positionsT` ausentes em `render.js`.
- **HTML**: `import("./src/main.js")` correto; sem `btn-transp`; divs essenciais presentes.
- **Save v5**: schema atualizado, exporta export/import.
- **Anti-regressão**: invariantes específicos pra bugs históricos:
  - mobs.js importa BLOCO_INFO se usa BLOCO_INFO (preveniu travamento).
  - _safeJSON trata null/undefined (preveniu boot quebrar).
  - atacarMob detecta ITEM.ARCO + bowCharging (preveniu regressão bow).
- **Por módulo**: invariantes específicos (World.recalcLuzChunk faz BFS, Player.sneak existe, MobManager tem 11+ espécies, etc).

Adicione um novo teste a cada bug que regrediu, para impedir reincidência.

---

## ⚙️ Performance + safety pack (Sprint 6.5)

- **Solid lookup cache** (Uint8Array por block ID): substitui hash lookup `BLOCO_INFO[t].solido` 6×/bloco/chunk.
- **Skip buried blocks**: pre-check 6 vizinhos sólidos → pula bloco enterrado inteiro.
- **Vertex color Uint8** (era Float32) com `normalized=true`: 4× menos memória GPU.
- **Memory watchdog**: a cada 1s lê `performance.memory` (Chrome). Se >85% → libera chunks distantes + toast.
- **Frame watchdog**: dt > 50ms → state._heavyFrame=true → skipa weather/ambient/tick mudas no frame.
- **Loading overlay**: backlog > 50% → mostra spinner não-bloqueante.
- **Predictive load**: chunks faltantes ordenados por (distância + alinhamento com velocidade).

---

## 📚 Documentos relacionados

- [`README.md`](README.md) — visão pública detalhada
- [`CLAUDE.md`](CLAUDE.md) — auto-continue para Claude Code
- [`AGENTS.md`](AGENTS.md) — regras detalhadas pra agentes
- [`docs/MODULES.md`](docs/MODULES.md) — referência por módulo
- [`docs/walkthrough.md`](docs/walkthrough.md) — passo-a-passo de jogo
- [`docs/SETUP.md`](docs/SETUP.md) — setup local

---

*Atualizado em maio/2026 — 11 sprints entregues, 18 módulos, 124 smoke tests, multiplayer cross-device em produção, Nether dimension, sistema adaptive quality, 16 mobs com A*.*
