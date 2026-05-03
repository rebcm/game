#!/bin/bash

# Validar se o documento de mapeamento de requisitos de dados existe
if [ ! -f docs/passdriver_data_requirements/data_classification.md ]; then
  echo "Erro: Documento de mapeamento de requisitos de dados não encontrado."
  exit 1
fi

# Validar se o documento contém as seções necessárias
sections=("Introdução" "Tipos de Dados" "Conclusão")
for section in "${sections[@]}"; do
  if ! grep -q "^# $section$" docs/passdriver_data_requirements/data_classification.md; then
    echo "Erro: Seção '$section' não encontrada no documento."
    exit 1
  fi
done

echo "Validação do mapeamento de requisitos de dados concluída com sucesso."
