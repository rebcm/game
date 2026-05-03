#!/bin/bash

# Verifica se os critérios de aceitação para endpoints estão definidos
if ! grep -q "Endpoints Obrigatórios" ./lib/docs/criterios_aceitacao_endpoints.md; then
  echo "Critérios de aceitação para endpoints não definidos"
  exit 1
fi

# Valida a renderização do UI do Swagger
if ! grep -q "Swagger UI" ./lib/docs/criterios_aceitacao_endpoints.md; then
  echo "Renderização do UI do Swagger não validada"
  exit 1
fi
