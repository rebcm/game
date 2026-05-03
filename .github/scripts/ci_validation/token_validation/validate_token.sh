#!/bin/bash

TOKEN=$1
CLOUDFLARE_API_URL="https://api.cloudflare.com/client/v4/user/tokens/verify"

RESPONSE=$(curl -s -X GET \
  "$CLOUDFLARE_API_URL" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json")

PERMISSIONS=$(echo "$RESPONSE" | jq -r '.result.permissions')

if echo "$PERMISSIONS" | grep -q '"Zone.DNS"'; then
  if echo "$PERMISSIONS" | grep -q '"Zone.Settings"'; then
    echo "Token is valid"
    exit 0
  else
    echo "Token does not have Zone.Settings permission"
    exit 1
  fi
else
  echo "Token does not have Zone.DNS permission"
  exit 1
fi
