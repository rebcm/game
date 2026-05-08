# 🛠 Setup de Desenvolvimento

**Projeto:** Construção Criativa da Rebeca — 3D
**Autora:** Rebeca Alves Moreira
**Versão atual:** Pós sprints 1-9 + 6.5 + 8.5 (multiplayer cross-device + Nether)

Como rodar o projeto localmente, validar mudanças e fazer deploy do jogo + worker de multiplayer.

---

## ⚡ Setup mínimo (5 minutos)

```bash
git clone https://github.com/rebcm/game
cd game/web3d
python3 -m http.server 8000
# Acesse http://localhost:8000
```

Pronto. O jogo carrega Three.js do CDN e roda no browser. **Não há `npm install` na raiz**. O `package.json` é intencionalmente ausente.

---

## 📋 Pré-requisitos

| Para... | Você precisa de... |
|---------|--------------------|
| Rodar o jogo localmente | Browser moderno (Chrome 90+, Firefox 90+, Safari 15+, Edge 90+). |
| Validar sintaxe | Node.js 16+ (pra `node --check`). |
| Rodar smoke tests | Node.js 16+. |
| Deploy do jogo | Cloudflare API token + account ID + Pages habilitado. |
| Deploy do Worker | Cloudflare API token + workers.dev subdomain habilitado. |
| Dev local com auto-reload (opcional) | `npx live-server` (download on-demand, sem instalação). |

---

## 🚀 Servidor local

ES modules nativos exigem HTTP — **não use `file://`**.

### Opção 1: Python (mais simples, sem deps)
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

### Multiplayer local (BroadcastChannel)
- Abra o jogo em **2 abas** do mesmo browser → ambos viram um ao outro automaticamente.
- Útil pra testar o sync sem precisar do Worker.

---

## ✅ Validar mudanças

Antes de commitar, sempre rode:

### 1. Sintaxe de cada módulo

```bash
for f in web3d/src/*.js; do node --check "$f" || echo "FALHOU: $f"; done
```

Saída esperada: nada (silêncio = sucesso).

### 2. Smoke tests (124 invariantes atualmente)

```bash
TMPDIR=$(mktemp -d) && cp -R web3d/* "$TMPDIR/" && \
  cp scripts/test-web3d-precheck.js "$TMPDIR/_p.js" && \
  ( cd "$TMPDIR" && node ./_p.js . ) && rm -rf "$TMPDIR"
```

Saída esperada:
```
✓ 124 passaram   ✗ 0 falharam
✅ Tudo OK — build pronto para deploy.
```

> **Por que copiar pra `/tmp` antes?** Sem `package.json` na raiz, mas se o `node` subir a árvore procurando um, ele encontra coisas que quebram o resolver. Em `/tmp` está limpo.

### 3. Adicionar smoke test pra prevenir regressão

Quando você corrige um bug, **adicione um invariante** em `scripts/test-web3d-precheck.js` que checa o fix. Exemplos vivos:

```js
// Anti-regressão: bug histórico de import faltante.
t('mobs.js importa BLOCO_INFO se usa BLOCO_INFO',
  !/\bBLOCO_INFO\b/.test(mobs) ||
  /import\s*\{[^}]*BLOCO_INFO[^}]*\}\s*from\s*['"]\.\/constants\.js['"]/.test(mobs));
```

---

## ☁️ Deploy

### Configurar credenciais

Crie `.env` na raiz baseado em `.env.example`:

```bash
CLOUDFLARE_API_TOKEN=token_pages_edit_de_53_caracteres
CLOUDFLARE_ACCOUNT_ID=account_id_de_32_hex
```

Obtenha em https://dash.cloudflare.com/profile/api-tokens.

**Permissões necessárias no token:**
- `Account.Cloudflare Pages.Edit` (pro game)
- `Account.Workers Scripts.Edit` (pro multiplayer worker — opcional, só se for atualizar)
- `Account.Workers Scripts.Read`

### Deploy do jogo (Cloudflare Pages)

```bash
set -a; source .env; set +a
./scripts/deploy-web3d.sh
```

O script:
1. Copia `web3d/` pra tmp.
2. Substitui `__BUILD_VERSION__` pelo timestamp UTC (cache busting).
3. Valida sintaxe (`node --check` em todos os `src/*.js`).
4. Roda 124 smoke tests.
5. Publica via `wrangler pages deploy`.

Se algum teste falhar, deploy aborta com exit 1.

### Deploy automático

A cada push em `main`, o GitHub Actions executa o mesmo script.

- Workflow: [`.github/workflows/deploy.yml`](../.github/workflows/deploy.yml)
- Secrets necessárias no GitHub:
  - `CLOUDFLARE_API_TOKEN`
  - `CLOUDFLARE_ACCOUNT_ID`

### Deploy do Worker de multiplayer (raro)

O Worker já está deployado em `wss://construcao-criativa-mp.rebcm-mp.workers.dev`. Só re-deploya se modificar `worker/src/index.js`.

```bash
cd worker
set -a; source ../.env; set +a
npx -y wrangler@latest deploy
```

**Pré-requisito uma vez:** workers.dev subdomain habilitado pra account. Se nunca foi configurado:

```bash
# Habilita subdomain "rebcm-mp" (substitua pelo seu)
set -a; source .env; set +a
ACCT_ID=$(curl -s "https://api.cloudflare.com/client/v4/accounts" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  | python3 -c "import json,sys; print(json.load(sys.stdin)['result'][0]['id'])")
curl -X PUT "https://api.cloudflare.com/client/v4/accounts/$ACCT_ID/workers/subdomain" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"subdomain":"rebcm-mp"}'
```

Worker usa **Durable Object SQLite-backed** (compat date 2024-09-23+) — disponível no **free tier** (sem custo $5/mês).

---

## 🔧 IDE recomendada

**VS Code** com extensões:
- JavaScript (Built-in) — syntax highlighting, hover.
- Live Server — preview rápido.
- GitLens — histórico inline.
- TODO Tree — encontra TODOs (mas o projeto não permite TODO em produção).

---

## 🧪 Validar Worker manualmente

```bash
# Health check (sem WebSocket)
curl -s "https://construcao-criativa-mp.rebcm-mp.workers.dev/"
# Resposta esperada: "Construção Criativa MP Worker — use /ws?room=NAME"

# Health da room (count de sessions)
curl -s "https://construcao-criativa-mp.rebcm-mp.workers.dev/health?room=test"
# Resposta esperada: {"sessions":N}
```

WebSocket teste (se tiver wscat):
```bash
npx wscat -c "wss://construcao-criativa-mp.rebcm-mp.workers.dev/ws?room=test"
> {"tipo":"pos","id":"test1","name":"Teste","x":0,"y":30,"z":0,"rot":0,"ts":1234567890000}
# Outros clientes na mesma room recebem essa mensagem.
```

---

## 🐛 Troubleshooting

| Problema | Causa | Solução |
|----------|-------|---------|
| `404 Not Found` ao carregar `src/main.js` | Servidor errado ou caminho relativo. | Use `python3 -m http.server` direto em `web3d/`. |
| Mouse não trava | Browser exige HTTPS pra pointer lock. | Use `127.0.0.1:8000` em vez de `localhost`. |
| Áudio mudo no celular | iOS/Safari exige gesto antes de AudioContext. | Toque a tela uma vez. |
| `node --check` falha | Sintaxe quebrada. | Veja a saída — aponta linha + coluna. |
| Smoke tests falham | Você quebrou um invariante. | Veja a saída — aponta o teste que falhou. |
| `wrangler` lento no 1º deploy | Baixa ~50 MB. | Aguarde. Próximos são instantâneos. |
| Worker SSL handshake error logo após deploy | Cert provisionando. | Aguarde 5-10min e tente de novo. |
| FPS baixo em mobile | Quality tier alto. | Pause menu → Qualidade → "Auto" ou "Baixa". Adaptive monitor reduz se necessário. |
| Travamento longo no início | Backlog de chunks gerando. | Loading overlay aparece. Aguarde. |
| Tempo de chunk gen alto | View radius muito grande. | Quality tier baixa o viewRadius automaticamente em hardware fraco. |
| Multiplayer sem outros players | Nome de sala diferente entre vocês. | Confirme nome IDÊNTICO + status "🌐 Conectado". |

---

## 📊 Estrutura de arquivos

```
game/
├── README.md                 # Visão pública detalhada
├── CLAUDE.md                 # Auto-continue pra Claude Code
├── AGENTS.md                 # Regras pra agentes
├── ARCHITECTURE.md           # Detalhes técnicos
├── .env / .env.example       # Cloudflare credentials
├── .github/workflows/
│   └── deploy.yml            # CI/CD push → deploy
├── docs/
│   ├── MODULES.md            # Referência por módulo (18 mods)
│   ├── walkthrough.md        # Guia de jogabilidade
│   └── SETUP.md              # ← você está aqui
├── scripts/
│   ├── deploy-web3d.sh       # Deploy Cloudflare Pages
│   └── test-web3d-precheck.js # 124 smoke tests
├── worker/                   # Multiplayer cross-device
│   ├── src/index.js          # Durable Object Room
│   └── wrangler.toml         # Free tier SQLite-backed
└── web3d/                    # ⭐ O JOGO
    ├── index.html
    ├── style.css
    ├── manifest.json
    ├── _headers
    └── src/                  # 18 módulos JS
        ├── main.js
        ├── state.js
        ├── constants.js
        ├── utils.js
        ├── audio.js
        ├── world.js
        ├── render.js
        ├── player.js
        ├── inventory.js
        ├── mobs.js
        ├── particles.js
        ├── ui.js
        ├── save.js
        ├── input.js
        ├── achievements.js
        ├── weather.js
        ├── multiplayer.js
        └── quality.js
```

---

## 📚 Mais documentação

- [`../README.md`](../README.md) — visão pública detalhada
- [`../CLAUDE.md`](../CLAUDE.md) — instruções pra Claude Code auto-continue
- [`../AGENTS.md`](../AGENTS.md) — regras pra qualquer agente de IA
- [`../ARCHITECTURE.md`](../ARCHITECTURE.md) — arquitetura técnica detalhada
- [`MODULES.md`](MODULES.md) — referência módulo por módulo
- [`walkthrough.md`](walkthrough.md) — passo-a-passo de jogo

---

*Atualizado em maio/2026 — pós sprints 1-9 + 6.5 + 8.5.*
