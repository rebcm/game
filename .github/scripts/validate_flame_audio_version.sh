#!/bin/bash

FLAME_AUDIO_VERSION=$(grep "flame_audio" pubspec.yaml | cut -d ':' -f 2- | tr -d '[:space:]')
FLAME_ENGINE_VERSION=$(grep "flame" pubspec.yaml | cut -d ':' -f 2- | tr -d '[:space:]')
FLUTTER_SDK_VERSION=$(grep "flutter" pubspec.yaml | cut -d ':' -f 2- | tr -d '[:space:]' | cut -d '>' -f 2-)

if [ "$FLAME_AUDIO_VERSION" != "" ] && [ "$FLAME_ENGINE_VERSION" != "" ] && [ "$FLUTTER_SDK_VERSION" != "" ]; then
  echo "Flame Audio version: $FLAME_AUDIO_VERSION"
  echo "Flame Engine version: $FLAME_ENGINE_VERSION"
  echo "Flutter SDK version: $FLUTTER_SDK_VERSION"

  if ! [[ "$FLUTTER_SDK_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid Flutter SDK version"
    exit 1
  fi

  if ! [[ "$FLAME_AUDIO_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid Flame Audio version"
    exit 1
  fi

  if ! [[ "$FLAME_ENGINE_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid Flame Engine version"
    exit 1
  fi

  # Check compatibility
  if [ "$(printf '%s\n' "$FLAME_AUDIO_VERSION" "$FLUTTER_SDK_VERSION" | sort -V | head -n 1)" != "$FLAME_AUDIO_VERSION" ]; then
    echo "Flame Audio version is not compatible with Flutter SDK version"
    exit 1
  fi

  if [ "$(printf '%s\n' "$FLAME_ENGINE_VERSION" "$FLUTTER_SDK_VERSION" | sort -V | head -n 1)" != "$FLAME_ENGINE_VERSION" ]; then
    echo "Flame Engine version is not compatible with Flutter SDK version"
    exit 1
  fi
else
  echo "Flame Audio, Flame Engine, or Flutter SDK version not found"
  exit 1
fi
