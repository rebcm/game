#!/bin/bash

if [ -z "$CF_API_TOKEN" ] || [ -z "$CF_ACCOUNT_ID" ]; then
  echo "Error: CF_API_TOKEN or CF_ACCOUNT_ID is not set"
  exit 1
fi

echo "CF_API_TOKEN and CF_ACCOUNT_ID are set"
