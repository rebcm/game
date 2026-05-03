#!/bin/bash

# Valida se o mapeamento de APIs de áudio foi documentado corretamente

if [ ! -f ./docs/audio_api_mapping/README.md ]; then
  echo "Erro: O arquivo README.md não existe em ./docs/audio_api_mapping"
  exit 1
fi

