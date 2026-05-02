#!/bin/bash

VERSION=$(git describe --tags --always)

echo "VERSION: $VERSION"

cd lib/features/versioning
dart run build_runner build --delete-conflicting-outputs

cd ../../..

flutter pubspec.yaml --patch-version=$VERSION

echo "Build version updated to $VERSION"
