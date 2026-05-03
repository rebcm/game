#!/bin/bash

validate_secret() {
  local secret_name=$1
  if [ -z "${!secret_name}" ]; then
    echo "Error: $secret_name is not set"
    exit 1
  fi
}

validate_secret 'API_KEY'
validate_secret 'SECRET_KEY'

echo "All required secrets are present"
