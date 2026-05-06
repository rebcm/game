# 📦 Referência de Módulos

**Projeto:** Construção Criativa da Rebeca — 3D
**Autora:** Rebeca Alves Moreira

Este documento descreve cada módulo em [`web3d/src/`](../web3d/src/) com responsabilidade, dependências e principais exports. Use como mapa para navegar pelo código.

---

## 🔗 Grafo de dependências

```
                    ┌──────────┐
                    │ state.js │ (depende de NADA)
                    └─────┬────┘
                          │ (importado por todos)
                          ▼
┌──────────────┐    ┌──────────────┐    ┌──────────┐
│ constants.js │←───│   utils.js   │    │ audio.js │
└──────┬───────┘    └──────┬───────┘    └────┬─────┘
       │ (importados por todos)              │
       ▼                                     ▼
┌──────────────┐    ┌──────────────┐    ┌──────────┐    ┌──────────┐
│   world.js   │    │ inventory.js │    │  save.js │    │   ui.js  │
└──────┬───────┘    └──────────────┘    └──────────┘    └──────────┘
       │
       ▼
┌──────────────┐
│  render.js   │
└──────┬───────┘
       │
       ▼
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  player.js   │    │   mobs.js    │    │ particles.js │
└──────────────┘    └──────────────┘    └──────────────┘
                          │
                          ▼
                    ┌──────────┐    ┌──────────┐
                    │ input.js │←──→│  main.js │
                    └──────────┘    └──────────┘
                                          │
                                          ▼
                                  [Inicializa tudo]
```

---

## constants.js

**Responsabilidade:** Constantes do mundo, blocos, itens, receitas. Imutável.

**Sem dependências.**

**Exports principais:**
- `CHUNK_SIZE`, `WORLD_Y`, `VIEW_RADIUS` — dimensões.
- `PLAYER_HEIGHT`, `PLAYER_RADIUS`, `GRAVIDADE`, `VEL_*` — física.
- `DIA_SEGUNDOS`, `SAVE_KEY` — tempo e save.
- `BLOCO` — IDs (0–25).
- `BLOCO_INFO` — metadata (`nome`, `solido`, `emiteLuz`, `cor`, `lateral`). **Não tem `transp` mais.**
- `ICONE` — emoji por bloco.
- `ITEM`, `ITEM_INFO` — itens (comida, ferramentas, armaduras).
- `RECEITAS` — array de receitas de crafting.

---

## utils.js

**Responsabilidade:** Funções puras utilitárias.

**Importa:** `constants.js`.

**Exports principais:**
- `hash2(x, z, salt)`, `hash3(x, y, z, salt)` — hashes determinísticos para geração.
- `clamp(v, lo, hi)`.
- `chunkKey(cx, cz)` — chave única no Map de chunks.
- `materialDeBloco(b)` — categoria de pisar (grama/pedra/madeira/etc) para SFX.
- `AO_OFFSETS` — tabela de offsets de vizinhos para AO.
- `vertexAOValor(world, sx, sy, sz, off3)` — calcula AO 0–3 para um vértice.
- `uvCelula(atlas, idx)` — coordenadas UV de uma célula no atlas.

---

## state.js

**Responsabilidade:** Estado global compartilhado entre módulos.

**Sem dependências.**

**Export:** objeto `state` com:
- `renderer`, `world`, `player`, `inv`, `ui`, `mobMgr`, `particulas` — instâncias (preenchidas em `main.init()`).
- `tempoDia`, `chunkLoadOrcamento`, `fpsAcc`, `fpsTimer` — runtime.
- `dropEntidades`, `xpOrbs` — entidades flutuantes.
- `bauAtivoCoords`, `fornalhaAtivaCoords` — paineis de blocos funcionais.
- `ambientAcc` — acumulador de ambient triggers.

**Padrão de uso:** `import { state } from './state.js'` e ler/escrever `state.world.foo()`.

---

## audio.js

**Responsabilidade:** Wrapper sobre `window.rebcm.sfx` (definido inline em `index.html`).

**Sem dependências de outros módulos.**

**Export:** objeto `Audio` com métodos:
- Mundo: `quebrar()`, `colocar()`.
- Combate: `atacar()`, `hit()`, `hurt()`, `critical()`.
- Comer: `comer()`, `eatCrunch()`.
- Movimento: `passo(material)`, `splash()`, `bolha()`.
- Progressão: `levelUp()`, `pickup()`, `xpOrb()`, `explosao()`.
- Mobs: `zumbi()`, `esqueleto()`, `creeperHiss()`, `aranha()`, `vaca()`, `ovelha()`, `porco()`, `galinha()`, `lobo()`, `slime()`, `endermanTeleport()`, `mobCall(tipo)`.
- Ambient: `caveDrip()`, `caveAmbient()`, `vento()`.
- UI: `chestOpen()`, `chestClose()`, `bowDraw()`, `bowRelease()`, `arrow()`, `equipArmor()`, `cama()`, `fornalhaLit()`, `pageFlip()`.
- Música: `musicaIniciar()`, `musicaParar()`.

---

## world.js

**Responsabilidade:** Chunks, geração de terreno, iluminação 15 níveis.

**Importa:** `constants.js`, `utils.js`.

**Classes/exports:**
- `class Chunk` — 16×16×64 voxels com `blocks` + `light` (skylight + blocklight em 1 byte).
  - `get/set(lx, y, lz, t)`.
  - `getLightSky/Block(lx, y, lz)`, `setLightCombinado(lx, y, lz, sky, block)`.
- `class World` — gerenciador de chunks + estados de baú/fornalha.
  - `getChunk/hasChunk(cx, cz)`.
  - `get/set(x, y, z, t)` global.
  - `isSolido(x, y, z)`.
  - `alturaTerreno`, `topoBioma`, `caverna`, `gerarChunk` — geração.
  - `recalcLuzChunk(chunk)` — calcula luz do chunk inteiro.
  - `getLightAt(x, y, z)` → `{sky, block}`.
  - `getBau`, `getFornalha`, `removerEstadoBloco` — estados.

---

## render.js

**Responsabilidade:** Three.js scene, atlas, mesh builder, sky, sol/lua, nuvens, estrelas, mão 1ª pessoa, highlight, cracks, camera shake.

**Importa:** Three.js, `constants.js`, `utils.js`.

**Classes/exports:**
- `class Renderer`:
  - `constructor(canvas)` — cria scene, camera, lights, atlas, sky, mão.
  - `buildChunkMesh(world, chunk)` — gera mesh do chunk com AO + iluminação.
  - `liberarChunkMesh(chunk)`.
  - `atualizarAlvo(hit, progresso)` — highlight + cracks.
  - `atualizarMao(dt, batendo, ferramenta)` — animação swing.
  - `atualizarFOV(dt, correndo)` — FOV pulse no sprint.
  - `aplicarShake(intensidade)`, `atualizarShake(dt)` — camera shake ao tomar dano.
  - `atualizarCeu(tempoDia, playerPos)` — sol, lua, nuvens, estrelas, fog, cor de céu.
  - `atualizarLuzesPontuais(world, playerPos)` — pool de 8 PointLights.
  - `render()`.

---

## player.js

**Responsabilidade:** Player 1ª pessoa: input, física AABB, swim, sneak, fome, ar, HP.

**Importa:** Three.js, `constants.js`, `utils.js`, `audio.js`, `state.js`.

**Class:**
- `class Player(camera)`:
  - `pos`, `vel`, `hp`, `fome`, `saturation`, `ar`, `xp`, `nivel`.
  - `modo: 'creative' | 'survival'`, `sneak`, `submerso`, `pausado`.
  - `input: {fwd, side, up, sprint, jump}`.
  - `atualizar(dt, world)` — input → física → fome/ar/regen.
  - `moverEixo(world, dx, dy, dz)` — colisão eixo a eixo.
  - `colisaoBlocos(world, px, py, pz)` — AABB.
  - `aplicarDano(d, fonte)`, `respawnar()`.

---

## inventory.js

**Responsabilidade:** Slots da hotbar/bag, drops por bloco/tier, crafting.

**Importa:** `constants.js`, `audio.js`, `state.js`.

**Classes/exports:**
- `class Inventario`:
  - `slots[36]`, `slotSel`, `armadura`.
  - `defesaTotal()`, `equiparDoSlot(idx)`, `desequipar(peca)`.
  - `selecionar(idx)`, `adicionar(item)`, `consumirAtual()`, `contar`, `consumir`, `trocar`.
  - `melhorPicareta()`, `melhorEspada()`.
- `Drops`: `podeMinerar(b, tier)`, `dropDeBloco(b, tier)`, `velocidadeQuebra(b, tier, ferr)`.
- `Crafting`: `disponiveis(inv, perto)`, `craftar(inv, r, perto)`.

---

## mobs.js

**Responsabilidade:** Mobs 3D com IA: 11 espécies, modelo, comportamentos especiais, spawn por luz.

**Importa:** Three.js, `constants.js`, `state.js`, `audio.js`.

**Classes/exports:**
- `TIPO_MOB` — enum de strings.
- `MOB_INFO` — metadata por tipo (hp, vel, hostil, dano, alcance, drops, cor, sec, flags como `pula`, `teleport`, `explode`, `amigavel`).
- `construirModeloMob(tipo, info)` — Group Three.js com pivots para animação.
- `class Mob(tipo, x, y, z)`:
  - `atualizar(dt, world, alvo)` — movimento, animação, comportamentos especiais.
- `class MobManager(scene)`:
  - `spawn(tipo, x, y, z)`, `remover(m)`.
  - `atualizar(dt, world, player, sun)` — atualiza todos + tenta spawn.
  - `tentarSpawn` — spawn rules por light level (paridade Minecraft).
  - `maisProximo(player, alc)`, `explosao(world, cx, cy, cz, raio)`.

---

## particles.js

**Responsabilidade:** Partículas, item drops voando, XP orbs visíveis, ambient triggers.

**Importa:** Three.js, `constants.js`, `world.js`, `state.js`, `audio.js`.

**Classes/exports:**
- `class Particulas(scene)`:
  - `spawnQuebra(cx, cy, cz, blocoTipo)` — faíscas ao quebrar bloco.
  - `spawnSmoke(cx, cy, cz)` — fumaça da fornalha.
  - `spawnLavaSpark(cx, cy, cz)` — centelhas de lava aberta.
  - `emitirAmbient(world, player)` — chamado a cada 0.4s no `atualizar`.
  - `atualizar(dt)`.
- `spawnItemDrop(drop, x, y, z)`, `atualizarItemDrops(dt)`.
- `spawnXPOrb(valor, x, y, z)`, `atualizarXpOrbs(dt, ganharXPFn)`.
- `atualizarAmbientTriggers(dt)` — toca cave drip / vento por contexto.

---

## ui.js

**Responsabilidade:** HUD (DOM), paineis, F3 debug, pause menu, criativo, tooltips.

**Importa:** `constants.js`, `inventory.js`, `state.js`, `audio.js`.

**Class:**
- `class UI`:
  - `atualizar()` — re-renderiza tudo.
  - `renderHotbar`, `renderBag`, `renderArmaduraSlots`, `renderCraft`, `renderBauPainel`, `renderFornalhaPainel`, `renderCriativo`.
  - `renderBars()` — HP/fome/ar com heart shake low HP.
  - `flashDano()`, `subtitle(texto)`, `toast(msg)`.
  - `mostrarMorte(causa)`, `esconderMorte()`.
  - `mostrarPause()`, `esconderPause()`.
  - `toggleF3()`, `toggleHud()`, `atualizarF3({targetBlock})`.
  - `atualizarOverlays()` — vinheta, underwater, low-hp.
  - `_tooltipMostrar(slot, ev)`, `_tooltipEsconder()`.

---

## save.js

**Responsabilidade:** Persistência em `localStorage` (schema v4).

**Importa:** `constants.js`, `world.js`, `state.js`.

**Export:** `Save` com `salvar()`, `carregar()`, `apagar()`.

Formato `v4`:
```js
{
  v: 4, seed,
  p: {x, y, z}, slot, hp, fome, xp, nivel, td, modo,
  inv: [{sx, b, i, q}],
  arm: {cabeca, torso, pernas, botas},
  baus: [{k, slots}],
  forn: [{k, input, combustivel, output}],
  chunks: [{cx, cz, b: base64}],
}
```

---

## input.js

**Responsabilidade:** Eventos de keyboard/mouse + touch controls (joystick + look + botões).

**Importa:** Three.js, `state.js`, `audio.js`, `save.js`.

**Exports:**
- `isTouchDevice` — boolean.
- `setActions({atacarMob, comerSlot, ...})` — recebe handlers de `main.js`.
- `setupInput()` — keyboard + mouse + UI buttons + pause menu.
- `setupTouchControls()` — joystick, look-zone, botões touch.

---

## main.js

**Responsabilidade:** Entry point. Bootstrap + loop principal + handlers de ações de jogo.

**Importa:** TUDO.

**Funções principais:**
- `init()` — cria todas as instâncias, carrega save, configura input.
- `loop(now)` — atualiza física, mobs, partículas, raycast, render.
- `atacarMob()`, `comerSlot()`, `dormir()` — ações.
- `abrirPainelBau(x, y, z)`, `abrirPainelFornalha(x, y, z)`.
- `raycastBloco(world, origem, dir, alc)` — DDA voxel.
- `ganharXP(pts)`, `xpProximoNivel()`.
- Handler do botão `#play` — fullscreen + lock pointer + init().

---

## 🧪 Adicionando um módulo novo

Quando criar um módulo novo (ex.: `weather.js`):

1. Crie [`web3d/src/weather.js`](web3d/src/) com `import { state } from './state.js';` no topo.
2. Defina classes/funções com `export`.
3. Importe em [`main.js`](../web3d/src/main.js) onde for usado.
4. Adicione um teste em [`scripts/test-web3d-precheck.js`](../scripts/test-web3d-precheck.js) verificando o módulo existe e tem invariantes esperadas.
5. Documente aqui neste arquivo.

---

*Atualizado em maio/2026.*
