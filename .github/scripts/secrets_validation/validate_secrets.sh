#!/bin/bash

validate_secrets() {
  if [ -z "$DB_CONNECTION_STRING" ]; then
    echo "DB_CONNECTION_STRING is not set"
    exit 1
  fi

  if [ -z "$API_KEY" ]; then
    echo "API_KEY is not set"
    exit 1
  fi
}

validate_secrets
