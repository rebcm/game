#!/bin/bash

BUILD_DIR=$1

if [ -z "$BUILD_DIR" ]; then
  echo "Error: Build directory not provided"
  exit 1
fi

if [ ! -d "$BUILD_DIR" ]; then
  echo "Error: Build directory does not exist"
  exit 1
fi

# Check if the binary exists and is not empty
if [ ! -f "$BUILD_DIR/rebcm.apk" ] || [ ! -s "$BUILD_DIR/rebcm.apk" ]; then
  echo "Error: APK file is missing or empty"
  exit 1
fi

echo "Binary validation successful"
