#!/bin/bash

# Validate i18n documentation
echo "Validating i18n documentation"

# Check if the documentation files exist for supported locales
supported_locales=("de" "fr")
for locale in "${supported_locales[@]}"; do
  if [ ! -f ".github/scripts/docs_validation/i18n_docs/content/biomas_$locale.md" ]; then
    echo "Error: Documentation file for locale '$locale' not found"
    exit 1
  fi
done

echo "i18n documentation validation successful"
