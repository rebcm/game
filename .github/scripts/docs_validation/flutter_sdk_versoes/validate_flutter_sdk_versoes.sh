#!/bin/bash

# Script para validar as versões mínimas do Flutter SDK suportadas

# Obtém a versão atual do Flutter
flutter_version=$(flutter --version | grep 'Flutter' | cut -d' ' -f2)

# Extrai as informações de versão mínima suportada para Android e iOS
android_min_version=$(flutter doctor -v | grep 'Android API' | cut -d':' -f2- | xargs)
ios_min_version=$(flutter doctor -v | grep 'iOS' | grep 'deployment target' | cut -d':' -f2- | xargs)

# Cria ou atualiza o arquivo de documentação com as versões mínimas
mkdir -p docs/flutter_sdk_versoes
cat > docs/flutter_sdk_versoes/minimas_versoes_suportadas.md << EOM
# Versões Mínimas Suportadas pelo Flutter SDK

## Versão atual do Flutter: $flutter_version

### Android
- API Level mínimo suportado: $android_min_version

### iOS
- Versão mínima de deployment target: $ios_min_version
EOM

echo "Versões mínimas suportadas documentadas com sucesso."
