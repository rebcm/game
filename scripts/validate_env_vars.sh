#!/bin/bash

# List of expected environment variables
EXPECTED_VARS=("VARIABLE_1" "VARIABLE_2" "VARIABLE_3")

for var in "${EXPECTED_VARS[@]}"; do
  if grep -q "$var" .env; then
    echo "$var found in .env"
  else
    echo "$var not found in .env"
    exit 1
  fi
done
