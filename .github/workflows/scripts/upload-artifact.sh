#!/bin/bash

APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
IPA_PATH="build/ios/ipa/game.ipa"

if [ -f "$APK_PATH" ]; then
  echo "Uploading APK artifact..."
  curl -X POST \
    https://api.github.com/repos/rebcm/game/actions/artifacts \
    -H 'Authorization: Bearer ${GITHUB_TOKEN}' \
    -H 'Content-Type: application/json' \
    -d '{"name":"app-release.apk","path":"'$APK_PATH'"}'
fi

if [ -f "$IPA_PATH" ]; then
  echo "Uploading IPA artifact..."
  curl -X POST \
    https://api.github.com/repos/rebcm/game/actions/artifacts \
    -H 'Authorization: Bearer ${GITHUB_TOKEN}' \
    -H 'Content-Type: application/json' \
    -d '{"name":"game.ipa","path":"'$IPA_PATH'"}'
fi
