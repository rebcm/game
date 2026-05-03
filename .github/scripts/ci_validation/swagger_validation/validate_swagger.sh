#!/bin/bash

# This script validates the Swagger implementation in the backend repository

# Check if the Swagger file exists
if [ ! -f "../backend/swagger.yaml" ]; then
  echo "Swagger file not found"
  exit 1
fi

# Validate the Swagger file
swagger-cli validate ../backend/swagger.yaml
if [ $? -ne 0 ]; then
  echo "Swagger validation failed"
  exit 1
fi

echo "Swagger validation successful"
