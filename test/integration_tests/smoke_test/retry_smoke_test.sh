#!/bin/bash

MAX_ATTEMPTS=3
BACKOFF_FACTOR=2
INITIAL_DELAY=1

attempt=1
delay=$INITIAL_DELAY

while [ $attempt -le $MAX_ATTEMPTS ]; do
  echo "Attempt $attempt/$MAX_ATTEMPTS"
  if flutter drive --driver=test/integration_tests/integration_test_driver/integration_test_driver.dart --target=test/integration_tests/smoke_test/smoke_test.dart; then
    echo "Smoke test passed"
    exit 0
  else
    echo "Smoke test failed, retrying in $delay seconds..."
    sleep $delay
    delay=$((delay * BACKOFF_FACTOR))
    attempt=$((attempt + 1))
  fi
done

echo "Smoke test failed after $MAX_ATTEMPTS attempts"
exit 1
