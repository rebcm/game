#!/bin/bash

# Verifica se o arquivo de dicas foi modificado
if git diff --name-only HEAD~1 | grep -q "lib/docs/dicas/"; then
  # Executa a validação das dicas
  dart ./.github/scripts/docs_validation/dicas/extract_dicas_strings.dart
  ./.github/scripts/docs_validation/dicas/validate_dicas_golden_tests.sh
fi
