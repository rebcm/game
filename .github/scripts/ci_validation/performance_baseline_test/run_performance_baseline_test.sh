#!/bin/bash

# Executar testes de performance
flutter test benchmarks/performance_baseline/performance_baseline_test.dart

# Verificar se os testes passaram
if [ $? -eq 0 ]; then
  echo "Testes de performance passaram"
else
  echo "Testes de performance falharam"
  exit 1
fi
