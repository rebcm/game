#!/bin/bash

# Validate installation documentation
echo "Validating installation documentation..."

# Check if README.md exists
if [ ! -f README.md ]; then
  echo "README.md not found"
  exit 1
fi

# Check if README.md contains installation instructions
if ! grep -q "Installation" README.md; then
  echo "Installation instructions not found in README.md"
  exit 1
fi

echo "Installation documentation validated successfully"
