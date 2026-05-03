#!/bin/bash

OUTPUT_FILE=$1

if ! command -v jq &> /dev/null; then
  echo "jq is required but not installed"
  exit 1
fi

jq -e '.blocos | type == "array"' $OUTPUT_FILE > /dev/null
if [ $? -ne 0 ]; then
  echo "Invalid output schema: 'blocos' must be an array"
  exit 1
fi

echo "Output schema is valid"
