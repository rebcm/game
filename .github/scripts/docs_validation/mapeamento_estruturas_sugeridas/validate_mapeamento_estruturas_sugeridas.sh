#!/bin/bash

# Validates if the documentation for mapeamento estruturas sugeridas exists
if [ ! -f "./docs/mapeamento_estruturas_sugeridas.md" ]; then
  echo "Error: Documentation file for mapeamento estruturas sugeridas is missing."
  exit 1
fi

# Checks if the documentation is not empty
if [ ! -s "./docs/mapeamento_estruturas_sugeridas.md" ]; then
  echo "Error: Documentation file for mapeamento estruturas sugeridas is empty."
  exit 1
fi

echo "Mapeamento estruturas sugeridas documentation is valid."
