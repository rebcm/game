#!/bin/bash

# Validate if the template is correctly applied to the construction guides
guides_dir="lib/docs/guias_construcao"
template_file=".github/scripts/docs_validation/guia_construcao/templates/guia_construcao_template.md"

if [ ! -f "$template_file" ]; then
  echo "Template file not found: $template_file"
  exit 1
fi

for guide in "$guides_dir"/*.md; do
  if [ -f "$guide" ]; then
    echo "Validating $guide against the template..."
    # Implement the logic to validate the guide against the template
    # For example, checking if the guide contains all the required sections
    required_sections=("Introduction" "Getting Started" "Tips")
    for section in "${required_sections[@]}"; do
      if ! grep -q "# $section" "$guide"; then
        echo "Error: $guide is missing the '$section' section."
        exit 1
      fi
    done
  fi
done

echo "All guides have been validated successfully."
