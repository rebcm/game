#!/bin/bash

validate_binary_version() {
  local binary_path=$1
  local expected_version=$2

  # Assuming the binary version is extracted using some command `extract_version`
  actual_version=$(extract_version "$binary_path")

  if [ "$actual_version" != "$expected_version" ]; then
    echo "Version mismatch for $binary_path: expected $expected_version, got $actual_version"
    exit 1
  fi
}

validate_binary_version "$1" "$2"
