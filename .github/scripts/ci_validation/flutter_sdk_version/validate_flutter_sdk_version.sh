#!/bin/bash

# Validar se as versões mínimas suportadas estão documentadas
if [ ! -f ".github/scripts/ci_validation/flutter_sdk_version/docs/criterios_aceitacao_flutter_sdk_version.md" ]; then
  echo "Arquivo de critérios de aceitação não encontrado."
  exit 1
fi

# Extrair a versão do Flutter SDK do pubspec.yaml
flutter_sdk_version=$(grep "sdk: flutter" pubspec.yaml -A 1 | tail -n 1 | tr -d ' ')

# Verificar se a versão mínima do Flutter SDK está documentada
if ! grep -q "$flutter_sdk_version" .github/scripts/ci_validation/flutter_sdk_version/docs/criterios_aceitacao_flutter_sdk_version.md; then
  echo "Versão do Flutter SDK não documentada corretamente."
  exit 1
fi

echo "Validação da versão do Flutter SDK concluída com sucesso."
exit 0

