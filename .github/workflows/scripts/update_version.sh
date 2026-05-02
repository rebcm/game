#!/bin/bash

VERSION=$(grep 'version:' pubspec.yaml | sed 's/version: //g' | tr -d '"')
BUILD_NUMBER=${GITHUB_RUN_NUMBER}

NEW_VERSION="${VERSION%%+*}+${BUILD_NUMBER}"

sed -i "s/version: .*/version: ${NEW_VERSION}/g" pubspec.yaml
