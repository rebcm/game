#!/bin/bash

validate_secret() {
  local secret_name=$1
  local secret_value=$2

  if [ -z "$secret_value" ]; then
    echo "Erro: Variável de ambiente '$secret_name' não está definida."
    echo "Por favor, configure '$secret_name' nas configurações do repositório."
    return 1
  fi
}

validate_secret 'CLOUDFLARE_TOKEN' "${CLOUDFLARE_TOKEN}"
validate_secret 'CLOUDFLARE_ACCOUNT_ID' "${CLOUDFLARE_ACCOUNT_ID}"
