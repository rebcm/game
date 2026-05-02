#!/bin/bash

mkdir -p docs/dependencies

cat > docs/dependencies/README.md << 'EOF2'
# Mapeamento de Versões de Dependências

Este documento visa mapear as versões das dependências do projeto, incluindo Flutter SDK, Dart SDK e pacotes listados no `pubspec.yaml`, para garantir compatibilidade e evitar breaking changes.

## Versões das Dependências

### Flutter e Dart SDK

- **Flutter SDK**: `flutter --version`
- **Dart SDK**: `dart --version`

### Pacotes do `pubspec.yaml`

#### Dependências de Produção

| Pacote | Versão |
| --- | --- |
EOF2

for package in $(yq e '.dependencies[] | select(. != "flutter") | key' pubspec.yaml); do
  version=$(yq e ".dependencies.$package" pubspec.yaml)
  echo "| $package | $version |" >> docs/dependencies/README.md
done

cat >> docs/dependencies/README.md << 'EOF2'
#### Dependências de Desenvolvimento

| Pacote | Versão |
| --- | --- |
EOF2

for package in $(yq e '.dev_dependencies[] | select(. != "flutter_test" and . != "integration_test") | key' pubspec.yaml); do
  version=$(yq e ".dev_dependencies.$package" pubspec.yaml)
  echo "| $package | $version |" >> docs/dependencies/README.md
done
EOF2

chmod +x .github/workflows/scripts/generate_dependency_map.sh
