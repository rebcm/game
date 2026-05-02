#!/bin/bash

echo "Flutter SDK: $(flutter --version)"
echo "Dart SDK: $(dart --version)"
echo "Pubspec Dependencies:"
cat pubspec.yaml | grep '^  [a-zA-Z0-9_]' | sed 's/^[[:space:]]*//g'
