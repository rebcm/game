#!/bin/bash

# Get dependencies from pubspec.yaml
dependencies=$(yq e '.dependencies | keys | .[]' pubspec.yaml)

# Check if documentation contains all dependencies
for dependency in $dependencies; do
  if ! grep -q "$dependency" docs/installation.md; then
    echo "Dependency $dependency not found in installation documentation"
    exit 1
  fi
done

echo "Installation documentation is up-to-date"
