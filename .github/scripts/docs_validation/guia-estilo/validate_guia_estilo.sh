#!/bin/bash

# Verifica se o guia de estilo de pastas existe
if [ ! -f "docs/guia-estilo/estrutura-pastas.md" ]; then
  echo "O guia de estilo de pastas não existe."
  exit 1
fi

