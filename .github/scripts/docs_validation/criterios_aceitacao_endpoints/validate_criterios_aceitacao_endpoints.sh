#!/bin/bash

# Validate if the required endpoints are documented
required_endpoints=("GET /docs" "GET /api/v1/blocks" "POST /api/v1/blocks")
missing_endpoints=()

for endpoint in "${required_endpoints[@]}"; do
  if ! grep -q "$endpoint" lib/docs/swagger.yaml; then
    missing_endpoints+=("$endpoint")
  fi
done

if [ ${#missing_endpoints[@]} -ne 0 ]; then
  echo "The following endpoints are missing in the Swagger documentation:"
  for endpoint in "${missing_endpoints[@]}"; do
    echo "- $endpoint"
  done
  exit 1
fi
