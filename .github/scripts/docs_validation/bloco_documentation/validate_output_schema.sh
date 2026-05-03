#!/bin/bash

OUTPUT_FILE=$1

if ! command -v jq &> /dev/null; then
  echo "jq is not installed. Please install jq to validate JSON."
  exit 1
fi

jq -e '.blocos | type == "array"' $OUTPUT_FILE > /dev/null
if [ $? -ne 0 ]; then
  echo "Validation failed: 'blocos' is not an array."
  exit 1
fi

echo "Validation successful."
