#!/bin/bash

# Exit on error
set -e

# Deploy to production
echo "Deploying to production..."

# Assuming the deploy script is for Flutter Web
flutter config --enable-web
flutter build web

# Deploy to GitHub Pages or other hosting platforms
# This is a simplified example; actual deployment may vary
# based on the hosting platform's requirements
git config --global user.email "github-actions[bot]@users.noreply.github.com"
git config --global user.name "github-actions[bot]"
git init
git add .
git commit -m "Deploy to production"
git push -f https://github.com/rebcm/game.git main:gh-pages

echo "Deployed successfully!"
