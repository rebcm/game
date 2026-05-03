#!/bin/bash

# Executa a validação das estruturas sugeridas
./.github/scripts/docs_validation/estruturas_sugeridas/run_validation.sh
if [ $? -ne 0 ]; then
  echo "Falha ao validar estruturas sugeridas."
  exit 1
fi

echo "Estruturas sugeridas validadas com sucesso."
