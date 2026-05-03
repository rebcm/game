#!/bin/bash

# Validate if the required endpoints are documented
required_endpoints=("GET /api/docs" "GET /api/swagger.json")
for endpoint in "${required_endpoints[@]}"; do
  if ! grep -q "$endpoint" ./game/docs/swagger.json; then
    echo "Error: $endpoint is not documented"
    exit 1
  fi
done

# Validate if the Swagger UI is rendering correctly
if ! grep -q "Swagger UI" ./game/docs/index.html; then
  echo "Error: Swagger UI is not rendering correctly"
  exit 1
fi
