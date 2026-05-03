#!/bin/bash

# Validate walkthrough documentation
# Check if the walkthrough documentation is up-to-date and correctly formatted

# Check for the presence of required files
if [ ! -f "./docs/walkthrough.md" ]; then
  echo "Error: Walkthrough documentation file not found."
  exit 1
fi

# Validate the format of the walkthrough documentation
# This can include checks for specific headers, links, or content
if ! grep -q "# Walkthrough" "./docs/walkthrough.md"; then
  echo "Error: Walkthrough documentation is not correctly formatted."
  exit 1
fi

echo "Walkthrough documentation validation successful."
