#!/bin/bash

# Verificar se o tamanho do chunk está correto
if ! grep -q "static const int chunkSize = 16;" lib/chunking/chunking_config.dart; then
  echo "Tamanho do chunk incorreto"
  exit 1
fi

# Verificar se a margem de pré-carregamento está correta
if ! grep -q "static const int bufferZone = 2;" lib/chunking/chunking_config.dart; then
  echo "Margem de pré-carregamento incorreta"
  exit 1
fi
