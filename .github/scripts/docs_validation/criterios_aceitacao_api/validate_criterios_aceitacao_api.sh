#!/bin/bash

# Validate API endpoints documentation
if ! grep -q "swagger_ui_endpoint" ./lib/main.dart; then
  echo "Error: Swagger UI endpoint not found in main.dart"
  exit 1
fi

# Check if API endpoints are documented
if ! grep -q "Swagger UI" ./docs/api_documentation.md; then
  echo "Error: API endpoints documentation not found"
  exit 1
fi
