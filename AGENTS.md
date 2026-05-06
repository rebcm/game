# AGENTS.md — Instruções para Agentes de Desenvolvimento

**Projeto:** Construção Criativa da Rebeca
**Autora:** Rebeca Alves Moreira
**Repositório:** https://github.com/rebcm/game
**Produção:** https://construcao-criativa.pages.dev

---

## 🎯 Missão

Evoluir o jogo voxel **Construção Criativa** mantendo a paridade visual e mecânica com o Minecraft real. O jogo deve permanecer **estável, divertido e leve** para rodar em qualquer celular ou desktop, sem build step e sem dependências pesadas.

A versão **ativa** está em [`web3d/`](web3d/) (Three.js + WebGL). A versão antiga em Flutter (`lib/`, `app/`) está em modo manutenção.

---

## 📜 Regras Invioláveis

1. **Autoria preservada.** O nome `Rebeca Alves Moreira` deve aparecer:
   - na tela inicial (`#boot .creditos`),
   - no `README.md`,
   - em comentários ou metadados quando relevante.

2. **Código que funciona.** Nenhum stub, TODO, mock ou implementação parcial é aceito. Toda feature comitada deve rodar de ponta a ponta.

3. **Web3D é single-file.** Todo o motor 3D vive em `web3d/game.js`. Não fragmentar em múltiplos módulos sem necessidade clara.

4. **Sem build step.** O jogo carrega via `index.html` → `game.js` direto. Não introduza Webpack, Vite, TypeScript transpilation, JSX, Babel ou qualquer pipeline que precise de `npm run build`.

5. **Sem dependências runtime extras.** Apenas o `three.js` via importmap CDN. Nada de React, Vue, jQuery, Lodash, etc.

6. **Validar antes de commitar.**
   ```bash
   node --check /tmp/check.mjs   # após copiar web3d/game.js
   ./scripts/deploy-web3d.sh     # roda smoke tests pré-deploy
   ```

7. **`package.json` está intencionalmente vazio.** A raiz do repo não usa npm. Não preencher.

8. **Mobile-first.** Toda mudança deve continuar rodando suavemente num celular Android médio em modo paisagem.

---

## ✅ O que pode evoluir livremente

A versão `web3d/` aceita expansões na direção de mais paridade com Minecraft. Os commits recentes já adicionaram **mobs, sobrevivência, armadura, baú, fornalha, XP, tela de morte, modo creative+survival** — isso é desejado e deve continuar.

Sinta-se autorizado a adicionar:

- 🌱 Iluminação 15 níveis (skylight + blocklight com flood-fill BFS)
- 🌍 Perlin/Simplex noise para terreno orgânico
- 🏘 Estruturas (vilas, dungeons, ravinas)
- 🎮 Animações 1ª pessoa mais ricas (bobbing, swing por ação)
- 🌧 Clima (chuva, neve, trovões)
- 🐺 Pathfinding A* para mobs
- 🎨 Greedy meshing para performance em mobile
- 🎵 Sons mais ricos por bioma e ação

---

## 🚫 O que evitar

- **Fragmentar `game.js` em vários arquivos** sem benefício mensurável.
- **Adicionar build pipeline** (Webpack/Vite/Rollup/etc).
- **Multiplayer / netcode** (escopo gigante, foge do propósito).
- **PvP, sistema de economia ou trading** (não é o foco).
- **Redstone, Nether, End** (escopo demais).
- **Dependências CSS frameworks** (Tailwind, Bootstrap). O `style.css` é mantido à mão pra ficar pixel-perfect.
- **Microtransações, ads, telemetria** — projeto da Rebeca, sem comércio.

---

## 🛠 Comandos Essenciais

### Rodar local
```bash
cd web3d
python3 -m http.server 8000
# Acesse http://localhost:8000
```

### Validar sintaxe
```bash
cp web3d/game.js /tmp/check.mjs
node --check /tmp/check.mjs
```

### Smoke test pré-deploy
```bash
node scripts/test-web3d-precheck.js web3d
```

### Deploy
```bash
set -a; source .env; set +a
./scripts/deploy-web3d.sh
```

---

## 🧠 Memória de Contexto (para LLM agents)

Ao trabalhar neste projeto:

- A **versão atual do jogo está em `web3d/`** — não em `app/lib/`. Edite arquivos errados é um erro comum.
- O **`AGENTS.md` original (anterior a maio/2026)** dizia "criativo puro, sem mobs/morte". Essa regra foi superada pelos commits recentes; **agora survival + mobs é desejável**.
- O **`package.json` da raiz está vazio de propósito**. `node` direto na raiz quebra; copie o arquivo pra `/tmp` e rode dali.
- O **deploy precisa de `CLOUDFLARE_API_TOKEN` e `CLOUDFLARE_ACCOUNT_ID`** no `.env`. Não commitar o `.env`.
- A **fonte pixelada do HUD** usa "Press Start 2P" do Google Fonts; se ela não carregar, o fallback é Consolas/Menlo monospace.

---

## 🧱 Convenções de Estilo

- **Português** em comentários e identifiers de domínio (Rebeca, blocos, mundo). 
- **Inglês** em APIs Three.js e padrões de código consagrados (clamp, hash, mesh).
- **Comentários explicam o "porquê"**, não o "o quê". Quando o código é óbvio, sem comentário.
- **Funções curtas**, classes coesas, sem deep inheritance.
- **Camelo** para variáveis JS (`tempoDia`, `materialDeBloco`).
- **UPPER_SNAKE** para constantes (`CHUNK_SIZE`, `VEL_SPRINT`).

---

## 📚 Documentos Relacionados

- [`README.md`](README.md) — visão geral do jogo
- [`ARCHITECTURE.md`](ARCHITECTURE.md) — arquitetura técnica
- [`docs/walkthrough.md`](docs/walkthrough.md) — passo-a-passo do jogo
- [`docs/SETUP.md`](docs/SETUP.md) — setup de ambiente local
- [`docs/deploy/procedimento-deploy.md`](docs/deploy/procedimento-deploy.md) — fluxo de deploy

---

*Atualizado em maio/2026 para refletir a migração para Three.js e o estado atual do jogo.*
