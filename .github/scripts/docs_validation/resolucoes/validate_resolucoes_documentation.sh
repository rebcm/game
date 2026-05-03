#!/bin/bash

# Validar se o arquivo resolucoes.md existe
if [ ! -f ./docs/resolucoes/resolucoes.md ]; then
  echo "Erro: Arquivo resolucoes.md não encontrado."
  exit 1
fi

# Validar se o arquivo contém a tabela de dispositivos alvo
if ! grep -q "Dispositivos Alvo" ./docs/resolucoes/resolucoes.md; then
  echo "Erro: Tabela de dispositivos alvo não encontrada no arquivo resolucoes.md."
  exit 1
fi

echo "Validação do arquivo resolucoes.md concluída com sucesso."
