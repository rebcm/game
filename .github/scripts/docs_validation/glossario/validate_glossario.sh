#!/bin/bash

# Validate glossário terms
if ! grep -q "passdriver" docs/glossario.md; then
  echo "Glossário validation failed: 'passdriver' term not found"
  exit 1
fi
