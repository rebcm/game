#!/bin/bash

# Validate peer review content
validate_peer_review() {
  # Check if the file exists
  if [ ! -f "$1" ]; then
    echo "File not found: $1"
    return 1
  fi

  # Check for spelling errors
  if ! aspell --lang=en --mode=markdown check "$1"; then
    echo "Spelling errors found in $1"
    return 1
  fi

  # Check for technical accuracy (this is a placeholder, actual implementation depends on the project's technical accuracy rules)
  if ! grep -q "technical accuracy check" "$1"; then
    echo "Technical accuracy check failed for $1"
    return 1
  fi

  return 0
}

# Example usage
validate_peer_review "docs/peer_review.md"
