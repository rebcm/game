#!/usr/bin/env bash
# =====================================================================
# deploy-web3d.sh — Deploy do web3d/ para Cloudflare Pages.
#
# Pipeline:
# 1. Copia web3d/ para um diretório temporário limpo.
# 2. Substitui __BUILD_VERSION__ no index.html pelo timestamp UTC
#    atual (cache busting do main.js?v=...).
# 3. Valida sintaxe de todos os módulos em src/*.js (node --check).
# 4. Roda os 93 smoke tests em scripts/test-web3d-precheck.js.
#    Aborta com exit 1 se qualquer teste falhar.
# 5. Publica via `wrangler pages deploy` no projeto construcao-criativa.
#
# Variáveis necessárias (no .env):
#   CLOUDFLARE_API_TOKEN   token com permissão Pages:Edit
#   CLOUDFLARE_ACCOUNT_ID  account id (32 hex)
#
# Uso:
#   set -a; source .env; set +a
#   ./scripts/deploy-web3d.sh
# =====================================================================
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

echo "🧪 Validando sintaxe dos módulos src/*.js …"
for f in "$BUILD/src"/*.js; do
  if ! node --check "$f" 2>&1; then
    echo "❌ Sintaxe inválida em $(basename "$f") — abortando deploy"
    exit 1
  fi
done
echo "  ✓ todos os módulos passam node --check"

echo "🧪 Rodando smoke tests pré-deploy …"
if [ -f "$ROOT/scripts/test-web3d-precheck.js" ]; then
  # Rodamos de dentro do BUILD (cwd != $ROOT). O package.json
  # da raiz é intencionalmente vazio e quebra o resolver do Node
  # ao subir a árvore. BUILD é um tmp limpo onde o Node não
  # encontra package.json malformado.
  cp "$ROOT/scripts/test-web3d-precheck.js" "$BUILD/_precheck.js"
  ( cd "$BUILD" && node ./_precheck.js . ) || {
    echo "❌ Smoke tests falharam — abortando deploy"
    exit 1
  }
  rm -f "$BUILD/_precheck.js"
else
  echo "  (sem testes pre-check definidos)"
fi

echo "Publicando no Cloudflare Pages..."
# FIX: passar commit-message ASCII puro pra evitar erro UTF-8 do CF API
# (CF API rejeita commit messages com certos caracteres como invalid UTF-8)
SAFE_MSG="deploy_${VERSION}"
npx -y wrangler@latest pages deploy "$BUILD" \
  --project-name=construcao-criativa \
  --commit-dirty=true \
  --commit-message="$SAFE_MSG"

echo "Deploy concluido com cache-bust v=$VERSION"
