#!/bin/bash

# Validate walkthrough documentation
validate_walkthrough_documentation() {
  # Check if walkthrough documentation exists
  if [ ! -f "./docs/walkthrough.md" ]; then
    echo "Walkthrough documentation not found."
    return 1
  fi

  # Check if walkthrough documentation is not empty
  if [ ! -s "./docs/walkthrough.md" ]; then
    echo "Walkthrough documentation is empty."
    return 1
  fi

  echo "Walkthrough documentation is valid."
  return 0
}

validate_walkthrough_documentation
