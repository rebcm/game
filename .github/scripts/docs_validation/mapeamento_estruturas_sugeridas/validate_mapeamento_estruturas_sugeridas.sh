#!/bin/bash

# Validar se o mapeamento de estruturas sugeridas está atualizado
# e se os templates necessários estão implementados corretamente.

# Verificar se o arquivo de mapeamento existe
if [ ! -f ./.github/scripts/docs_validation/mapeamento_estruturas_sugeridas/mapeamento_estruturas_sugeridas.md ]; then
  echo "Erro: Arquivo de mapeamento de estruturas sugeridas não encontrado."
  exit 1
fi

# Verificar se os templates necessários estão listados no arquivo
templates=$(grep "Template para" ./.github/scripts/docs_validation/mapeamento_estruturas_sugeridas/mapeamento_estruturas_sugeridas.md)
if [ -z "$templates" ]; then
  echo "Erro: Templates necessários não listados no arquivo de mapeamento."
  exit 1
fi

echo "Validação do mapeamento de estruturas sugeridas concluída com sucesso."

