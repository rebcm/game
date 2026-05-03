#!/bin/bash

DOC_FILE=$1

# Verifica se o arquivo existe
if [ ! -f "$DOC_FILE" ]; then
  echo "Arquivo $DOC_FILE não encontrado."
  exit 1
fi

# Verifica se o arquivo segue a estrutura padrão
if ! grep -q "## Estrutura Padrão" "$DOC_FILE"; then
  echo "O arquivo $DOC_FILE não segue a estrutura padrão."
  exit 1
fi

echo "Validação concluída com sucesso."
