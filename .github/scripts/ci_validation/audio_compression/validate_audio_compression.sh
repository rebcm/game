#!/bin/bash

# Define the acceptable bitrate range (in kbps)
MIN_BITRATE=128
MAX_BITRATE=192

# Check if the bitrate is within the acceptable range
check_bitrate() {
  local bitrate=$(ffprobe -v error -show_entries stream=bit_rate -of default=noprint_wrappers=1:nokey=1 "$1")
  bitrate=$((bitrate / 1000)) # Convert to kbps
  if (( bitrate < MIN_BITRATE || bitrate > MAX_BITRATE )); then
    echo "Bitrate $bitrate kbps is out of range [$MIN_BITRATE, $MAX_BITRATE] for file $1"
    exit 1
  fi
}

# Check all audio files in the assets directory
for file in assets/*.mp3; do
  check_bitrate "$file"
done
