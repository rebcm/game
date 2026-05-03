#!/bin/bash

CLOUDFLARE_API_TOKEN=$(grep CLOUDFLARE_API_TOKEN .env | cut -d '=' -f2-)

if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "CLOUDFLARE_API_TOKEN is missing"
  exit 1
fi

if ! curl -s -o /dev/null -w "%{http_code}" -X GET \
  "https://api.cloudflare.com/client/v4/user/tokens/verify" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -H "Content-Type: application/json" | grep -q "200"; then
  echo "CLOUDFLARE_API_TOKEN is invalid"
  exit 1
fi

echo "CLOUDFLARE_API_TOKEN is valid"
exit 0
