#!/bin/bash

# Validar se as dicas de construção foram aprovadas
# por um revisor antes de serem publicadas

# Verificar se o arquivo de dicas contém a aprovação
if grep -q "aprovacao: true" game/docs/dicas_template/template.dart; then
  echo "Dicas aprovadas com sucesso!"
else
  echo "Erro: Dicas não aprovadas."
  exit 1
fi
