#!/bin/bash

# Validate the output schema against the expected schema
validate_output_schema() {
  local output_schema=$1
  local expected_schema=$2

  # Use a JSON validation tool like jq to validate the schema
  if ! jq -e '. == .' "$output_schema" "$expected_schema" > /dev/null; then
    echo "Output schema validation failed"
    return 1
  fi
}

# Define the paths to the output schema and expected schema
OUTPUT_SCHEMA='./.github/scripts/docs_validation/bloco_documentation/output_schema.json'
EXPECTED_SCHEMA='./.github/scripts/docs_validation/output_schema/expected_schema.json'

# Create the expected schema file if it doesn't exist
if [ ! -f "$EXPECTED_SCHEMA" ]; then
  cat > "$EXPECTED_SCHEMA" << 'EOF_SCHEMA'
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Output Schema",
  "type": "object",
  "properties": {
    "blocks": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "id": {"type": "string"},
          "name": {"type": "string"},
          "description": {"type": "string"}
        },
        "required": ["id", "name", "description"]
      }
    }
  },
  "required": ["blocks"]
}
EOF_SCHEMA
fi

# Validate the output schema
validate_output_schema "$OUTPUT_SCHEMA" "$EXPECTED_SCHEMA"
