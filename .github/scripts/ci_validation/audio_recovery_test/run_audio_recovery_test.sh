#!/bin/bash

# Define test parameters
TEST_ITERATIONS=10
RECOVERY_TIMEOUT=5

# Run audio recovery test
for i in $(seq 1 $TEST_ITERATIONS); do
  echo "Running audio recovery test iteration $i"
  flutter drive --target=test_driver/integration_test.dart --driver=test_driver/integration_test_driver.dart --test-name=audio_recovery_test
  if [ $? -ne 0 ]; then
    echo "Audio recovery test failed on iteration $i"
    exit 1
  fi
  sleep $RECOVERY_TIMEOUT
done

echo "Audio recovery test completed successfully"
