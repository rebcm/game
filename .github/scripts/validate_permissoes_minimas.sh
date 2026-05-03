#!/bin/bash

# Script para validar se as permissões mínimas estão configuradas corretamente

# Verificar se o Cloudflare CLI está instalado
if ! command -v wrangler &> /dev/null; then
    echo "Cloudflare CLI (wrangler) não está instalado."
    exit 1
fi

# Autenticar no Cloudflare
wrangler login

# Verificar permissões para o site Pages
pages_permissions=$(wrangler pages list | grep "Permission")

if [ "$pages_permissions" != "Permission: Editar" ]; then
    echo "Permissões não estão configuradas corretamente."
    exit 1
fi

echo "Permissões mínimas configuradas corretamente."
