#!/bin/bash

# Validate if Swagger files exist
if [ ! -f docs/swagger/swagger.json ] || [ ! -f docs/swagger/swagger_ui.html ]; then
  echo "Swagger files are missing"
  exit 1
fi

# Validate Swagger content (example check, adjust according to actual needs)
swagger_content=$(cat docs/swagger/swagger.json)
if ! echo "$swagger_content" | grep -q '"swagger": "2.0"'; then
  echo "Invalid Swagger content"
  exit 1
fi

echo "Swagger validation successful"
