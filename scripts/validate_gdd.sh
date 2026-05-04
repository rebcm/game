#!/bin/bash

# Validate GDD template usage
# Check if new GDDs follow the template

GDD_DIR=".github/docs/game_design_document_template"
TEMPLATE_FILE="$GDD_DIR/template.md"

for gdd in $(find .github/docs -name "*.md"); do
  if ! grep -q "Game Design Document (GDD) Template" "$gdd"; then
    echo "GDD $gdd does not follow the template"
    # Implement further validation logic as needed
  fi
done
