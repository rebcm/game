#!/bin/bash

README_FILE="README.md"

if [ ! -f "$README_FILE" ]; then
  echo "README.md not found"
  exit 1
fi

REQUIRED_HEADERS=("# Projeto" "# Missão" "# Regras Invioláveis")

for HEADER in "${REQUIRED_HEADERS[@]}"; do
  if ! grep -q "^$HEADER" "$README_FILE"; then
    echo "Missing required header: $HEADER"
    exit 1
  fi
done

echo "README.md validation successful"
exit 0
