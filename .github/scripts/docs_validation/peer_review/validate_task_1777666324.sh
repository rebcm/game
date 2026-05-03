#!/bin/bash

# Task-specific validation for task-1777666324-13-sub-6-disc-1777777797-3
# Checks if the documentation changes are technically accurate for the player

# Check if the documentation files have been modified
if git diff --name-only HEAD~1 | grep -qE '.github/scripts/docs_validation/estruturas_sugeridas/estruturas_sugeridas.md'; then
  echo "Documentation changes detected. Proceeding with validation..."
else
  echo "No documentation changes detected. Skipping validation..."
  exit 0
fi

# Validate the documentation content
./.github/scripts/docs_validation/estruturas_sugeridas/run_validation.sh

# Check if the validation script passed
if [ $? -eq 0 ]; then
  echo "Documentation validation successful."
else
  echo "Documentation validation failed."
  exit 1
fi
