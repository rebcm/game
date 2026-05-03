#!/bin/bash

# Verificar a versão do Flutter SDK
flutter doctor | grep 'Flutter' | grep -q '3.0.0'

if [ $? -ne 0 ]; then
  echo "Versão do Flutter SDK não é compatível"
  exit 1
fi

# Verificar a documentação
grep -q 'API Level 21' docs/flutter_sdk_version.md
if [ $? -ne 0 ]; then
  echo "Documentação não está atualizada com a versão mínima suportada do Android"
  exit 1
fi

grep -q 'iOS 12' docs/flutter_sdk_version.md
if [ $? -ne 0 ]; then
  echo "Documentação não está atualizada com a versão mínima suportada do iOS"
  exit 1
fi
