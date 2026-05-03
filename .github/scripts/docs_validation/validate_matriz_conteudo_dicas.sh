#!/bin/bash

.github/scripts/docs_validation/matriz_conteudo_dicas/run_extract_matriz_conteudo_dicas.sh

if [ -f "docs/matriz_conteudo_dicas.json" ]; then
  echo "Matriz de conteúdo de dicas gerada com sucesso."
else
  echo "Falha ao gerar matriz de conteúdo de dicas."
  exit 1
fi
