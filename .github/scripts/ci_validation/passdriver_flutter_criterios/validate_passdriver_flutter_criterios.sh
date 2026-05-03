#!/bin/bash

# Verificar se o arquivo de critérios de aceitação existe
if [ ! -f ./.github/docs/passdriver_flutter_criterios/criterios_aceitacao.md ]; then
  echo "Arquivo de critérios de aceitação não encontrado."
  exit 1
fi

# Verificar se o arquivo de critérios de aceitação está vazio
if [ ! -s ./.github/docs/passdriver_flutter_criterios/criterios_aceitacao.md ]; then
  echo "Arquivo de critérios de aceitação está vazio."
  exit 1
fi

echo "Critérios de aceitação validados com sucesso."
exit 0
