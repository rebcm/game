#!/bin/bash

GRADLE_VERSION=\$(gradle --version | head -n 1 | cut -d ' ' -f 2)

if [[ "\$(printf '%s\n' "7.3" "\$GRADLE_VERSION" | sort -V | head -n1)" != "7.3" ]]; then
  echo "Gradle version \$GRADLE_VERSION is compatible with JDK 17"
else
  echo "Gradle version \$GRADLE_VERSION is not compatible with JDK 17. Minimum required version is 7.3"
  exit 1
fi
