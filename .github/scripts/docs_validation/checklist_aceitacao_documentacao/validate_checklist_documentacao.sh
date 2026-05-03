#!/bin/bash

checklist_file="docs/checklist_aceitacao_documentacao.md"
if [ ! -f "$checklist_file" ]; then
  echo "Checklist de Aceitação para Documentação não encontrado."
  exit 1
fi

required_items=("Material" "Tempo" "Dificuldade")
for item in "${required_items[@]}"; do
  if ! grep -q "$item" "$checklist_file"; then
    echo "Item '$item' não encontrado na Checklist de Aceitação para Documentação."
    exit 1
  fi
done

echo "Checklist de Aceitação para Documentação validada com sucesso."
exit 0
