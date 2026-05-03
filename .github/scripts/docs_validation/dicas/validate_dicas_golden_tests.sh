#!/bin/bash

# Validate if golden tests for dicas are present

if [ ! -f "test/golden_tests/dicas/resolucoes_test.dart" ]; then
  echo "Golden tests for dicas are missing"
  exit 1
fi

echo "Golden tests for dicas are present"
exit 0
