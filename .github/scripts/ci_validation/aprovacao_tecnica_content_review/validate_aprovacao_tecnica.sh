#!/bin/bash

# Verifica se as dicas foram aprovadas tecnicamente
if [ -f ./assets/dicas/dicas.json ]; then
  # Lê o conteúdo do arquivo dicas.json
  conteudo=$(cat ./assets/dicas/dicas.json)
  
  # Verifica se o conteúdo contém a chave "aprovado"
  if echo "$conteudo" | grep -q '"aprovado": true'; then
    echo "Dicas aprovadas tecnicamente."
    exit 0
  else
    echo "Dicas não aprovadas tecnicamente."
    exit 1
  fi
else
  echo "Arquivo dicas.json não encontrado."
  exit 1
fi
