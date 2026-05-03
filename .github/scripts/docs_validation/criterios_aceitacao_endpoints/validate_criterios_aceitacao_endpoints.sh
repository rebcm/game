#!/bin/bash

# Validate if the required endpoints are documented in the Swagger file
required_endpoints=("GET /blocks" "POST /blocks" "PUT /blocks/{id}" "DELETE /blocks/{id}")
swagger_file="assets/swagger.yaml"

for endpoint in "${required_endpoints[@]}"; do
  method=$(echo "$endpoint" | cut -d' ' -f1)
  path=$(echo "$endpoint" | cut -d' ' -f2-)

  if ! grep -q "$method $path" "$swagger_file"; then
    echo "Error: $endpoint is not documented in $swagger_file"
    exit 1
  fi
done

echo "All required endpoints are documented in $swagger_file"
