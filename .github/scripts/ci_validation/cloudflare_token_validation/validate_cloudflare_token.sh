#!/bin/bash

CLOUDFLARE_API_TOKEN=$1
CLOUDFLARE_ZONE_ID=$2

if [ -z "$CLOUDFLARE_API_TOKEN" ] || [ -z "$CLOUDFLARE_ZONE_ID" ]; then
  echo "Erro: Token ou Zone ID do Cloudflare não fornecido."
  exit 1
fi

RESPONSE=$(curl -s -X GET \
  https://api.cloudflare.com/client/v4/user/tokens/verify \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN")

if echo "$RESPONSE" | grep -q '"result":null'; then
  echo "Erro: Token inválido ou expirado."
  exit 1
fi

PERMISSIONS=$(echo "$RESPONSE" | jq -r '.result.permissions[]')

HAS_ZONE_DNS=false
HAS_ZONE_SETTINGS=false

for PERMISSION in $PERMISSIONS; do
  if [ "$PERMISSION" = "Zone:DNS:Edit" ] || [ "$PERMISSION" = "Zone:DNS:Read" ]; then
    HAS_ZONE_DNS=true
  fi
  if [ "$PERMISSION" = "Zone:Settings:Edit" ] || [ "$PERMISSION" = "Zone:Settings:Read" ]; then
    HAS_ZONE_SETTINGS=true
  fi
done

if [ "$HAS_ZONE_DNS" = false ] || [ "$HAS_ZONE_SETTINGS" = false ]; then
  echo "Erro: Token não possui as permissões necessárias (Zone.DNS e Zone.Settings)."
  exit 1
fi

echo "Token validado com sucesso."
exit 0
