#!/bin/bash

# Valida se a versão do Gradle é compatível com o JDK 17

GRADLE_VERSION=$(gradle --version | grep "Gradle" | cut -d ' ' -f2)

if [[ "$GRADLE_VERSION" < "7.3" ]]; then
  echo "Erro: A versão do Gradle ($GRADLE_VERSION) não é compatível com o JDK 17. Versão mínima requerida: 7.3"
  exit 1
else
  echo "Versão do Gradle ($GRADLE_VERSION) é compatível com o JDK 17."
fi
