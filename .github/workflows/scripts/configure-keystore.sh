#!/bin/bash

echo "$ANDROID_KEYSTORE" | base64 --decode > android/keystore.jks
echo "$ANDROID_KEYSTORE_PASSWORD" > android/keystore.password
