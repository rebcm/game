#!/bin/bash

# Validate environment configuration for the project

# Check if .env file exists
if [ ! -f ./.env ]; then
  echo ".env file is missing"
  exit 1
fi

# Check if necessary variables are set in .env
necessary_vars=("DB_HOST" "DB_PORT" "DB_NAME" "DB_USER" "DB_PASSWORD" "API_KEY")
for var in "${necessary_vars[@]}"; do
  if ! grep -q "^$var=" ./.env; then
    echo "$var is not set in .env"
    exit 1
  fi
done

# Validate wrangler.toml configuration
if [ ! -f ./wrangler.toml ]; then
  echo "wrangler.toml file is missing"
  exit 1
fi

# Check if necessary secrets are set
necessary_secrets=("DB_PASSWORD" "API_KEY")
for secret in "${necessary_secrets[@]}"; do
  if ! wrangler secret list | grep -q "^$secret$"; then
    echo "$secret is not set as a secret"
    exit 1
  fi
done

echo "Environment configuration is valid"
