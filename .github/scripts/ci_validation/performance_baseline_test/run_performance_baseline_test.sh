#!/bin/bash

# Script para executar testes de baseline de performance (FPS)

# Configurações
DEVICE_TYPE="emulator"
FPS_THRESHOLD=30

# Executar teste de performance
flutter run --profile --device $DEVICE_TYPE --benchmark &

# Aguardar o término do teste
wait $!

# Verificar se o FPS atingiu o threshold
FPS=$(flutter pub run flutter_devtools --benchmark --machine | grep -oP '(?<="fps": )\d+')
if [ $FPS -lt $FPS_THRESHOLD ]; then
  echo "FPS abaixo do threshold: $FPS < $FPS_THRESHOLD"
  exit 1
else
  echo "FPS dentro do threshold: $FPS >= $FPS_THRESHOLD"
  exit 0
fi
