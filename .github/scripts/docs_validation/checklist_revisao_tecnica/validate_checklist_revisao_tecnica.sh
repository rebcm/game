#!/bin/bash

# Validacao do checklist de revisao tecnica
# Verifica se os criterios tecnicos estao sendo seguidos

# Criterios tecnicos
CRITERIOS_TECNICOS=("nomenclatura de widgets" "fluxos de navegacao" "termos de API")

for criterio in "${CRITERIOS_TECNICOS[@]}"; do
  if ! grep -q "$criterio" docs/checklist_revisao_tecnica.md; then
    echo "Erro: $criterio nao encontrado no checklist de revisao tecnica"
    exit 1
  fi
done

echo "Checklist de revisao tecnica validado com sucesso"
