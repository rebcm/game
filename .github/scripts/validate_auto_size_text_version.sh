#!/bin/bash

VERSION=$(grep 'auto_size_text:' pubspec.yaml | awk '{print $2}' | tr -d '^+')
if [ "$VERSION" != "3.0.0" ]; then
  echo "auto_size_text version is not 3.0.0"
  exit 1
fi
