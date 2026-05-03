#!/bin/bash

# Lista de estruturas sugeridas que precisam de templates
ESTRUTURAS_SUGERIDAS=("castelo" "cabana" "ponte" "labirinto")

# Verifica se os templates existem
for estrutura in "${ESTRUTURAS_SUGERIDAS[@]}"; do
  if [ ! -f "assets/estruturas_sugeridas/$estrutura.json" ]; then
    echo "Erro: Template para '$estrutura' não encontrado."
    exit 1
  fi
done

echo "Todos os templates de estruturas sugeridas estão presentes."
