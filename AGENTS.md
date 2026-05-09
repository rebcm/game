# AGENTS.md — Regras detalhadas para agentes de IA

**Projeto:** Construção Criativa da Rebeca — 3D
**Autora:** Rebeca Alves Moreira
**Versão atual:** Web3D modular (Three.js + addons postprocessing + ES modules nativos) + Cloudflare Worker pra multiplayer
**Última grande atualização:** maio/2026 — paridade Minecraft 1.21 + qualidade visual premium + áudio 3D HRTF
**Estado atual:** 1000 blocos · 210+ items · 65 mobs · 14 estruturas · 10 biomas · 60 encantamentos · 17 efeitos · 64 achievements · 124/124 testes ✓

---

## 🎯 Missão

Evoluir o jogo voxel **Construção Criativa** em direção a paridade visual e mecânica com Minecraft real, mantendo:

- **Estabilidade absoluta** em produção (https://construcao-criativa.pages.dev).
- **Performance fluida** em mobile (sistema adaptive quality cobre low-end Android até desktop ultra).
- **Modularidade** que permite auto-continue por agentes de IA.
- **Zero infraestrutura** que custe dinheiro — tudo no free tier do Cloudflare.

A versão **ativa e única** está em [`web3d/`](web3d/) (jogo) + [`worker/`](worker/) (multiplayer). Sem Flutter, sem build step, sem dependências runtime extras além de Three.js via CDN.

---

## 📜 Regras invioláveis

1. **Autoria preservada.** "Rebeca Alves Moreira" deve aparecer:
   - na tela inicial de boot (boot card),
   - no [`README.md`](README.md),
   - em mensagens de commit relevantes (`Autoria: Rebeca Alves Moreira.` na linha final do corpo).

2. **Código que funciona.** Sem TODO/FIXME/HACK no código mergeado. Cada feature roda completa.

3. **Modular.** Engine vive em [`web3d/src/*.js`](web3d/src/) com 19 módulos (~28K LOC total). Módulos grandes (render.js ~9K LOC, mobs.js ~3K LOC, constants.js ~3.5K LOC, main.js ~3.3K LOC) refletem a complexidade legítima de cada domínio. Adicione novos arquivos quando justificar.

4. **Sem build step.** `index.html` carrega `src/main.js` diretamente. Sem Webpack/Vite/Rollup/TypeScript/JSX/Babel.

5. **Sem deps runtime extras.** Só Three.js (+ addons postprocessing) via importmap CDN. Sem React/Vue/jQuery/Lodash.
   - **Exceção 1**: `wrangler` (CLI Cloudflare) só pra deploy — não roda em produção.
   - **Exceção 2**: nada novo no `worker/` além de Cloudflare Workers runtime (já tem WebSocket nativo + Durable Objects).

6. **Sem transparência em blocos.** Vidro/folha/água/tocha são todos opacos. Smoke test impede regressão (verifica `transp:true` ausente em `constants.js`).

7. **Validar antes de commitar:**
   - `node --check web3d/src/*.js` (cada módulo)
   - smoke tests em `scripts/test-web3d-precheck.js` — **124 invariantes atualmente**, podem crescer.

8. **`package.json` está intencionalmente ausente** na raiz. Não criar. (Smoke tests rodam via mktemp pra evitar resolver de Node subir a árvore.)

9. **Mobile-first.** Mudanças devem rodar em celular Android médio em modo paisagem. Sistema adaptive quality já protege automaticamente — mas grandes refatores requerem teste manual em mobile.

11. **Defensive code obrigatório** para features visuais/audio modernas (sky shader GLSL, Bloom postprocessing, Web Audio API, AudioContext). Wrap em `try/catch` com fallback gracioso e log único — **nunca** quebrar o init do jogo se a feature opcional falhar em alguma GPU/browser.

12. **Não importar módulos via window.X.** Sempre `import * as THREE from 'three'`, etc. Se precisar de THREE em outro módulo, importe lá — não dependa de globals injetados.

10. **Free tier sempre.** Não introduzir features que exijam paid tier (Cloudflare Workers Paid Plan, KV pago, R2, etc.). Atualmente:
    - Pages free tier (web3d/) — ilimitado pra static.
    - Workers free tier (worker/) — 100k req/dia, Durable Objects SQLite-backed.

---

## ✅ O que pode evoluir (livre)

Categorias que CABEM no escopo + têm impacto:

- **Iluminação**: skylight lateral mais sofisticada, smooth lighting (suavização entre vértices).
- **Geração**: novos biomas (swamp, desert oasis), mais estruturas (mineshafts com rails, fortresses), Strongholds.
- **Mobs**: novos tipos (Snow Golem, Pillager, Wandering Trader), behaviors mais ricos (mob in love → segue parceiro, villager se esconde à noite).
- **Combate**: shield, attack cooldown bar, parry, crit chance baseada em arma.
- **Visual**: greedy meshing (tem limitação UV — precisa solução pra texture array), shadow mapping, postprocessing (bloom).
- **Áudio**: música por bioma, 3D positional pra mob calls, voice for villager.
- **UI/UX**: tutorial inicial, achievement screen completa, stats screen com gráfico, leaderboard online.
- **World mechanics**: redstone básica, fogo se espalha (precisa de BLOCO.FOGO), bone meal accelera growth.
- **Multiplayer**: chat (UI + Worker já suporta relay), sync de chunks alterados (já tem sync de posição).
- **Conteúdo**: brewing stand UI completa (atualmente poções via crafting), enchanted books, item durability, Iron Golem spawn perto de villagers, snow biome com igloos.

---

## 🚫 Fora do escopo (NÃO fazer)

- **Microtransações, ads, telemetria não-essencial.**
- **Backend persistente** (servidor de jogo). MP é só sync visual via Worker.
- **CSS frameworks** (Tailwind, Bootstrap). HTML/CSS direto.
- **Conteúdo NSFW, mods de violência gráfica, etc.**
- **Quebra de retrocompatibilidade do save** sem migração explícita (atualmente schema v5 com auto-migração de v4).

**Antes restrito, AGORA dentro do escopo (atualizar mente):**
- ~~Multiplayer / netcode~~ → Sprint 8 + 8.5 entregues. Há Worker em produção.
- ~~Nether / End~~ → Sprint 9 entregou Nether. End pode ser próximo se justificar.
- ~~Redstone~~ → ainda fora (complexo demais por enquanto). Mas pode ser se alguém implementar com cuidado.

---

## 🛠 Comandos essenciais

```bash
# Dev local (jogo)
cd web3d && python3 -m http.server 8000
# Dev local com porta alternativa (caso 8000 ocupada)
cd web3d && python3 -m http.server 8001

# Validação completa
for f in web3d/src/*.js; do node --check "$f"; done

# Smoke tests (124 invariantes atualmente)
TMPDIR=$(mktemp -d) && cp -R web3d/* "$TMPDIR/" && \
  cp scripts/test-web3d-precheck.js "$TMPDIR/_p.js" && \
  ( cd "$TMPDIR" && node ./_p.js . ) && rm -rf "$TMPDIR"

# Deploy do jogo
set -a; source .env; set +a
./scripts/deploy-web3d.sh

# Deploy do Worker (multiplayer) — feito raramente
cd worker
set -a; source ../.env; set +a
npx -y wrangler@latest deploy
```

---

## 🧠 Convenções de estilo

- **Português brasileiro** em comentários, mensagens, identifiers de domínio (`Rebeca`, `blocos`, `mundo`, `colideEm`).
- **Inglês** em APIs Three.js e padrões de código consagrados (`mesh`, `geometry`, `BufferAttribute`, `clamp`).
- **Comentários** explicam o "porquê" (regra de negócio, paridade Minecraft, fix de bug histórico), não o "o quê" óbvio.
- **camelCase** para variáveis e funções (`tempoDia`, `materialDeBloco`, `colideEm`).
- **UPPER_SNAKE** para constantes (`CHUNK_SIZE`, `VEL_SPRINT`, `TICK_MS`).
- **PascalCase** para classes (`Player`, `World`, `MobManager`).
- **Prefixo _** para helpers/state interno (`_safeJSON`, `_renderBoot`, `state._heavyFrame`).

---

## 🧪 Anti-regressão

A cada bug que regrediu, **adicione um smoke test** em `scripts/test-web3d-precheck.js` que checa o invariante. Exemplos vivos:

- "mobs.js importa BLOCO_INFO se usa BLOCO_INFO" — preveniu travamento por import faltante.
- "_safeJSON trata null/undefined" — preveniu boot screen quebrar com localStorage vazio.
- "atacarMob detecta ITEM.ARCO (entra em charge mode)" — preveniu regressão no bow charge.

---

## 📚 Documentação relacionada

- [`README.md`](README.md) — visão geral do jogo + features completas
- [`CLAUDE.md`](CLAUDE.md) — instruções específicas para Claude Code auto-continue
- [`ARCHITECTURE.md`](ARCHITECTURE.md) — arquitetura técnica detalhada (fluxo, decisões, pipeline)
- [`docs/MODULES.md`](docs/MODULES.md) — referência de cada módulo
- [`docs/walkthrough.md`](docs/walkthrough.md) — passo-a-passo do jogo
- [`docs/SETUP.md`](docs/SETUP.md) — setup de desenvolvimento

---

*Atualizado em maio/2026 — após sprints 1-9 + 6.5 + 8.5 (multiplayer cross-device + Nether + 16 mobs + 36 blocos + sistemas adaptativos).*
