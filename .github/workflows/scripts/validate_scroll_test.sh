#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <test_result_file>"
  exit 1
fi

RESULT_FILE=$1

if grep -q "All tests passed" "$RESULT_FILE"; then
  echo "Scroll test passed"
  exit 0
else
  echo "Scroll test failed"
  exit 1
fi
