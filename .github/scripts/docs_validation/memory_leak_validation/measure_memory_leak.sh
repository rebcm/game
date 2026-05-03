#!/bin/bash

# Measure memory usage before and after destroying estado_jogo.dart
# to quantify memory leak in bytes/objects.

# Step 1: Run the Flutter app with memory profiling enabled
flutter run --profile --trace-memory --target lib/main.dart &

# Step 2: Capture the memory usage before destroying estado_jogo.dart
# Assuming a function `capture_memory_snapshot` is implemented
capture_memory_snapshot before_destruction.json

# Step 3: Destroy estado_jogo.dart
# Assuming a function `destroy_estado_jogo` is implemented
destroy_estado_jogo

# Step 4: Capture the memory usage after destroying estado_jogo.dart
capture_memory_snapshot after_destruction.json

# Step 5: Compare the memory snapshots to quantify memory leak
compare_memory_snapshots before_destruction.json after_destruction.json > memory_leak_report.txt
