#!/bin/bash

# Obtém a versão do Flutter em uso
flutter_version=$(flutter --version | grep 'Flutter' | awk '{print $2}')

# Extrai as informações de versão mínima de Android e iOS suportadas
android_min_version=$(flutter doctor -v | grep 'Android SDK version' -A 3 | grep 'minSdkVersion' | awk '{print $2}' | tr -d ',')
ios_min_version=$(grep 'MinimumOSVersion' ios/Podfile.lock | awk '{print $2}')

# Salva as informações em um arquivo markdown
cat > docs/flutter_sdk_versoes.md << EOM
# Versões Mínimas Suportadas pelo Flutter SDK

- **Versão do Flutter:** $flutter_version
- **Versão mínima do Android:** API Level $android_min_version
- **Versão mínima do iOS:** $ios_min_version

EOM

echo "Versões mínimas suportadas documentadas com sucesso."
