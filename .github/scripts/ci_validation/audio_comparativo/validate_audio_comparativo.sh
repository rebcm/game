#!/bin/bash

# Validar a existência e conteúdo do arquivo audio_api_comparativo.md
if [ ! -f docs/audio_api_comparativo/audio_api_comparativo.md ]; then
  echo "Arquivo audio_api_comparativo.md não encontrado."
  exit 1
fi

# Verificar se o arquivo contém a tabela comparativa
if ! grep -q "| Cenário | Android | iOS |" docs/audio_api_comparativo/audio_api_comparativo.md; then
  echo "Tabela comparativa não encontrada no arquivo audio_api_comparativo.md."
  exit 1
fi

echo "Validação do comparativo de áudio concluída com sucesso."
