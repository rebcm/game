#!/bin/bash

# Validate the output of the Flutter minimum SDK version test
if [ -f flutter_min_sdk_versions.txt ]; then
  echo "Flutter minimum SDK version test passed: versions recorded."
else
  echo "Flutter minimum SDK version test failed: versions not recorded."
  exit 1
fi
