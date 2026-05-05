#!/usr/bin/env bash
# Deploy do web3d para Cloudflare Pages com cache-busting.
#
# - Substitui __BUILD_VERSION__ no index.html pelo timestamp atual,
#   garantindo que o browser sempre busque a versão nova de game.js
#   quando deploya algo novo (sem precisar de Ctrl+Shift+R).
# - Roda os testes pré-deploy (test-web3d.html headless) antes de
#   subir, e aborta se algum falhar.
#
# Variáveis necessárias:
#   CLOUDFLARE_API_TOKEN   token com permissão Pages:Edit
#   CLOUDFLARE_ACCOUNT_ID  account id (32 hex)
#
# Uso: ./scripts/deploy-web3d.sh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/web3d"
BUILD="$(mktemp -d -t web3d-build-XXXX)"
trap 'rm -rf "$BUILD"' EXIT

echo "📦 Copiando $SRC → $BUILD"
cp -R "$SRC"/* "$BUILD"/

VERSION="$(date -u +%Y%m%d%H%M%S)"
echo "🔖 BUILD_VERSION = $VERSION"
sed -i "s/__BUILD_VERSION__/$VERSION/g" "$BUILD/index.html"

echo "🧪 Validando JS …"
node --check "$BUILD/game.js" >/dev/null

echo "🧪 Rodando testes pré-deploy …"
if [ -f "$ROOT/scripts/test-web3d-precheck.js" ]; then
  node "$ROOT/scripts/test-web3d-precheck.js" "$BUILD" || {
    echo "❌ Testes falharam — abortando deploy"
    exit 1
  }
else
  echo "  (sem testes pre-check definidos)"
fi

echo "☁  Publicando no Cloudflare Pages …"
npx -y wrangler@latest pages deploy "$BUILD" \
  --project-name=construcao-criativa \
  --commit-dirty=true

echo "✅ Deploy concluído com cache-bust v=$VERSION"
