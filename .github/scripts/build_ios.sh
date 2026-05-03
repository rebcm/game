#!/bin/bash

# Existing build script content...
# Add IPA build and artifact upload steps
flutter build ipa --export-options-plist=.github/scripts/ExportOptions.plist
mv build/ios/ipa/*.ipa build/ios/ipa/rebcm.ipa
