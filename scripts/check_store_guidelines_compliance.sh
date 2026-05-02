#!/bin/bash

# Check if the description contains prohibited content
if grep -q "survival\|health\|hunger\|death\|drops\|mobs\|NPCs\|monsters" ./pubspec.yaml; then
  echo "Description contains prohibited content"
  exit 1
fi

# Check if the description is not empty
if ! grep -q "description:" ./pubspec.yaml; then
  echo "Description is empty"
  exit 1
fi

echo "Store guidelines compliance check passed"
