# AGENTS.md — Regras detalhadas para agentes de IA

**Projeto:** Construção Criativa da Rebeca — 3D
**Autora:** Rebeca Alves Moreira
**Versão atual:** Web3D modular (Three.js + ES modules nativos)

---

## 🎯 Missão

Evoluir o jogo voxel **Construção Criativa** em direção a paridade visual e mecânica com Minecraft real, mantendo:

- Estabilidade absoluta em produção (https://construcao-criativa.pages.dev).
- Performance fluida em mobile.
- Modularidade que permite auto-continue por agentes de IA.

A versão **ativa e única** está em [`web3d/`](web3d/). Sem Flutter, sem build step, sem dependências extras além de Three.js via CDN.

---

## 📜 Regras invioláveis

1. **Autoria preservada.** "Rebeca Alves Moreira" deve aparecer:
   - na tela inicial de boot,
   - no [`README.md`](README.md),
   - em mensagens de commit relevantes.

2. **Código que funciona.** Sem TODO/FIXME/HACK no código mergeado. Cada feature roda completa.

3. **Modular.** Engine vive em [`web3d/src/*.js`](web3d/src/) com 14 módulos. Adicione novos arquivos quando justificar; não inflar módulos existentes além de ~700 LOC.

4. **Sem build step.** `index.html` carrega `src/main.js` diretamente. Sem Webpack/Vite/Rollup/TypeScript/JSX/Babel.

5. **Sem deps runtime extras.** Só Three.js via importmap CDN. Sem React/Vue/jQuery/Lodash.

6. **Sem transparência em blocos.** Vidro/folha/água/tocha são todos opacos. Smoke test impede regressão (verifica `transp:true` ausente em `constants.js`).

7. **Validar antes de commitar:**
   - `node --check web3d/src/*.js` (cada módulo)
   - smoke tests em `scripts/test-web3d-precheck.js` (93 invariantes)

8. **`package.json` está intencionalmente ausente** na raiz. Não criar.

9. **Mobile-first.** Mudanças devem rodar em celular Android médio em modo paisagem.

---

## ✅ O que pode evoluir

- Iluminação (skylight lateral, smooth lighting).
- Geração de mundo (Perlin, biomas, vilas, dungeons, ravinas).
- Mobs (pathfinding, novos tipos, drops).
- Combate (arco/flecha, shield, attack cooldown).
- Visual (greedy meshing, weather, particles).
- Áudio (mais SFX, novas tracks ambient).
- UI/UX (achievement popups, HUD enhancements).

---

## 🚫 Fora do escopo

- Multiplayer / netcode.
- PvP / economia / trading.
- Redstone / Nether / End.
- Microtransações, ads, telemetria.
- CSS frameworks (Tailwind, Bootstrap).
- Servidor backend (o jogo é 100% client-side).

---

## 🛠 Comandos essenciais

```bash
# Dev local
cd web3d && python3 -m http.server 8000

# Validação
for f in web3d/src/*.js; do node --check "$f"; done

# Smoke tests (93 invariantes)
TMPDIR=$(mktemp -d) && cp -R web3d/* "$TMPDIR/" && \
  cp scripts/test-web3d-precheck.js "$TMPDIR/_p.js" && \
  ( cd "$TMPDIR" && node ./_p.js . ) && rm -rf "$TMPDIR"

# Deploy
set -a; source .env; set +a
./scripts/deploy-web3d.sh
```

---

## 📚 Documentação relacionada

- [`README.md`](README.md) — visão geral do jogo
- [`CLAUDE.md`](CLAUDE.md) — instruções específicas para Claude Code auto-continue
- [`ARCHITECTURE.md`](ARCHITECTURE.md) — arquitetura técnica detalhada
- [`docs/MODULES.md`](docs/MODULES.md) — referência de cada módulo
- [`docs/walkthrough.md`](docs/walkthrough.md) — passo-a-passo do jogo
- [`docs/SETUP.md`](docs/SETUP.md) — setup de desenvolvimento

---

## 🧠 Convenções de estilo

- **Português** em comentários e identifiers de domínio (`Rebeca`, `blocos`, `mundo`).
- **Inglês** em APIs Three.js e padrões de código consagrados.
- **Comentários** explicam o "porquê", não o "o quê" óbvio.
- **CamelCase** para variáveis e funções (`tempoDia`, `materialDeBloco`).
- **UPPER_SNAKE** para constantes (`CHUNK_SIZE`, `VEL_SPRINT`).
- **PascalCase** para classes (`Player`, `World`, `MobManager`).

---

*Atualizado em maio/2026 — refatoração modular completa.*
