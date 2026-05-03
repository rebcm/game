#!/bin/bash

# Valida a documentação da API
echo "Validando critérios de aceitação da API..."

# Verifica se os endpoints obrigatórios estão documentados
if ! grep -q "/api/v1/blocos" .github/scripts/docs_validation/criterios_aceitacao_api/content/criterios_aceitacao_api_task_1777666324-13-sub-9-disc-1777779502-1-disc-1777780486-2.md; then
  echo "Erro: Endpoint /api/v1/blocos não documentado"
  exit 1
fi

if ! grep -q "/api/v1/biomas" .github/scripts/docs_validation/criterios_aceitacao_api/content/criterios_aceitacao_api_task_1777666324-13-sub-9-disc-1777779502-1-disc-1777780486-2.md; then
  echo "Erro: Endpoint /api/v1/biomas não documentado"
  exit 1
fi

if ! grep -q "/api/v1/rebeca" .github/scripts/docs_validation/criterios_aceitacao_api/content/criterios_aceitacao_api_task_1777666324-13-sub-9-disc-1777779502-1-disc-1777780486-2.md; then
  echo "Erro: Endpoint /api/v1/rebeca não documentado"
  exit 1
fi

echo "Critérios de aceitação da API validados com sucesso!"
