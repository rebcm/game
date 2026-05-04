#!/bin/bash

# Diretório dos arquivos de documentação
DOCS_DIR=".github/docs"

# Idioma alvo para validação
TARGET_LOCALE="pt-BR"

# Função para verificar se um arquivo Markdown contém tradução para o idioma alvo
validate_translation() {
  local file_path=$1
  if grep -q "^\[pt-BR\]" "$file_path"; then
    echo "Arquivo $file_path contém tradução para $TARGET_LOCALE"
  else
    echo "ERRO: Arquivo $file_path NÃO contém tradução para $TARGET_LOCALE"
    exit 1
  fi
}

# Percorre todos os arquivos Markdown no diretório de documentação
for file in $(find "$DOCS_DIR" -type f -name "*.md"); do
  validate_translation "$file"
done

echo "Validação de tradução concluída com sucesso"
