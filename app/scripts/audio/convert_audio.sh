#!/bin/bash

# Directory containing original audio files
INPUT_DIR="../../assets/audio"

# Directory to output converted audio files
OUTPUT_DIR="../../assets/audio_compressed"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Function to convert audio files to lower bitrate
convert_audio() {
  local file="$1"
  local output_file="$2"
  ffmpeg -i "$file" -c:a libvorbis -b:a 64k "$output_file"
}

# Convert all audio files
for file in "$INPUT_DIR"/*/*.ogg "$INPUT_DIR"/*/*.mp3; do
  if [ -f "$file" ]; then
    relative_path="${file#$INPUT_DIR/}"
    output_file="$OUTPUT_DIR/$relative_path"
    output_file="${output_file%.*}.ogg" # Ensure output is .ogg
    mkdir -p "$(dirname "$output_file")"
    convert_audio "$file" "$output_file"
  fi
done
