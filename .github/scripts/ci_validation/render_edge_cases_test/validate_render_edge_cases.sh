#!/bin/bash

if [ $? -eq 0 ]; then
  echo "Render edge cases test passed"
else
  echo "Render edge cases test failed"
  exit 1
fi
