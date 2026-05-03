#!/bin/bash

# Verificar se a matriz de resultados esperados para áudio existe
if [ ! -f "docs/audio_comparativo/matriz_resultados_esperados.md" ]; then
  echo "Erro: Matriz de resultados esperados para áudio não encontrada."
  exit 1
fi

# Verificar se a matriz de resultados esperados para áudio está correta
if ! grep -q "Modo Silencioso" "docs/audio_comparativo/matriz_resultados_esperados.md"; then
  echo "Erro: Matriz de resultados esperados para áudio está incorreta."
  exit 1
fi

echo "Validação da matriz de resultados esperados para áudio concluída com sucesso."
