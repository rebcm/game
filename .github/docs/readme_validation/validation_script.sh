#!/bin/bash

required_headers=("PROJECT RULES" "Missão" "Regras Invioláveis" "Comandos Essenciais")
readme_file="README.md"

if [ ! -f "$readme_file" ]; then
  echo "README.md not found"
  exit 1
fi

for header in "${required_headers[@]}"; do
  if ! grep -q "^# .*${header}" "$readme_file"; then
    echo "Missing header: $header"
    exit 1
  fi
done

echo "README.md validation successful"
exit 0
