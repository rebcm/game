#!/bin/bash

README_FILE="README.md"

REQUIRED_HEADERS=(
  "# Projeto"
  "## Missão"
  "## Regras Invioláveis"
  "## Comandos Essenciais"
)

for HEADER in "${REQUIRED_HEADERS[@]}"; do
  if ! grep -q "$HEADER" "$README_FILE"; then
    echo "Erro: Cabeçalho '$HEADER' não encontrado no README.md"
    exit 1
  fi
done

echo "README.md validado com sucesso"
