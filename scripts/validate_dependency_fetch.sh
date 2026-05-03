#!/bin/bash

flutter pub get
if [ $? -eq 0 ]; then
  echo "Dependency fetch successful"
else
  echo "Dependency fetch failed"
  exit 1
fi
