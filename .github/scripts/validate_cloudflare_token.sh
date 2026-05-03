#!/bin/bash

if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "Cloudflare API token is not set"
  exit 1
fi

curl -X GET \
"https://api.cloudflare.com/client/v4/user/tokens/verify" \
-H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
-H "Content-Type: application/json" | grep -q '"result":true' || (echo "Invalid Cloudflare token" && exit 1)
