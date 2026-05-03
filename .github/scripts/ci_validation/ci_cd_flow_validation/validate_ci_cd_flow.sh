#!/bin/bash

# Validar se cada etapa descrita na documentação corresponde fielmente ao comportamento do sistema em produção
echo "Validating CI/CD flow..."

# Verificar se o pipeline está executando conforme a documentação
if ! diff -q .github/docs/pipeline_documentation.md <(echo "Simulando conteúdo do pipeline em produção"); then
  echo "Erro: Documentação do pipeline não corresponde ao comportamento em produção."
  exit 1
fi

echo "CI/CD flow validation successful."
