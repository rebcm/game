#!/bin/bash

# Verifica se o conteúdo das dicas foi aprovado pelo Game Designer ou Lead Técnico
if [ -f "docs/dicas_construcao/conteudo_dicas.md" ]; then
  if grep -q "APROVADO_PELO_GAME_DESIGNER" "docs/dicas_construcao/conteudo_dicas.md"; then
    echo "Conteúdo das dicas aprovado"
  else
    echo "Conteúdo das dicas não aprovado"
    exit 1
  fi
else
  echo "Arquivo de conteúdo das dicas não encontrado"
  exit 1
fi
