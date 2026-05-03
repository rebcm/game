#!/bin/bash

# Validate bloco documentation against the schema
schema_file=.github/scripts/docs_validation/bloco_documentation/output_schema.json
docs_file=docs/bloco_documentation.json

if ! command -v jq &> /dev/null; then
  echo "jq is not installed. Please install jq to validate JSON."
  exit 1
fi

jq -e '. | tojson | fromjson | . == .' < "$schema_file" > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Schema file is not valid JSON."
  exit 1
fi

if [ ! -f "$docs_file" ]; then
  echo "Documentation file not found: $docs_file"
  exit 1
fi

jq -e '. | tojson | fromjson' < "$docs_file" > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Documentation file is not valid JSON."
  exit 1
fi

if jq -e '.blocos[] | select(.id == null or .nome == null or .descricao == null)' < "$docs_file" > /dev/null 2>&1; then
  echo "Documentation file does not conform to the schema."
  exit 1
fi

echo "Documentation file is valid."
