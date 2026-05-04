#!/bin/bash

# Define the directory containing the translation files
TRANSLATION_DIR="lib/i18n/locales"

# Define the expected locale
EXPECTED_LOCALE="pt-BR"

# Check if the translation directory exists
if [ ! -d "$TRANSLATION_DIR" ]; then
  echo "Translation directory not found: $TRANSLATION_DIR"
  exit 1
fi

# Check if the expected locale file exists
if [ ! -f "$TRANSLATION_DIR/$EXPECTED_LOCALE.json" ]; then
  echo "Expected locale file not found: $TRANSLATION_DIR/$EXPECTED_LOCALE.json"
  exit 1
fi

# Iterate through all markdown files in the .github/docs directory
find .github/docs -type f -name "*.md" | while read -r file; do
  # Check if the file contains any translation keys
  if grep -q "{" "$file"; then
    # Extract translation keys
    KEYS=$(grep -oP '(?<=\{).*?(?=\})' "$file")
    
    # Check if the extracted keys exist in the expected locale file
    for key in $KEYS; do
      if ! grep -q "\"$key\"" "$TRANSLATION_DIR/$EXPECTED_LOCALE.json"; then
        echo "Missing translation key '$key' in $EXPECTED_LOCALE.json for file: $file"
        exit 1
      fi
    done
  fi
done

echo "Translation validation successful."
