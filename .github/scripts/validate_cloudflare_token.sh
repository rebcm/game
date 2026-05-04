#!/bin/bash

# Load environment variables from .env file
source .env

# Check if CLOUDFLARE_API_TOKEN is set
if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "CLOUDFLARE_API_TOKEN is not set"
  exit 1
fi

# Validate Cloudflare token using curl
RESPONSE=$(curl -s -X GET \
  https://api.cloudflare.com/client/v4/user/tokens/verify \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -H "Content-Type: application/json")

# Check if the response is successful
if echo "$RESPONSE" | grep -q '"result":null'; then
  echo "Invalid Cloudflare token"
  exit 1
else
  echo "Cloudflare token is valid"
fi
