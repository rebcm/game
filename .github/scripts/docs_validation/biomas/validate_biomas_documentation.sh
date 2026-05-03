#!/bin/bash

# Validar a documentação dos biomas
if ! grep -q "Biomas do Jogo" ./.github/scripts/docs_validation/biomas/content/biomas.md; then
  echo "Erro: Documentação de biomas não encontrada ou inválida."
  exit 1
fi

echo "Documentação de biomas validada com sucesso."
