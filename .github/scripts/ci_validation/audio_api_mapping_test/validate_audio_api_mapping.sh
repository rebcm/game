#!/bin/bash

# Validate that the audio API comparison document exists and is not empty
if [ ! -f docs/audio_api_mapping/audio_api_comparison.md ] || [ ! -s docs/audio_api_mapping/audio_api_comparison.md ]; then
  echo "Audio API comparison document is missing or empty."
  exit 1
fi

