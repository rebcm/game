#!/bin/bash

# Script to validate memory leak baseline

# Check if the memory leak baseline file exists
if [ ! -f ./docs/memory_leak_baseline.txt ]; then
  echo "Memory leak baseline file not found."
  exit 1
fi

# Check if the memory leak baseline file is not empty
if [ ! -s ./docs/memory_leak_baseline.txt ]; then
  echo "Memory leak baseline file is empty."
  exit 1
fi

# Validate the content of the memory leak baseline file
baseline=$(cat ./docs/memory_leak_baseline.txt)
if ! [[ $baseline =~ ^[0-9]+$ ]]; then
  echo "Invalid memory leak baseline value."
  exit 1
fi

echo "Memory leak baseline validation successful."
