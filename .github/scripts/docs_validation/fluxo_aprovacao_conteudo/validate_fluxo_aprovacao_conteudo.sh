#!/bin/bash

# Validar se o fluxo de aprovação de conteúdo está documentado corretamente
if ! grep -q "Fluxo de Aprovação de Conteúdo" ./.github/scripts/docs_validation/dicas/content/dicas_construcao.md; then
  echo "Fluxo de aprovação de conteúdo não está documentado em dicas_construcao.md"
  exit 1
fi

echo "Fluxo de aprovação de conteúdo validado com sucesso"
