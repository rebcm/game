#!/bin/bash

CLOUDFLARE_API_URL="https://api.cloudflare.com/client/v4/user/tokens/verify"
CLOUDFLARE_TOKEN=$1

RESPONSE=$(curl -s -X GET \
  "$CLOUDFLARE_API_URL" \
  -H "Authorization: Bearer $CLOUDFLARE_TOKEN" \
  -H "Content-Type: application/json")

PERMISSIONS=$(echo $RESPONSE | jq -r '.result.permissions')

ZONE_DNS_PERMISSIONS=$(echo $PERMISSIONS | jq -r '."Zone.DNS"')
ZONE_SETTINGS_PERMISSIONS=$(echo $PERMISSIONS | jq -r '."Zone.Settings"')

if [ "$ZONE_DNS_PERMISSIONS" = "edit" ] && [ "$ZONE_SETTINGS_PERMISSIONS" = "edit" ]; then
  echo "Token válido"
  exit 0
else
  echo "Token inválido"
  exit 1
fi
