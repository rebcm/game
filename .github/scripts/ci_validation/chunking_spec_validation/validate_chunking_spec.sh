#!/bin/bash

# Verifica se o tamanho dos chunks está correto
if [ "$(grep -oP '(?<=Tamanho dos Chunks\nOs chunks têm um tamanho de )\d+x\d+' ./docs/technical_specs/chunking_specification.md)" != "16x16" ]; then
  echo "Tamanho dos chunks incorreto"
  exit 1
fi

# Verifica se a quantidade de chunks vizinhos está correta
if [ "$(grep -oP '(?<=O sistema mantém em cache os )\d+' ./docs/technical_specs/chunking_specification.md)" != "8" ]; then
  echo "Quantidade de chunks vizinhos incorreta"
  exit 1
fi

# Verifica se a lógica de unloading está correta
if [ "$(grep -oP '(?<=distância de )\d+' ./docs/technical_specs/chunking_specification.md)" != "3" ]; then
  echo "Lógica de unloading incorreta"
  exit 1
fi

