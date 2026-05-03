#!/bin/bash

# Script to run memory leak tests
# Usage: ./run_memory_leak_test.sh

# Navigate to the project root
cd /home/user/game

# Run the memory leak test using leak_tracker
flutter test --dart-define=LEAK_TRACKER=true test/memory_leak/memory_leak_test.dart

# Check if the test was successful
if [ $? -eq 0 ]; then
  echo "Memory leak test passed"
else
  echo "Memory leak test failed"
  exit 1
fi
