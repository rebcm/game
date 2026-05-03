#!/bin/bash

# Validar se a documentação dos biomas foi atualizada
if ! grep -q "Biomas do Jogo" ./docs/biomas/descrição_dos_biomas.md; then
  echo "Erro: Documentação dos biomas não foi atualizada corretamente."
  exit 1
fi

