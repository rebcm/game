#!/bin/bash

README_FILE="README.md"

REQUIRED_HEADERS=(
  "# Projeto"
  "## Missão"
  "## Regras Invioláveis"
)

for HEADER in "${REQUIRED_HEADERS[@]}"; do
  if ! grep -q "^$HEADER" "$README_FILE"; then
    echo "Error: $HEADER not found in $README_FILE"
    exit 1
  fi
done

echo "README.md validation successful"
