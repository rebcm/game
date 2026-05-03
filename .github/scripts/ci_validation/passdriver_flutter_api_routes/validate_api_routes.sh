#!/bin/bash

# Valida se as rotas da API estão documentadas
if ! grep -q "/api/v1/healthcheck" ./.github/docs/passdriver_flutter_api_routes/route_matrix_definition.md; then
  echo "Rota /api/v1/healthcheck não documentada"
  exit 1
fi

if ! grep -q "/api/v1/config" ./.github/docs/passdriver_flutter_api_routes/route_matrix_definition.md; then
  echo "Rota /api/v1/config não documentada"
  exit 1
fi

echo "Rotas da API validadas com sucesso"
