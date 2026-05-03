#!/bin/bash

# Validate API documentation criteria
if ! grep -q "Endpoints obrigatórios:" ./lib/docs/api_documentation.md; then
  echo "API documentation is missing required endpoints section"
  exit 1
fi

if ! grep -q "Validação de tipos de dados:" ./lib/docs/api_documentation.md; then
  echo "API documentation is missing data type validation section"
  exit 1
fi

if ! grep -q "Exemplos de payloads:" ./lib/docs/api_documentation.md; then
  echo "API documentation is missing payload examples section"
  exit 1
fi
