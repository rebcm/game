#!/bin/bash

# Simula o trigger de merge/tag
echo "Simulando trigger de merge/tag..."

# Verifica se o artefato está disponível no serviço de distribuição final
echo "Verificando disponibilidade do artefato..."
if [ -z "$(curl -s -f https://example.com/artefato)" ]; then
  echo "Artefato não encontrado!"
  exit 1
fi

echo "Teste E2E concluído com sucesso!"
exit 0

