#!/bin/bash

# Executa o teste E2E
bash .github/scripts/ci_validation/e2e_pipeline_test/run_e2e_pipeline_test.sh

# Verifica o resultado do teste
if [ $? -ne 0 ]; then
  echo "Falha no teste E2E!"
  exit 1
fi

echo "Validação do teste E2E concluída com sucesso!"
exit 0

