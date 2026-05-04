#!/bin/bash

# Execute flutter analyze and capture output
flutter analyze > lint_output.txt 2>&1

# Parse the output and convert to JSON
cat lint_output.txt | jq -R -s 'split("\n") | map(select(length > 0))' > lint_output.json
