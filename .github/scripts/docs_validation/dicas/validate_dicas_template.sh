#!/bin/bash

# Validar se as dicas seguem o template definido
validate_dicas() {
  local dicas_dir="./lib/docs/dicas"
  for file in "$dicas_dir"/*.md; do
    if ! grep -q "^# " "$file"; then
      echo "Erro: $file não contém um título"
      return 1
    fi
    if ! grep -q "## Descrição:" "$file"; then
      echo "Erro: $file não contém uma descrição"
      return 1
    fi
  done
}

validate_dicas
