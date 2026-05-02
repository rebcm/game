#!/bin/bash

if [ ! -d "build/web" ]; then
  echo "Web build directory not found"
  exit 1
fi

if [ -z "$(ls -A build/web)" ]; then
  echo "Web build directory is empty"
  exit 1
fi

echo "Web build validated successfully"
