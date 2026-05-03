#!/bin/bash

# Script to validate if all BLoC classes have corresponding documentation files

# Find all Dart files that contain classes extending BLoC
bloc_classes=$(grep -r --include "*.dart" "extends BLoC" lib/ | cut -d ':' -f 1)

for file in $bloc_classes; do
  class_name=$(basename "$file" .dart)
  doc_file="docs/blocos/$class_name.md"
  if [ ! -f "$doc_file" ]; then
    echo "Missing documentation for $class_name in $file"
    exit 1
  fi
done
