#!/bin/bash

# Validar a existência da matriz de comparativo de áudio
if [ ! -f "./docs/audio/matriz_audio.md" ]; then
  echo "Erro: matriz_audio.md não encontrado."
  exit 1
fi

# Validar o conteúdo da matriz
grep -q "Modo Silencioso" ./docs/audio/matriz_audio.md && grep -q "Alternância de Hardware" ./docs/audio/matriz_audio.md
if [ $? -ne 0 ]; then
  echo "Erro: conteúdo da matriz_audio.md está incorreto."
  exit 1
fi

echo "Validação do comparativo de áudio concluída com sucesso."
