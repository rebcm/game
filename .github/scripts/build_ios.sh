#!/bin/bash

# Existing build commands...
flutter build ipa --release --export-options-plist=.github/scripts/ExportOptions.plist

# Upload artifact
curl -X POST \
  https://api.github.com/repos/rebcm/game/actions/artifacts \
  -H 'Authorization: Bearer ${GITHUB_TOKEN}' \
  -H 'Content-Type: application/json' \
  -d '{"name":"rebcm-ios","path":"build/ios/ipa/rebcm.ipa"}'
