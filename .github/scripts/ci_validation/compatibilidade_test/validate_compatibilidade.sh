#!/bin/bash

# Validar critérios de aceitação para compatibilidade
echo "Validando critérios de aceitação para compatibilidade..."

# Executar teste de compatibilidade
./.github/scripts/ci_validation/compatibilidade_test/run_compatibilidade_test.sh

# Verificar saída do teste
if [ $? -eq 0 ]; then
  echo "Critérios de aceitação para compatibilidade atendidos!"
else
  echo "Erro: Critérios de aceitação para compatibilidade não atendidos!"
  exit 1
fi
