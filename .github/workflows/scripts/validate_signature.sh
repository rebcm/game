#!/bin/bash

validate_android_signature() {
  if ! command -v apksigner &> /dev/null; then
    echo "Erro: apksigner não encontrado. Instale o Android SDK Build-Tools."
    exit 1
  fi

  APK_PATH=$1
  if [ ! -f "$APK_PATH" ]; then
    echo "Erro: APK não encontrado em $APK_PATH"
    exit 1
  fi

  apksigner verify --verbose "$APK_PATH"
  if [ $? -ne 0 ]; then
    echo "Erro: Assinatura do APK inválida"
    exit 1
  fi
}

validate_ios_signature() {
  if ! command -v codesign &> /dev/null; then
    echo "Erro: codesign não encontrado. Certifique-se de estar em um ambiente macOS com Xcode configurado."
    exit 1
  fi

  APP_PATH=$1
  if [ ! -d "$APP_PATH" ]; then
    echo "Erro: Aplicativo iOS não encontrado em $APP_PATH"
    exit 1
  fi

  codesign --verify --verbose "$APP_PATH"
  if [ $? -ne 0 ]; then
    echo "Erro: Assinatura do aplicativo iOS inválida"
    exit 1
  fi
}

validate_checksum() {
  FILE_PATH=$1
  EXPECTED_CHECKSUM=$2

  if [ ! -f "$FILE_PATH" ]; then
    echo "Erro: Arquivo não encontrado em $FILE_PATH"
    exit 1
  fi

  ACTUAL_CHECKSUM=$(sha256sum "$FILE_PATH" | cut -d' ' -f1)
  if [ "$ACTUAL_CHECKSUM" != "$EXPECTED_CHECKSUM" ]; then
    echo "Erro: Checksum do arquivo $FILE_PATH não confere. Esperado: $EXPECTED_CHECKSUM, Obtido: $ACTUAL_CHECKSUM"
    exit 1
  fi
}

usage() {
  echo "Uso: $0 <plataforma> <caminho_do_arquivo> [checksum esperado]"
  echo "Plataformas suportadas: android, ios, checksum"
  exit 1
}

PLATFORM=$1
FILE_PATH=$2
EXPECTED_CHECKSUM=$3

case $PLATFORM in
  android)
    validate_android_signature "$FILE_PATH"
    ;;
  ios)
    validate_ios_signature "$FILE_PATH"
    ;;
  checksum)
    if [ -z "$EXPECTED_CHECKSUM" ]; then
      usage
    fi
    validate_checksum "$FILE_PATH" "$EXPECTED_CHECKSUM"
    ;;
  *)
    usage
    ;;
esac
