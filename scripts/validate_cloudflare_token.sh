#!/bin/bash

CLOUDFLARE_API_URL="https://api.cloudflare.com/client/v4/user/tokens/verify"
CLOUDFLARE_TOKEN=$1

response=$(curl -s -X GET \
  "$CLOUDFLARE_API_URL" \
  -H "Authorization: Bearer $CLOUDFLARE_TOKEN" \
  -H "Content-Type: application/json")

permissions=$(echo "$response" | jq -r '.result.permissions')

has_zone_dns=$(echo "$permissions" | jq -r 'has("Zone.DNS")')
has_zone_settings=$(echo "$permissions" | jq -r 'has("Zone.Settings")')

if [ "$has_zone_dns" = "true" ] && [ "$has_zone_settings" = "true" ]; then
  echo "Token is valid"
  exit 0
else
  echo "Token is invalid"
  exit 1
fi
