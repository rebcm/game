#!/bin/bash

# Função para verificar se o arquivo contém texto preciso para o jogador
validate_texto_preciso() {
  local arquivo=$1
  local criterios_minimos=("clareza" "concisão" "relevância")
  local passou=true

  for criterio in "${criterios_minimos[@]}"; do
    if ! grep -q "$criterio" "$arquivo"; then
      echo "Erro: $arquivo não atende ao critério de '$criterio'"
      passou=false
    fi
  done

  if [ "$passou" = true ]; then
    echo "Sucesso: $arquivo atende aos critérios mínimos"
  else
    exit 1
  fi
}

# Verifica se o arquivo foi fornecido como argumento
if [ $# -eq 0 ]; then
  echo "Erro: Nenhum arquivo fornecido para validação"
  exit 1
fi

validate_texto_preciso "$1"
