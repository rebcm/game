#!/bin/bash

# Validate walkthrough documentation
# Check if walkthrough documentation is up-to-date and correctly formatted

# Navigate to the documentation directory
cd game/docs || exit

# Check if walkthrough.dart exists
if [ ! -f walkthrough.dart ]; then
  echo "walkthrough.dart not found"
  exit 1
fi

# Validate the documentation
dart analyze walkthrough.dart
if [ $? -ne 0 ]; then
  echo "walkthrough.dart analysis failed"
  exit 1
fi

echo "Walkthrough documentation validation successful"
