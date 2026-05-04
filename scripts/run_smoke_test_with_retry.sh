#!/bin/bash

attempt=0
max_attempts=3

while [ $attempt -lt $max_attempts ]; do
  if flutter drive --driver=test/integration_tests/integration_test_driver/integration_test_driver.dart --target=test/integration_tests/smoke_test/smoke_test.dart; then
    exit 0
  else
    attempt=$((attempt + 1))
    echo "Smoke test failed. Retrying..."
  fi
done

exit 1
