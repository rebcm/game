#!/bin/bash

# Valida se o documento de políticas de autoplay existe e não está vazio
if [ ! -f ./docs/autoplay_politicas/autoplay_politicas.md ] || [ ! -s ./docs/autoplay_politicas/autoplay_politicas.md ]; then
  echo "Erro: Documento de políticas de autoplay não existe ou está vazio."
  exit 1
fi

echo "Documento de políticas de autoplay validado com sucesso."
