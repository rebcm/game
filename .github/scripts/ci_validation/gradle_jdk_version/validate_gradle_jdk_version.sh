#!/bin/bash

GRADLE_VERSION=$(gradle --version | grep 'Gradle' | cut -d ' ' -f 2)

if [[ $(printf '%s\n' "7.3" "$GRADLE_VERSION" | sort -V | head -n1) != "7.3" ]]; then
  echo "Gradle versão $GRADLE_VERSION é compatível com JDK 17"
else
  echo "Erro: Gradle versão $GRADLE_VERSION não é compatível com JDK 17. Use Gradle 7.3 ou superior."
  exit 1
fi
