#!/bin/bash

# Validar se o mapeamento de estruturas sugeridas está atualizado
if ! grep -q "Mapeamento de Estruturas Sugeridas" docs/mapeamento_estruturas_sugeridas.md; then
  echo "Erro: Mapeamento de Estruturas Sugeridas não encontrado"
  exit 1
fi
