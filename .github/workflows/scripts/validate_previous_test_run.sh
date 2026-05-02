#!/bin/bash

# Script to investigate logs of previous test run
log_file=".github/workflows/logs/previous_test_run.log"

if [ -f "$log_file" ]; then
  echo "Analyzing previous test run logs..."
  grep -E 'error|failure|exception' "$log_file"
else
  echo "No log file found for previous test run."
fi
