#!/bin/bash

# Deploy script for the game project

# Exit on error
set -e

# Navigate to the project root
cd "$(dirname "$0")/../../"

# Validate and build the project
flutter pub get
dart analyze
flutter build web

# Deploy to GitHub Pages
# This step is handled by the GitHub Actions workflow
