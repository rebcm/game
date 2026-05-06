# CLAUDE.md — Instruções para Claude Code e outros agentes de IA

**Projeto:** Construção Criativa da Rebeca
**Autora:** Rebeca Alves Moreira
**Versão atual:** Web3D (Three.js)

---

## 🎯 Propósito

Este documento dá contexto para agentes de IA (Claude Code, Cursor, Copilot Chat, etc.) que vão editar o projeto. Para a documentação completa, veja [`../AGENTS.md`](../AGENTS.md) — este aqui é só um resumo das informações essenciais.

---

## 📍 O que importa saber

1. **Versão ativa: `web3d/`** (Three.js + WebGL puro). A versão `app/`/`lib/` (Flutter 2D) é legado.
2. **Arquivo único:** todo o motor 3D vive em [`web3d/game.js`](../web3d/game.js) (~4200 linhas).
3. **Sem build step:** `index.html` carrega `game.js` direto via importmap CDN.
4. **`package.json` da raiz está vazio.** Para validar sintaxe: copie `web3d/game.js` para `/tmp/check.mjs` e rode `node --check`.
5. **`AGENTS.md` original (pré-2026)** dizia "criativo puro, sem mobs/morte". Essa regra **foi superada** — agora survival + mobs é desejável e já está implementado.

---

## 🛠 Comandos comuns

```bash
# Rodar local
cd web3d && python3 -m http.server 8000

# Validar sintaxe
cp web3d/game.js /tmp/check.mjs && node --check /tmp/check.mjs

# Smoke test pré-deploy
node scripts/test-web3d-precheck.js web3d

# Deploy (precisa CLOUDFLARE_API_TOKEN no .env)
set -a; source .env; set +a
./scripts/deploy-web3d.sh
```

---

## 🚫 NÃO faça

- Não fragmente `game.js` em vários módulos.
- Não adicione build pipeline (Webpack/Vite/Rollup).
- Não introduza React, Vue, jQuery, ou framework CSS.
- Não toque em `app/lib/` a menos que o usuário peça explicitamente — é legado.
- Não commit o `.env` (tem credenciais Cloudflare).
- Não remova `Rebeca Alves Moreira` dos créditos.

---

## ✅ Pode fazer livremente

- Adicionar features na direção de paridade com Minecraft real.
- Editar `web3d/game.js`, `web3d/style.css`, `web3d/index.html`.
- Adicionar novos blocos, mobs, receitas, mecânicas.
- Otimizar performance (greedy meshing, frustum culling, etc).
- Atualizar documentação `.md`.

---

## 📚 Documentação relacionada

- [`../README.md`](../README.md) — visão geral pública
- [`../AGENTS.md`](../AGENTS.md) — regras detalhadas pra agentes
- [`../ARCHITECTURE.md`](../ARCHITECTURE.md) — arquitetura técnica
- [`./SETUP.md`](./SETUP.md) — setup de desenvolvimento
- [`./walkthrough.md`](./walkthrough.md) — passo-a-passo do jogo
