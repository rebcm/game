# CLAUDE.md — Instruções para Claude Code em modo auto-continue

**Projeto:** Construção Criativa da Rebeca — 3D
**Autora:** Rebeca Alves Moreira
**Repositório:** https://github.com/rebcm/game
**Produção:** https://construcao-criativa.pages.dev

---

## 🎯 Para o agente: como trabalhar neste projeto

Este projeto foi **estruturado especificamente para você (Claude Code, ou qualquer agente de IA) operar em modo agent auto-continue**. Cada decisão arquitetural foi tomada para minimizar dependências, ambiguidade e risco de quebrar o jogo.

**Antes de começar qualquer alteração, leia este arquivo até o fim.**

---

## 🧭 Bússola: O que este jogo é

Voxel sandbox 3D **com paridade Minecraft 1.21**, totalmente em browser:

- **Single-page web app** sem build step. `web3d/index.html` carrega `web3d/src/main.js` diretamente via importmap CDN do Three.js (+ addons postprocessing).
- **Modular** com 19 arquivos `.js` em [`web3d/src/`](web3d/src/) (~28K LOC total).
- **Pixel-perfect** com fonte Press Start 2P e atlas procedural sem dependências externas.
- **Todos os blocos são opacos** — não existe transparência. Não tente reintroduzir.

**Estado atual (2026-05-09):**
- **1000 blocos** com qualidade visual premium (gradient + bevel + AO sutil)
- **210+ items** (Shield, Crossbow, Mace 1.21, Elytra, Totem, 14 poções, 11 discos, spawn eggs)
- **65 mobs** com models 3D + AI ranged dedicada (28 com AI customizada)
- **14 estruturas** geradas (Stronghold, Nether Fortress, End City, Ancient City, Trial Chamber, etc.)
- **10 biomas** (deserto, planicies, floresta, taiga, cherry_grove, mangrove_swamp, bamboo_jungle, mushroom_fields, lush_caves, snowy)
- **15 profissões villager** (farmer, butcher, fisherman, etc.)
- **17 efeitos** de status, **60 encantamentos** em 12 categorias
- **64 achievements** com persistência localStorage
- **Sky Shader Custom GLSL** + **Bloom Post-processing** + **Vignette + Color Grading**
- **Spatial Audio 3D HRTF** + **Reverb procedural** + **6 ambient loops por bioma**
- **3 dimensões**: Overworld, Nether (com Fortress), End (com Cities)

---

## 🚦 Loop de trabalho recomendado (auto-continue)

A cada ciclo do agente, siga este fluxo:

1. **Entender o pedido**
   - Se for vago, foque em melhorias **incrementais** que aproximem o jogo do Minecraft real.
   - Se for específico, identifique qual(is) módulo(s) tocar.

2. **Localizar o módulo certo** consultando [`docs/MODULES.md`](docs/MODULES.md):
   - Mundo, blocos, geração, estruturas, fluidos, crops, tree growth → [`web3d/src/world.js`](web3d/src/world.js)
   - Render 3D, atlas, sky shader, mesh, bloom, postprocessing → [`web3d/src/render.js`](web3d/src/render.js)
   - Movimento, física, HP/fome, mounts, elytra glide, efeitos → [`web3d/src/player.js`](web3d/src/player.js)
   - Mobs, IA, spawn rules, AI ranged, models 3D → [`web3d/src/mobs.js`](web3d/src/mobs.js)
   - Inventário, crafting, drops → [`web3d/src/inventory.js`](web3d/src/inventory.js)
   - HUD, paineis, F3, status effects sidebar, criativo → [`web3d/src/ui.js`](web3d/src/ui.js)
   - Save / Load multi-mundo → [`web3d/src/save.js`](web3d/src/save.js)
   - Input (teclado/mouse/touch) → [`web3d/src/input.js`](web3d/src/input.js)
   - Audio: wrapper SFX + Spatial Audio 3D HRTF + reverb → [`web3d/src/audio.js`](web3d/src/audio.js); SFX inline em [`web3d/index.html`](web3d/index.html)
   - Particles (smoke, leaf, snow, pollen, spark, arrow, drop) → [`web3d/src/particles.js`](web3d/src/particles.js)
   - Achievements (64 conquistas) → [`web3d/src/achievements.js`](web3d/src/achievements.js)
   - Weather (chuva, neve, lightning) → [`web3d/src/weather.js`](web3d/src/weather.js)
   - Multiplayer cross-device → [`web3d/src/multiplayer.js`](web3d/src/multiplayer.js)
   - Quality auto-detect + FPS monitor → [`web3d/src/quality.js`](web3d/src/quality.js)
   - Chunk gen async via Worker thread → [`web3d/src/chunkgen-worker.js`](web3d/src/chunkgen-worker.js)
   - Bootstrap + loop principal + handlers → [`web3d/src/main.js`](web3d/src/main.js)

3. **Editar com cuidado**
   - Mantenha imports/exports consistentes — ES modules nativos.
   - Imports são relativos com `./modulo.js` (sempre com extensão `.js`).
   - Estado compartilhado vai em [`web3d/src/state.js`](web3d/src/state.js): `state.world`, `state.player`, `state.ui`, etc.
   - **Não introduza dependências novas** além de Three.js (já no importmap).
   - **Não adicione build step.** O projeto é run-direct.

4. **Validar antes de continuar**
   ```bash
   # Sintaxe de cada módulo
   for f in web3d/src/*.js; do node --check "$f"; done

   # Smoke tests (124 invariantes)
   TMPDIR=$(mktemp -d) && cp -R web3d/* "$TMPDIR/" && \
     cp scripts/test-web3d-precheck.js "$TMPDIR/_p.js" && \
     ( cd "$TMPDIR" && node ./_p.js . ) && rm -rf "$TMPDIR"
   ```

5. **Commitar com mensagem descritiva** seguindo o padrão dos commits anteriores:
   ```
   feat(web3d): <descrição curta>

   <corpo opcional explicando contexto>

   Autoria: Rebeca Alves Moreira.
   Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
   ```

6. **Deploy automático**
   - `git push origin main` → GitHub Actions roda `scripts/deploy-web3d.sh` → Cloudflare Pages.

---

## 🚫 NÃO FAÇA

- **Não reintroduza transparência** em blocos. Vidro/folha/água/tocha são todos opacos. Smoke test falha se vir `transp:true`.
- **Não restaure `web3d/game.js`**. O jogo é modular agora.
- **Não adicione `package.json`** na raiz. Smoke tests/dev local não dependem de npm.
- **Não fragmente módulos pequenos demais** — se algo cabe em um módulo existente sem inflar, mantenha lá.
- **Não commit `.env`** (tem credenciais Cloudflare).
- **Não remova "Rebeca Alves Moreira"** dos créditos visíveis.
- **Não introduza React/Vue/jQuery/CSS framework**. Vanilla JS + Three.js.
- **Não use TypeScript / JSX / Babel**. ES2022 puro.
- **Não toque no `app/`, `lib/`, `android/`, `ios/`** se sobrarem (são legados em `.gitignore`).

---

## ✅ PODE FAZER LIVREMENTE

- Criar **novos módulos** em `web3d/src/` se um sistema novo justifica (ex.: `weather.js`).
- Adicionar **novos blocos** em [`constants.js`](web3d/src/constants.js) — adicione cor no atlas em [`render.js`](web3d/src/render.js).
- Adicionar **novos mobs** em [`mobs.js`](web3d/src/mobs.js) (modelo + IA).
- Adicionar **novas receitas** em [`constants.js`](web3d/src/constants.js) RECEITAS.
- Adicionar **novos SFX** em [`index.html`](web3d/index.html) (`window.rebcm.sfx`) e expor wrapper em [`audio.js`](web3d/src/audio.js).
- Otimizar mesh builder (greedy meshing, LOD, etc).
- Implementar **Perlin/Simplex** real em `utils.js` ou `world.js`.
- Adicionar estruturas (vilas, dungeons) na geração de chunks.
- Adicionar weather (chuva, neve) em `render.js` + `state.js`.
- Adicionar pathfinding A* em `mobs.js`.

---

## 🧪 Verificações obrigatórias

Antes de cada commit, garanta:

- [ ] `node --check web3d/src/*.js` passa em todos
- [ ] Smoke tests passam (`93 passaram   0 falharam`)
- [ ] `index.html` aponta pra `src/main.js` (não `game.js` antigo)
- [ ] Sem `transp:true` em `constants.js`
- [ ] Sem `meshT/positionsT` em `render.js`
- [ ] Sem `KeyT` (alternar transparência) em `input.js`
- [ ] Autoria "Rebeca Alves Moreira" preservada em README

---

## 🗺 Estrutura completa do repositório

```
game/
├── README.md
├── CLAUDE.md            # ← VOCÊ ESTÁ AQUI (auto-continue)
├── AGENTS.md            # Regras detalhadas pra agentes
├── ARCHITECTURE.md      # Arquitetura técnica
├── .env.example         # Template de credenciais
├── .gitignore
├── .github/workflows/
│   └── deploy.yml       # Deploy automático Cloudflare Pages
├── docs/
│   ├── MODULES.md       # Referência de cada módulo
│   ├── walkthrough.md   # Como jogar
│   └── SETUP.md         # Setup local
├── scripts/
│   ├── deploy-web3d.sh  # Script de deploy
│   └── test-web3d-precheck.js  # 93 smoke tests
└── web3d/
    ├── index.html
    ├── style.css
    ├── manifest.json
    ├── _headers
    ├── favicon.svg / .png
    └── src/             # 14 módulos JS
```

---

## 🛠 Comandos rápidos

```bash
# Rodar local
cd web3d && python3 -m http.server 8000

# Validar sintaxe de todos módulos
for f in web3d/src/*.js; do node --check "$f"; done

# Smoke tests
TMPDIR=$(mktemp -d) && cp -R web3d/* "$TMPDIR/" && \
  cp scripts/test-web3d-precheck.js "$TMPDIR/_p.js" && \
  ( cd "$TMPDIR" && node ./_p.js . ) && rm -rf "$TMPDIR"

# Deploy
set -a; source .env; set +a
./scripts/deploy-web3d.sh

# Commit padrão
git add -A
git commit -m "$(cat <<EOF
feat(web3d): <descricao>

Autoria: Rebeca Alves Moreira.
Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
git push origin main
```

---

## 🎯 Auto-continue: o que evoluir

Em ordem de prioridade para fidelidade ao Minecraft real:

1. **Greedy meshing** em [`render.js`](web3d/src/render.js) — performance massiva em mobile.
2. **Perlin/Simplex 2D+3D** em [`utils.js`](web3d/src/utils.js) — terreno menos "ondulado" que senoides.
3. **Skylight propagação lateral** em [`world.js`](web3d/src/world.js) — luz mais realista nas bordas de cavernas.
4. **Estruturas geradas**: vilas, dungeons, ravinas em [`world.js`](web3d/src/world.js).
5. **Pathfinding A*** em [`mobs.js`](web3d/src/mobs.js) — mobs evitam buracos e seguem você melhor.
6. **Weather**: chuva, neve, trovões em [`render.js`](web3d/src/render.js) + ambient triggers em [`particles.js`](web3d/src/particles.js).
7. **Animação 1ª pessoa rica**: bobbing ao andar, swing por ação.
8. **Combate avançado**: arco/flecha (item ITEM.ARCO), shield, attack cooldown bar.

Cada um desses pode ser feito em uma sessão de auto-continue de poucas centenas de LOC.

---

## 🧠 Memória cruzada (caso já tenha trabalhado aqui antes)

- **Versão atual**: web3d/ Three.js (legados Flutter foram removidos em maio/2026).
- **Save schema**: `v4` (em `constants.js#SAVE_KEY`). Bumpa quando o formato muda.
- **Smoke tests**: 93 invariantes em `scripts/test-web3d-precheck.js`. Se você adicionar um novo invariante crítico, **adicione um teste lá**.
- **Iluminação**: já implementada (skylight vertical + blocklight BFS por chunk).
- **Mobs**: 11 espécies (vaca, galinha, porco, ovelha, lobo, zumbi, esqueleto, aranha, creeper, slime, enderman).

---

## 💬 Comunicação com o usuário

- **Português brasileiro** em mensagens, comentários, identifiers de domínio.
- **Inglês** em APIs Three.js / padrões de programação consagrados (clamp, hash, mesh).
- **Concisão**: não verbalize cada arquivo lido; só resuma resultados.

---

## 🚨 Em caso de emergência

Se você quebrou o jogo e não consegue consertar, faça **revert do último commit**:

```bash
git revert HEAD --no-edit
git push origin main
```

A produção rebobina automaticamente via Cloudflare Pages.

---

*Boa codificação. O foco é construir um jogo cada vez mais fiel ao Minecraft, mantendo simplicidade arquitetural.*
