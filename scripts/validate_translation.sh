#!/bin/bash

find . -type f -name "*.dart" -o -name "*.md" | while read file; do
  if grep -q 'pt-BR' "$file"; then
    if ! grep -q 'Rebeca Alves Moreira' "$file"; then
      echo "Arquivo $file não contém o nome da autora."
      exit 1
    fi
  fi
done

echo "Validação de tradução concluída com sucesso."
