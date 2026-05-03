#!/bin/bash

if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "CLOUDFLARE_API_TOKEN is not set"
  exit 1
fi

curl -X GET \
  https://api.cloudflare.com/client/v4/user/tokens/verify \
  -H 'Authorization: Bearer '$CLOUDFLARE_API_TOKEN'' \
  -H 'Content-Type: application/json'

if [ $? -ne 0 ]; then
  echo "Failed to validate CLOUDFLARE_API_TOKEN"
  exit 1
fi

result=$(curl -s -X GET \
  https://api.cloudflare.com/client/v4/user/tokens/verify \
  -H 'Authorization: Bearer '$CLOUDFLARE_API_TOKEN'' \
  -H 'Content-Type: application/json' | jq '.result')

if [ "$result" != "true" ]; then
  echo "Invalid CLOUDFLARE_API_TOKEN"
  exit 1
fi

echo "CLOUDFLARE_API_TOKEN is valid"
