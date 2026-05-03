#!/bin/bash

# Verificar se a versão do Gradle é compatível com o JDK 17
GRADLE_VERSION=$(gradle --version | grep 'Gradle' | cut -d ' ' -f2)

if [[ "$GRADLE_VERSION" < "7.3" ]]; then
  echo "Erro: Versão do Gradle ($GRADLE_VERSION) não é compatível com JDK 17. Necessário Gradle 7.3 ou superior."
  exit 1
else
  echo "Versão do Gradle ($GRADLE_VERSION) é compatível com JDK 17."
fi
