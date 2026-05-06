# 🛠 Setup de Ambiente

**Projeto:** Construção Criativa da Rebeca
**Autora:** Rebeca Alves Moreira

Como rodar o projeto localmente para desenvolvimento.

---

## 🎮 Versão Web3D (Atual)

A versão ativa está em [`web3d/`](../web3d/) e usa apenas Three.js + WebGL puro. **Sem build step.**

### Pré-requisitos
- Qualquer servidor HTTP estático (Python, Node, Go, etc).
- Navegador moderno (Chrome 90+, Firefox 90+, Safari 15+, Edge 90+).
- Node 16+ apenas para rodar `node --check` na sintaxe (opcional).

### Rodar local

```bash
git clone https://github.com/rebcm/game
cd game/web3d

# Opção 1: Python (mais comum)
python3 -m http.server 8000

# Opção 2: Node serve
npx serve .

# Opção 3: live-reload pra dev
npx live-server .
```

Abra `http://localhost:8000` no browser. **Não use `file://`** — módulos ES e pointer lock não funcionam.

### Validar antes de commitar

```bash
# Sintaxe (precisa copiar pro /tmp porque o package.json da raiz está vazio)
cp web3d/game.js /tmp/check.mjs
node --check /tmp/check.mjs

# Smoke tests pré-deploy (30 testes headless)
node scripts/test-web3d-precheck.js web3d
```

---

## 🧊 Versão Flutter 2D (Legado)

A versão antiga em [`app/`](../app/) e [`lib/`](../lib/). Apenas mantida como referência.

### Pré-requisitos
- Flutter SDK ≥ 3.24
- Dart ≥ 3.0
- Java 17 (para builds Android)

### Rodar local

```bash
cd game/app

flutter pub get
dart analyze --no-fatal-warnings    # zero erros é exigido
flutter run                          # device ou emulator
```

### Build web

```bash
flutter build web --release --base-href /
# Output em app/build/web/
```

---

## 🔐 Variáveis de Ambiente

Para deploy em Cloudflare Pages, precisa de `.env` na raiz com:

```bash
CLOUDFLARE_API_TOKEN=token_pages_edit_de_32_caracteres
CLOUDFLARE_ACCOUNT_ID=account_id_de_32_hex
```

Veja `.env.example` para a lista completa de variáveis suportadas.

**Importante:** o `.env` está no `.gitignore` — nunca commit credenciais.

Carregue antes de rodar o deploy:
```bash
set -a; source .env; set +a
./scripts/deploy-web3d.sh
```

---

## 📦 Dependências

### Web3D
| Dependência | Versão | Fonte |
|-------------|--------|-------|
| Three.js | 0.165.0 | CDN unpkg via importmap |
| Press Start 2P | latest | Google Fonts (opcional, com fallback) |

Não há `npm install` na raiz. O `package.json` está intencionalmente vazio.

### Flutter (legado)
Veja `pubspec.yaml` na raiz para a lista de packages Dart.

---

## 🧪 Testes

### Web3D
- **Smoke tests headless**: `scripts/test-web3d-precheck.js`
  - Verifica tags HTML obrigatórias.
  - Confere classes/IDs do CSS.
  - Valida estrutura mínima do `game.js`.
  - É executado automaticamente no `deploy-web3d.sh`.

### Flutter
```bash
cd app
flutter test                    # unit tests
flutter test integration_test/   # integration tests
```

---

## 🔧 IDE Recomendada

- **VS Code** com extensões:
  - Dart (para Flutter)
  - JavaScript (Built-in)
  - Live Server (para desenvolvimento web3d/)
  - GitLens

---

## 🚨 Troubleshooting

| Problema | Causa | Solução |
|----------|-------|---------|
| `node --check web3d/game.js` falha | `package.json` raiz está vazio | Copie pra `/tmp/check.mjs` primeiro |
| Mouse não trava no localhost | Browser exige HTTPS pra pointer lock em alguns casos | Use `127.0.0.1` em vez de `localhost`, ou habilite localhost-as-secure no Chrome |
| `wrangler pages deploy` falha | Credenciais Cloudflare ausentes | `set -a; source .env; set +a` antes |
| Texturas pixeladas borradas | Anti-aliasing do navegador | Já está configurado no CSS com `image-rendering: pixelated`; verifique zoom do browser |
| Áudio mudo | iOS/Safari exige gesto antes do AudioContext | Toque a tela uma vez |

---

## 📚 Mais documentação

- [`README.md`](../README.md) — visão geral
- [`ARCHITECTURE.md`](../ARCHITECTURE.md) — arquitetura técnica
- [`AGENTS.md`](../AGENTS.md) — regras para agentes de desenvolvimento
- [`docs/walkthrough.md`](walkthrough.md) — guia jogável
- [`docs/deploy/procedimento-deploy.md`](deploy/procedimento-deploy.md) — fluxo de deploy

---

*Atualizado em maio/2026.*
