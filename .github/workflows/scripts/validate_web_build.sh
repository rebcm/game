#!/bin/bash

if [ ! -d "build/web" ]; then
  echo "Build artifacts not found"
  exit 1
fi

echo "Build artifacts validated successfully"
