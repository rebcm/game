#!/bin/bash

OUTPUT_FILE=$1

if ! command -v jq &> /dev/null; then
  echo "jq is not installed. Please install jq to validate JSON schema."
  exit 1
fi

jq -e '.blocks | length > 0' $OUTPUT_FILE > /dev/null
if [ $? -ne 0 ]; then
  echo "Validation failed: 'blocks' array is empty or missing."
  exit 1
fi

echo "Validation succeeded: Output schema is valid."
