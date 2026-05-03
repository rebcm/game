#!/bin/bash

# Script para validar a taxonomia de categorias da documentação

# Diretório onde estão os arquivos de documentação
DOC_DIR="docs"

# Arquivo que define a taxonomia de categorias permitidas
TAXONOMIA_FILE="docs/taxonomia_categorias.json"

# Verificar se o arquivo de taxonomia existe
if [ ! -f "$TAXONOMIA_FILE" ]; then
  echo "Erro: Arquivo de taxonomia não encontrado ($TAXONOMIA_FILE)"
  exit 1
fi

# Extrair as categorias permitidas do arquivo de taxonomia
CATEGORIAS_PERMITIDAS=$(jq -r '.categorias[]' "$TAXONOMIA_FILE")

# Verificar cada arquivo de documentação
for file in "$DOC_DIR"/*.md; do
  # Extrair as categorias mencionadas no arquivo
  CATEGORIAS_MENCIONADAS=$(grep -oP '(?<=categoria: ).*' "$file")
  
  # Verificar se as categorias mencionadas estão na lista de permitidas
  for categoria in $CATEGORIAS_MENCIONADAS; do
    if ! echo "$CATEGORIAS_PERMITIDAS" | grep -q "^$categoria$"; then
      echo "Erro: Categoria '$categoria' não permitida encontrada em $file"
      exit 1
    fi
  done
done

echo "Validação de taxonomia concluída com sucesso"
