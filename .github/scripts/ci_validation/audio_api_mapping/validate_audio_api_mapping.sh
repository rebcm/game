#!/bin/bash

# Verifica se o documento de mapeamento de APIs de áudio existe
if [ ! -f ./docs/audio_api_mapping/README.md ]; then
  echo "Erro: Documento de mapeamento de APIs de áudio não encontrado."
  exit 1
fi

# Verifica se o documento de mapeamento de APIs de áudio está atualizado
if ! grep -q "Flutter Web (Web Audio API)" ./docs/audio_api_mapping/README.md; then
  echo "Erro: Documento de mapeamento de APIs de áudio desatualizado."
  exit 1
fi

if ! grep -q "Android (AudioTrack/MediaPlayer)" ./docs/audio_api_mapping/README.md; then
  echo "Erro: Documento de mapeamento de APIs de áudio desatualizado."
  exit 1
fi

if ! grep -q "iOS (AVAudioPlayer)" ./docs/audio_api_mapping/README.md; then
  echo "Erro: Documento de mapeamento de APIs de áudio desatualizado."
  exit 1
fi

echo "Validação do documento de mapeamento de APIs de áudio concluída com sucesso."
