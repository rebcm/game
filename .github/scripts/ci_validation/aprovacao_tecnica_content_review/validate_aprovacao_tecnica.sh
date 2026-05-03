#!/bin/bash

# Verifica se as dicas foram aprovadas tecnicamente
if [ -f ./assets/dicas/dicas.json ]; then
  # Implementar lógica para verificar aprovação técnica
  echo "Verificando aprovação técnica das dicas..."
  # Se não aprovado, sair com erro
  # exit 1
else
  echo "Arquivo de dicas não encontrado."
  exit 1
fi
