#!/bin/bash

# Validar se a decisão da stack tecnológica foi documentada corretamente
if [ ! -f ./.github/docs/passdriver_flutter_stack_decision/decision.md ]; then
  echo "Erro: Documento de decisão da stack tecnológica não encontrado."
  exit 1
fi

# Validar se o exemplo de integração nativa existe
if [ ! -f ./.github/docs/passdriver_flutter_stack_decision/examples/native_integration.dart ]; then
  echo "Erro: Exemplo de integração nativa não encontrado."
  exit 1
fi

echo "Validação da stack tecnológica concluída com sucesso."

