#!/bin/bash

# Identificar a versão do Flutter SDK
flutter_sdk_version=$(flutter --version | grep "Flutter" | cut -d ' ' -f2)

# Identificar as versões mínimas de Android e iOS suportadas
android_min_version=$(flutter doctor -v | grep "Android SDK" -A 5 | grep "minSdkVersion" | cut -d '=' -f2-)
ios_min_version=$(flutter doctor -v | grep "Xcode" -A 5 | grep "Minimum iOS Deployment Target" | cut -d ':' -f2-)

# Documentar as versões mínimas suportadas
echo "Versão do Flutter SDK: $flutter_sdk_version" > docs/flutter_sdk_version.md
echo "Versão mínima do Android: $android_min_version" >> docs/flutter_sdk_version.md
echo "Versão mínima do iOS: $ios_min_version" >> docs/flutter_sdk_version.md

# Verificar se as versões mínimas estão documentadas
if [ ! -f docs/flutter_sdk_version.md ]; then
  echo "Erro: Versões mínimas não documentadas"
  exit 1
fi

echo "Versões mínimas do Flutter SDK documentadas com sucesso"
