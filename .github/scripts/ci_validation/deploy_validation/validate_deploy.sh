#!/bin/bash

# Verificar status do build
if [ $? -ne 0 ]; then
  echo "Erro: Build falhou"
  exit 1
fi

# Verificar status HTTP 200 na URL de produção
URL_PRODUCAO="https://example.com"
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" $URL_PRODUCAO)
if [ $STATUS_CODE -ne 200 ]; then
  echo "Erro: URL de produção retornou status $STATUS_CODE"
  exit 1
fi

# Verificar logs de deploy
LOG_FILE=".github/logs/deploy.log"
if grep -q "ERROR" $LOG_FILE; then
  echo "Erro: Logs de deploy contêm erros"
  exit 1
fi

echo "Deploy validado com sucesso"
exit 0
