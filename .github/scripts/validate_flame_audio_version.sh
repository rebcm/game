#!/bin/bash

FLAME_VERSION=$(grep "flame:" ./pubspec.yaml | awk '{print $2}' | tr -d '^')
FLAME_AUDIO_VERSION=$(grep "flame_audio:" ./pubspec.yaml | awk '{print $2}' | tr -d '^')

if [ "$(printf '%s\n' "$FLAME_VERSION" "$FLAME_AUDIO_VERSION" | sort -V | head -n1)" != "$FLAME_AUDIO_VERSION" ]; then
  echo "flame_audio version is not compatible with flame version"
  exit 1
fi
