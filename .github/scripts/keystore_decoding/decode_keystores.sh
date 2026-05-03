#!/bin/bash

# Decode Base64 encoded keystores
echo "Decoding keystores..."

# Create directory for keystores if it doesn't exist
mkdir -p android/app/keystores ios/keystores

# Decode keystores from Base64 encoded secrets
echo $RELEASE_KEYSTORE_BASE64 | base64 --decode > android/app/keystores/release.keystore
echo $DEBUG_KEYSTORE_BASE64 | base64 --decode > android/app/keystores/debug.keystore
echo $IOS_P12_BASE64 | base64 --decode > ios/keystores/rebeca.p12

echo "Keystores decoded successfully."
