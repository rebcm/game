#!/bin/bash

# Verifica se os critérios de aceitação para endpoints estão definidos
if ! grep -q "Endpoints Obrigatórios" ./docs/criterios_aceitacao_endpoints.md; then
  echo "Critérios de aceitação para endpoints não definidos"
  exit 1
fi

# Verifica se a renderização do UI do Swagger está validada
if ! grep -q "Renderização do Swagger validada" ./docs/criterios_aceitacao_endpoints.md; then
  echo "Renderização do UI do Swagger não validada"
  exit 1
fi
