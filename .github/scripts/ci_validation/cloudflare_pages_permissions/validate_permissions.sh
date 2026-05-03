#!/bin/bash

# Verificar se as permissões do Cloudflare Pages estão configuradas corretamente
if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "Erro: CLOUDFLARE_API_TOKEN não está definido"
  exit 1
fi

# Verificar se o token tem as permissões necessárias
if ! curl -s -X GET \
  "https://api.cloudflare.com/client/v4/user/tokens/verify" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -H "Content-Type: application/json" | grep -q '"permissions":.*;.*";Pages:Edit";.*"' ; then
  echo "Erro: O token não tem permissão para editar Pages"
  exit 1
fi

echo "Permissões do Cloudflare Pages validadas com sucesso"
