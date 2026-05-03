#!/bin/bash

# Validate API documentation criteria
if ! grep -q "Endpoints obrigatórios:" ./lib/docs/swagger.yaml; then
  echo "Endpoints obrigatórios not defined"
  exit 1
fi

if ! grep -q "Tipos de dados:" ./lib/docs/swagger.yaml; then
  echo "Tipos de dados not defined"
  exit 1
fi

if ! grep -q "Exemplos de payloads:" ./lib/docs/swagger.yaml; then
  echo "Exemplos de payloads not defined"
  exit 1
fi
