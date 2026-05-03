#!/bin/bash

# Validação da configuração do Wrangler

validate_wrangler_config() {
  local env=$1
  local vars=("${@:2}")

  for var in "${vars[@]}"; do
    if ! grep -q "$var" "wrangler.toml"; then
      echo "Erro: Variável $var não encontrada no wrangler.toml para o ambiente $env"
      return 1
    fi
  done
}

validate_wrangler_config "dev" "VAR_DEV_1" "VAR_DEV_2" "SECRET_DEV_1"
validate_wrangler_config "staging" "VAR_STAGING_1" "VAR_STAGING_2" "SECRET_STAGING_1"
validate_wrangler_config "prod" "VAR_PROD_1" "VAR_PROD_2" "SECRET_PROD_1"

echo "Configuração do Wrangler validada com sucesso"
