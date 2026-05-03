#!/bin/bash

# Validate environment configuration

# Check if .env file exists
if [ ! -f .env ]; then
  echo ".env file is missing"
  exit 1
fi

# Check if required variables are set
required_vars=("DB_HOST" "DB_PORT" "DB_USER" "DB_PASSWORD" "API_KEY")
for var in "${required_vars[@]}"; do
  if ! grep -q "^$var=" .env; then
    echo "$var is not set in .env file"
    exit 1
  fi
done

echo "Environment configuration is valid"
