#!/bin/bash

# Lê a versão do Flutter SDK do pubspec.yaml
flutter_sdk_version=$(grep 'sdk: ">=2' pubspec.yaml | sed 's/.*sdk: ">=\(.*\)".*/\1/')

# Versões mínimas suportadas
android_min_version="21"
ios_min_version="11"

# Verifica se a versão do Flutter SDK suporta as versões mínimas de Android e iOS
if [ "$(printf '%s\n' "$flutter_sdk_version" '2.17.0' | sort -V | head -n1)" = "2.17.0" ]; then
  echo "Versão do Flutter SDK é compatível com as versões mínimas suportadas."
else
  echo "Versão do Flutter SDK não é compatível com as versões mínimas suportadas."
  exit 1
fi

