#!/bin/bash

# Validate if OpenAPI contract test exists
if [ ! -f "test/contract_tests/openapi_contract_test.dart" ]; then
  echo "OpenAPI contract test file not found."
  exit 1
fi

# Validate if OpenAPI contract test workflow exists
if [ ! -f ".github/workflows/contract_test.yml" ]; then
  echo "OpenAPI contract test workflow file not found."
  exit 1
fi
