#!/bin/bash

if [ -f "lib/docs/estruturas_sugeridas.txt" ]; then
  count=$(wc -l < lib/docs/estruturas_sugeridas.txt)
  if [ $count -gt 0 ]; then
    echo "Estruturas sugeridas validadas com sucesso!"
  else
    echo "Nenhuma estrutura sugerida encontrada."
    exit 1
  fi
else
  echo "Arquivo estruturas_sugeridas.txt não encontrado."
  exit 1
fi
