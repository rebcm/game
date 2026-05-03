#!/bin/bash

# Valida se o guia de estilo para dicas de construção está presente e segue o padrão estabelecido

if [ ! -f docs/guias/estilo/guia_de_estilo_dicas.md ]; then
  echo "Erro: Guia de estilo para dicas de construção não encontrado."
  exit 1
fi

# Verifica se o arquivo contém a estrutura sugerida
if ! grep -q "## Estrutura Sugerida" docs/guias/estilo/guia_de_estilo_dicas.md; then
  echo "Erro: Guia de estilo não contém a seção 'Estrutura Sugerida'."
  exit 1
fi

echo "Guia de estilo para dicas de construção validado com sucesso."
exit 0

