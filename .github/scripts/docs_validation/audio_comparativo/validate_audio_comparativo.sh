#!/bin/bash

# Validar se o arquivo de comparativo de APIs de áudio existe
if [ ! -f "docs/audio_api_comparativo/audio_api_comparativo.md" ]; then
    echo "Arquivo de comparativo de APIs de áudio não encontrado."
    exit 1
fi

# Validar se o arquivo de comparativo de APIs de áudio está atualizado
if ! grep -q "Comparativo de APIs de Áudio" "docs/audio_api_comparativo/audio_api_comparativo.md"; then
    echo "Arquivo de comparativo de APIs de áudio desatualizado."
    exit 1
fi

