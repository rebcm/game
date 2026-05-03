#!/bin/bash

# Validate API acceptance criteria
validate_api_criteria() {
  local api_docs_file="docs/api_documentation.md"
  local required_endpoints=("GET /api/blocks" "POST /api/blocks" "GET /api/biome")

  if [ ! -f "$api_docs_file" ]; then
    echo "API documentation file not found: $api_docs_file"
    return 1
  fi

  for endpoint in "${required_endpoints[@]}"; do
    if ! grep -q "$endpoint" "$api_docs_file"; then
      echo "Missing endpoint in API documentation: $endpoint"
      return 1
    fi
  done

  echo "API acceptance criteria validated successfully"
  return 0
}

validate_api_criteria
