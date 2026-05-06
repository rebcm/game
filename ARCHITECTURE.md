# 🏛 Arquitetura — Construção Criativa da Rebeca

**Autora:** Rebeca Alves Moreira
**Versão:** Web3D modular (Three.js + ES modules)

---

## 🎯 Visão geral

O jogo é uma **single-page web app** rodando 100% no navegador. Não há backend, não há build step, não há servidor de jogo.

Todo o código fica em [`web3d/`](web3d/) e é deployado direto no Cloudflare Pages como arquivos estáticos.

---

## 📂 Estrutura de pastas

```
game/
├── README.md                # Visão geral pública
├── CLAUDE.md                # Instruções para Claude Code auto-continue
├── AGENTS.md                # Regras detalhadas para agentes de IA
├── ARCHITECTURE.md          # Você está aqui
├── .env.example             # Template de credenciais Cloudflare
├── .gitignore
├── .github/workflows/
│   └── deploy.yml           # Deploy automático
├── docs/
│   ├── MODULES.md           # Referência módulo por módulo
│   ├── walkthrough.md       # Como jogar
│   └── SETUP.md             # Setup de desenvolvimento
├── scripts/
│   ├── deploy-web3d.sh      # Cache busting + smoke tests + wrangler
│   └── test-web3d-precheck.js  # 93 smoke tests
└── web3d/                   # ⭐ O jogo
    ├── index.html           # HUD em DOM + áudio inline (window.rebcm.sfx)
    ├── style.css            # Pixel-perfect com Press Start 2P
    ├── manifest.json        # PWA
    ├── _headers             # Cache headers (HTML 60s, JS immutable)
    ├── favicon.svg / .png
    └── src/                 # 14 módulos ES
        ├── main.js          # Entry: init() + loop + handlers de ações
        ├── state.js         # Estado global compartilhado
        ├── constants.js     # BLOCO, ITEM, RECEITAS, dimensões
        ├── utils.js         # Hashes, AO, materialDeBloco, uvCelula
        ├── audio.js         # Wrapper sobre window.rebcm.sfx
        ├── world.js         # Chunk, World, geração, lighting 15 níveis
        ├── render.js        # Renderer Three.js, atlas, sky, mesh builder
        ├── player.js        # Player, física AABB, swim, sneak
        ├── inventory.js     # Inventario, Drops, Crafting
        ├── mobs.js          # Mob, MobManager, 11 espécies
        ├── particles.js     # Particulas, ItemDrop, XPOrb, ambient
        ├── ui.js            # UI, paineis, F3, pause, criativo
        ├── save.js          # localStorage v4
        └── input.js         # Keyboard + mouse + touch
```

---

## 🔄 Fluxo de execução

```
[Usuário clica JOGAR]
       ↓
main.js: handler do botão #play
  ├─ desbloqueia AudioContext (gesto do clique)
  ├─ requestFullscreen + screen.orientation.lock('landscape')
  ├─ esconde #boot, mostra #hud
  └─ chama init()
       ↓
init() (main.js)
  ├─ state.ui = new UI()
  ├─ state.inv = new Inventario() + hotbar inicial
  ├─ state.renderer = new Renderer(canvas)
  ├─ state.world = new World(seed)
  ├─ state.player = new Player(camera) + PointerLockControls
  ├─ state.mobMgr = new MobManager(scene)
  ├─ state.particulas = new Particulas(scene)
  ├─ Save.carregar() → restaura ou spawn novo
  ├─ setActions({ atacarMob, comerSlot, ... })
  ├─ setupInput()        # keyboard + mouse + UI buttons
  ├─ setupTouchControls() # joystick + look + touch buttons
  ├─ Audio.musicaIniciar()
  ├─ setInterval(Save.salvar, 30s)
  └─ requestAnimationFrame(loop)
       ↓
loop(dt) [60 fps]
  ├─ FPS counter
  ├─ Verifica pausa (paineis abertos / morto / pause menu)
  ├─ Se não pausado:
  │   ├─ player.atualizar(dt) → input → física → swim → sneak → fome → ar
  │   ├─ tempoDia += dt/240
  │   ├─ mobMgr.atualizar(dt, world, player, sun)
  │   ├─ particulas.atualizar(dt)  # incluindo ambient (smoke fornalha, lava sparks)
  │   ├─ raycastBloco → highlight + quebra/colocar
  │   └─ renderer.atualizarMao(dt)
  ├─ Carrega chunks faltantes (orçamento 2/frame)
  ├─ Build mesh dos chunks dirty (orçamento 2/frame)
  ├─ Libera chunks fora do view radius
  ├─ renderer.atualizarCeu(tempoDia, playerPos)  # nuvens, sol, lua, estrelas
  ├─ renderer.atualizarLuzesPontuais(...)
  ├─ ui.renderBars()
  ├─ ui.atualizarOverlays()  # vinheta, underwater, low-hp
  ├─ ui.atualizarF3({targetBlock})
  ├─ atualizarItemDrops(dt)
  ├─ atualizarXpOrbs(dt, ganharXP)
  ├─ atualizarAmbientTriggers(dt)  # cave drip, vento
  ├─ Camera shake offset
  └─ renderer.render()
```

---

## 💡 Decisões de design chave

### Modularidade
- **14 módulos ES** com responsabilidade única, importados via `import` nativo do browser.
- **Sem ciclos de import**: estado compartilhado fica em [`state.js`](web3d/src/state.js) (objeto mutável); módulos referenciam `state.world`, `state.player` etc.

### Sem build step
- `index.html` define `<script type="importmap">` apontando Three.js para CDN unpkg.
- `index.html` carrega `src/main.js?v=__BUILD_VERSION__` (substituído no deploy pelo timestamp).
- Cache: HTML `max-age=60`, JS `max-age=31536000 immutable` — quando deploya algo novo, a URL do JS muda e o browser revalida sozinho.

### Iluminação 15 níveis
- Cada `Chunk` tem `light: Uint8Array` (1 byte por voxel: 4 bits sky + 4 bits block).
- `World.recalcLuzChunk(chunk)`:
  1. **Skylight vertical**: desce do topo, fica em 15 enquanto não bater bloco sólido.
  2. **Blocklight BFS**: enfileira fontes emissivas (lava, luz, tocha) e propaga -1 por bloco.
- Mesh builder lê `world.getLightAt(adjacent_voxel)` para cada face → vertex color modulada.
- Recalc local por chunk (não cruza bordas) — simplificação aceitável.

### Blocos opacos (sem transparência)
- Após refatoração, `BLOCO_INFO` não tem mais `transp: true`.
- Mesh builder único (sem `meshT/positionsT`).
- Faces visíveis: `world.get(adj) === BLOCO.AR`.
- Vidro/folha/água/tocha aparecem como blocos sólidos com cores próprias.

### Estado compartilhado
- [`state.js`](web3d/src/state.js) exporta um objeto único `state` com referências às instâncias.
- Módulos fazem `import { state } from './state.js'` e leem/escrevem `state.world.foo()`.
- Evita ciclos de import e prop drilling.

### Save em localStorage v4
- JSON único: posição, HP, fome, XP, nível, modo, hora, inventário, armadura, baús, fornalhas, chunks modificados (base64).
- Versão `v4` corresponde à refatoração modular sem transparência.

### Mobs com IA leve
- 11 espécies em `MOB_INFO` com `hp`, `vel`, `hostil`, `dano`, `alcance`, `drops()`, `cor`, `sec`.
- Spawn por light level (paridade Minecraft real).
- Comportamentos especiais: slime pula, enderman teleporta.
- Sons casuais por mob a cada 6–18s quando perto (raio 24m).

### Áudio procedural
- HTML inline `<script>` define `window.rebcm.sfx` com osciladores Web Audio.
- ~40 SFX: passos por material, mob calls, ambient (cave drip/vento), UI (chest, eat, equip), combate (hurt/critical/explosao).
- Música: progressão harmônica de 4 acordes (pad sustenido) + melodia em escala diatônica, em loop.
- [`audio.js`](web3d/src/audio.js) só faz wrapper com nomes amigáveis.

### HUD em DOM
- Não usa WebGL para HUD. Vinheta/flash/tooltip/F3/pause são `<div>` sobre o canvas.
- Permite Press Start 2P + emojis + animações CSS.

---

## 🚀 Pipeline de deploy

```
git push origin main
       ↓
GitHub Actions (.github/workflows/deploy.yml)
  └─ scripts/deploy-web3d.sh
       ├─ cp web3d/* /tmp/build-XXXX/
       ├─ sed __BUILD_VERSION__ → timestamp UTC (cache busting)
       ├─ for f in src/*.js; node --check "$f"
       ├─ node test-web3d-precheck.js .   # 93 smoke tests
       └─ wrangler pages deploy /tmp/build-XXXX
              └→ construcao-criativa.pages.dev
```

Se algum smoke test falhar, **deploy aborta com exit 1** e o status do PR fica vermelho.

---

## 🛡 Smoke tests (93 invariantes)

[`scripts/test-web3d-precheck.js`](scripts/test-web3d-precheck.js) verifica:

- **Estrutura**: 14 módulos `src/*.js` existem; `game.js` antigo NÃO existe.
- **Sintaxe**: `node --check` em cada módulo.
- **Blocos opacos**: `transp:true` ausente em `constants.js`; `meshT/positionsT` ausentes em `render.js`.
- **HTML**: `import("./src/main.js")` correto; sem `btn-transp`; divs essenciais presentes.
- **Por módulo**: invariantes específicos (ex.: `World.recalcLuzChunk` faz BFS, `Player.sneak` existe, `MobManager` tem 11 espécies, etc).

Adicione um novo teste a cada bug que regrediu, para impedir reincidência.

---

## 📚 Documentos relacionados

- [`README.md`](README.md) — visão pública
- [`CLAUDE.md`](CLAUDE.md) — auto-continue para Claude Code
- [`AGENTS.md`](AGENTS.md) — regras detalhadas
- [`docs/MODULES.md`](docs/MODULES.md) — referência por módulo
- [`docs/walkthrough.md`](docs/walkthrough.md) — passo-a-passo
- [`docs/SETUP.md`](docs/SETUP.md) — setup local

---

*Atualizado em maio/2026 — arquitetura modular completa.*
