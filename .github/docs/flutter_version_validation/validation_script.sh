#!/bin/bash

FLUTTER_VERSION=$(flutter --version | grep "Flutter" | cut -d' ' -f2)
JAVA_VERSION=$(java -version 2>&1 | grep "java version" | cut -d'"' -f2 | cut -d'.' -f1-2)

if [ "$FLUTTER_VERSION" != "3.0.0" ] && [ "$FLUTTER_VERSION" != "3.0.1" ] && [ "$FLUTTER_VERSION" != "3.0.2" ] && [ "$FLUTTER_VERSION" != "3.0.3" ] && [ "$FLUTTER_VERSION" != "3.0.4" ] && [ "$FLUTTER_VERSION" != "3.0.5" ]; then
  echo "Flutter version $FLUTTER_VERSION is not compatible with Java $JAVA_VERSION"
  exit 1
fi

if [ "$JAVA_VERSION" != "17" ]; then
  echo "Java version $JAVA_VERSION is not compatible with Flutter $FLUTTER_VERSION"
  exit 1
fi

echo "Flutter version $FLUTTER_VERSION is compatible with Java $JAVA_VERSION"
exit 0
