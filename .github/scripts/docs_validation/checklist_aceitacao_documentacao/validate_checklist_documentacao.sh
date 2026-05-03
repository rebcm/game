#!/bin/bash

template_file=".github/pull_request_template/pull_request_template.md"
required_items=("Descrição" "Tipo de mudança" "Checklist")

for item in "${required_items[@]}"; do
  if ! grep -q "$item" "$template_file"; then
    echo "Erro: '$item' não encontrado no template de Pull Request."
    exit 1
  fi
done

echo "Template de Pull Request validado com sucesso."
