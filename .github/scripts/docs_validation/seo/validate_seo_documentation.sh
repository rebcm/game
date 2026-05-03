#!/bin/bash

SEO_DOC_FILE="docs/seo/palavras-chave.md"

if [ ! -f "$SEO_DOC_FILE" ]; then
  echo "Erro: $SEO_DOC_FILE não encontrado."
  exit 1
fi

echo "Validação do documento SEO concluída com sucesso."
