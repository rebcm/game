#!/bin/bash

MAX_ATTEMPTS=3
BACKOFF_FACTOR=2
INITIAL_DELAY=1

attempt=1
delay=$INITIAL_DELAY

while [ $attempt -le $MAX_ATTEMPTS ]; do
  if flutter drive --driver=test/integration_tests/smoke_test_driver/smoke_test_driver.dart --target=test/integration_tests/smoke_test/smoke_test.dart; then
    exit 0
  else
    echo "Attempt $attempt failed. Retrying in $delay seconds..."
    sleep $delay
    delay=$((delay * BACKOFF_FACTOR))
    attempt=$((attempt + 1))
  fi
done

exit 1
