#!/bin/bash

# Check if JAVA_HOME is set
if [ -z "$JAVA_HOME" ]; then
  echo "JAVA_HOME is not set"
  exit 1
fi

# Validate Java version
java_version=$($JAVA_HOME/bin/java -version 2>&1 | head -n 1 | cut -d '"' -f 2)
if [[ $java_version != "17."* ]]; then
  echo "Java version is not 17 or higher: $java_version"
  exit 1
fi

echo "JAVA_HOME is set and valid: $JAVA_HOME"
