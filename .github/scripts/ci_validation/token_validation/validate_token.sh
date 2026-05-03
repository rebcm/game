#!/bin/bash

TOKEN=$1
ZONE_ID=$2

RESPONSE=$(curl -s -X GET \
  https://api.cloudflare.com/client/v4/user/tokens/verify \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN")

PERMISSIONS=$(echo $RESPONSE | jq -r '.result.permissions')

if echo "$PERMISSIONS" | grep -q '"Zone.DNS:read"'; then
  if echo "$PERMISSIONS" | grep -q '"Zone.Settings:read"'; then
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
