#!/bin/bash

# Valida se as permissões do Cloudflare Pages estão configuradas corretamente

# Verifica se a variável de ambiente CLOUDFLARE_API_TOKEN está definida
if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "Erro: CLOUDFLARE_API_TOKEN não está definido"
  exit 1
fi

# Simula uma chamada à API do Cloudflare para verificar as permissões
# Substitua por uma chamada real à API do Cloudflare Pages
echo "Simulando chamada à API do Cloudflare Pages..."

# Verifica se a permissão de leitura e escrita no repositório está configurada
if ! grep -q "repo" <<< "$CLOUDFLARE_API_TOKEN_PERMISSIONS"; then
  echo "Erro: Permissão de leitura e escrita no repositório não está configurada"
  exit 1
fi

# Verifica se a permissão de execução de builds e deploys está configurada
if ! grep -q "pages:write" <<< "$CLOUDFLARE_API_TOKEN_PERMISSIONS"; then
  echo "Erro: Permissão de execução de builds e deploys não está configurada"
  exit 1
fi

echo "Permissões do Cloudflare Pages validadas com sucesso"
