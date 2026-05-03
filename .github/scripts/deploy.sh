#!/bin/bash

# Exit on error
set -e

# Flutter clean
flutter clean

# Flutter pub get
flutter pub get

# Build the app
flutter build web

# Deploy to GitHub Pages or other hosting platforms
# This step may vary based on the hosting platform
