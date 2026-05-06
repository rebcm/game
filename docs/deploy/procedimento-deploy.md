# 🚀 Procedimento de Deploy

**Projeto:** Construção Criativa da Rebeca
**Autora:** Rebeca Alves Moreira
**Versão:** Web3D (Three.js)

---

## 🎯 Visão Geral

O deploy publica a pasta [`../../web3d/`](../../web3d/) no **Cloudflare Pages**, no projeto `construcao-criativa`. URL final: https://construcao-criativa.pages.dev.

O deploy é feito pelo script [`../../scripts/deploy-web3d.sh`](../../scripts/deploy-web3d.sh) que:

1. Copia `web3d/` para um diretório temporário.
2. Substitui `__BUILD_VERSION__` pelo timestamp UTC atual (cache busting).
3. Valida sintaxe com `node --check`.
4. Roda smoke tests pré-deploy ([`../../scripts/test-web3d-precheck.js`](../../scripts/test-web3d-precheck.js)).
5. Publica via `wrangler pages deploy`.

---

## 📋 Pré-requisitos

### Variáveis de ambiente
Crie `.env` na raiz do projeto:

```bash
CLOUDFLARE_API_TOKEN=token_com_permissao_pages_edit
CLOUDFLARE_ACCOUNT_ID=account_id_de_32_hex
```

Obtenha em https://dash.cloudflare.com/profile/api-tokens.

### Ferramentas
- **Node 16+**: `node --check` para validação.
- **`wrangler`**: instalado on-demand via `npx -y wrangler@latest`.

---

## 🚀 Deploy Manual

```bash
# 1. Carrega credenciais
set -a
source .env
set +a

# 2. Roda o deploy
./scripts/deploy-web3d.sh
```

Saída típica:
```
📦 Copiando web3d/ → /tmp/web3d-build-XXXX
🔖 BUILD_VERSION = 20260505233200
🧪 Validando JS …
🧪 Rodando testes pré-deploy …
  → 30/30 testes passaram
☁  Publicando no Cloudflare Pages …
✨ Deployment complete! https://abcd1234.construcao-criativa.pages.dev
```

---

## 🤖 Deploy Automático (CI/CD)

A cada push para `main`, o GitHub Actions executa o mesmo script:

- **Workflow:** [`.github/workflows/Deploy.yml`](../../.github/workflows/Deploy.yml)
- **Secrets necessárias** no repositório GitHub:
  - `CLOUDFLARE_API_TOKEN`
  - `CLOUDFLARE_ACCOUNT_ID`

O job:
1. Faz checkout do código.
2. Carrega secrets como env vars.
3. Roda `./scripts/deploy-web3d.sh`.

Se algum smoke test falhar, o deploy **aborta** e o status do PR fica vermelho.

---

## ⏪ Rollback

Cloudflare Pages mantém todas as versões deployadas. Para reverter:

### Opção 1: via dashboard
1. https://dash.cloudflare.com → Pages → `construcao-criativa`.
2. Aba **Deployments** → encontre a versão anterior estável.
3. Clique nos `…` → **Rollback to this deployment**.

### Opção 2: via Git
```bash
# Identificar commit anterior estável
git log --oneline

# Reverter
git revert <hash-do-commit-ruim>
git push origin main

# O CI/CD redeploya automaticamente
```

### Opção 3: via wrangler
```bash
npx wrangler pages deployment list --project-name=construcao-criativa
# Use o ID do deployment desejado:
npx wrangler pages deployment ... # consulte docs do wrangler
```

---

## 🔍 Monitoramento

### Verificar deploy
- **Status do GitHub Actions:** aba **Actions** no repositório.
- **Status do Pages:** dashboard Cloudflare.
- **URL ao vivo:** https://construcao-criativa.pages.dev.

### Cache busting
Como `index.html` carrega `game.js?v=__BUILD_VERSION__` com timestamp único, o browser **sempre busca a versão nova** após o deploy. Não precisa de Ctrl+Shift+R.

`_headers` configura:
- `index.html`: `Cache-Control: max-age=60` (revalida rápido).
- `game.js?v=…`: `Cache-Control: max-age=31536000, immutable` (cacheia agressivo, mas a URL muda).

---

## 🧪 Testes Pré-Deploy

O `test-web3d-precheck.js` roda 30 smoke tests que verificam:

- Tags HTML obrigatórias presentes (`#hud`, `#hotbar`, `#crosshair`, etc).
- IDs e classes do CSS conferem com o que o JS espera.
- Sintaxe do JS é válida (`node --check`).
- Exports/importação de módulos consistentes.

Se algum falhar, o deploy aborta com exit 1.

Para rodar manualmente:
```bash
node scripts/test-web3d-precheck.js web3d
```

---

## 🚨 Troubleshooting

| Problema | Causa | Solução |
|----------|-------|---------|
| `Authentication error` no wrangler | `CLOUDFLARE_API_TOKEN` faltando ou inválido | Verifique `.env` ou regenere o token |
| `Project not found` | `CLOUDFLARE_ACCOUNT_ID` errado | Pegue o ID correto em https://dash.cloudflare.com |
| Smoke tests falham | Mudança quebrou estrutura mínima | Veja a saída do precheck e corrija |
| `node --check` falha | Erro de sintaxe em `game.js` | Veja stack trace e corrija |
| Deploy ok mas site mostra versão antiga | Cache do browser ou Cloudflare | Hard reload (Ctrl+Shift+R) ou aguarde 60s |
| `wrangler` instala lento | npm cache limpo | Aguarde — primeira vez baixa ~50 MB |

---

*Atualizado em maio/2026 — fluxo wrangler + cache busting.*
