#!/bin/bash

# Verificar se o build foi bem-sucedido
if [ $? -ne 0 ]; then
  echo "Build falhou"
  exit 1
fi

# Verificar status 200 na URL de produção
url_status=$(curl -s -o /dev/null -w "%{http_code}" https://example.com)
if [ $url_status -ne 200 ]; then
  echo "URL de produção não retornou status 200"
  exit 1
fi

# Verificar logs de deploy
if grep -q "error" deploy.log; then
  echo "Logs de deploy contêm erros"
  exit 1
fi

echo "Critérios de aceitação para deploy atendidos"
exit 0
