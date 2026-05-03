#!/bin/bash

# Verifica se o walkthrough está correto
if ! grep -q "Introdução" game/docs/walkthrough.md; then
  echo "Erro: Walkthrough incorreto"
  exit 1
fi

echo "Walkthrough validado com sucesso"
