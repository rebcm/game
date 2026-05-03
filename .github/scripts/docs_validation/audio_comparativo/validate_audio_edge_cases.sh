#!/bin/bash

# Validar se a matriz de edge cases foi atualizada
matrix_file="./.github/scripts/docs_validation/audio_comparativo/edge_cases_matrix.md"

if [ ! -f "$matrix_file" ]; then
  echo "Arquivo de matriz de edge cases não encontrado."
  exit 1
fi

# Verificar se o arquivo contém todas as colunas necessárias
required_columns=("Caso de Teste" "Descrição" "Comportamento Esperado iOS (AVAudioSession)" "Comportamento Esperado Android (AudioManager)")
column_count=$(head -n 1 "$matrix_file" | tr '|' '\n' | grep -v '^$' | wc -l)

if [ $column_count -ne ${#required_columns[@]} ]; then
  echo "A matriz de edge cases não contém todas as colunas necessárias."
  exit 1
fi

echo "Matriz de edge cases validada com sucesso."
