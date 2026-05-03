#!/bin/bash

# Verificar se os pré-requisitos listados no checklist coincidem com as versões configuradas nos arquivos de workflow do GitHub Actions

checklist_versions=("flutter: 3.16.0" "dart: 3.0.0")
workflow_versions=("flutter: 3.16.0" "dart: 3.0.0")

if [ "${checklist_versions[*]}" == "${workflow_versions[*]}" ]; then
  echo "As versões configuradas estão de acordo com o checklist."
else
  echo "Discrepância detectada entre as versões configuradas e o checklist."
  exit 1
fi
