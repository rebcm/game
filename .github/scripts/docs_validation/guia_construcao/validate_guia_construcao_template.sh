#!/bin/bash

# Validate if the construction guide template is correctly formatted

TEMPLATE_FILE="docs/guia_construcao/template.md"

if [ ! -f "$TEMPLATE_FILE" ]; then
  echo "Template file not found: $TEMPLATE_FILE"
  exit 1
fi

# Check if the template contains the required sections
REQUIRED_SECTIONS=("Material necessário" "Tempo estimado" "Dificuldade")
for SECTION in "${REQUIRED_SECTIONS[@]}"; do
  if ! grep -q "$SECTION" "$TEMPLATE_FILE"; then
    echo "Missing required section: $SECTION"
    exit 1
  fi
done

echo "Construction guide template is valid"
exit 0
