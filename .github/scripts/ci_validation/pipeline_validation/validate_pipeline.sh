#!/bin/bash

# Valida a execução do pipeline comparando com a documentação

# Lê a documentação do pipeline
PIPELINE_DOC=$(cat .github/docs/pipeline_documentation.md)

# Lê as etapas do pipeline do arquivo de configuração
PIPELINE_CONFIG=$(cat .github/workflows/main.yml)

# Compara as etapas documentadas com as etapas configuradas
if ! diff -q <(echo "$PIPELINE_DOC" | grep -oP '(?<=## Etapas do Pipeline).*?(?=##)') <(echo "$PIPELINE_CONFIG" | grep -oP '(?<=jobs:).*?(?=EOF)') > /dev/null; then
  echo "Diferença encontrada entre a documentação e a configuração do pipeline."
  exit 1
fi

echo "Pipeline validado com sucesso."
