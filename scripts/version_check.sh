#!/bin/bash

flutter_version=$(flutter --version | grep "Flutter" | awk '{print $2}')
min_flutter_version=$(grep "flutter: " pubspec.yaml | awk '{print $2}' | tr -d '^"')
min_flutter_version=${min_flutter_version//\'/}
if [[ "$(printf '%s\n' "$min_flutter_version" "$flutter_version" | sort -V | head -n1)" != "$min_flutter_version" ]]; then
  echo "Flutter version is valid: $flutter_version"
else
  echo "Flutter version is not valid. Expected >= $min_flutter_version but got $flutter_version"
  exit 1
fi

java_version=$(java -version 2>&1 | grep "openjdk version" | awk '{print $3}' | tr -d '"')
required_java_version="17"
if [[ "$java_version" == "$required_java_version"* ]]; then
  echo "Java version is valid: $java_version"
else
  echo "Java version is not valid. Expected $required_java_version but got $java_version"
  exit 1
fi
