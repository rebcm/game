#!/bin/bash

# Validate template format documentation
# Check if template format documentation exists and is not empty
if [ ! -f ./docs/template_format.md ]; then
  echo "Template format documentation not found."
  exit 1
fi

if [ ! -s ./docs/template_format.md ]; then
  echo "Template format documentation is empty."
  exit 1
fi

# Check if template format is defined
if ! grep -q "Template Format" ./docs/template_format.md; then
  echo "Template format not defined in documentation."
  exit 1
fi

echo "Template format documentation is valid."
exit 0
