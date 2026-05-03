#!/bin/bash

# Verificar se o conteúdo das dicas foi aprovado
if [ -f ./assets/dicas/dicas.json ]; then
  # Verificar se o conteúdo foi aprovado pelo Game Designer e Lead Técnico
  if grep -q '"aprovado": true' ./assets/dicas/dicas.json && grep -q '"aprovado_tecnico": true' ./assets/dicas/dicas.json; then
    echo "Aprovação técnica do conteúdo das dicas validada com sucesso."
    exit 0
  else
    echo "Erro: Conteúdo das dicas não aprovado."
    exit 1
  fi
else
  echo "Erro: Arquivo de dicas não encontrado."
  exit 1
fi
