#!/bin/bash

if [ -z "$API_KEY" ]; then
  echo "API_KEY is not set"
  exit 1
fi

if [ -z "$SECRET_KEY" ]; then
  echo "SECRET_KEY is not set"
  exit 1
fi
