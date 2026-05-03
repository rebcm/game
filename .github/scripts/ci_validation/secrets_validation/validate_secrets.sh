#!/bin/bash

validate_secret() {
  local secret_name=$1
  local secret_value=$2

  if [ -z "$secret_value" ]; then
    echo "Error: $secret_name is not set or is empty"
    return 1
  fi

  echo "$secret_name is set correctly"
  return 0
}

validate_secret "KEYSTORE_PASSWORD" "${KEYSTORE_PASSWORD}"
validate_secret "KEYSTORE_ALIAS" "${KEYSTORE_ALIAS}"
validate_secret "KEYSTORE_PATH" "${KEYSTORE_PATH}"

if [ $? -ne 0 ]; then
  exit 1
fi
