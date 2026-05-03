#!/bin/bash

# Validate audio API mapping documentation
if [ ! -f ./docs/audio_api_mapping/audio_api_comparison.md ]; then
  echo "Audio API comparison document is missing."
  exit 1
fi

