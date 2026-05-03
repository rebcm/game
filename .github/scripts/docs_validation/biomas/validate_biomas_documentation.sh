#!/bin/bash

# Validar se a documentação de biomas existe e não está vazia
if [ ! -f ./docs/biomas/descrição.md ] || [ ! -s ./docs/biomas/descrição.md ]; then
  echo "Documentação de biomas está faltando ou vazia"
  exit 1
fi

