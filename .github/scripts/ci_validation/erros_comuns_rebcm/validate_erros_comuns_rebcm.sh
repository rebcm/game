#!/bin/bash

# Validar se o documento de erros comuns existe
if [ ! -f ./.github/docs/erros_comuns_rebcm/criterios_aceitacao_erros_comuns.md ]; then
  echo "Erro: Documento de erros comuns não encontrado."
  exit 1
fi

# Validar se o documento contém os 5 erros comuns
erros_count=$(grep -c "### " ./.github/docs/erros_comuns_rebcm/criterios_aceitacao_erros_comuns.md)
if [ $erros_count -ne 5 ]; then
  echo "Erro: Documento não contém 5 erros comuns."
  exit 1
fi

echo "Validação concluída com sucesso."
