#!/bin/bash

# Validar o conteúdo do arquivo de critérios de aceitação
if grep -q "Critérios de Aceitação para UI de Dicas" .github/scripts/docs_validation/criterios_aceitacao_documentacao/content/criterios_aceitacao_task_1777666324-13-sub-6-disc-1777777940-1-disc-1777778282-1.md; then
  echo "Critérios de Aceitação validados com sucesso."
else
  echo "Erro: Critérios de Aceitação não atendidos."
  exit 1
fi
