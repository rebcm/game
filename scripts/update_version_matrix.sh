#!/bin/bash

VERSION_MATRIX_FILE="./.github/docs/setup_version_matrix/version_matrix.md"

FLUTTER_VERSION=$(flutter --version | grep "Flutter" | awk '{print $2}')
DART_VERSION=$(dart --version | grep "Dart" | awk '{print $4}' | sed 's/.$//')
JAVA_VERSION=$(java -version 2>&1 | grep "version" | awk '{print $3}' | sed 's/"//g')

sed -i "s/| Flutter    | .* |/| Flutter    | $FLUTTER_VERSION |/" $VERSION_MATRIX_FILE
sed -i "s/| Dart       | .* |/| Dart       | $DART_VERSION |/" $VERSION_MATRIX_FILE
sed -i "s/| Java       | .* |/| Java       | $JAVA_VERSION |/" $VERSION_MATRIX_FILE
