#!/bin/bash

CHECKLIST_FILE=".github/scripts/docs_validation/checklist_revisao_tecnica/checklist_revisao_tecnica.md"

if [ ! -f "$CHECKLIST_FILE" ]; then
  echo "Checklist de Revisão Técnica não encontrado."
  exit 1
fi

# Lógica para validar o conteúdo do checklist
# Por exemplo, verificar se os critérios de aceitação estão presentes
if ! grep -q "Critérios de Aceitação" "$CHECKLIST_FILE"; then
  echo "Critérios de Aceitação não encontrados no checklist."
  exit 1
fi

echo "Checklist de Revisão Técnica validado com sucesso."
exit 0
