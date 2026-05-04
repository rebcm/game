#!/bin/bash

# Diretório dos arquivos de tradução
TRANSLATION_DIR="lib/i18n/locales"

# Idioma alvo
TARGET_LANG="pt-BR"

# Verifica se o diretório de tradução existe
if [ ! -d "$TRANSLATION_DIR" ]; then
  echo "Diretório de tradução não encontrado: $TRANSLATION_DIR"
  exit 1
fi

# Verifica se o arquivo de tradução para o idioma alvo existe
if [ ! -f "$TRANSLATION_DIR/$TARGET_LANG.json" ]; then
  echo "Arquivo de tradução para $TARGET_LANG não encontrado"
  exit 1
fi

# Carrega as chaves do arquivo de tradução padrão (en-US)
DEFAULT_LANG="en-US"
DEFAULT_KEYS=$(jq -r 'keys[]' "$TRANSLATION_DIR/$DEFAULT_LANG.json")

# Verifica se as chaves do arquivo de tradução alvo estão corretas
for key in $DEFAULT_KEYS; do
  if ! jq -e ".${key}" "$TRANSLATION_DIR/$TARGET_LANG.json" > /dev/null; then
    echo "Chave '$key' não encontrada ou incorreta no arquivo de tradução para $TARGET_LANG"
    exit 1
  fi
done

echo "Validação de tradução concluída com sucesso"
