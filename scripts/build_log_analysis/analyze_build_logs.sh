#!/bin/bash

# Analyze build logs for errors and warnings
analyze_logs() {
  local log_file=$1
  local error_count=$(grep -cE 'error|Error|ERROR' "$log_file")
  local warning_count=$(grep -cE 'warning|Warning|WARNING' "$log_file")
  local dependency_issue=$(grep -c 'pubspec.yaml' "$log_file")
  local signing_issue=$(grep -cE 'CodeSign|code signing' "$log_file")

  echo "Error count: $error_count"
  echo "Warning count: $warning_count"
  echo "Dependency issue: $dependency_issue"
  echo "Signing issue: $signing_issue"
}

# Check if log file is provided
if [ $# -eq 0 ]; then
  echo "Please provide the log file to analyze"
  exit 1
fi

analyze_logs "$1"
