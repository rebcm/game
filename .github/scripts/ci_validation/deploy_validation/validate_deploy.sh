#!/bin/bash

bash .github/scripts/ci_validation/deploy_validation/run_deploy_validation.sh

if [ $? -ne 0 ]; then
  echo "Falha na validação do deploy"
  exit 1
fi

