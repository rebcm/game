#!/bin/bash

flutter_sdk_version=$(flutter --version | grep 'Flutter' | cut -d' ' -f2)

min_android_api_level=$(grep 'minSdkVersion' android/app/build.gradle | cut -d'=' -f2- | tr -d '[:space:]')

min_ios_version=$(grep 'IPHONEOS_DEPLOYMENT_TARGET' ios/Podfile | cut -d '=' -f2- | tr -d '[:space:]' | tr -d ';' | tr -d '"')

echo "Versão do Flutter SDK: $flutter_sdk_version"
echo "Nível mínimo da API Android: $min_android_api_level"
echo "Versão mínima do iOS: $min_ios_version"

cat > docs/flutter_sdk_versoes.md << EOF2
# Versões Mínimas Suportadas

## Flutter SDK
$flutter_sdk_version

## Android
API Level $min_android_api_level

## iOS
$min_ios_version
EOF2
