#!/bin/bash

validate_keystore() {
  if [ -z "$1" ]; then
    echo "Keystore path is empty"
    exit 1
  fi

  if [ ! -f "$1" ]; then
    echo "Keystore file not found: $1"
    exit 1
  fi
}

validate_keystore "${KEYSTORE_PATH}"
validate_keystore "${CERTIFICATE_PATH}"
