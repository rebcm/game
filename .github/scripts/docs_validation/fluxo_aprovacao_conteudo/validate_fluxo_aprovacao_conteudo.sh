#!/bin/bash

# Verificar se o arquivo de dicas existe
if [ ! -f "./lib/dicas/dicas.json" ]; then
  echo "Arquivo dicas.json não encontrado"
  exit 1
fi

# Extrair as dicas
dart ./lib/dicas/extract_dicas_strings.dart

# Verificar se as dicas foram aprovadas
if grep -q '"aprovada": false' ./lib/dicas/dicas.json; then
  echo "Existem dicas não aprovadas"
  exit 1
fi

echo "Fluxo de aprovação de conteúdo validado com sucesso"
exit 0
