# 📦 Referência de Módulos

**Projeto:** Construção Criativa da Rebeca — 3D
**Autora:** Rebeca Alves Moreira

Este documento descreve cada módulo em [`web3d/src/`](../web3d/src/) com responsabilidade, dependências e principais exports. **18 módulos JS, ~6500 LOC total.**

Use como mapa pra navegar pelo código.

---

## 🔗 Grafo de dependências (simplificado)

```
                    ┌──────────┐
                    │ state.js │ (sem deps — usado por todos)
                    └─────┬────┘
                          ▼
┌──────────────┐    ┌──────────────┐    ┌──────────┐
│ constants.js │←───│   utils.js   │    │ audio.js │
└──────┬───────┘    └──────┬───────┘    └────┬─────┘
       │ (importados por todos os domínios)  │
       ▼                                     ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│   world.js   │  │ inventory.js │  │   save.js    │  │ achievements │
└──────┬───────┘  └──────────────┘  └──────────────┘  └──────────────┘
       │
       ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│  render.js   │  │  player.js   │  │   mobs.js    │  │ particles.js │
└──────┬───────┘  └──────────────┘  └──────────────┘  └──────────────┘
       │                  │                │                │
       ▼                  ▼                ▼                ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│  weather.js  │  │ multiplayer  │  │   ui.js      │  │  quality.js  │
└──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘
                          │                │                │
                          └────────────────┼────────────────┘
                                           ▼
                                  ┌──────────────┐    ┌──────────┐
                                  │   input.js   │←──→│  main.js │
                                  └──────────────┘    └──────────┘
                                                            │
                                                            ▼
                                                  [Inicializa tudo]
```

---

## constants.js

**Responsabilidade:** Constantes do mundo, blocos, itens, receitas.

**Sem dependências.**

**Exports principais:**
- `CHUNK_SIZE` (16), `WORLD_Y` (64), `VIEW_RADIUS` (6 default — overridden por quality).
- `PLAYER_HEIGHT` (1.8), `PLAYER_RADIUS` (0.3), `GRAVIDADE`, `VEL_*` — física.
- `DIA_SEGUNDOS` (240 = 4min/dia), `SAVE_KEY` (legacy v4).
- `BLOCO` — IDs (0-35). **36 blocos** incluindo SLAB_*, FENCE, LADDER, DOOR, MESA_ENCANT, NETHERRACK, PORTAL_NETHER.
- `BLOCO_INFO` — metadata (`nome`, `solido`, `emiteLuz`, `cor`, `lateral`, `shape`).
  - **Sem `transp` — todos opacos.**
  - `shape`: `'slab' | 'fence' | 'ladder' | 'door' | 'door_open'` pra blocos não-cubo.
- `ICONE` — emoji por bloco.
- `ITEM` — IDs até 290+. Inclui poções (270-273), esmeralda (280), peixe (281), sílex (290), flint_steel (291).
- `ITEM_INFO` — metadata (nutricao, ferramenta, armadura, defesa, tier, pocao, plantavel).
- `RECEITAS` — array de ~40 receitas (workbench, crafting básico, baú, fornalha, mesa, baldes, isqueiro).

---

## utils.js

**Responsabilidade:** Funções puras utilitárias.

**Importa:** `constants.js`.

**Exports principais:**
- `hash2(x, z, salt)`, `hash3(x, y, z, salt)` — hashes determinísticos.
- `clamp(v, lo, hi)`.
- `chunkKey(cx, cz)` — chave única no Map de chunks.
- `materialDeBloco(b)` — categoria de pisar (grama/pedra/madeira/etc) pra SFX.
- `AO_OFFSETS` — tabela de offsets de vizinhos pra Ambient Occlusion.
- `vertexAOValor(world, sx, sy, sz, off3)` — calcula AO 0-3 por vértice.
- `uvCelula(atlas, idx)` — UVs de uma célula no atlas.
- **`perlin2(x, y, seed)`** + **`perlin3(x, y, z, seed)`** + **`fbm2(x, y, octaves)`** — noise para terreno + cavernas + biomas.
- **`aStarMob(world, sx, sy, sz, gx, gz, maxNodes=100)`** ⭐ — A* pathfinding 2D pra mobs (Sprint 6).

---

## state.js

**Responsabilidade:** Estado global compartilhado entre módulos.

**Sem dependências.**

**Export:** objeto `state` com:
- Instâncias: `renderer`, `world`, `player`, `inv`, `ui`, `mobMgr`, `particulas`.
- Identidade: `playerName`, `worldName` (Sprint 8).
- Runtime: `tempoDia`, `chunkLoadOrcamento`, `fpsAcc`, `fpsTimer`.
- Adaptive: `quality` (preset atual), `_heavyFrame`, `_busy`, `_portalAcc`.
- Entidades: `dropEntidades`, `xpOrbs`.
- Painel ativo: `bauAtivoCoords`, `fornalhaAtivaCoords`.

**Padrão de uso:** `import { state } from './state.js'` e ler/escrever `state.world.foo()`.

---

## audio.js

**Responsabilidade:** Wrapper sobre `window.rebcm.sfx` (definido inline em `index.html`).

**Sem dependências de outros módulos.**

**Export:** objeto `Audio` com ~50 métodos:
- Mundo: `quebrar()`, `colocar()`.
- Combate: `atacar()`, `hit()`, `hurt()`, `critical()`.
- Comer: `comer()`, `eatCrunch()`.
- Movimento: `passo(material)`, `splash()`, `bolha()`.
- Progressão: `levelUp()`, `pickup()`, `xpOrb()`, `explosao()`, `respawn()`.
- Mobs: `zumbi()`, `esqueleto()`, `creeperHiss()`, `aranha()`, `vaca()`, `ovelha()`, `porco()`, `galinha()`, `lobo()`, `slime()`, `endermanTeleport()`, `mobCall(tipo)`.
- Ambient: `caveDrip()`, `caveAmbient()`, `vento()`.
- UI: `chestOpen/Close()`, `bowDraw/Release()`, `arrow()`, `equipArmor()`, `cama()`, `fornalhaLit()`, `pageFlip()`.
- Clima: `chuva()`, `trovao()`.
- Música: `musicaIniciar()`, `musicaParar()`.

---

## world.js

**Responsabilidade:** Chunks, geração de terreno, iluminação 15 níveis, dimensões, estruturas, fluidos, crops.

**Importa:** `constants.js`, `utils.js`.

**Classes/exports:**
- `class Chunk` — 16×16×64 voxels com `blocks` (Uint8Array) + `light` (Uint8Array, 4 bits sky + 4 bits block).
- `class World`:
  - **Multi-dimensão** (Sprint 9): `dimensao`, `_chunksOverworld`, `_chunksNether`, `trocarDimensao(novaDim)`.
  - **Geração**:
    - `alturaTerreno(x, z)` — fBM Perlin 2D.
    - `biomaEm(x, z)` — 4 biomas via temperatura+umidade Perlin.
    - `topoBioma(x, z, h)` — bloco do topo por bioma.
    - `caverna(x, y, z)` — Perlin 3D threshold.
    - `gerarChunk(cx, cz)` — overworld.
    - `_gerarChunkNether(cx, cz)` — nether (lava+glowstone).
    - `_gerarVila(c, cx, cz, baseY)` — 3 casas + spawn villager deferido.
    - `_gerarDungeon(c, cx, cz, lx, ly, lz)` — sala 5×5×4 com baú + tochas.
  - **Fluidos** (Sprint 5): `espalharFluido(x, y, z, tipo)` — BFS 4 blocos água, 2 lava.
  - **Spread** (Sprint 5): `spreadGrama(playerX, playerZ, n)` — terra exposta vira grama.
  - **Crops** (Sprint 1): `plantarSemente(x, y, z, tipo)` + `atualizarCrops()` + `colherCrop(x, y, z)`.
  - **Mudas** (Sprint 4): `plantarMuda(x, y, z)` + `atualizarMudas()` (cresce em árvore).
  - **Folha decay** (Sprint 4): `iniciarDecayFolhas(x, y, z, raio=4)`.
  - **Gravity** (Sprint 4): `aplicarGravidadeBlocos(x, y, z)` — areia cai.
  - **Lighting** (15 níveis): `recalcLuzChunk(chunk)` (skylight vertical + blocklight BFS).
  - **Estado**: `getBau`, `getFornalha`, `removerEstadoBloco`.
  - **API global**: `get/set(x, y, z, t)`, `isSolido(x, y, z)`, `getLightAt(x, y, z)`.

---

## render.js

**Responsabilidade:** Three.js scene, atlas procedural, mesh builder com AO + iluminação, sky/sol/lua/nuvens/estrelas, mão 1ª pessoa, highlight, cracks, camera shake, FOV pulse, bobbing, custom shapes (slabs/fence/ladder/door).

**Importa:** Three.js, `constants.js`, `utils.js`, `weather.js`, `state.js`.

**Tamanho:** ~1300 LOC (maior módulo).

**Classes/exports:**
- `class Renderer`:
  - `constructor(canvas)` — cria scene, camera, lights, atlas, sky.
    - Lê `state.quality` (Sprint 8): pixelRatio, antialias.
    - ACES Filmic Tonemapping + sRGB output (Sprint 8).
    - Antialiasing dinâmico, preserveDrawingBuffer pra F2 screenshot.
  - `buildChunkMesh(world, chunk)` — gera mesh. **Otimizações Sprint 6.5**:
    - Solid lookup cache (Uint8Array por block ID).
    - Skip fully-buried blocks.
    - Vertex color em Uint8 (era Float32).
    - Custom shapes (slab/fence/ladder/door/door_open) com geometria especializada.
  - `liberarChunkMesh(chunk)` — dispose explícito de geometry + nullifica arrays pra ajudar GC.
  - `contagemFacesTotal()` — perf stat (F3).
  - `atualizarAlvo(hit, progresso)` — highlight + cracks + crosshair color (mob/bloco/branco).
  - `atualizarMao(dt, batendo, ferramenta)` — animação swing.
  - `atualizarFOV(dt, correndo)` — FOV pulse no sprint (com fovBase do settings).
  - `aplicarShake(intensidade)`, `atualizarShake(dt)` — camera shake ao tomar dano.
  - `atualizarBobbing(dt, andando, sprintando)` — Sprint 1.
  - `atualizarCeu(tempoDia, playerPos)` — sky multi-stop 6-keypoints (Sprint 8), sol, lua com glow noturno, nuvens, estrelas com twinkle 4Hz.
  - `atualizarLuzesPontuais(world, playerPos)` — pool de 8 PointLights.
  - `render()`.

---

## player.js

**Responsabilidade:** Player 1ª pessoa: input, física AABB, swim, sneak, climb (ladder), fome, ar, HP, drop ao morrer, regen condicional.

**Importa:** Three.js, `constants.js`, `utils.js`, `audio.js`, `state.js`, `particles.js`, `save.js`.

**Class:**
- `class Player(camera)`:
  - `pos`, `vel`, `hp`, `fome`, `saturation`, `ar`, `xp`, `nivel`.
  - `modo: 'creative' | 'survival'`, `sneak`, `submerso`, `pausado`.
  - `efeitos`: `{speed, strength, regen}` — timestamps de poções (Sprint 3).
  - `bowCharging`, `bowCharge` — bow charge (Sprint 3).
  - `input: {fwd, side, up, sprint, jump}`.
  - `atualizar(dt, world)`:
    - Input → física AABB → swim → climb (se em ladder) → portal Nether → hunger curve real (Sprint 1) → ar → poção effects.
  - `_tocaLadder(world)` — detecta ladder pra ativar climb mode.
  - `moverEixo(world, dx, dy, dz)` — colisão eixo a eixo.
  - `colisaoBlocos(world, px, py, pz)` — AABB respeita custom shapes (slab=meia altura, fence=pillar, ladder=passa, door=chapinha).
  - `aplicarDano(d, fonte)` — drop inventário ao morrer (Sprint 1) + Protection enchantment (Sprint 3) + stat death.
  - `respawnar()`.

---

## inventory.js

**Responsabilidade:** Slots da hotbar/bag, drops por bloco/tier, crafting com workbench detection.

**Importa:** `constants.js`, `audio.js`, `state.js`.

**Classes/exports:**
- `class Inventario`:
  - `slots[36]`, `slotSel`, `armadura` (4 peças).
  - `defesaTotal()`, `equiparDoSlot(idx)`, `desequipar(peca)`.
  - `selecionar(idx)`, `adicionar(item)`, `consumirAtual()`, `contar`, `consumir`, `trocar`.
  - `melhorPicareta()`, `melhorEspada()`.
- `Drops`:
  - `podeMinerar(b, tier)`, `dropDeBloco(b, tier)`, `velocidadeQuebra(b, tier, ferr)`.
  - Drops especiais: GRAMA → terra + 15% semente, PEDRA → pedra + 2% lapis + 10% silex, FOLHA → 5% pau + 6% muda, VIDRO → vidro (sprint 4 fix).
- `Crafting`:
  - `disponiveis(inv, perto)` — filtra receitas viáveis.
  - `craftar(inv, r, perto)` — consome inputs, dá output, audio.

---

## mobs.js

**Responsabilidade:** Mobs 3D com IA: 16 espécies, modelos detalhados, A*, line-of-sight, panic, breeding, sun damage, custom dimensions.

**Importa:** Three.js, `constants.js`, `state.js`, `audio.js`, `particles.js`, `utils.js` (aStarMob).

**Tamanho:** ~1300 LOC (maior módulo após render).

**Classes/exports:**
- `TIPO_MOB` — enum de strings (16 tipos).
- `MOB_INFO` — metadata por tipo (hp, vel, hostil, dano, alcance, drops, cor, sec, flags como `pula`, `teleport`, `explode`, `amigavel`, `flutua`, `fuseSegundos`).
- `_dimsMob(tipo)` — tabela de raio + altura por tipo (AABB).
- `construirModeloMob(tipo, info)` — Group Three.js detalhado:
  - Helpers: `olhosPretos` (esclera branca + pupila preta), `olhosBrilhantes` (sclera + pupila emissiva).
  - 16 cases — cada mob com modelo único: vaca tem chifres+cauda+úbere, lobo tem orelhas pontudas+cauda longa, ghast tem 9 tentáculos pendurados, etc.
- `class Mob`:
  - **AABB collision** (Sprint 6): `colideEm(world, x, y, z)` respeita custom shapes.
  - **LOS** (Sprint 6): `podeVer(world, tx, ty, tz)` raycast cooperativo.
  - **`tomarDano(dano, kbX, kbZ)`** — knockback velocity + panic se passivo.
  - **`atualizar(dt, world, alvo)`**:
    - `desclipar` (sai de bloco se spawn ruim).
    - Pânico (foge do player em zigzag).
    - Knockback velocity decay.
    - Locomoção (regular ou pula).
    - Sunburn (zumbi/esqueleto em luz solar).
    - Snap vertical (mob flutua na água, ghast oscila).
    - Animação (pernas, braços, cabeça).
    - Head tracking (olha pro player se < 12 blocos).
    - Galinha põe ovo a cada 60-120s.
    - Stuck detection (3s sem mover → invalida path + hop).
- `class MobManager(scene)`:
  - `spawn(tipo, x, y, z, opts)`, `remover(m)`.
  - **`atualizar(dt, world, player, sun)`** — atualiza todos + tenta spawn + `tentarReproducao` + `atualizarCrias`.
  - **`tentarSpawn`** — spawn rules por light level + torch detection (Sprint 5) + dimensão (Nether só ghast).
  - **`tentarReproducao`** — pares em love mode próximos → spawn cria.
  - **A* pathfinding** (Sprint 6): hostis melee usam path se vê player E < 16 blocos.
  - **Line-of-sight cached** 0.4-0.7s.
  - **Esqueleto/Witch ranged** — atira flecha (cooldown 2.5/3s).
  - **Creeper fuse** 1.5s + foge se cat <6 blocos.
  - `maisProximo(player, alc)`, `explosao(world, cx, cy, cz, raio)`.

---

## particles.js

**Responsabilidade:** Partículas, item drops voando, XP orbs, Arrow projétil, ambient triggers.

**Importa:** Three.js, `constants.js`, `world.js`, `state.js`, `audio.js`.

**Classes/exports:**
- `class Particulas(scene)`:
  - `spawnQuebra(cx, cy, cz, blocoTipo)` — faíscas ao quebrar.
  - `spawnSmoke(cx, cy, cz)` — fumaça da fornalha.
  - `spawnLavaSpark(cx, cy, cz)` — centelhas de lava.
  - `spawnSprintDust(x, y, z)` — poeira ao sprintar (Sprint 4).
  - `spawnCritStars(cx, cy, cz)` — 7 estrelas amarelas em crítico (Sprint 4).
  - `emitirAmbient(world, player)`:
    - Smoke da fornalha ativa.
    - Lava sparks.
    - **Lava queima madeira/folha adjacente** (Sprint 5) — drop de carvão.
  - `atualizar(dt)` + cave drip ambient se player subterrâneo.
- `class XPOrb`, `spawnXPOrb`, `atualizarXpOrbs(dt, ganharXPFn)`.
- `class ItemDrop`, `spawnItemDrop`, `atualizarItemDrops(dt)`.
- `class Arrow`, `spawnArrow(origem, dir, dano, vel)`, `atualizarArrows(dt)` — projétil de bow.
- `atualizarAmbientTriggers(dt)` — toca cave drip / vento por contexto.

---

## ui.js

**Responsabilidade:** HUD em DOM, paineis, F3 debug, pause menu, criativo, tooltips, achievements toast, loading overlay, minimap 2D, damage numbers.

**Importa:** Three.js, `constants.js`, `inventory.js`, `state.js`, `audio.js`, `achievements.js`, `save.js`, `multiplayer.js`.

**Tamanho:** ~900 LOC.

**Class:**
- `class UI`:
  - `atualizar()` — re-renderiza tudo.
  - `renderHotbar`, `renderBag`, `renderArmaduraSlots`, `renderCraft`, `renderBauPainel`, `renderFornalhaPainel`, `renderCriativo`.
  - `renderBars()` — HP/fome/ar/XP com **heart shake low HP**.
  - `flashDano()`, `subtitle(texto)`, `toast(msg)`, **`toastConquista(ach)`** (Sprint 4).
  - `mostrarMorte(causa)`, `esconderMorte()`, `mostrarPause()`, `esconderPause()`.
  - `toggleF3()`, `toggleHud()`, `atualizarF3({targetBlock})` — F3 mostra player/mundo/stats/faces/online.
  - `atualizarOverlays()` — vinheta, underwater, low-hp.
  - **`mostrarLoading(msg, detalhe)` / `esconderLoading()`** (Sprint 8).
  - **`atualizarMinimap()`** (Sprint 1) — top-down 160×160 com cores por bioma + mobs como dots + player com seta.
  - `_tooltipMostrar(slot, ev)`, `_tooltipEsconder()`.
  - `spawnDamageNumber(x, y, z, dano, isCrit)` + `atualizarDamageNumbers(dt)`.

---

## save.js

**Responsabilidade:** Persistência multi-mundo em `localStorage` (schema v5) + identidade do jogador + stats globais + export/import JSON.

**Importa:** `state.js`.

**Layout localStorage:**
- `rebcm3d_player`: `{name}` — identidade persistida.
- `rebcm3d_worlds_index`: `[{name, seed, lastPlayed, modo}]` (até 12).
- `rebcm3d_world_<name>`: snapshot por mundo.
- `rebcm3d_save_v4`: legacy (auto-migrado como "Mundo Antigo").
- `rebcm3d_stats_v1`: stats globais (mobsKilled, blocksBroken, deaths, secondsPlayed, etc).

**Export:** `Save` com:
- **Identidade**: `getPlayer()`, `setPlayer(name)`.
- **Index**: `listarMundos()`, `registrarMundo(name, seed, modo)`, `apagarMundo(name)`.
- **Save**: `salvar()`, `carregarPorNome(name)`, `carregar()` (legacy).
- **Stats**: `getStats()`, `incrementarStat(key, by=1)`.
- **Compartilhar**: `exportarMundoAtual()` (download blob), `importarMundo(json)`.
- `_safeJSON(s, fb)` — wrapper que trata `JSON.parse(null)` → fallback (preveniu travamento histórico).

**Schema v5:**
```js
{
  v: 5, name, seed, playerName,
  p: {x, y, z}, slot, hp, fome, xp, nivel, td, modo,
  inv: [{sx, b, i, q}],
  arm: {cabeca, torso, pernas, botas},
  baus: [{k, slots}],
  forn: [{k, input, combustivel, output}],
  chunks: [{cx, cz, b: base64}],
  savedAt,
}
```

---

## input.js

**Responsabilidade:** Eventos keyboard/mouse + touch controls (joystick + look + botões) + pause menu handlers + settings sliders + quality selector.

**Importa:** Three.js, `state.js`, `audio.js`, `save.js`, `quality.js`.

**Exports:**
- `isTouchDevice` — boolean.
- `setActions({atacarMob, soltarArco, comerSlot, abrirPainelBau, abrirPainelFornalha, dormir})` — recebe handlers de `main.js`.
- `setupInput()`:
  - Keyboard: F1/F2/F3/F5/Tab/Esc/WASD/Espaço/Shift/Ctrl/E/C/F/Q/G/1-9.
  - Mouse: lock automático, click esq/dir, scroll pra hotbar.
  - Pause menu botões + quality selector + settings sliders (FOV/sens/volume com persistência localStorage).
- `setupTouchControls()` — joystick virtual + look-zone + botões touch.

---

## main.js

**Responsabilidade:** Entry point. Bootstrap (boot screen) + loop principal + handlers de ações de jogo + memory watchdog + portal Nether logic.

**Importa:** TUDO + Cloudflare Worker URL.

**Tamanho:** ~900 LOC.

**Funções principais:**
- `_renderBoot()` / `_renderBootSafe()` — boot screen com input nome + lista mundos.
- `_entrarNoJogo({playerName, worldName, isNew})` — fullscreen + lock + init.
- `init()` — cria todas instâncias, carrega save, configura input, inicia multiplayer + música.
- `loop(now)`:
  - Frame watchdog + memory check.
  - Player atualizar + Portal Nether check.
  - mobMgr/particulas/multiplayer atualizar.
  - Raycast bloco, crosshair color update.
  - Predictive chunk load + mesh build.
  - Loading overlay update.
  - Tick mudas/crops/spreadGrama.
  - Clima + ambient.
  - Renderer atualizarCeu/Luzes/FOV/Bobbing.
  - HUD update.
- `atacarMob()` — melee + bow charge inicia.
- `soltarArco()` — bow release com força proporcional.
- `comerSlot()` — comer ou beber poção.
- `aplicarPocao(tipo)` — efeito heal/speed/strength/regen.
- `dormir()` — pula noite.
- `abrirPainelBau/Fornalha(x, y, z)`.
- `abrirTradeVillager(mob)` — modal de trade com 4 trocas estáveis por seed.
- `encantarItemAtual()` — gasta XP + 1 LAPIS, aplica enchant no item ativo.
- `raycastBloco(world, origem, dir, alc)` — DDA voxel.
- `ganharXP(pts)`, `xpProximoNivel()`.
- `_checkMemory()` — watchdog Chrome (libera chunks se >85%).

---

## achievements.js (Sprint 4)

**Responsabilidade:** Sistema de conquistas (advancements) com persistência localStorage + toast verde grande.

**Importa:** `state.js`, `audio.js`.

**Exports:**
- `ACHIEVEMENTS` — 12 conquistas com `{titulo, desc, icone}`:
  - PRIMEIRA_MADEIRA, PRIMEIRA_PRANCHA, PRIMEIRA_PICARETA, PRIMEIRA_PEDRA, PRIMEIRO_DIAMANTE, PRIMEIRO_FORNALHA, COMER_CARNE, PRIMEIRO_MOB, CRIAR_BAU, PLANTAR_MUDA, DOMESTICAR_LOBO, TANTO_FAZ.
- `Achievements`:
  - `desbloqueada(id)`, `unlock(id)` (idempotente — só dispara 1ª vez), `reset()`.
- Dispara `state.ui.toastConquista` + `Audio.levelUp` no unlock.
- Persistência em `rebcm3d_achievements_v1` (Set serializado).

---

## weather.js (Sprint 5)

**Responsabilidade:** Sistema de clima — chuva, neve acumula, trovão, sky tinting durante chuva.

**Importa:** Three.js, `constants.js`, `state.js`, `audio.js`.

**Exports:**
- `atualizarClima(dt)` — chamado do main loop:
  - Toggle weather random (~30% chuva, 70% clear).
  - Chuva: spawn rain particles + ambient sound + chance de trovão.
  - Snow accumulation (Sprint 4): em altitude ≥30 + bioma frio, planta NEVE em cima de blocos. Tickado a cada 2s.
- `corCeuComClima(cor, sun)` — tinta sky cinza durante chuva.

---

## multiplayer.js (Sprint 8 + 8.5)

**Responsabilidade:** Multiplayer local (BroadcastChannel) + cross-device (WebSocket via Worker).

**Importa:** Three.js, `state.js`.

**Exports:**
- `Multiplayer`:
  - `iniciar()` — abre BroadcastChannel + auto-reconnect WS se room salva.
  - `_broadcast()` — envia posição+rotação+nome a 5Hz pra ambos canais.
  - `_onMsg(msg)` — recebe, spawna ghost mesh + nome flutuante (canvas sprite).
  - `atualizar(dt)` — lerp suave (k=dt*8) anti-jitter.
  - `_cleanup()` — ghosts inativos > 5s removidos + dispose de geometry/textura.
  - `conectarOnline(roomName, urlBase)` — abre WebSocket pra Worker URL com room.
  - `desconectarOnline()`.
  - `isOnline()`, `roomAtual()`, `jogadoresOnline()`.

**Constantes:**
- `WS_URL_DEFAULT` = `wss://construcao-criativa-mp.rebcm-mp.workers.dev/ws`
- `CANAL` = `'rebcm3d-multiplayer-v1'`
- `TICK_MS` = 200, `TIMEOUT_MS` = 5000

---

## quality.js (Sprint 8)

**Responsabilidade:** Detecção adaptativa de tier + presets + FPS monitor + persistência.

**Importa:** `state.js`.

**Exports:**
- `PRESETS` — 4 tiers (low/medium/high/ultra) com `{viewRadius, pixelRatio, antialias, maxMobs, maxParticles, chunkLoadBudget, chunkMeshBudget, enableSnow, enableEmissive, fovBase}`.
- `detectarTier()` — score 1-12 baseado em mobile flag + RAM (deviceMemory) + CPU (hardwareConcurrency) + GPU (UNMASKED_RENDERER_WEBGL).
- `aplicarTier(tier)` — atualiza `state.quality` + renderer.setPixelRatio em runtime.
- `inicializar()` — chamado no início de `init()`, antes do renderer.
- `tickFps(dt)` — coleta últimos 120 frames; se média < 28fps + auto + sem troca recente, baixa 1 tier.
- `carregarPreferencia()` / `salvarPreferencia(modo)` — localStorage `rebcm3d_quality_v1`.

---

## 🧪 Adicionando um módulo novo

1. Crie [`web3d/src/seu-modulo.js`](../web3d/src/) com `import { state } from './state.js';` no topo (se precisar).
2. Defina classes/funções com `export`.
3. Importe em [`main.js`](../web3d/src/main.js) onde for usado, ou em outro módulo apropriado.
4. Adicione um teste em [`scripts/test-web3d-precheck.js`](../scripts/test-web3d-precheck.js) verificando o módulo existe e tem invariantes esperadas.
5. Documente aqui neste arquivo numa nova seção.
6. Atualize [`ARCHITECTURE.md`](../ARCHITECTURE.md) se for um sistema grande.

---

*Atualizado em maio/2026 — 18 módulos JS, ~6500 LOC, 124 smoke tests.*
