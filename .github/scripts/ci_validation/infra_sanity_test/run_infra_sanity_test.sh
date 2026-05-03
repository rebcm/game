#!/bin/bash

# Define o diretório do projeto
PROJECT_DIR="/home/user/game"

# Verifica se o arquivo wrangler.toml existe
if [ ! -f "$PROJECT_DIR/wrangler.toml" ]; then
  echo "Erro: wrangler.toml não encontrado"
  exit 1
fi

# Extrai as rotas definidas no wrangler.toml
ROUTES=$(grep -oP '(?<=route = ").*(?=")' "$PROJECT_DIR/wrangler.toml")

# Verifica se as rotas estão operacionais
for ROUTE in $ROUTES; do
  RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$ROUTE")
  if [ "$RESPONSE_CODE" != "200" ]; then
    echo "Erro: Rota $ROUTE não está operacional. Código de resposta: $RESPONSE_CODE"
    exit 1
  fi
done

# Verifica os triggers definidos no wrangler.toml
TRIGGERS=$(grep -oP '(?<=trigger = ").*(?=")' "$PROJECT_DIR/wrangler.toml")

# Verifica se os triggers estão operacionais
for TRIGGER in $TRIGGERS; do
  RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$TRIGGER")
  if [ "$RESPONSE_CODE" != "200" ]; then
    echo "Erro: Trigger $TRIGGER não está operacional. Código de resposta: $RESPONSE_CODE"
    exit 1
  fi
done

echo "Teste de sanidade de infraestrutura concluído com sucesso"
exit 0
