#!/bin/bash

# Validate API endpoints documentation
if ! grep -q "GET /api/v1/docs" ./game/docs/swagger.yaml; then
  echo "Missing endpoint: GET /api/v1/docs"
  exit 1
fi

if ! grep -q "GET /api/v1/endpoints" ./game/docs/swagger.yaml; then
  echo "Missing endpoint: GET /api/v1/endpoints"
  exit 1
fi

# Additional validation logic can be added here

exit 0
