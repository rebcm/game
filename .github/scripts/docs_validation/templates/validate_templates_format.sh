#!/bin/bash

# Validate templates format documentation
# Check if templates are correctly defined as Flutter widgets, static images or vector schemes

# Check for the existence of template documentation files
if [ ! -f "./docs/templates.md" ]; then
  echo "Error: Template documentation file not found."
  exit 1
fi

# Validate template format definition
template_format=$(grep "Template Format:" ./docs/templates.md | awk '{print $3}')
if [ "$template_format" != "Flutter" ] && [ "$template_format" != "Static" ] && [ "$template_format" != "Vector" ]; then
  echo "Error: Invalid template format defined in documentation."
  exit 1
fi

echo "Template format validation successful."
