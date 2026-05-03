#!/bin/bash

# Verificar se as dicas foram aprovadas pelo Game Designer ou Lead Técnico
approved=$(grep -c "approved_by_game_designer=true" dicas.txt)

if [ $approved -eq 0 ]; then
  echo "Erro: Dicas não aprovadas pelo Game Designer ou Lead Técnico."
  exit 1
fi
