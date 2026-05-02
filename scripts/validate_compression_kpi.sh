#!/bin/bash

target_size=$(cat compression_kpi.txt | grep target_size | cut -d '=' -f 2)

apk_size=$(stat -c%s rebcm.apk)

if [ $apk_size -le $target_size ]; then
  echo "Compression KPI met: APK size ($apk_size bytes) is less than or equal to target size ($target_size bytes)"
  exit 0
else
  echo "Compression KPI not met: APK size ($apk_size bytes) is greater than target size ($target_size bytes)"
  exit 1
fi
