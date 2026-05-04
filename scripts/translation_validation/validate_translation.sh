#!/bin/bash

# Define the directories to check for translation files
DIRECTORIES=("./lib" "./test")

# Loop through each directory
for DIRECTORY in "${DIRECTORIES[@]}"; do
  # Find all markdown files in the directory and its subdirectories
  find "$DIRECTORY" -type f -name "*.md" | while read -r FILE; do
    # Check if the file contains any translation keys
    if grep -q "tr@" "$FILE"; then
      # If it does, check if the translation key is valid
      grep -o "tr@[^ ]*" "$FILE" | while read -r KEY; do
        KEY=${KEY#tr@}
        if ! grep -q "\"$KEY\"" lib/i18n/locales/*.json; then
          echo "Invalid translation key '$KEY' found in $FILE"
          exit 1
        fi
      done
    fi
  done
done

echo "Translation validation successful"
