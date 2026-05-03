#!/bin/bash

# Validar a existência da matriz de resultados esperados
if [ ! -f "docs/audio_comparativo/matriz_resultados_esperados.md" ]; then
  echo "Erro: Matriz de resultados esperados não encontrada."
  exit 1
fi

# Validar o conteúdo da matriz
grep -q "Modo Silencioso" docs/audio_comparativo/matriz_resultados_esperados.md
if [ $? -ne 0 ]; then
  echo "Erro: Cenário 'Modo Silencioso' não encontrado na matriz."
  exit 1
fi

grep -q "Alternância HW" docs/audio_comparativo/matriz_resultados_esperados.md
if [ $? -ne 0 ]; then
  echo "Erro: Cenário 'Alternância HW' não encontrado na matriz."
  exit 1
fi

echo "Validação da matriz de resultados esperados concluída com sucesso."
