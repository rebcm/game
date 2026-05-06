# 🛠 Setup de Desenvolvimento

**Projeto:** Construção Criativa da Rebeca — 3D
**Autora:** Rebeca Alves Moreira

Como rodar o projeto localmente, validar mudanças e fazer deploy.

---

## ⚡ Setup mínimo (5 minutos)

```bash
git clone https://github.com/rebcm/game
cd game/web3d
python3 -m http.server 8000
# Acesse http://localhost:8000
```

Pronto. O jogo carrega Three.js do CDN e roda no browser. **Não há `npm install`.**

---

## 📋 Pré-requisitos

| Para... | Você precisa de... |
|---------|--------------------|
| Rodar o jogo | Apenas um browser moderno (Chrome 90+, Firefox 90+, Safari 15+, Edge 90+). |
| Validar sintaxe | Node.js 16+ (apenas para `node --check`). |
| Rodar smoke tests | Node.js 16+. |
| Deploy | Cloudflare API token + account ID. |

**Não há dependências npm.** O `package.json` é intencionalmente ausente.

---

## 🚀 Servidor local

ES modules nativos exigem HTTP — não use `file://`.

### Opção 1: Python (mais simples)
```bash
cd web3d
python3 -m http.server 8000
```

### Opção 2: Node serve
```bash
cd web3d
npx serve .
```

### Opção 3: Live reload (dev rápido)
```bash
cd web3d
npx live-server .
```

Abra `http://localhost:8000` (ou `http://127.0.0.1:8000` se pointer-lock falhar em alguns browsers).

---

## ✅ Validar mudanças

Antes de commitar, sempre rode:

### 1. Sintaxe de cada módulo

```bash
for f in web3d/src/*.js; do node --check "$f" || echo "FALHOU: $f"; done
```

Saída esperada: nada (silêncio = sucesso).

### 2. Smoke tests (93 invariantes)

```bash
TMPDIR=$(mktemp -d) && cp -R web3d/* "$TMPDIR/" && \
  cp scripts/test-web3d-precheck.js "$TMPDIR/_p.js" && \
  ( cd "$TMPDIR" && node ./_p.js . ) && rm -rf "$TMPDIR"
```

Saída esperada:
```
✓ 93 passaram   ✗ 0 falharam
✅ Tudo OK — build pronto para deploy.
```

> **Por que copiar pra `/tmp` antes?** O `.gitignore` esconde `package.json` da raiz, mas se o `node` subir a árvore procurando um, ele encontra um `package.json` vazio que quebra o resolver. Em `/tmp` está limpo.

---

## ☁ Deploy

### Configurar credenciais

Crie `.env` na raiz baseado em `.env.example`:

```bash
CLOUDFLARE_API_TOKEN=token_pages_edit_de_53_caracteres
CLOUDFLARE_ACCOUNT_ID=account_id_de_32_hex
```

Obtenha em https://dash.cloudflare.com/profile/api-tokens.

### Deploy manual

```bash
set -a; source .env; set +a
./scripts/deploy-web3d.sh
```

O script:
1. Copia `web3d/` para tmp.
2. Substitui `__BUILD_VERSION__` pelo timestamp UTC (cache busting).
3. Valida sintaxe (`node --check` em todos os `src/*.js`).
4. Roda 93 smoke tests.
5. Publica via `wrangler pages deploy`.

Se algum teste falhar, deploy aborta com exit 1.

### Deploy automático

A cada push em `main`, o GitHub Actions executa o mesmo script.

- Workflow: [`.github/workflows/deploy.yml`](../.github/workflows/deploy.yml)
- Secrets necessárias no GitHub:
  - `CLOUDFLARE_API_TOKEN`
  - `CLOUDFLARE_ACCOUNT_ID`

---

## 🔧 IDE recomendada

**VS Code** com extensões:
- JavaScript (Built-in) — syntax highlighting, hover.
- Live Server — preview rápido.
- GitLens — histórico inline.

---

## 🐛 Troubleshooting

| Problema | Causa | Solução |
|----------|-------|---------|
| `404 Not Found` ao carregar `src/main.js` | Servidor errado ou caminho relativo quebrado. | Use `python3 -m http.server` direto em `web3d/`. |
| Mouse não trava | Browser exige HTTPS pra pointer lock. | Use `127.0.0.1:8000` em vez de `localhost`. |
| Áudio mudo no celular | iOS/Safari exige gesto antes de AudioContext. | Toque a tela uma vez. |
| `node --check` falha | `package.json` da raiz está vazio. | Já tratado em smoke tests via `mktemp`. |
| Smoke tests falham | Você quebrou um invariante. | Veja a saída — ele aponta o que falhou. |
| `wrangler` lento | Primeiro deploy baixa ~50 MB. | Aguarde. |
| FPS baixo em mobile | `VIEW_RADIUS` muito alto. | Reduza em `web3d/src/constants.js` (default 4 → tente 3). |

---

## 📚 Mais documentação

- [`../README.md`](../README.md) — visão geral
- [`../CLAUDE.md`](../CLAUDE.md) — instruções para Claude Code auto-continue
- [`../AGENTS.md`](../AGENTS.md) — regras para agentes
- [`../ARCHITECTURE.md`](../ARCHITECTURE.md) — arquitetura técnica
- [`MODULES.md`](MODULES.md) — referência de cada módulo
- [`walkthrough.md`](walkthrough.md) — como jogar

---

*Atualizado em maio/2026.*
