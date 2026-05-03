#!/bin/bash

# Verifica se as dicas foram aprovadas tecnicamente
if [ -f ./dicas_aprovadas.txt ]; then
  echo "Dicas aprovadas tecnicamente"
else
  echo "Erro: Dicas não aprovadas tecnicamente"
  exit 1
fi
