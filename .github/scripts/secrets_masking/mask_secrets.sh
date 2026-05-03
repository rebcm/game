#!/bin/bash

# Function to mask secrets in logs
mask_secrets() {
  for secret in "$@"; do
    echo "::add-mask::$secret"
  done
}

# List of secrets to mask
secrets_to_mask=("$CLOUDFLARE_API_TOKEN" "$CLOUDFLARE_ACCOUNT_ID" "$KEYSTORE_PASSWORD" "$KEY_ALIAS" "$KEY_PASSWORD")

# Call the function with the list of secrets
mask_secrets "${secrets_to_mask[@]}"
