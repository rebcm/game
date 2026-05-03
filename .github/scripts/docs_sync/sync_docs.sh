#!/bin/bash

# Check if .env file has changed
if git diff --quiet HEAD~1 -- .env; then
  echo "No changes in .env file"
else
  echo "Changes detected in .env file. Updating documentation..."
  # Update documentation for environment variables
  cp .env .github/docs/env_validation.md
fi

# Check if pubspec.yaml file has changed
if git diff --quiet HEAD~1 -- pubspec.yaml; then
  echo "No changes in pubspec.yaml file"
else
  echo "Changes detected in pubspec.yaml file. Updating documentation..."
  # Update documentation for dependencies
  dart pub deps --json > .github/docs/dependencies/pubspec_dependencies.json
  # Generate markdown from json
  echo "# Dependencies" > .github/docs/dependencies/pubspec_dependencies.md
  echo "## Production Dependencies" >> .github/docs/dependencies/pubspec_dependencies.md
  jq '.packages[] | select(.kind == "direct") | "\(.name) - \(.version)"' .github/docs/dependencies/pubspec_dependencies.json >> .github/docs/dependencies/pubspec_dependencies.md
  echo "## Development Dependencies" >> .github/docs/dependencies/pubspec_dependencies.md
  jq '.packages[] | select(.kind == "dev") | "\(.name) - \(.version)"' .github/docs/dependencies/pubspec_dependencies.json >> .github/docs/dependencies/pubspec_dependencies.md
fi
