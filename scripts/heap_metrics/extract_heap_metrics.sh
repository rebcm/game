#!/bin/bash

# Extract heap metrics from Flutter DevTools
flutter pub global run devtools --no-open-browser --profile temp_profile.json
cat temp_profile.json | jq '.memoryProfile.heapSize' > heap_metrics.txt
rm temp_profile.json
