#!/bin/bash

original_size=$(stat -c%s original.apk)
new_size=$(stat -c%s new.apk)

echo "Original APK size: $original_size bytes"
echo "New APK size: $new_size bytes"

reduction=$(echo "scale=2; (($original_size - $new_size) / $original_size) * 100" | bc)
echo "Reduction: $reduction%"

target_reduction=$(cat compression_target.txt)
if (( $(echo "$reduction >= $target_reduction" | bc -l) )); then
  echo "KPI achieved: $reduction% >= $target_reduction%"
else
  echo "KPI not achieved: $reduction% < $target_reduction%"
fi
