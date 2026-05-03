#!/bin/bash

# Validar se a documentação existe
if [ ! -f .github/scripts/docs_validation/criterios_aceitacao_documentacao/content/criterios_aceitacao_task_1777666324-13-sub-4-disc-1777777740-2-disc-1777778833-1.md ]; then
  echo "Documentação não encontrada"
  exit 1
fi

# Validar se a documentação contém os critérios de aceitação
if ! grep -q "Critérios de Aceitação" .github/scripts/docs_validation/criterios_aceitacao_documentacao/content/criterios_aceitacao_task_1777666324-13-sub-4-disc-1777777740-2-disc-1777778833-1.md; then
  echo "Critérios de aceitação não encontrados na documentação"
  exit 1
fi

echo "Documentação validada com sucesso"
exit 0

