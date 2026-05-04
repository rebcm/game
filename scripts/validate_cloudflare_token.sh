#!/bin/bash

# Load environment variables from .env file
source .env

# Check if CLOUDFLARE_API_TOKEN is set
if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "CLOUDFLARE_API_TOKEN is not set in .env file"
  exit 1
fi

# Validate Cloudflare API token
curl -s -X GET \
  https://api.cloudflare.com/client/v4/user/tokens/verify \
  -H 'Authorization: Bearer '$CLOUDFLARE_API_TOKEN'' \
  -H 'Content-Type: application/json'

