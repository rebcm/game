#!/bin/bash

# Script para extrair metadados de blocos automaticamente
# Objetivo: Evitar documentação obsoleta

# Diretório onde estão as classes de blocos
BLOCK_CLASSES_DIR="lib/blocos"

# Arquivo de saída para os metadados
METADATA_FILE="docs/taxonomia/blocos_disponiveis.md"

# Cabeçalho do arquivo de metadados
echo "# Blocos Disponíveis" > $METADATA_FILE
echo "" >> $METADATA_FILE

# Loop pelas classes de blocos
for file in $(find $BLOCK_CLASSES_DIR -name "*.dart"); do
  # Extrair nome da classe
  CLASS_NAME=$(basename "$file" .dart)
  
  # Extrair descrição da classe (supondo que esteja em um comentário de documentação)
  CLASS_DOC=$(grep -m 1 "///" "$file" | sed 's/^[[:space:]]*///[[:space:]]*//')
  
  # Adicionar informações ao arquivo de metadados
  echo "## $CLASS_NAME" >> $METADATA_FILE
  echo "$CLASS_DOC" >> $METADATA_FILE
  echo "" >> $METADATA_FILE
done

