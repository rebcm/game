#!/bin/bash

# Navigate to the audio assets directory
cd assets/audio

# Optimize ambient sounds
for file in ambient/*.wav; do
  ffmpeg -i "$file" -c:a libvorbis -q:a 5 "optimized/ambient/$(basename "$file" .wav).ogg"
done

# Optimize sfx sounds
for file in sfx/*.wav; do
  ffmpeg -i "$file" -c:a libvorbis -q:a 5 "optimized/sfx/$(basename "$file" .wav).ogg"
done

# Optimize music
for file in music/*.wav; do
  ffmpeg -i "$file" -c:a libvorbis -q:a 5 "optimized/music/$(basename "$file" .wav).ogg"
done
