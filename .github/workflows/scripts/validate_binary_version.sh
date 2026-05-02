#!/bin/bash

ARTIFACT_DIR=$1
VERSION=$(grep version pubspec.yaml | head -1 | cut -d ':' -f2- | xargs)

for file in "$ARTIFACT_DIR"/*; do
  if [[ $file == *.apk || $file == *.aab ]]; then
    echo "Validating version for $file"
    aapt dump badging "$file" | grep versionName | cut -d ':' -f2- | xargs | grep -q "$VERSION"
    if [ $? -ne 0 ]; then
      echo "Version mismatch for $file"
      exit 1
    fi
  elif [[ $file == *.ipa ]]; then
    echo "Validating version for $file"
    # ipa version validation is complex and requires specific tools
    # implement later if needed
    :
  fi
done
