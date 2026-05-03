#!/bin/bash

# Validate OpenAPI definition

if ! command -v openapi-generator &> /dev/null; then
  echo "openapi-generator not found"
  exit 1
fi

openapi-generator validate -i lib/openapi/openapi.yaml
