#!/bin/bash

if [ -f "lib/docs/estruturas_sugeridas.md" ]; then
  echo "Estruturas sugeridas validadas com sucesso."
else
  echo "Erro ao validar estruturas sugeridas."
  exit 1
fi
