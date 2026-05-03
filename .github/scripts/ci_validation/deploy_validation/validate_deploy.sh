#!/bin/bash

# Validar critérios de aceitação
bash .github/scripts/ci_validation/deploy_validation/run_deploy_validation.sh

# Verificar se os testes passaram
if [ $? -eq 0 ]; then
  echo "Deploy validado com sucesso"
else
  echo "Falha na validação do deploy"
  exit 1
fi
