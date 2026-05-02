#!/bin/bash

required_reduction_percentage=10  # Define the required reduction percentage
actual_reduction_percentage=${SIZE_REDUCTION_PERCENTAGE}

if (( $(echo "$actual_reduction_percentage >= $required_reduction_percentage" | bc -l) )); then
  echo "Compression KPI met: $actual_reduction_percentage% reduction achieved"
  exit 0
else
  echo "Compression KPI not met: $actual_reduction_percentage% reduction achieved, $required_reduction_percentage% required"
  exit 1
fi
