#!/bin/bash

# Configura as variáveis de ambiente necessárias para o wrangler.toml
configure_wrangler() {
  # Cria o arquivo wrangler.toml se não existir
  if [ ! -f wrangler.toml ]; then
    touch wrangler.toml
  fi

  # Define as variáveis de ambiente
  local vars=(
    "DB_HOST"
    "DB_PORT"
    "DB_NAME"
    "DB_USER"
    "DB_PASSWORD"
    "API_KEY"
  )

  # Adiciona as variáveis ao wrangler.toml
  for var in "${vars[@]}"; do
    echo "Setting $var in wrangler.toml"
    wrangler secret put $var
  done
}

configure_wrangler
