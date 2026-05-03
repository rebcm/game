#!/bin/bash

# Validar se o arquivo de critérios de aceitação existe
if [ ! -f docs/criterios/criterios_aceitacao_ux_dicas.md ]; then
  echo "Arquivo de critérios de aceitação não encontrado"
  exit 1
fi

# Validar se o arquivo de critérios de aceitação contém as métricas de avaliação
if ! grep -q "Métricas de Avaliação" docs/criterios/criterios_aceitacao_ux_dicas.md; then
  echo "Arquivo de critérios de aceitação não contém as métricas de avaliação"
  exit 1
fi

# Validar se o arquivo de critérios de aceitação contém os critérios de aceitação
if ! grep -q "Critérios de Aceitação" docs/criterios/criterios_aceitacao_ux_dicas.md; then
  echo "Arquivo de critérios de aceitação não contém os critérios de aceitação"
  exit 1
fi

echo "Validação do arquivo de critérios de aceitação concluída com sucesso"
