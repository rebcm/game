#!/bin/bash

# Valida se o mapeamento de APIs de áudio está atualizado

# Verifica se o arquivo README.md existe
if [ ! -f ./docs/audio_api_mapping/README.md ]; then
  echo "Erro: Arquivo README.md não encontrado"
  exit 1
fi

# Verifica se o conteúdo do arquivo README.md está correto
if ! grep -q "Mapeamento de APIs de Áudio por Plataforma" ./docs/audio_api_mapping/README.md; then
  echo "Erro: Conteúdo do arquivo README.md incorreto"
  exit 1
fi

echo "Mapeamento de APIs de áudio validado com sucesso"
exit 0

