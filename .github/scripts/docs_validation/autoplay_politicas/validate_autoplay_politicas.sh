#!/bin/bash

# Validates autoplay policies documentation for Chrome, Safari, and Firefox

# Check if the documentation file exists
if [ ! -f ./docs/autoplay_politicas.md ]; then
  echo "Error: ./docs/autoplay_politicas.md not found"
  exit 1
fi

# Validate Chrome autoplay policy documentation
if ! grep -q "Chrome" ./docs/autoplay_politicas.md; then
  echo "Error: Chrome autoplay policy not documented"
  exit 1
fi

# Validate Safari autoplay policy documentation
if ! grep -q "Safari" ./docs/autoplay_politicas.md; then
  echo "Error: Safari autoplay policy not documented"
  exit 1
fi

# Validate Firefox autoplay policy documentation
if ! grep -q "Firefox" ./docs/autoplay_politicas.md; then
  echo "Error: Firefox autoplay policy not documented"
  exit 1
fi

echo "Autoplay policies documentation validated successfully"
