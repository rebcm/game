#!/bin/bash

# Define the estruturas sugeridas file path
ESTRUTURAS_SUGERIDAS_FILE="./lib/docs/estruturas_sugeridas.md"

# Check if the estruturas sugeridas file exists
if [ ! -f "$ESTRUTURAS_SUGERIDAS_FILE" ]; then
  echo "Estruturas sugeridas file not found: $ESTRUTURAS_SUGERIDAS_FILE"
  exit 1
fi

# Validate the estruturas sugeridas content (example: check for specific keywords)
if ! grep -q "Estruturas Sugeridas" "$ESTRUTURAS_SUGERIDAS_FILE"; then
  echo "Estruturas sugeridas content is invalid or missing required keywords."
  exit 1
fi

echo "Estruturas sugeridas validation successful."
