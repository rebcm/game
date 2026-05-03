#!/bin/bash

# Validação da documentação de biomas

# Verifica se o arquivo de descrição de biomas existe
if [ ! -f ./game/docs/biomas/descrição_biomas.md ]; then
  echo "Erro: Arquivo de descrição de biomas não encontrado."
  exit 1
fi

# Verifica se o conteúdo do arquivo não está vazio
if [ ! -s ./game/docs/biomas/descrição_biomas.md ]; then
  echo "Erro: Arquivo de descrição de biomas está vazio."
  exit 1
fi

echo "Documentação de biomas validada com sucesso."
