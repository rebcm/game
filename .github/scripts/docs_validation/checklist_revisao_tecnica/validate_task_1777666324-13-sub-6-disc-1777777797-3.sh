#!/bin/bash

CONTENT_FILE=".github/scripts/docs_validation/checklist_revisao_tecnica/content/revisao_ortografica_task_1777666324-13-sub-6-disc-1777777797-3.md"

if [ ! -f "$CONTENT_FILE" ]; then
  echo "Arquivo de conteúdo não encontrado: $CONTENT_FILE"
  exit 1
fi

# Verificar se o arquivo contém os critérios de aceitação
if ! grep -q "Critérios de Aceitação" "$CONTENT_FILE"; then
  echo "Critérios de Aceitação não encontrados no arquivo de conteúdo."
  exit 1
fi

# Verificar se o arquivo contém os passos para execução
if ! grep -q "Passos para Execução" "$CONTENT_FILE"; then
  echo "Passos para Execução não encontrados no arquivo de conteúdo."
  exit 1
fi

echo "Validação concluída com sucesso."
