#!/bin/bash

# Verifica se o glossário existe
if [ ! -f docs/glossario/glossario.md ]; then
  echo "Glossário não encontrado"
  exit 1
fi

# Valida o conteúdo do glossário (exemplo simples)
if ! grep -q "Termo Técnico" docs/glossario/glossario.md; then
  echo "Glossário não contém o termo esperado"
  exit 1
fi

echo "Glossário validado com sucesso"
exit 0
