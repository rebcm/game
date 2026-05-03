#!/bin/bash

# Validates the documentation acceptance criteria
# Checks if the required dicas are present and in the correct format

# Check if the dicas file exists
if [ ! -f ./docs/dicas.md ]; then
  echo "Error: dicas.md file not found"
  exit 1
fi

# Check if the dicas file contains the required headers
required_headers=("Dicas Obrigatórias" "Formato de Exibição" "Métrica de Validação")
for header in "${required_headers[@]}"; do
  if ! grep -q "^# $header$" ./docs/dicas.md; then
    echo "Error: $header not found in dicas.md"
    exit 1
  fi
done

# Check if the dicas list is not empty
if ! grep -q "^-\|^#" ./docs/dicas.md; then
  echo "Error: dicas list is empty"
  exit 1
fi

echo "Documentation acceptance criteria validated successfully"
