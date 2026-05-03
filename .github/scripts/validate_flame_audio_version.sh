#!/bin/bash

validate_flame_audio_version() {
  local flame_version=$(grep '^  flame:' pubspec.yaml | awk '{print $2}' | tr -d '"')
  local flame_audio_version=$(grep '^  flame_audio:' pubspec.yaml | awk '{print $2}' | tr -d '"')

  if [ -n "$flame_version" ] && [ -n "$flame_audio_version" ]; then
    if ! grep -q "^flame_audio: ^$flame_audio_version" "$(dirname "$(find . -name 'pubspec.lock')")/pubspec.lock"; then
      echo "Incompatible flame_audio version. Expected version compatible with Flame $flame_version."
      exit 1
    fi
  else
    echo "Flame or flame_audio version not found in pubspec.yaml."
    exit 1
  fi
}

validate_flame_audio_version
