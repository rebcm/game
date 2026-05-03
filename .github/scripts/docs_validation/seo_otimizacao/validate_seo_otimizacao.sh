#!/bin/bash

# Validacao da otimizacao de SEO
# Verifica se as palavras-chave estratégicas estão presentes na documentação

# Defina as palavras-chave estratégicas
KEYWORDS=("Flutter" "Voxel" "Criativo" "Rebeca")

# Verifique se as palavras-chave estão presentes nos arquivos de documentação
for keyword in "${KEYWORDS[@]}"; do
  if ! grep -q "$keyword" ./docs/seo/palavras-chave.md; then
    echo "Palavra-chave '$keyword' não encontrada na documentação SEO."
    exit 1
  fi
done

echo "Validação de SEO concluída com sucesso."
