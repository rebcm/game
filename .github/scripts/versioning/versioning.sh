#!/bin/bash

# Lê a versão atual do pubspec.yaml
VERSION=$(grep 'version:' pubspec.yaml | sed 's/version: //')

# Extrai os componentes da versão
MAJOR=$(echo $VERSION | cut -d '.' -f 1)
MINOR=$(echo $VERSION | cut -d '.' -f 2 | cut -d '+' -f 1)
PATCH_BUILD=$(echo $VERSION | cut -d '.' -f 3)
BUILD=$(echo $PATCH_BUILD | cut -d '+' -f 2)

# Incrementa o build
NEW_BUILD=$((BUILD + 1))

# Atualiza a versão no pubspec.yaml
sed -i "s/version: $VERSION/version: $MAJOR.$MINOR.$PATCH_BUILD+$NEW_BUILD/" pubspec.yaml

echo "Versão atualizada para $MAJOR.$MINOR.$PATCH_BUILD+$NEW_BUILD"
