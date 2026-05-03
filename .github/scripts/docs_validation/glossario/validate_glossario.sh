#!/bin/bash

# Script para validar o glossário de termos técnicos

GLOSSARIO_FILE="./docs/glossario/glossario.md"

if [ ! -f "$GLOSSARIO_FILE" ]; then
  echo "Erro: Glossário não encontrado em $GLOSSARIO_FILE"
  exit 1
fi

# Verificar se o glossário contém os termos esperados
TERMOS_ESPERADOS=("Termo Técnico 1" "Termo Técnico 2" "Termo Técnico 3")
for TERMO in "${TERMOS_ESPERADOS[@]}"; do
  if ! grep -q "$TERMO" "$GLOSSARIO_FILE"; then
    echo "Erro: Termo '$TERMO' não encontrado no glossário"
    exit 1
  fi
done

echo "Glossário validado com sucesso"
exit 0

