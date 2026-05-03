#!/bin/bash

# Validar se o arquivo audio_api_comparativo.md existe
if [ ! -f docs/audio_api_comparativo/audio_api_comparativo.md ]; then
  echo "Arquivo audio_api_comparativo.md não encontrado."
  exit 1
fi

# Validar conteúdo do arquivo
grep -q "Matriz de Resultados Esperados" docs/audio_api_comparativo/audio_api_comparativo.md
if [ $? -ne 0 ]; then
  echo "Conteúdo inválido no arquivo audio_api_comparativo.md."
  exit 1
fi

echo "Validação do comparativo de áudio concluída com sucesso."

