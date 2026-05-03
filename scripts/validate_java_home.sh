#!/bin/bash

java_home_cli=$(java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home')
java_home_ide=$(grep 'gradle.java.home' ~/.gradle/gradle.properties | cut -d'=' -f2-)

if [ "$java_home_cli" != "$java_home_ide" ]; then
  echo "Java Home mismatch detected!"
  exit 1
fi
echo "Java Home is synchronized."
