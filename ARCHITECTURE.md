# 🏛 Arquitetura do Projeto

**Projeto:** Construção Criativa da Rebeca
**Autora:** Rebeca Alves Moreira

---

## 🎯 Visão Geral

O repositório `rebcm/game` contém **dois sandboxes coexistentes** do mesmo conceito (jogo voxel da Rebeca), com tecnologias diferentes:

| Sandbox | Stack | Status | Localização |
|---------|-------|--------|-------------|
| **Web3D** | Three.js + WebGL puro | ✅ **Ativo (versão deployada)** | [`web3d/`](web3d/) |
| **Flutter 2D** | Flutter + Flame | 🧊 Manutenção (legado) | [`lib/`](lib/), [`app/`](app/) |

A versão **Web3D** é a única em desenvolvimento ativo e a que está em produção em https://construcao-criativa.pages.dev.

A versão **Flutter** é mantida no repo como referência histórica e como base de comparação. Não é deployada.

---

## 🎮 Web3D (Versão Ativa)

### Stack
- **Three.js 0.165** via importmap CDN unpkg
- **JavaScript ES2022** (módulos nativos, sem build)
- **WebGL** via `THREE.WebGLRenderer`
- **Web Audio API** para SFX procedurais
- **localStorage** para persistência

### Arquivos
```
web3d/
├── index.html       # Entrada: HUD em DOM, áudio inline, importmap, boot screen
├── style.css        # Estilo pixel-perfect com fonte "Press Start 2P"
├── game.js          # Engine completo (~4200 linhas, single-file)
├── manifest.json    # PWA manifest
├── favicon.svg      # Ícone voxel isométrico
└── _headers         # Cache headers do Cloudflare Pages
```

### Estrutura interna do `game.js`

O arquivo é dividido em seções marcadas por banners `// ====== N) Nome ======`:

| # | Seção | Responsabilidade |
|---|-------|------------------|
| 1 | Constantes | `BLOCO`, `BLOCO_INFO`, `ITEM`, `ITEM_INFO`, `RECEITAS`, dimensões |
| 2 | Utilitários | `hash2`, `hash3`, `clamp`, `chunkKey`, `materialDeBloco` |
| 3 | Mundo / Chunk | `Chunk` (16×16×64 voxels), `World` (chunks Map + estados de baú/fornalha) |
| 4 | Renderer | Cena Three.js, atlas procedural, mesh por chunk, céu, sol/lua, nuvens |
| 5 | Player + Controles | `Player` com física AABB, swim, sneak, fall damage, ar/oxigênio |
| 6 | Inventário, Drops, Crafting | `Inventario`, `Drops`, `Crafting` |
| 6.5 | Partículas | `Particulas` (faíscas ao quebrar bloco) |
| 6.6 | Item Drops | `ItemDrop` (entidades flutuantes coletáveis) |
| 7 | Mobs | `Mob`, `MobManager`, modelos 3D de 9 espécies |
| 8 | Audio | wrapper sobre `window.rebcm.sfx` definido no HTML |
| 9 | UI | `UI` class — hotbar, barras, painéis, F3, pause, criativo |
| 10 | Save / Load | `Save.salvar()` / `Save.carregar()` em localStorage |
| 11 | Globals + Bootstrap | `init()`, declaração das instâncias globais |
| 12 | Boot | listener do botão `JOGAR`, fullscreen, pointer lock |

### Fluxo de Execução

```
[Usuário clica JOGAR]
       ↓
init()
  ├─ new Renderer(canvas)
  │     └─ cria scene, camera, atlas, sol/lua/nuvens, highlight, mão
  ├─ new World(seed)
  ├─ new Player(camera) + PointerLockControls
  ├─ new MobManager(scene)
  ├─ new Particulas(scene)
  ├─ Save.carregar()  → restaura estado (ou spawn fresh)
  ├─ setupInput()      → keyboard, mouse, F3, pause, criativo
  ├─ setupTouchControls() → joystick, look-zone, botões touch
  └─ requestAnimationFrame(loop)
       ↓
loop(dt)  [60 fps]
  ├─ FPS counter
  ├─ if !pausado:
  │     ├─ player.atualizar(dt) → input → física → swim → sneak → fome → ar
  │     ├─ tempoDia += dt/240
  │     ├─ mobMgr.atualizar(dt, world, player, sun)
  │     ├─ particulas.atualizar(dt)
  │     ├─ raycast → highlight + quebra/colocar
  │     └─ renderer.atualizarMao(dt, ...)
  ├─ Carrega chunks faltantes (orçamento 2/frame)
  ├─ Build mesh dos chunks dirty (orçamento 2/frame)
  ├─ Libera chunks fora do view radius
  ├─ renderer.atualizarCeu(tempoDia, playerPos)  # nuvens, sol, lua
  ├─ renderer.atualizarLuzesPontuais(...)
  ├─ ui.renderBars()
  ├─ ui.atualizarOverlays()  → vinheta, underwater, low-hp
  ├─ ui.atualizarF3({targetBlock: ray?.hit})
  ├─ atualizarItemDrops(dt)
  └─ renderer.render()
```

### Decisões de Design

- **Chunks 16×16×64 com altura limitada a 64**: paridade próxima do Minecraft (que vai a 384 hoje, 256 antes), mas suficiente para dispositivos móveis.
- **Per-face meshing** (não greedy): mais simples, ainda viável para `VIEW_RADIUS=4` (9×9 = 81 chunks visíveis).
- **AO fake por vértice**: três blocos vizinhos por vértice; sem flood fill real.
- **Skylight aproximado por dynamic sun intensity**: não há canal de luz por voxel; cavernas escurecem pela atenuação geral, não por skylight real.
- **Modelos de mob com `THREE.Group`** + cabeça/corpo/pernas/braços animadas via pivots Group.
- **HUD em DOM** sobreposto ao canvas (não em WebGL): permite Press Start 2P, emojis, tooltips fáceis.
- **Áudio Web Audio inline** no HTML: o módulo `game.js` apenas consome `window.rebcm.sfx` exposto pelo `<script>` da raiz.
- **Save em localStorage com versão `v3`**: migrações sem quebra. `chunks` modificados serializados em base64.

---

## 🧊 Flutter 2D (Legado)

### Stack
- Flutter 3.24 + Flame 1.18
- Renderização isométrica custom com painter's algorithm
- Build via `flutter build web --release`

### Estrutura
```
app/lib/
├── main.dart                          # Entrada: landscape + immersive
├── constantes.dart                    # Dimensões, velocidades
├── blocos/tipo_bloco.dart            # 13 blocos
├── mundo/mundo.dart                  # Grid 32×32×20 + ondas senoidais
├── personagem/rebeca.dart            # Movimento, raycasting
├── renderizador/renderizador_isometrico.dart  # Painter's algorithm
├── jogo/construcao_criativa.dart     # FlameGame loop
└── ui/controles_overlay.dart         # Joystick, hotbar, HUD

lib/                                  # Cópia/módulo Flutter
```

Esta versão segue a regra original "criativo puro, sem mobs/morte". Não tem paridade com Minecraft moderno.

---

## 🔄 Comparação Web3D × Flutter

| Aspecto | Web3D ✅ | Flutter 2D 🧊 |
|---------|----------|---------------|
| Vista | 1ª/3ª pessoa real 3D | Isométrica 2.5D |
| Mundo | Infinito por chunks | 32×32×20 fixo |
| Tipos de bloco | 26 | 13 |
| Mobs | 9 espécies com IA | nenhum |
| Modos | Criativo + Sobrevivência | Criativo apenas |
| Crafting | 25+ receitas + workbench + fornalha | nenhum |
| Inventário | 36 slots + 4 armadura + abas | hotbar 8 slots |
| Save | localStorage v3 com chunks | nenhum |
| Day/Night | Ciclo de 4 minutos com sol/lua/nuvens | nenhum |
| Mobile | Touch otimizado | Touch básico |
| Performance | 60 fps em celular médio | 30 fps em celular médio |
| Build size | ~180 KB total (game.js) | ~4 MB (Flutter web bundle) |

---

## 🚀 Pipeline de Deploy

### Web3D (atual)

```
git push origin main
       ↓
GitHub Actions (.github/workflows/Deploy.yml)
       ↓
scripts/deploy-web3d.sh
       ├─ cp web3d/* /tmp/web3d-build-XXXX/
       ├─ sed __BUILD_VERSION__ → timestamp UTC
       ├─ node --check game.js
       ├─ node test-web3d-precheck.js   # 30 smoke tests
       └─ wrangler pages deploy → construcao-criativa.pages.dev
```

### Flutter (legado)
Existe workflow histórico em `.github/workflows/`. Não é mais executado em prod.

---

## 📚 Documentação Relacionada

- [`README.md`](README.md) — visão geral pública
- [`AGENTS.md`](AGENTS.md) — instruções para agentes de IA
- [`docs/walkthrough.md`](docs/walkthrough.md) — guia jogável
- [`docs/SETUP.md`](docs/SETUP.md) — ambiente de desenvolvimento
- [`docs/deploy/procedimento-deploy.md`](docs/deploy/procedimento-deploy.md) — fluxo de deploy detalhado
- [`docs/blocos/README.md`](docs/blocos/README.md) — catálogo de blocos
- [`docs/biomas.md`](docs/biomas.md) — biomas e geração de terreno

---

*Atualizado em maio/2026 — migração Three.js completa.*
