#!/bin/bash

# TO DO: implement logic to calculate the current APK/IPA size
current_size=$(echo "1000") # placeholder value

target_reduction=$(cat compression_target.txt)
target_size=$(echo "scale=2; $current_size * (1 - $target_reduction / 100)" | bc)

echo "Current size: $current_size"
echo "Target size: $target_size"

if (( $(echo "$current_size <= $target_size" | bc -l) )); then
  echo "KPI achieved!"
else
  echo "KPI not achieved!"
fi
