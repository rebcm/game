#!/bin/bash

if [ -z "$CF_API_TOKEN" ]; then
  echo "Error: CF_API_TOKEN is not set"
  exit 1
fi

echo "CF_API_TOKEN is set"
