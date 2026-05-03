#!/bin/bash

# Validar se o arquivo de definição da matriz de resoluções existe
if [ ! -f ./docs/resolucoes_tela/definicao_matriz_resolucoes.md ]; then
  echo "Erro: Arquivo de definição da matriz de resoluções não encontrado."
  exit 1
fi

# Validar o conteúdo do arquivo
grep -q "Matriz de Resoluções de Tela" ./docs/resolucoes_tela/definicao_matriz_resolucoes.md
if [ $? -ne 0 ]; then
  echo "Erro: Conteúdo inválido no arquivo de definição da matriz de resoluções."
  exit 1
fi

echo "Validação da matriz de resoluções realizada com sucesso."
