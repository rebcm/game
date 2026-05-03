#!/bin/bash

# Navigate to the test directory
cd test/contract_tests

# Run the OpenAPI contract tests
flutter test openapi_contract_test.dart

# Check if the tests passed
if [ $? -ne 0 ]; then
  echo "OpenAPI contract tests failed"
  exit 1
fi
