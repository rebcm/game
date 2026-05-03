#!/bin/bash

# Validate estruturas sugeridas documentation
echo "Validating estruturas sugeridas documentation..."

# Check if estruturas_sugeridas directory exists
if [ ! -d "assets/estruturas_sugeridas" ]; then
  echo "Error: assets/estruturas_sugeridas directory does not exist."
  exit 1
fi

# Check if estruturas_sugeridas files are valid
for file in assets/estruturas_sugeridas/*.json; do
  if ! jq -e . >/dev/null 2>&1 <"$file"; then
    echo "Error: $file is not a valid JSON file."
    exit 1
  fi
done

echo "Estruturas sugeridas documentation is valid."
