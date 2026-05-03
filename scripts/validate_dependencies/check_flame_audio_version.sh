#!/bin/bash

FLAME_VERSION=$(grep -oP '(?<=flame: )\S+' pubspec.yaml)
FLAME_AUDIO_VERSION=$(grep -oP '(?<=flame_audio: )\S+' pubspec.yaml)
FLUTTER_SDK_VERSION=$(flutter --version | grep -oP '(?<=Flutter )\S+')

echo "Flame version: $FLAME_VERSION"
echo "Flame Audio version: $FLAME_AUDIO_VERSION"
echo "Flutter SDK version: $FLUTTER_SDK_VERSION"

# Add logic to check compatibility between Flame, Flame Audio, and Flutter SDK versions
# For demonstration purposes, assume compatibility check is done by comparing major versions
FLAME_MAJOR_VERSION=$(echo $FLAME_VERSION | cut -d '.' -f 1)
FLAME_AUDIO_MAJOR_VERSION=$(echo $FLAME_AUDIO_VERSION | cut -d '.' -f 1)

if [ "$FLAME_MAJOR_VERSION" != "$FLAME_AUDIO_MAJOR_VERSION" ]; then
  echo "Incompatible versions: Flame ($FLAME_VERSION) and Flame Audio ($FLAME_AUDIO_VERSION)"
  exit 1
fi

echo "Versions are compatible"
