#!/bin/bash

if ! command -v jsonschema &> /dev/null; then
  echo "jsonschema não encontrado. Por favor, instale usando 'pip install jsonschema'"
  exit 1
fi

./.github/scripts/docs_validation/bloco_documentation/validate_block_reference.sh
