#!/bin/bash

# Validar a existência da documentação de mapeamento de APIs de áudio
if [ ! -f ./.github/scripts/ci_validation/audio_api_mapping/docs/criterios_aceitacao_audio_api_mapping.md ]; then
  echo "Erro: Documentação de mapeamento de APIs de áudio não encontrada."
  exit 1
fi

# Validar o conteúdo da documentação
if ! grep -q "Critérios de Aceitação para Mapeamento de APIs de Áudio" ./.github/scripts/ci_validation/audio_api_mapping/docs/criterios_aceitacao_audio_api_mapping.md; then
  echo "Erro: Conteúdo da documentação de mapeamento de APIs de áudio inválido."
  exit 1
fi

echo "Validação da documentação de mapeamento de APIs de áudio concluída com sucesso."
