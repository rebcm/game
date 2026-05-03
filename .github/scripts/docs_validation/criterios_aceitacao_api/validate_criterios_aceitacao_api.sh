#!/bin/bash

# Validate API documentation against predefined criteria
# Check if API endpoints are documented
if ! grep -q "paths:" lib/docs/swagger.yaml; then
  echo "Error: API endpoints are not documented"
  exit 1
fi

# Check if data types are validated
if ! grep -q "type:" lib/docs/swagger.yaml; then
  echo "Error: Data types are not validated"
  exit 1
fi

# Check if payload examples are provided
if ! grep -q "example:" lib/docs/swagger.yaml; then
  echo "Error: Payload examples are not provided"
  exit 1
fi

echo "API documentation validation successful"
