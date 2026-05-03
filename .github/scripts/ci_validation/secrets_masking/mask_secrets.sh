#!/bin/bash

# Function to mask secrets in logs
mask_secrets() {
  # List of secrets to mask
  local secrets=("$@")
  local log_file="${1:-/dev/stdin}"
  shift

  # Use sed to replace each secret with a masked version
  for secret in "${secrets[@]}"; do
    log_file=$(sed "s|$secret|********|g" <<< "$log_file")
  done

  echo "$log_file"
}

# Example usage: mask_secrets "secret_value1" "secret_value2" < log_file.log
