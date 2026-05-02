#!/bin/bash

for file in assets/audio/optimized/*.ogg; do
  if ! ffprobe -v error "$file"; then
    echo "Invalid ogg file: $file"
    exit 1
  fi
done
