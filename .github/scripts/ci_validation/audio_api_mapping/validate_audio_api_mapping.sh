#!/bin/bash

# Validate audio API mapping across platforms
echo "Validating audio API mapping..."

# Check if the necessary files exist
if [ ! -f "./lib/audio/audio_web.dart" ] || [ ! -f "./lib/audio/audio_android.dart" ] || [ ! -f "./lib/audio/audio_ios.dart" ]; then
  echo "Error: Audio implementation files not found."
  exit 1
fi

# Compare the implementations
echo "Comparing audio API implementations..."
diff ./lib/audio/audio_web.dart ./lib/audio/audio_android.dart > /dev/null
if [ $? -eq 0 ]; then
  echo "Warning: Web and Android audio implementations are identical."
fi

diff ./lib/audio/audio_web.dart ./lib/audio/audio_ios.dart > /dev/null
if [ $? -eq 0 ]; then
  echo "Warning: Web and iOS audio implementations are identical."
fi

diff ./lib/audio/audio_android.dart ./lib/audio/audio_ios.dart > /dev/null
if [ $? -eq 0 ]; then
  echo "Warning: Android and iOS audio implementations are identical."
fi

echo "Audio API mapping validation completed."
