#!/bin/bash

current_size=$(stat -c%s rebcm.apk)
new_size=$(stat -c%s rebcm_new.apk)
reduction=$(echo "scale=2; (($current_size - $new_size) / $current_size) * 100" | bc)
echo "$reduction"
