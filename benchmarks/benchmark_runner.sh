#!/bin/bash

echo "Running Flutter Scene benchmark..."
flutter run --benchmark ./benchmarks/flutter_scene

echo "Running Three.js benchmark..."
# Three.js benchmarking is typically done in a browser environment.
# For simplicity, this script assumes manual comparison.

echo "Running Unity benchmark..."
./benchmarks/unity/benchmark.sh
