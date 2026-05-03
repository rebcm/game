#!/bin/bash

# Validação do conteúdo das dicas de construção

# Verifica se o arquivo de conteúdo existe
if [ ! -f docs/dicas/conteudo.md ]; then
  echo "Erro: Arquivo de conteúdo das dicas não encontrado."
  exit 1
fi

# Verifica se o conteúdo está vazio
if [ ! -s docs/dicas/conteudo.md ]; then
  echo "Erro: Conteúdo das dicas está vazio."
  exit 1
fi

echo "Validação das dicas de construção concluída com sucesso."
