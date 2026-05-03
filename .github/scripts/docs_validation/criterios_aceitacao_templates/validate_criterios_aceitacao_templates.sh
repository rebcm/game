#!/bin/bash

# Validate criterios aceitacao templates
# Check if the templates directory exists
if [ ! -d "assets/templates" ]; then
  echo "Templates directory does not exist"
  exit 1
fi

# Check if the templates directory contains the required files
required_files=("template1.md" "template2.md" "template3.md")
for file in "${required_files[@]}"; do
  if [ ! -f "assets/templates/$file" ]; then
    echo "Template file $file does not exist"
    exit 1
  fi
done

# Check if the templates conform to the required structure
# This can be done by checking the presence of certain headers or sections
for file in "${required_files[@]}"; do
  if ! grep -q "# Template" "assets/templates/$file"; then
    echo "Template file $file does not contain the required header"
    exit 1
  fi
done

echo "Criterios aceitacao templates validation successful"
