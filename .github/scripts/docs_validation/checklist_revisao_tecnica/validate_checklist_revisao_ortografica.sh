#!/bin/bash

CONTENT_FILE=".github/scripts/docs_validation/checklist_revisao_tecnica/content/revisao_ortografica_task_1777666324-13-sub-6-disc-1777777797-3.md"

if [ ! -f "$CONTENT_FILE" ]; then
  echo "Arquivo $CONTENT_FILE não encontrado."
  exit 1
fi

# Verificar se o arquivo contém os critérios de aceitação
if ! grep -q "Critérios de Aceitação" "$CONTENT_FILE"; then
  echo "Critérios de Aceitação não encontrados no arquivo $CONTENT_FILE."
  exit 1
fi

# Verificar se o arquivo contém o processo de revisão
if ! grep -q "Processo de Revisão" "$CONTENT_FILE"; then
  echo "Processo de Revisão não encontrado no arquivo $CONTENT_FILE."
  exit 1
fi

echo "Validação do checklist de revisão ortográfica concluída com sucesso."
