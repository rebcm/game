#!/bin/bash

# Validates the documentation checklist
# Checks if the required topics are present in dicas.md

required_topics=("Versão do Flutter" "Dependências" "Variáveis de Ambiente" "Comandos de Build")
dicas_file="docs/dicas.md"

if [ ! -f "$dicas_file" ]; then
  echo "Error: $dicas_file not found"
  exit 1
fi

for topic in "${required_topics[@]}"; do
  if ! grep -q "$topic" "$dicas_file"; then
    echo "Error: $topic not found in $dicas_file"
    exit 1
  fi
done

echo "Documentation checklist validation successful"
