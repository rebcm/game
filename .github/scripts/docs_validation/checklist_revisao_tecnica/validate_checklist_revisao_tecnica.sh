#!/bin/bash

# Define the checklist file path
CHECKLIST_FILE="./.github/scripts/docs_validation/checklist_revisao_tecnica/checklist_revisao_tecnica.md"

# Check if the checklist file exists
if [ ! -f "$CHECKLIST_FILE" ]; then
  echo "Checklist file not found: $CHECKLIST_FILE"
  exit 1
fi

# Validate the checklist content (example: check for specific keywords)
if ! grep -q "Revisão Ortográfica" "$CHECKLIST_FILE"; then
  echo "Checklist content is invalid or missing required keywords."
  exit 1
fi

echo "Checklist validation successful."
