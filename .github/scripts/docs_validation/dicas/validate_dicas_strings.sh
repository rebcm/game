#!/bin/bash

# Validar se as dicas de construção estão de acordo com o esperado
if grep -q "TODO" ./lib/docs/dicas/construcao.md; then
  echo "Erro: Encontrado 'TODO' no arquivo de dicas de construção."
  exit 1
fi

echo "Dicas de construção validadas com sucesso."
