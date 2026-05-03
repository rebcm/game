#!/bin/bash

# Validate template format documentation
# Check if template documentation exists
if [ ! -f "docs/template_documentation.md" ]; then
  echo "Template documentation not found"
  exit 1
fi

# Check if template format is defined
if ! grep -q "Template Format:" docs/template_documentation.md; then
  echo "Template format not defined in documentation"
  exit 1
fi

echo "Template format validation successful"
