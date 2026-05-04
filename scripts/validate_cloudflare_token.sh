#!/bin/bash

CLOUDFLARE_API_TOKEN=$(grep CLOUDFLARE_API_TOKEN .env | cut -d '=' -f2)

if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "CLOUDFLARE_API_TOKEN not found in .env file"
  exit 1
fi

RESPONSE=$(curl -s -X GET \
  https://api.cloudflare.com/client/v4/user/tokens/verify \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN")

VERIFY_RESULT=$(echo $RESPONSE | jq -r '.result')

if [ "$VERIFY_RESULT" != "true" ]; then
  echo "Invalid or expired CLOUDFLARE_API_TOKEN"
  exit 1
fi

echo "CLOUDFLARE_API_TOKEN is valid"
