#!/bin/bash

EXPECTED_FLUTTER_VERSION="3.0.0"
FLUTTER_VERSION=$(flutter --version | head -n 1 | cut -d ' ' -f 2)

if [ "$FLUTTER_VERSION" != "$EXPECTED_FLUTTER_VERSION" ]; then
  echo "Versão do Flutter incorreta. Esperado: $EXPECTED_FLUTTER_VERSION, Encontrado: $FLUTTER_VERSION"
  exit 1
fi
