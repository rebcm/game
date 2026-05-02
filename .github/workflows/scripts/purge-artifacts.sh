#!/bin/bash

# Script para limpar artefatos antigos
# Executa periodicamente para evitar preenchimento do storage

# Defina o número de dias para manter artefatos
RETENCAO_DIAS=7

# Liste artefatos e filtre por data de criação
ARTIFACTS=$(gh api /repos/rebcm/game/actions/artifacts --paginate --jq '.artifacts[] | {name, created_at, id}')

# Processe cada artefato
echo "$ARTIFACTS" | jq -r '.id' | while read -r ID; do
  CREATED_AT=$(echo "$ARTIFACTS" | jq -r ". | select(.id == $ID) | .created_at")
  DATA_CRIACAO=$(date -d "$CREATED_AT" +%s)
  DATA_ATUAL=$(date +%s)
  DIFERENCA=$(( (DATA_ATUAL - DATA_CRIACAO) / 86400 ))

  if [ $DIFERENCA -gt $RETENCAO_DIAS ]; then
    echo "Deletando artefato $ID criado em $CREATED_AT"
    gh api /repos/rebcm/game/actions/artifacts/$ID --method DELETE
  fi
done
