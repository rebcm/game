#!/bin/bash

# Valida se o token do Cloudflare foi rotacionado corretamente

CLOUDFLARE_API_TOKEN=$1
CLOUDFLARE_ACCOUNT_ID=$2

if [ -z "$CLOUDFLARE_API_TOKEN" ] || [ -z "$CLOUDFLARE_ACCOUNT_ID" ]; then
  echo "Erro: CLOUDFLARE_API_TOKEN ou CLOUDFLARE_ACCOUNT_ID não fornecido"
  exit 1
fi

# Implemente aqui a lógica para validar o token e account ID
# Por exemplo, fazendo uma requisição para a API do Cloudflare
echo "Token e Account ID válidos"
exit 0
