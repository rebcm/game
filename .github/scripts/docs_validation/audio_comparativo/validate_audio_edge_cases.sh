#!/bin/bash

edge_cases_matrix_file="./.github/scripts/docs_validation/audio_comparativo/edge_cases_matrix.md"

if [ ! -f "$edge_cases_matrix_file" ]; then
  echo "Arquivo edge_cases_matrix.md não encontrado."
  exit 1
fi

count=$(grep -c "| Modo Silencioso |" "$edge_cases_matrix_file")

if [ "$count" -eq 0 ]; then
  echo "Caso de teste 'Modo Silencioso' não encontrado no arquivo edge_cases_matrix.md."
  exit 1
fi

echo "Validação concluída com sucesso."
