#!/bin/bash

# Validate audio compression
validate_compression() {
  local bitrate=$1
  local threshold=$2
  local compressed_size=$(ffmpeg -i input.mp3 -c:a libmp3lame -b:a $bitrate output.mp3 2>&1 | grep -oP '(?<=size=)\d+')
  if (( compressed_size < threshold )); then
    echo "Compression successful with bitrate $bitrate"
  else
    echo "Compression failed with bitrate $bitrate"
    exit 1
  fi
}

# Define ideal bitrate
IDEAL_BITRATE=128k

# Validate compression with ideal bitrate
validate_compression $IDEAL_BITRATE 102400
