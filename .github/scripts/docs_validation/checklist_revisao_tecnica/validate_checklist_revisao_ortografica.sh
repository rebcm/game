#!/bin/bash

# Verifica se o arquivo checklist_revisao_tecnica.md foi modificado
if git diff --name-only HEAD~1 HEAD | grep -q ".github/scripts/docs_validation/checklist_revisao_tecnica/checklist_revisao_tecnica.md"; then
  # Executa a validação do conteúdo
  dart ./.github/scripts/docs_validation/estruturas_sugeridas/extract_estruturas_sugeridas.dart
  # Verifica se houve erros durante a validação
  if [ $? -ne 0 ]; then
    echo "Erro durante a validação do conteúdo"
    exit 1
  fi
fi
