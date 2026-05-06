# Instruções para Agentes — Sub-diretório `rebcm/game/`

**Autora:** Rebeca Alves Moreira

> Este sub-diretório é histórico. A documentação principal está na raiz.

---

## 📚 Veja a documentação principal

- [`../../AGENTS.md`](../../AGENTS.md) — regras completas para agentes
- [`../../docs/CLAUDE.md`](../../docs/CLAUDE.md) — contexto rápido para Claude Code
- [`../../README.md`](../../README.md) — visão geral

---

## 🎯 Resumo

- **Versão ativa do jogo:** Three.js em [`../../web3d/`](../../web3d/)
- **Não editar `app/lib/` (Flutter)** — é legado.
- **Sem build step** — `index.html` carrega `game.js` direto.
- **Validar com:** `cp web3d/game.js /tmp/check.mjs && node --check /tmp/check.mjs`
- **Deploy:** `./scripts/deploy-web3d.sh` (precisa `.env` com Cloudflare creds).

---

*Atualizado em maio/2026.*
