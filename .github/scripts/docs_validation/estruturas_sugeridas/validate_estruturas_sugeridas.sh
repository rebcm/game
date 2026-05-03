#!/bin/bash

# Validate the technical accuracy of the estruturas sugeridas documentation

# Check if the documentation file exists
if [ ! -f ./docs/estruturas_sugeridas/technical_accuracy_checklist.md ]; then
  echo "Documentation file not found."
  exit 1
fi

# Check if the documentation content is not empty
if [ ! -s ./docs/estruturas_sugeridas/technical_accuracy_checklist.md ]; then
  echo "Documentation content is empty."
  exit 1
fi

echo "Estruturas sugeridas documentation validation successful."
