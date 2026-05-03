#!/bin/bash

# Check if SEO documentation exists
if [ ! -f docs/seo/keywords.md ] || [ ! -f docs/seo/strategy.md ]; then
  echo "SEO documentation is missing"
  exit 1
fi

# Check if SEO keywords are used in the documentation
if ! grep -q "Flutter" docs/seo/keywords.md; then
  echo "SEO keywords are not used in the documentation"
  exit 1
fi
