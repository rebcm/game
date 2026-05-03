#!/bin/bash

# Valida se o guia de profiling de memória foi atualizado

GUIDE_PATH="lib/docs/guias_depuracao/profiling_memoria.md"

if [ ! -f "$GUIDE_PATH" ]; then
  echo "Erro: Guia de profiling de memória não encontrado."
  exit 1
fi

# Adicione aqui lógica adicional para validação do conteúdo, se necessário
