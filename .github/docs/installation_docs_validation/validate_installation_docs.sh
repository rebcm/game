#!/bin/bash

# Function to extract dependencies from pubspec.yaml
extract_dependencies() {
  grep -E '^\s+[a-zA-Z0-9_]+:' pubspec.yaml | awk '{print $1}' | tr -d ':' | sort
}

# Function to check if documentation contains all dependencies
validate_docs() {
  dependencies=$(extract_dependencies)
  for dep in $dependencies; do
    if ! grep -q "$dep" .github/docs/installation_docs_validation/installation_docs.md; then
      echo "Dependency $dep not found in installation_docs.md"
      return 1
    fi
  done
  echo "Documentation is up-to-date"
  return 0
}

validate_docs
