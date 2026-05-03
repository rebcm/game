#!/bin/bash

# Validate tone and style for documentation and tips
# Usage: bash .github/scripts/docs_validation/validate_tone_and_style.sh

# Define the directories to check
DIRECTORIES_TO_CHECK=("lib" "assets/docs")

# Define the allowed tone and style guidelines file
GUIDELINES_FILE="docs/style_guidelines.md"

# Check if the guidelines file exists
if [ ! -f "$GUIDELINES_FILE" ]; then
    echo "Error: $GUIDELINES_FILE not found."
    exit 1
fi

# Iterate over the directories
for directory in "${DIRECTORIES_TO_CHECK[@]}"; do
    # Check if the directory exists
    if [ -d "$directory" ]; then
        # Find all markdown files in the directory
        while IFS= read -r file; do
            # Validate the tone and style of the file against the guidelines
            # This is a placeholder command; you should replace it with your actual validation logic
            echo "Validating tone and style for $file"
            # tone_and_style_validator "$file" "$GUIDELINES_FILE"
        done < <(find "$directory" -type f -name "*.md")
    else
        echo "Warning: $directory does not exist."
    fi
done
