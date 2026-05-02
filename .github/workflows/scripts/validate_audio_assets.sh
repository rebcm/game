#!/bin/bash

validate_audio() {
  local file=$1
  local format=$(ffprobe -v error -show_streams -print_format json "$file" | jq -r '.streams[0].codec_name')
  if [ "$format" != "opus" ] && [ "$format" != "vorbis" ] && [ "$format" != "mp3" ]; then
    echo "Unsupported codec in $file: $format"
    exit 1
  fi
}

for file in assets/audio/optimized/ambient/*.ogg assets/audio/optimized/music/*.ogg assets/audio/optimized/sfx/*.ogg; do
  validate_audio "$file"
done

for file in assets/audio/optimized/ambient/*.mp3 assets/audio/optimized/music/*.mp3 assets/audio/optimized/sfx/*.mp3; do
  validate_audio "$file"
done
