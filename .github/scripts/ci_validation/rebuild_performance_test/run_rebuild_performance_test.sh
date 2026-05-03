#!/bin/bash

# Executar o teste de performance de rebuild
flutter drive --target=test_driver/main.dart --driver=test_driver/performance_test.dart --profile

# Coletar os resultados do teste
RESULTS=$(flutter pub run flutter_driver_test --driver=test_driver/performance_test.dart)

# Extrair o número de rebuilds e a latência do resultado
REBUILDS=$(echo "$RESULTS" | grep -oP '(?<=Rebuilds: )\d+')
LATENCY=$(echo "$RESULTS" | grep -oP '(?<=Latency: )\d+(\.\d+)?')

# Verificar se os resultados atendem aos critérios de aceitação
if [ $REBUILDS -le 50 ] && (( $(echo "$LATENCY <= 100" | bc -l) )); then
  echo "Teste de performance de rebuild passou!"
else
  echo "Teste de performance de rebuild falhou!"
  exit 1
fi

