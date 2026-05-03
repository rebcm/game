#!/bin/bash

checklist_file="docs/checklist_aceitacao_arquitetura.md"
required_items=("Separação entre Data, Domain e Presentation" "Uso correto de providers" "Arquitetura modular")

if [ ! -f "$checklist_file" ]; then
  echo "Checklist de aceitação de arquitetura não encontrado."
  exit 1
fi

for item in "${required_items[@]}"; do
  if ! grep -q "$item" "$checklist_file"; then
    echo "Item '$item' não encontrado no checklist de aceitação de arquitetura."
    exit 1
  fi
done

echo "Checklist de aceitação de arquitetura validado com sucesso."
exit 0
