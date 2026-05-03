#!/bin/bash

CLOUDFLARE_TOKEN=$1
ZONE_ID=$2

if [ -z "$CLOUDFLARE_TOKEN" ] || [ -z "$ZONE_ID" ]; then
  echo "Erro: Token ou Zone ID do Cloudflare não fornecido."
  exit 1
fi

RESPONSE=$(curl -s -X GET \
  https://api.cloudflare.com/client/v4/zones/$ZONE_ID/settings \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $CLOUDFLARE_TOKEN")

DNS_PERMISSION=$(echo $RESPONSE | jq -r '.result[] | select(.id == "dns") | .modified_on')
SETTINGS_PERMISSION=$(echo $RESPONSE | jq -r '.result[] | select(.id == "settings") | .modified_on')

if [ -n "$DNS_PERMISSION" ] && [ -n "$SETTINGS_PERMISSION" ]; then
  echo "Token válido e possui as permissões necessárias."
  exit 0
else
  echo "Erro: Token inválido ou sem as permissões Zone.DNS e Zone.Settings."
  exit 1
fi
