#!/bin/bash

# Validation logic for task-1777666324-13-sub-6-disc-1777777797-3
# This script checks the documentation for technical accuracy

# Check if the documentation file exists
if [ ! -f game/docs/walkthrough.dart ]; then
  echo "Documentation file not found: game/docs/walkthrough.dart"
  exit 1
fi

# Validate the content of the documentation file
dart .github/scripts/docs_validation/dicas/extract_dicas_strings.dart game/docs/walkthrough.dart
if [ $? -ne 0 ]; then
  echo "Failed to extract dicas strings from walkthrough.dart"
  exit 1
fi

# Check for any errors in the documentation validation
if [ ! -z "$(dart analyze game/docs/walkthrough.dart)" ]; then
  echo "Errors found in walkthrough.dart"
  dart analyze game/docs/walkthrough.dart
  exit 1
fi

echo "Documentation validation successful for task-1777666324-13-sub-6-disc-1777777797-3"
