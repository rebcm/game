#!/bin/bash

# Verifica se o arquivo de estruturas sugeridas existe
if [ ! -f ./lib/docs/estruturas_sugeridas.md ]; then
  echo "Arquivo estruturas_sugeridas.md não encontrado."
  exit 1
fi

# Executa a validação ortográfica
dart ./.github/scripts/docs_validation/estruturas_sugeridas/extract_estruturas_sugeridas.dart
if [ $? -ne 0 ]; then
  echo "Falha ao extrair estruturas sugeridas."
  exit 1
fi

echo "Revisão ortográfica concluída com sucesso."
