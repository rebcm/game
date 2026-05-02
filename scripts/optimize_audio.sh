#!/bin/bash

# Optimize ambient audio files
for file in ./assets/audio/raw/ambient/*.wav; do
  ffmpeg -i "$file" -c:a libvorbis -q:a 5 "./assets/audio/optimized/ambient/$(basename "$file" .wav).ogg"
done

# Optimize music audio files
for file in ./assets/audio/raw/music/*.wav; do
  ffmpeg -i "$file" -c:a libvorbis -q:a 5 "./assets/audio/optimized/music/$(basename "$file" .wav).ogg"
done

# Optimize sfx audio files
for file in ./assets/audio/raw/sfx/*.wav; do
  ffmpeg -i "$file" -c:a libvorbis -q:a 5 "./assets/audio/optimized/sfx/$(basename "$file" .wav).ogg"
done
