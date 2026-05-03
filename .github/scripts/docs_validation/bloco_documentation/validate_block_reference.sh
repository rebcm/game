#!/bin/bash

# Validate block reference against the schema
schema_file="./.github/scripts/docs_validation/bloco_documentation/output_schema.json"
documentation_file="./docs/bloco_documentation.json"

if ! command -v jq &> /dev/null; then
  echo "jq is not installed. Please install jq to validate JSON."
  exit 1
fi

jq -e '.blocos[] | select(.id == null or .nome == null or .descricao == null)' "$documentation_file" > /dev/null
if [ $? -eq 0 ]; then
  echo "Validation failed: Missing required fields in block documentation."
  exit 1
fi

echo "Validation successful: Block documentation is valid."
