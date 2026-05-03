#!/bin/bash

if ! grep -q "responsividade_test" ./.github/workflows/responsividade_test.yml; then
  echo "Erro: Testes de responsividade não configurados corretamente."
  exit 1
fi

if ! flutter test test/responsividade/tela_pequena_test.dart; then
  echo "Erro: Testes de responsividade falharam."
  exit 1
fi
