#!/bin/bash

# Validate SEO keywords in documentation
documentation_files=$(find ./docs -type f -name "*.md")

for file in $documentation_files; do
  if ! grep -q "Flutter" "$file"; then
    echo "SEO keyword 'Flutter' not found in $file"
    exit 1
  fi
  if ! grep -q "PassDriver" "$file"; then
    echo "SEO keyword 'PassDriver' not found in $file"
    exit 1
  fi
done

echo "SEO keyword validation successful"
