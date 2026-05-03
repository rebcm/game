#!/bin/bash

# Script to profile memory usage before and after estado_jogo.dart destruction

# Step 1: Run the Flutter app with memory profiling enabled
flutter run --profile --trace-memory --target lib/main.dart

# Step 2: Capture memory snapshot before destroying estado_jogo.dart
echo "Capturing memory snapshot before destruction..."
dart ./lib/utils/memory_snapshot.dart --output before_destruction.json

# Step 3: Destroy estado_jogo.dart (this step should be done manually or through UI automation)

# Step 4: Capture memory snapshot after destroying estado_jogo.dart
echo "Capturing memory snapshot after destruction..."
dart ./lib/utils/memory_snapshot.dart --output after_destruction.json

# Step 5: Compare the two memory snapshots to identify leaks
echo "Comparing memory snapshots..."
dart ./lib/utils/compare_memory_snapshots.dart --before before_destruction.json --after after_destruction.json --output memory_leak_report.json

echo "Memory profiling completed. Results are in memory_leak_report.json"
