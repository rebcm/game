#!/bin/bash

# Validar build sucesso
if [ $? -ne 0 ]; then
  echo "Erro: Build falhou"
  exit 1
fi

# Validar status 200 na URL de produção
URL_PRODUCAO="https://example.com"
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" $URL_PRODUCAO)
if [ $STATUS_CODE -ne 200 ]; then
  echo "Erro: Status code $STATUS_CODE na URL de produção"
  exit 1
fi

# Validar logs de deploy sem erros
LOG_FILE="deploy.log"
if grep -q "ERROR" $LOG_FILE; then
  echo "Erro: Logs de deploy contêm erros"
  exit 1
fi

echo "Deploy validado com sucesso"
exit 0

