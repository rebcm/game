#!/bin/bash

# Validate if the required endpoints are documented
required_endpoints=("GET /docs" "GET /openapi.json")
for endpoint in "${required_endpoints[@]}"; do
  if ! grep -q "$endpoint" lib/docs/openapi.json; then
    echo "Error: $endpoint is not documented"
    exit 1
  fi
done

echo "All required endpoints are documented"
