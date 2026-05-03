#!/bin/bash

# Verifica se o guia de estilo de pastas existe
if [ ! -f docs/arquitetura/guia_estilo_pastas.md ]; then
  echo "Erro: Guia de estilo de pastas não encontrado."
  exit 1
fi

# Verifica se o guia de estilo de pastas está atualizado
if ! grep -q "Estrutura de Pastas" docs/arquitetura/guia_estilo_pastas.md; then
  echo "Erro: Guia de estilo de pastas desatualizado."
  exit 1
fi

