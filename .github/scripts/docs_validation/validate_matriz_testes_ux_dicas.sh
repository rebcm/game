#!/bin/bash

# Valida se o arquivo matriz_testes_ux_dicas.md existe
if [ ! -f ./docs/ux_tests/matriz_testes_ux_dicas.md ]; then
  echo "Erro: Arquivo matriz_testes_ux_dicas.md não encontrado."
  exit 1
fi

# Valida o conteúdo do arquivo
if ! grep -q "## Cenários de Teste" ./docs/ux_tests/matriz_testes_ux_dicas.md; then
  echo "Erro: Seção 'Cenários de Teste' não encontrada no arquivo matriz_testes_ux_dicas.md."
  exit 1
fi

echo "Validação concluída com sucesso."
