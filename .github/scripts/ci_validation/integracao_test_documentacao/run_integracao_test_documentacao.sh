#!/bin/bash

# Script para executar testes de integração da documentação

# Verifica se o diretório de testes de integração existe
if [ ! -d "./integration_test" ]; then
  echo "Diretório de testes de integração não encontrado."
  exit 1
fi

# Executa os testes de integração
flutter test integration_test/documentacao_test.dart

