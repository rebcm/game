#!/bin/bash

# This script is used by the CI/CD pipeline to deploy the preview environment

# Exit on error
set -e

# Build web
flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=true

# Deploy to preview
npx gh-pages -d build/web -b preview -r https://github.com/rebcm/game.git -u "github-actions[bot]" -m "Deploy preview [skip ci]"
