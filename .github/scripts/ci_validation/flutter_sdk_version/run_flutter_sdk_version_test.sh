#!/bin/bash

# Verifica se a versão do Flutter SDK está de acordo com os critérios de aceitação

flutter_sdk_version=$(flutter --version | grep "Flutter" | cut -d' ' -f2)

echo "Versão do Flutter SDK: $flutter_sdk_version"

# Implementar lógica para verificar se a versão do Flutter SDK atende aos critérios de aceitação
# e documentar as versões mínimas suportadas de Android e iOS

