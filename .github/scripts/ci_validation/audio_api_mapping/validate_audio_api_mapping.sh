#!/bin/bash

# Verifica se o arquivo README.md existe no diretório docs/audio_api_mapping
if [ ! -f ./docs/audio_api_mapping/README.md ]; then
  echo "Erro: Arquivo README.md não encontrado no diretório docs/audio_api_mapping"
  exit 1
fi

# Verifica se o conteúdo do arquivo README.md está correto
if ! grep -q "Mapeamento de APIs de Áudio por Plataforma" ./docs/audio_api_mapping/README.md; then
  echo "Erro: Conteúdo do arquivo README.md incorreto"
  exit 1
fi

echo "Validação do mapeamento de APIs de áudio bem-sucedida"
