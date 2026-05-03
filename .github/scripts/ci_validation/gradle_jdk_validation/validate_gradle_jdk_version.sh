#!/bin/bash

GRADLE_VERSION=$(gradle --version | head -n 1 | cut -d ' ' -f 2)

if [[ $(printf "%s\n" "7.3" "$GRADLE_VERSION" | sort -V | head -n 1) != "7.3" ]]; then
  echo "Gradle version is compatible with JDK 17"
else
  echo "Error: Gradle version must be 7.3 or higher to support JDK 17"
  exit 1
fi
