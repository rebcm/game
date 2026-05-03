#!/bin/bash

# Valida se as dicas seguem o template padrão

DIRETORIO_DICAS="lib/docs/dicas"

for arquivo in "$DIRETORIO_DICAS"/*.md; do
  if ! grep -q "^# Título da Dica" "$arquivo" &&
     ! grep -q "^## Problema" "$arquivo" &&
     ! grep -q "^## Solução" "$arquivo" &&
     ! grep -q "^## Estrutura Sugerida" "$arquivo"; then
    echo "Arquivo $arquivo não segue o template padrão."
    exit 1
  fi
done

echo "Todas as dicas seguem o template padrão."
