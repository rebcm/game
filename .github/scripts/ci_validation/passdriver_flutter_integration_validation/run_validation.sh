#!/bin/bash

# Executar testes de integração
flutter test integration_test/passdriver_flutter_integration_test.dart

# Executar benchmarks
flutter run --release benchmarks/passdriver_flutter_benchmark.dart

# Verificar se a taxa de frames está dentro do limite aceitável
FPS=$(flutter devtools --profile --benchmark benchmarks/passdriver_flutter_benchmark.dart | grep "Average FPS" | awk '{print $3}')
if (( $(echo "$FPS < 60" | bc -l) )); then
  echo "Taxa de frames abaixo do limite aceitável: $FPS"
  exit 1
fi
