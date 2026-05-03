#!/bin/bash

# Verifica se o mapeamento de APIs de áudio foi atualizado
if ! diff -q ./docs/audio_api_mapping/README.md ./docs/audio_api_mapping/README.md.expected; then
  echo "Erro: O mapeamento de APIs de áudio não foi atualizado corretamente."
  exit 1
fi
