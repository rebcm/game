#!/bin/bash

# Validate SEO keywords in documentation
SEO_KEYWORDS=("flutter" "voxel" "creative mode" "game development")
DOC_FILES=$(find ./game/docs -type f -name "*.md")

for file in $DOC_FILES; do
  for keyword in "${SEO_KEYWORDS[@]}"; do
    if ! grep -q "$keyword" "$file"; then
      echo "Warning: $keyword not found in $file"
    fi
  done
done
