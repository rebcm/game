#!/bin/bash

# Validar se os templates necessários existem
templates=(casa_basica.json torre_alta.json ponte_simples.json jardim.json labirinto.json)
for template in "${templates[@]}"; do
  if [ ! -f "assets/estruturas_sugeridas/$template" ]; then
    echo "Erro: Template $template não encontrado."
    exit 1
  fi
done

echo "Todos os templates necessários estão presentes."
