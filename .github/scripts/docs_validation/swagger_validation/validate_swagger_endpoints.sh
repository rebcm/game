#!/bin/bash
if ! grep -q "Swagger UI" docs/swagger_ui.html; then
  echo "Swagger UI is not rendering correctly"
  exit 1
fi
required_endpoints=("GET /api/docs" "GET /api/swagger.json")
for endpoint in "${required_endpoints[@]}"; do
  if ! grep -q "$endpoint" docs/swagger_endpoints.md; then
    echo "Missing endpoint documentation: $endpoint"
    exit 1
  fi
done
echo "Swagger UI and endpoints documentation are valid"
