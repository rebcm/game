#!/bin/bash

# Testar se o documento de mapeamento de estruturas sugeridas existe
if [ ! -f docs/mapeamento_estruturas/estruturas_sugeridas.md ]; then
  echo "Erro: Documento de mapeamento de estruturas sugeridas não encontrado."
  exit 1
fi

# Testar se o documento não está vazio
if [ ! -s docs/mapeamento_estruturas/estruturas_sugeridas.md ]; then
  echo "Erro: Documento de mapeamento de estruturas sugeridas está vazio."
  exit 1
fi

echo "Teste de mapeamento de estruturas sugeridas passou."
