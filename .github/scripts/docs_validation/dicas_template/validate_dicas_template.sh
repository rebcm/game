#!/bin/bash

validate_dicas_template() {
  local dicas_dir="game/docs/dicas"
  local template=".github/scripts/docs_validation/dicas_template/template.md"

  for dica_file in "$dicas_dir"/*.md; do
    if ! diff -q "$template" "$dica_file" > /dev/null; then
      echo "Dica $dica_file não segue o template padrão."
      exit 1
    fi
  done
}

validate_dicas_template
