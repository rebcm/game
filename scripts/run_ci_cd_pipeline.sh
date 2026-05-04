#!/bin/bash

# Run CI/CD pipeline locally
flutter drive --driver=test/integration_tests/smoke_test/smoke_test_driver.dart --target=test/integration_tests/smoke_test/smoke_test.dart

if [ $? -eq 0 ]; then
  echo "Smoke test passed"
else
  echo "Smoke test failed, rolling back to previous version"
fi
