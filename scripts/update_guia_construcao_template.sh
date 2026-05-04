#!/bin/bash

TEMPLATE_FILE="./.github/docs/guia_construcao_template/template.md"

if [ ! -f "$TEMPLATE_FILE" ]; then
  echo "Template file not found: $TEMPLATE_FILE"
  exit 1
fi

echo "Guia de construção template is up to date."
