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

STATUS=$(echo $RESPONSE | jq -r '.result')

if [ "$STATUS" == "true" ]; then
  echo "Cloudflare token is valid"
else
  echo "Cloudflare token is invalid"
  exit 1
fi
