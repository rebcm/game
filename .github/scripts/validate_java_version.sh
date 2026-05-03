#!/bin/bash

EXPECTED_JAVA_VERSION="17"
JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d ' ' -f 3 | tr -d '"')

if [[ "$JAVA_VERSION" != "$EXPECTED_JAVA_VERSION"* ]]; then
  echo "Versão do Java incorreta. Esperado: $EXPECTED_JAVA_VERSION, Encontrado: $JAVA_VERSION"
  exit 1
fi
