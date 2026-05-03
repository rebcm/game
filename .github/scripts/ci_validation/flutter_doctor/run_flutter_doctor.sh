#!/bin/bash

# Execute flutter doctor and capture the output
flutter doctor > flutter_doctor_output.txt 2>&1

# Check if there are any missing dependencies
if grep -q "X" flutter_doctor_output.txt; then
  echo "Flutter doctor found issues:"
  cat flutter_doctor_output.txt
else
  echo "Flutter doctor did not find any issues."
fi
