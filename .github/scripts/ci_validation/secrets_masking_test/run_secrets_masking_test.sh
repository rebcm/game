#!/bin/bash

# Execute flutter test with driver and verify logs for secrets
flutter drive --target=test/integration_test/secrets_masking_test/secrets_masking_test.dart --driver=test/integration_test/secrets_masking_test/secrets_masking_test_driver.dart > test_log.txt 2>&1

# Check if any secret is present in the log
if grep -E "(senha|password|key_path|api_key)" test_log.txt; then
  echo "Secrets found in the log"
  exit 1
else
  echo "No secrets found in the log"
  exit 0
fi
