#!/bin/bash

# Valida se o mapeamento de APIs de áudio foi realizado corretamente

if [ ! -f ./docs/audio_api_mapping/README.md ]; then
  echo "Erro: O arquivo README.md não existe em ./docs/audio_api_mapping/"
  exit 1
fi

# Verifica se o arquivo contém a tabela de matriz de suporte
if ! grep -q "| Plataforma | Versão Mínima | API de Áudio         |" ./docs/audio_api_mapping/README.md; then
  echo "Erro: A tabela de matriz de suporte não foi encontrada no README.md"
  exit 1
fi

echo "Validação do mapeamento de APIs de áudio concluída com sucesso"
