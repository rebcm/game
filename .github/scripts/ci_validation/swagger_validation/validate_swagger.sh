#!/bin/bash

# Validate Swagger implementation in the backend repository
# This script assumes the backend repository is cloned and available locally

BACKEND_REPO_PATH="../backend"
SWAGGER_YAML_PATH="$BACKEND_REPO_PATH/swagger.yaml"

if [ ! -f "$SWAGGER_YAML_PATH" ]; then
  echo "Swagger YAML file not found at $SWAGGER_YAML_PATH"
  exit 1
fi

# Validate Swagger YAML syntax
swagger-cli validate "$SWAGGER_YAML_PATH"

if [ $? -ne 0 ]; then
  echo "Swagger YAML validation failed"
  exit 1
fi

echo "Swagger YAML validation successful"
