#!/bin/bash

# Este script executa o teste de vazamento de memória

# Configura o ambiente para o teste
export MEMORY_LEAK_TEST=true

# Executa o teste de vazamento de memória usando o flutter driver
flutter drive --target=test/integration_tests/memory_leak_test.dart --driver=test/integration_tests/memory_leak_test_driver.dart --profile --no-sandbox

# Coleta e imprime os resultados do teste de vazamento de memória
