#!/bin/bash

# Validação do template das dicas
# Verifica se as dicas seguem o template: Problema -> Solução -> Estrutura Sugerida

# Diretório das dicas
DICAS_DIR="game/docs/dicas"

# Verifica se o diretório existe
if [ ! -d "$DICAS_DIR" ]; then
  echo "Diretório de dicas não encontrado: $DICAS_DIR"
  exit 1
fi

# Loop por todos os arquivos de dicas
for file in "$DICAS_DIR"/*.md; do
  # Verifica se o arquivo contém o template correto
  if ! grep -q "## Problema" "$file" || ! grep -q "## Solução" "$file" || ! grep -q "## Estrutura Sugerida" "$file"; then
    echo "Arquivo $file não segue o template padrão."
    exit 1
  fi
done

echo "Todas as dicas seguem o template padrão."
