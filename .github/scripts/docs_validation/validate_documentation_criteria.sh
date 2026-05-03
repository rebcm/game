#!/bin/bash

check_documentation() {
  local file=$1
  local has_description=false
  local is_ptbr=false

  while IFS= read -r line; do
    if [[ $line =~ ^##\ Descrição ]]; then
      has_description=true
    fi
    if [[ $line =~ [Pp]ortuguês.*[Bb]rasil ]]; then
      is_ptbr=true
    fi
  done < "$file"

  if [ $has_description = false ]; then
    echo "Error: $file is missing a description section"
    return 1
  fi

  if [ $is_ptbr = false ]; then
    echo "Error: $file is not in PT-BR"
    return 1
  fi
}

for file in docs/**/*.md; do
  check_documentation "$file"
done

# Validate OpenAPI contract
bash .github/scripts/docs_validation/validate_openapi_contract_test.sh
. .github/scripts/validate_responsividade.sh
./.github/scripts/docs_validation/env_validation/validate_env_example.sh
