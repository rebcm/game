#!/bin/bash

# Validate if required secrets are set
required_secrets=("DB_URL" "API_KEY" "API_SECRET")

for secret in "${required_secrets[@]}"; do
  if ! wrangler secret get "$secret" &> /dev/null; then
    echo "Error: Secret '$secret' is not set."
    exit 1
  fi
done

echo "All required secrets are set."
