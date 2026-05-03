#!/bin/bash

# Script para executar o teste de performance de rebuild

# Configurações
DEVICE=$(flutter devices | grep -o 'iPhone\|Android')
TEST_NAME="Rebuild Performance Test"

# Executar o teste
flutter drive --target=test/integration_tests/rebuild_performance_test.dart --driver=test/integration_tests/rebuild_performance_test_driver.dart --profile --device=$DEVICE

# Coletar resultados
RESULTS=$(cat rebuild_performance_test_results.json)

# Extrair número de rebuilds e latência
REBUILDS=$(echo $RESULTS | jq '.rebuilds')
LATENCY=$(echo $RESULTS | jq '.latency')

# Verificar critérios de aceitação
if [ $REBUILDS -le 50 ] && [ $LATENCY -le 100 ]; then
  echo "Teste passou: $TEST_NAME"
else
  echo "Teste falhou: $TEST_NAME"
  exit 1
fi

