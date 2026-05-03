#!/bin/bash

EXPECTED_ENDPOINTS=$(cat docs/swagger_endpoints.md | grep -v '^#' | sed '/^$/d')
ACTUAL_ENDPOINTS=$(curl -s http://localhost:8080/v1/swagger.json | jq -r '.paths | keys[]')

for endpoint in $EXPECTED_ENDPOINTS; do
  if ! echo "$ACTUAL_ENDPOINTS" | grep -q "^$endpoint$"; then
    echo "Endpoint $endpoint não encontrado na documentação do Swagger"
    exit 1
  fi
done

echo "Todos os endpoints obrigatórios estão presentes na documentação do Swagger"
exit 0
