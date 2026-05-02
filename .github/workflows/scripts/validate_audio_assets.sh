#!/bin/bash

echo "Validating audio assets..."

if [ ! -d "assets/audio/optimized" ]; then
  echo "Audio assets directory not found!"
  exit 1
fi

echo "Audio assets validation successful!"
