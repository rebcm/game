#!/bin/bash

JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
GRADLE_JDK=$(grep 'Gradle JDK' .idea/misc.xml | sed 's/.*value="\(.*\)".*/\1/')

if [ "$JAVA_HOME" != "$GRADLE_JDK" ]; then
  echo "Java Home mismatch: $JAVA_HOME (CLI) vs $GRADLE_JDK (IDE)"
  exit 1
fi
