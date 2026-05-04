#!/bin/bash

JDK_VERSION=$(java -version 2>&1 | head -1 | cut -d '"' -f 2 | cut -d '.' -f 1)

if [ "$JDK_VERSION" != "17" ]; then
  echo "JDK version is not 17"
  exit 1
fi
