#!/bin/bash

# Executar testes de integração
flutter drive --target=test_driver/integration_test.dart

# Verificar se o deploy foi bem-sucedido
if [ $? -eq 0 ]; then
  echo "Deploy test passed!"
else
  echo "Deploy test failed!"
  exit 1
fi

