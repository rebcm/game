#!/bin/bash

flutter_version=$(flutter --version | grep "Flutter" | awk '{print $2}')
dart_version=$(dart --version | grep "Dart" | awk '{print $4}' | sed 's/.$//')
java_version=$(java -version 2>&1 | grep "version" | awk '{print $3}' | sed 's/"//g')

sed -i "s/| Flutter    | .* |/| Flutter    | $flutter_version |/" .github/docs/setup_version_matrix/version_matrix.md
sed -i "s/| Dart       | .* |/| Dart       | $dart_version |/" .github/docs/setup_version_matrix/version_matrix.md
sed -i "s/| Java       | .* |/| Java       | $java_version |/" .github/docs/setup_version_matrix/version_matrix.md
