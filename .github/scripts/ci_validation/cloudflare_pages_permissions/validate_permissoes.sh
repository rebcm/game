#!/bin/bash

# Verificar se as permissões mínimas estão configuradas corretamente
if [ "$(cat ./.github/docs/permissoes_minimas_cloudflare_pages.md | grep 'pages:write')" != "" ]; then
  echo "Permissão para deploy configurada corretamente"
else
  echo "Erro: Permissão para deploy não configurada corretamente"
  exit 1
fi

if [ "$(cat ./.github/docs/permissoes_minimas_cloudflare_pages.md | grep 'pages:read')" != "" ]; then
  echo "Permissão para build configurada corretamente"
else
  echo "Erro: Permissão para build não configurada corretamente"
  exit 1
fi

if [ "$(cat ./.github/docs/permissoes_minimas_cloudflare_pages.md | grep 'secret:read')" != "" ]; then
  echo "Permissão para acesso aos secrets configurada corretamente"
else
  echo "Erro: Permissão para acesso aos secrets não configurada corretamente"
  exit 1
fi

