#!/bin/bash

VERSION=$(grep 'version:' pubspec.yaml | sed 's/version: //g')
BUILD_NUMBER=${GITHUB_RUN_NUMBER}

echo "Current version: ${VERSION}"
echo "Build number: ${BUILD_NUMBER}"

NEW_VERSION=$(echo $VERSION | sed "s/\(.*\)+\(.*\)/\1+${BUILD_NUMBER}/g")
echo "New version: ${NEW_VERSION}"

sed -i "s/version: $VERSION/version: $NEW_VERSION/g" pubspec.yaml
