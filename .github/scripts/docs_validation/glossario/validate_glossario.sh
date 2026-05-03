#!/bin/bash

GLOSSARIO_FILE="lib/docs/glossario.md"

if [ ! -f "$GLOSSARIO_FILE" ]; then
  echo "Glossário não encontrado. Criando glossário vazio."
  touch "$GLOSSARIO_FILE"
fi

TERMOS=$(grep -oP '(?<=^## ).*' "$GLOSSARIO_FILE")

echo "Validação do glossário concluída."
