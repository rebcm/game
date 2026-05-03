#!/bin/bash

FLAME_AUDIO_VERSION=$(grep 'flame_audio:' pubspec.yaml | awk '{print $2}' | tr -d ' ')
FLAME_VERSION=$(grep 'flame:' pubspec.yaml | awk '{print $2}' | tr -d ' ')

if [ -z "$FLAME_AUDIO_VERSION" ] || [ -z "$FLAME_VERSION" ]; then
  echo "Error: Could not determine flame_audio or flame version."
  exit 1
fi

FLAME_AUDIO_MAJOR_VERSION=$(echo $FLAME_AUDIO_VERSION | cut -d '.' -f 1)
FLAME_MAJOR_VERSION=$(echo $FLAME_VERSION | cut -d '.' -f 1)

if [ "$FLAME_AUDIO_MAJOR_VERSION" != "$FLAME_MAJOR_VERSION" ]; then
  echo "Error: flame_audio version is not compatible with flame version."
  exit 1
fi

echo "flame_audio version is compatible with flame version."
exit 0
