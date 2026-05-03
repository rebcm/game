#!/bin/bash

# Convert audio files to .ogg format
for file in assets/audio/sfx/*.wav; do
  ffmpeg -i "$file" -c:a libvorbis -q:a 5 "assets/audio/optimized/sfx/$(basename "$file" .wav).ogg"
done

for file in assets/audio/ambient/*.wav; do
  ffmpeg -i "$file" -c:a libvorbis -q:a 5 "assets/audio/optimized/ambient/$(basename "$file" .wav).ogg"
done

for file in assets/audio/music/*.wav; do
  ffmpeg -i "$file" -c:a libvorbis -q:a 5 "assets/audio/optimized/music/$(basename "$file" .wav).ogg"
done
