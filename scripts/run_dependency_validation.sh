#!/bin/bash

echo "Executando validação de dependências..."

echo "Verificando Flutter e Dart..."
flutter --version
dart --version

echo "Executando flutter doctor..."
flutter doctor

echo "Verificando dependências do projeto..."
flutter pub get

echo "Compilando o projeto..."
flutter build

echo "Executando testes de integração..."
flutter drive --driver=test/integration_tests/tip_validation_test/tip_validation_test_driver.dart --target=test/integration_tests/tip_validation_test/tip_validation_test.dart

echo "Validação de dependências concluída."
