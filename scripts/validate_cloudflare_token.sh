#!/bin/bash

CLOUDFLARE_API_TOKEN=$(grep CLOUDFLARE_API_TOKEN .env | cut -d '=' -f2)

if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "CLOUDFLARE_API_TOKEN not found in .env file"
  exit 1
fi

RESPONSE=$(curl -s -X GET \
  https://api.cloudflare.com/client/v4/user/tokens/verify \
  -H 'Authorization: Bearer '$CLOUDFLARE_API_TOKEN' \
  -H 'Content-Type: application/json')

if echo $RESPONSE | grep -q '"result":null'; then
  echo "Invalid CLOUDFLARE_API_TOKEN"
  exit 1
else
  echo "CLOUDFLARE_API_TOKEN is valid"
fi
