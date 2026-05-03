#!/bin/bash

# Critérios de Aceitação para UI de Dicas
# Verificar se os critérios de aceitação para a UI de dicas estão definidos corretamente

# Verificar se o arquivo de critérios de aceitação existe
if [ ! -f "./game/docs/criterios_aceitacao_ui_dicas.md" ]; then
  echo "Arquivo de critérios de aceitação não encontrado"
  exit 1
fi

# Verificar se os critérios de aceitação estão definidos corretamente
if ! grep -q "Critérios de Aceitação" "./game/docs/criterios_aceitacao_ui_dicas.md"; then
  echo "Critérios de aceitação não definidos corretamente"
  exit 1
fi

echo "Critérios de aceitação para UI de dicas validados com sucesso"
