#!/bin/bash

# Validar build
if grep -q "Build successful" .github/scripts/ci_validation/ci_cd_docs/docs/build_log.txt; then
  echo "Build validado com sucesso"
else
  echo "Falha na validação do build"
  exit 1
fi

# Validar test
if grep -q "Tests passed" .github/scripts/ci_validation/ci_cd_docs/docs/test_results.txt; then
  echo "Testes validados com sucesso"
else
  echo "Falha na validação dos testes"
  exit 1
fi

# Validar lint
if grep -q "Lint successful" .github/scripts/ci_validation/ci_cd_docs/docs/lint_results.txt; then
  echo "Lint validado com sucesso"
else
  echo "Falha na validação do lint"
  exit 1
fi

# Validar deploy
if grep -q "Deploy successful" .github/scripts/ci_validation/ci_cd_docs/docs/deploy_log.txt; then
  echo "Deploy validado com sucesso"
else
  echo "Falha na validação do deploy"
  exit 1
fi

echo "Todos os critérios de aceitação foram atendidos"
