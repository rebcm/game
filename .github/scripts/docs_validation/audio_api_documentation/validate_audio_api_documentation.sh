#!/bin/bash

# Validate audio API documentation
# Check if the documentation files exist and contain the required information

DOCS_DIR="./docs/audio_api"
PLATFORM_DOCS=("./docs/audio_api/web_audio_api.md" "./docs/audio_api/android_audio_api.md" "./docs/audio_api/ios_audio_api.md")

if [ ! -d "$DOCS_DIR" ]; then
  echo "Error: $DOCS_DIR does not exist"
  exit 1
fi

for doc in "${PLATFORM_DOCS[@]}"; do
  if [ ! -f "$doc" ]; then
    echo "Error: $doc does not exist"
    exit 1
  fi
  if ! grep -q "Audio API" "$doc"; then
    echo "Error: $doc does not contain 'Audio API'"
    exit 1
  fi
done

echo "Audio API documentation validation successful"
