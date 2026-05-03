#!/bin/bash

CLOUDFLARE_TOKEN=$1
ZONE_ID=$2

if [ -z "$CLOUDFLARE_TOKEN" ] || [ -z "$ZONE_ID" ]; then
  echo "Cloudflare token and zone ID are required"
  exit 1
fi

RESPONSE=$(curl -s -X GET \
  https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $CLOUDFLARE_TOKEN")

if [ $? -ne 0 ]; then
  echo "Failed to validate Cloudflare token"
  exit 1
fi

ERRORS=$(echo $RESPONSE | jq '.errors')

if [ $(echo $ERRORS | jq 'length') -gt 0 ]; then
  echo "Cloudflare token is invalid or lacks required permissions"
  exit 1
fi

echo "Cloudflare token is valid"
