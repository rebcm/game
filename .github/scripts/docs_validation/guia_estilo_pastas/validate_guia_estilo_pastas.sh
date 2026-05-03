#!/bin/bash

# Valida o guia de estilo de pastas

# Verifica se o arquivo existe
if [ ! -f docs/guia_estilo_pastas/guia_estilo_pastas.md ]; then
  echo "Erro: Arquivo guia_estilo_pastas.md não encontrado"
  exit 1
fi

# Verifica se o conteúdo do arquivo está correto
if ! grep -q "## Estrutura de Pastas" docs/guia_estilo_pastas/guia_estilo_pastas.md; then
  echo "Erro: Conteúdo do arquivo guia_estilo_pastas.md incorreto"
  exit 1
fi

echo "Guia de estilo de pastas validado com sucesso"
