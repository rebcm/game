#!/bin/bash

# Script para estabelecer o baseline de consumo de memória

# Executar o teste de memória com o estado_jogo.dart ativo
MEMORY_BEFORE=$(dart ./lib/utils/performance_testing/memory_leak_detector.dart --before)

# Destruir o estado_jogo.dart
dart ./test/integration/stress_test/memory_stress_test.dart --destroy-estado-jogo

# Executar novamente o teste de memória
MEMORY_AFTER=$(dart ./lib/utils/performance_testing/memory_leak_detector.dart --after)

# Calcular a diferença
MEMORY_DIFF=$((MEMORY_AFTER - MEMORY_BEFORE))

# Registrar os resultados
echo "$MEMORY_BEFORE $MEMORY_AFTER $MEMORY_DIFF" >> ./.github/scripts/ci_validation/memory_leak_test/docs/memory_baseline.log

