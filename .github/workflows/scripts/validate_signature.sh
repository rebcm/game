#!/bin/bash

validate_android_signature() {
  APK_PATH=$1
  if ! apksigner verify --verbose "$APK_PATH" > /dev/null; then
    echo "Erro: Assinatura do APK inválida"
    exit 1
  fi
}

validate_ios_signature() {
  IPA_PATH=$1
  if ! codesign --verify --verbose "$IPA_PATH" > /dev/null; then
    echo "Erro: Assinatura do IPA inválida"
    exit 1
  fi
}

validate_android_signature "$1"
