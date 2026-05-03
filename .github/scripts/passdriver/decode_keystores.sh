#!/bin/bash

echo "Decodificando keystores..."

mkdir -p android/app/keystores ios/keystores

echo $KEYSTORE_JKS_BASE64 | base64 --decode > android/app/keystores/keystore.jks
echo $KEYSTORE_P12_BASE64 | base64 --decode > ios/keystores/keystore.p12

echo "Keystores decodificados com sucesso."
