#!/bin/bash

# Lista de estruturas específicas do jogo que precisam de templates
estruturas_sugeridas=("castelo" "casa" "ponte" "jardim")

# Verifica se as estruturas sugeridas estão documentadas
for estrutura in "${estruturas_sugeridas[@]}"; do
  if ! grep -q "$estrutura" ./docs/estruturas_sugeridas.md; then
    echo "Estrutura '$estrutura' não está documentada."
    exit 1
  fi
done

echo "Todas as estruturas sugeridas estão documentadas."
exit 0
