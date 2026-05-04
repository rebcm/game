#!/bin/bash

BUILD_COMMAND="flutter build web --base-href=/game/"
echo "Verifying build command: $BUILD_COMMAND"

$BUILD_COMMAND

if [ $? -eq 0 ]; then
  echo "Build successful with correct base-href"
else
  echo "Build failed with correct base-href"
  exit 1
fi
