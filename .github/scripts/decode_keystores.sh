#!/bin/bash

# Decode Base64 secrets back to binary files
echo "Decoding keystores from Base64 secrets..."

# Ensure the directory exists
mkdir -p android/keystores ios/keystores

# Decode KEY_JKS_BASE64 to key.jks
echo "$KEY_JKS_BASE64" | base64 --decode > android/keystores/key.jks

# Decode KEY_P12_BASE64 to key.p12
echo "$KEY_P12_BASE64" | base64 --decode > ios/keystores/key.p12

echo "Keystores decoded successfully."
