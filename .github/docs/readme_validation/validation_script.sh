#!/bin/bash

required_headers=("PROJECT RULES" "Missão" "Regras Invioláveis" "Comandos Essenciais")
file_path="README.md"

if [ ! -f "$file_path" ]; then
  echo "Error: $file_path not found."
  exit 1
fi

for header in "${required_headers[@]}"; do
  if ! grep -q "^# .*${header}" "$file_path"; then
    echo "Error: '$header' not found in $file_path"
    exit 1
  fi
done

echo "All required headers found in README.md"
exit 0
