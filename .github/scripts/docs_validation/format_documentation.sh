#!/bin/bash

# Script to format documentation files according to the new standard

# List of documentation files to be formatted
DOC_FILES=(
  "docs/swagger_endpoints.md"
  "docs/swagger_ui.html"
  "docs/wrangler_secrets.md"
  "docs/bloco_documentation.json"
  "docs/seo/palavras-chave.md"
  "docs/audio_api_comparativo/audio_api_comparativo.md"
  "peer_review.md"
)

# Format each documentation file according to the new standard
for file in "${DOC_FILES[@]}"; do
  if [ -f "$file" ]; then
    # Assuming a formatting command or tool is available
    # For example, using prettier for markdown files
    if [[ "$file" == *.md ]]; then
      npx prettier --write "$file"
    fi
    # Add more conditions for other file types as needed
  else
    echo "File $file not found."
  fi
done
