#!/bin/bash

# Validates the content approval flow documentation
# Checks if the necessary files and configurations are in place

# Check if the dicas template is valid
if ! grep -q "Aprovador:" .github/scripts/docs_validation/dicas_template/template.md; then
  echo "Error: dicas template is missing Aprovador field"
  exit 1
fi

# Check if the dicas content has been approved
if ! grep -q "Aprovado por:" game/docs/dicas/dicas.md; then
  echo "Error: dicas content is missing Aprovado por field"
  exit 1
fi
