#!/bin/bash

# Compara as strings extraídas com os testes golden
if diff -q ./.github/scripts/docs_validation/dicas/dicas_golden.txt ./.github/scripts/docs_validation/dicas/dicas_extracted.txt; then
  echo "Dicas válidas"
else
  echo "Dicas inválidas"
  exit 1
fi
