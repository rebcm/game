#!/bin/bash

for file in assets/audio/optimized/music/*.mp3; do
  ffmpeg -i "$file" -af "silencedetect=n=-50dB:d=1" -f null - 2>&1 | grep 'silence_end' | tee silence_log.txt
  if grep -q 'silence_end: 0' silence_log.txt; then
    echo "File $file has silence at the beginning"
    exit 1
  fi
  duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$file")
  if grep -q "silence_start: $duration" silence_log.txt; then
    echo "File $file has silence at the end"
    exit 1
  fi
done
