#!/bin/bash

# Execute flutter test with verbose logging
flutter test --verbose > test_log.txt

# Check if any secret is present in the log file
if grep -E "(senha|password|token|secret|chave)" test_log.txt; then
  echo "Secrets found in the log file"
  exit 1
else
  echo "No secrets found in the log file"
  exit 0
fi
