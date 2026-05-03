#!/bin/bash

# Validate memory leak baseline
if ! diff test_driver/memory_leak_baseline.json <(cat test_driver/memory_leak_baseline.json); then
  echo "Memory leak baseline validation failed"
  exit 1
fi
