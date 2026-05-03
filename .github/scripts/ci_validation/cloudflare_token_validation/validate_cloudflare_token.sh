#!/bin/bash

CLOUDFLARE_TOKEN=$1
ZONE_ID=$2

validate_token() {
  response=$(curl -s -X GET \
    https://api.cloudflare.com/client/v4/user/tokens/verify \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $CLOUDFLARE_TOKEN")

  permissions=$(echo "$response" | jq -r '.result.permissions')

  if echo "$permissions" | grep -q '"Zone.DNS"'; then
    if echo "$permissions" | grep -q '"Zone.Settings"'; then
      echo "Token is valid"
      return 0
    else
      echo "Token does not have Zone.Settings permission"
      return 1
    fi
  else
    echo "Token does not have Zone.DNS permission"
    return 1
  fi
}

validate_token
