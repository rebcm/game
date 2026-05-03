#!/bin/bash

JSON_FILE=.github/scripts/docs_validation/output_schema/output_schema.json
OUTPUT_FILE=.github/scripts/docs_validation/bloco_documentation/output.json

if ! jq -e . >/dev/null 2>&1 < "$OUTPUT_FILE"; then
  echo "Invalid JSON in $OUTPUT_FILE"
  exit 1
fi

if ! jsonschema -i "$OUTPUT_FILE" "$JSON_FILE"; then
  echo "Output does not match the schema"
  exit 1
fi
