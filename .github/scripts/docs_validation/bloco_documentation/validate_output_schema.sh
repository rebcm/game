#!/bin/bash

schema_file="./.github/scripts/docs_validation/bloco_documentation/output_schema.json"
output_file="./.github/scripts/docs_validation/bloco_documentation/block_reference.json"

if ! jq -e . "$output_file" > /dev/null; then
  echo "Invalid JSON in $output_file"
  exit 1
fi

if ! jsonschema -i "$output_file" "$schema_file"; then
  echo "Validation failed against schema in $schema_file"
  exit 1
fi
