#!/bin/bash

# Validar checklist_revisao_tecnica.md
if [ -f .github/scripts/docs_validation/checklist_revisao_tecnica/checklist_revisao_tecnica.md ]; then
  echo "Checklist de Revisão Técnica encontrado."
else
  echo "Checklist de Revisão Técnica não encontrado."
  exit 1
fi

# Validar revisao_ortografica_task_1777666324-13-sub-6-disc-1777777797-3.md
if [ -f .github/scripts/docs_validation/checklist_revisao_tecnica/content/revisao_ortografica_task_1777666324-13-sub-6-disc-1777777797-3.md ]; then
  echo "Revisão Ortográfica e Técnica do Conteúdo encontrado."
else
  echo "Revisão Ortográfica e Técnica do Conteúdo não encontrado."
  exit 1
fi
