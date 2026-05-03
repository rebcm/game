#!/bin/bash

# Validate environment configuration
if [ ! -f .env ]; then
  echo ".env file is missing"
  exit 1
fi

# Check for required variables in .env
required_vars=("DB_URL" "API_KEY" "WRANGLER_TOKEN")
for var in "${required_vars[@]}"; do
  if ! grep -q "$var" .env; then
    echo "$var is missing in .env"
    exit 1
  fi
done

echo "Environment configuration is valid"
