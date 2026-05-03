#!/bin/bash

CLOUDFLARE_API_TOKEN=${CLOUDFLARE_API_TOKEN}
CLOUDFLARE_ZONE_ID=${CLOUDFLARE_ZONE_ID}

if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "CLOUDFLARE_API_TOKEN is not set"
  exit 1
fi

if [ -z "$CLOUDFLARE_ZONE_ID" ]; then
  echo "CLOUDFLARE_ZONE_ID is not set"
  exit 1
fi

RESPONSE=$(curl -s -X GET \
  https://api.cloudflare.com/client/v4/zones/${CLOUDFLARE_ZONE_ID} \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer ${CLOUDFLARE_API_TOKEN}")

if echo "$RESPONSE" | grep -q '"success":true'; then
  echo "Cloudflare token is valid"
else
  echo "Cloudflare token is invalid"
  echo "$RESPONSE"
  exit 1
fi
