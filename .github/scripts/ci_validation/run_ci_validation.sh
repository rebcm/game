#!/bin/bash

# Run all CI validations
echo "Running clean build validation..."
bash .github/scripts/ci_validation/clean_build/run_clean_build_validation.sh

if [ $? -eq 0 ]; then
  echo "All CI validations successful."
else
  echo "One or more CI validations failed."
  exit 1
fi
