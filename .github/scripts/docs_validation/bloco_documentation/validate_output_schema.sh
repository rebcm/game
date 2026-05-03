#!/bin/bash

schema_file=".github/scripts/docs_validation/bloco_documentation/output_schema.json"
output_file="docs/bloco_documentation.json"

if ! jq -e . >/dev/null 2>&1 "$output_file"; then
  echo "Invalid JSON in $output_file"
  exit 1
fi

if ! jq -s '.[0] as $schema | .[1] | map(select(.id != null)) | map({id, nome, descricao}) | . == $schema.blocos' "$schema_file" "$output_file" >/dev/null 2>&1; then
  echo "Output does not match the schema in $schema_file"
  exit 1
fi
