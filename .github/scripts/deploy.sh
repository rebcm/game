#!/bin/bash

# Exit on error
set -e

# Flutter build command for web
flutter config --enable-web
flutter build web

# Deploy to GitHub Pages or other hosting services
# This is a placeholder; adjust according to your actual deployment strategy
echo "Deploying to hosting service..."
