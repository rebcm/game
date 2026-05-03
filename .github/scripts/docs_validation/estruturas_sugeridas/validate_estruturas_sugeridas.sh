#!/bin/bash

# Validate estruturas sugeridas
dart ./.github/scripts/docs_validation/estruturas_sugeridas/extract_estruturas_sugeridas.dart
if [ $? -ne 0 ]; then
  echo "Error extracting estruturas sugeridas"
  exit 1
fi

# Compare with golden tests
diff -u lib/docs/estruturas_sugeridas.txt ./.github/scripts/docs_validation/estruturas_sugeridas/estruturas_sugeridas_golden.txt
if [ $? -ne 0 ]; then
  echo "estruturas sugeridas validation failed"
  exit 1
fi

echo "estruturas sugeridas validation successful"
