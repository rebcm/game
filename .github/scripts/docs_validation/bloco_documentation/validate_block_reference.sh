#!/bin/bash

output=$(dart ./.github/scripts/docs_validation/bloco_documentation/extract_block_reference_matrix.dart)
echo "$output" > output.json

if ! jsonschema -i output.json ./.github/scripts/docs_validation/bloco_documentation/output_schema.json; then
  echo "Validation failed"
  exit 1
fi
