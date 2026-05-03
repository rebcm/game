#!/bin/bash

# Validar o conteúdo das dicas de construção
if ! grep -q "Dicas de Construção" .github/scripts/docs_validation/dicas/content/dicas_construcao.md; then
  echo "Erro: O arquivo dicas_construcao.md não contém o título 'Dicas de Construção'"
  exit 1
fi

# Validar a presença de dicas gerais
if ! grep -q "Dicas Gerais" .github/scripts/docs_validation/dicas/content/dicas_construcao.md; then
  echo "Erro: O arquivo dicas_construcao.md não contém a seção 'Dicas Gerais'"
  exit 1
fi

# Validar a presença de estruturas sugeridas
if ! grep -q "Estruturas Sugeridas" .github/scripts/docs_validation/dicas/content/dicas_construcao.md; then
  echo "Erro: O arquivo dicas_construcao.md não contém a seção 'Estruturas Sugeridas'"
  exit 1
fi

echo "Validação concluída com sucesso!"
