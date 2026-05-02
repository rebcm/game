#!/bin/bash

GRADLE_VERSION=$(gradle --version | grep 'Gradle' | awk '{print $2}')
echo "Gradle Version: $GRADLE_VERSION"
if [ "$(printf '%s\n' '7.5' "$GRADLE_VERSION" | sort -V | head -n1)" = '7.5' ]; then
  echo "Gradle version is compatible with AGP"
else
  echo "Gradle version is not compatible with AGP"
  exit 1
fi
