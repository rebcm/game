#!/bin/bash

# Check flame_audio version compatibility
FLAME_AUDIO_VERSION=$(flutter pub deps | grep flame_audio | awk '{print $2}' | sed 's/\.//g')
FLAME_VERSION=$(flutter pub deps | grep flame | awk '{print $2}' | sed 's/\.//g')

if [ $FLAME_AUDIO_VERSION -lt $FLAME_VERSION ]; then
  echo "flame_audio version is not compatible with flame version"
  exit 1
fi
