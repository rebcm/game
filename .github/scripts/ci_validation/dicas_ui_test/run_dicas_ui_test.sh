#!/bin/bash

# Executa os testes de UI para as telas de dicas
flutter drive --target=test_driver/dicas_ui_test.dart --driver=test_driver/dicas_ui_test_driver.dart --profile --no-sandbox

# Verifica se os testes passaram
if [ $? -eq 0 ]; then
  echo "Testes de UI para telas de dicas passaram"
else
  echo "Testes de UI para telas de dicas falharam"
  exit 1
fi
