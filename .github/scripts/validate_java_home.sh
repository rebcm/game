#!/bin/bash

JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
GRADLE_JDK=$(grep 'Gradle JDK' .idea/misc.xml | sed 's/.*value="\(.*\)".*/\1/')

if [ "$JAVA_HOME" != "$GRADLE_JDK" ]; then
  echo "JAVA_HOME ($JAVA_HOME) and Gradle JDK ($GRADLE_JDK) do not match."
  exit 1
fi
