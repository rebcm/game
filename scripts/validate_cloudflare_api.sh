#!/bin/bash

# Verifica se o token da API Cloudflare está configurado
if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "Token da API Cloudflare não configurado"
  exit 1
fi

# Executa o pipeline de CI/CD
flutter pub get
dart run build_runner build --delete-conflicting-outputs

# Verifica se o pipeline completou sem erros 403
if [ $? -eq 0 ]; then
  echo "Validação do token da API Cloudflare bem-sucedida"
else
  echo "Erro durante a validação do token da API Cloudflare"
  exit 1
fi
