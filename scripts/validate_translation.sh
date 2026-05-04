#!/bin/bash

# Diretório dos arquivos de documentação
DOCS_DIR=".github/docs"

# Idioma alvo para validação
TARGET_LANG="pt-BR"

# Função para verificar se um arquivo Markdown contém tradução para o idioma alvo
validate_translation() {
  local file="$1"
  if grep -q "^\s*{\s*\"${TARGET_LANG}\"[^}]*}" "$file"; then
    echo "[INFO] $file contém tradução para $TARGET_LANG"
  else
    echo "[ERRO] $file NÃO contém tradução para $TARGET_LANG"
    exit 1
  fi
}

# Percorre todos os arquivos Markdown no diretório de documentação
for file in $(find "$DOCS_DIR" -type f -name "*.md"); do
  validate_translation "$file"
done

echo "[INFO] Validação de tradução concluída com sucesso"
