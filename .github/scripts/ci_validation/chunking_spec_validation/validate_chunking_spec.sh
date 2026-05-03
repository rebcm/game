#!/bin/bash

# Verifica se o tamanho do chunk está definido corretamente
if [ "$(grep -c 'O tamanho do chunk é definido como 16x16 blocos' ./docs/specs/chunking_spec.md)" -eq 1 ]; then
  echo "Tamanho do chunk validado com sucesso"
else
  echo "Erro: Tamanho do chunk não está definido corretamente"
  exit 1
fi

# Verifica se a margem de pré-carregamento está definida corretamente
if [ "$(grep -c 'A margem de pré-carregamento ao redor do jogador é definida como 2 chunks' ./docs/specs/chunking_spec.md)" -eq 1 ]; then
  echo "Margem de pré-carregamento validada com sucesso"
else
  echo "Erro: Margem de pré-carregamento não está definida corretamente"
  exit 1
fi
