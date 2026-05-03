#!/bin/bash

# Verifica se o conteúdo foi revisado
if grep -q "TODO" game/docs/walkthrough.dart; then
  echo "Erro: Conteúdo não revisado"
  exit 1
fi

# Verifica se o conteúdo está tecnicamente preciso
dart analyze game/docs/walkthrough.dart
if [ $? -ne 0 ]; then
  echo "Erro: Conteúdo com erros de análise"
  exit 1
fi

echo "Revisão técnica concluída com sucesso"
