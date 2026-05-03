#!/bin/bash

validate_env() {
  if [ ! -f .env ]; then
    echo ".env file is missing"
    exit 1
  fi

  # Verifica se as variáveis de ambiente estão definidas
  local vars=(
    "DB_HOST"
    "DB_PORT"
    "DB_NAME"
    "DB_USER"
    "DB_PASSWORD"
    "API_KEY"
  )

  for var in "${vars[@]}"; do
    if ! grep -q "^$var=" .env; then
      echo "$var is not defined in .env"
      exit 1
    fi
  done
}

validate_env
