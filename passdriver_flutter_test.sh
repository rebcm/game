#!/bin/bash

# Run Flutter performance test
flutter drive --target=test_driver/app.dart --driver=test_driver/performance_test.dart --profile

# Check FPS and Jank Frames
FPS=$(cat performance_test_result.txt | grep "FPS" | cut -d ":" -f2)
JANK_FRAMES=$(cat performance_test_result.txt | grep "Jank Frames" | cut -d ":" -f2)

# Compare with KPI
FPS_KPI=$(cat performance_kpi/fps_kpi.txt | cut -d "=" -f2)
JANK_FRAMES_KPI=$(cat performance_kpi/jank_frames_kpi.txt | cut -d "=" -f2)

if (( $(echo "$FPS < $FPS_KPI" | bc -l) )); then
  echo "FPS is lower than expected"
  exit 1
fi

if (( $(echo "$JANK_FRAMES > $JANK_FRAMES_KPI" | bc -l) )); then
  echo "Jank Frames is higher than expected"
  exit 1
fi
