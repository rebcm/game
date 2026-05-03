#!/bin/bash

# Decrypt keystore using GitHub Secrets
echo "Decrypting keystore..."
mkdir -p android/app
echo "$KEYSTORE_ENCRYPTED" | base64 --decode > android/app/keystore.jks.enc
openssl aes-256-cbc -d -in android/app/keystore.jks.enc -out android/app/keystore.jks -pass pass:$KEYSTORE_PASSWORD
echo "Keystore decrypted successfully."
