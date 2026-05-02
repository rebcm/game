#!/bin/bash

validate_checksum() {
  local file_path=$1
  local expected_checksum=$2

  actual_checksum=$(sha256sum "$file_path" | cut -d' ' -f1)

  if [ "$actual_checksum" != "$expected_checksum" ]; then
    echo "Checksum mismatch for $file_path: expected $expected_checksum, got $actual_checksum"
    exit 1
  fi
}

validate_checksum "$1" "$2"
