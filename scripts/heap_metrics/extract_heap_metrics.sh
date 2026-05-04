#!/bin/bash

# Extract heap metrics from Flutter DevTools
flutter pub global run devtools --no-launch-browser --port 9101 &
DEVTOOLS_PID=$!

# Wait for DevTools to start
sleep 5

# Run the heap dump command
flutter drive --driver=test/integration_tests/heap_dump_test/heap_dump_test_driver.dart --target=test/integration_tests/heap_dump_test/heap_dump_test.dart --profile --heap-dump-to=heap_dump.json

# Kill the DevTools process
kill $DEVTOOLS_PID

# Parse the heap dump JSON
dart scripts/heap_metrics/parse_heap_dump.dart heap_dump.json
