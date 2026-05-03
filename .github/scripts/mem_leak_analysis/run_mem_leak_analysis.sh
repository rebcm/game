#!/bin/bash

# Script to analyze memory leak by measuring memory consumption before and after destroying estado_jogo.dart

# Function to get memory consumption
get_memory_consumption() {
  # Use 'flutter run --profile' and 'devtools' to get memory consumption
  # For simplicity, assume we are using a hypothetical command 'get_memory_usage' to get the current memory usage
  get_memory_usage
}

# Main function to run memory leak analysis
run_mem_leak_analysis() {
  # Start flutter app in profile mode
  flutter run --profile &
  flutter_pid=$!

  # Wait for the app to start
  sleep 10

  # Get initial memory consumption
  initial_memory=$(get_memory_consumption)
  echo "Initial memory consumption: $initial_memory"

  # Destroy estado_jogo.dart
  # For simplicity, assume we are using a hypothetical command 'destroy_estado_jogo' to destroy estado_jogo.dart
  destroy_estado_jogo

  # Wait for some time to allow garbage collection
  sleep 5

  # Get final memory consumption
  final_memory=$(get_memory_consumption)
  echo "Final memory consumption: $final_memory"

  # Calculate memory leak
  memory_leak=$((final_memory - initial_memory))
  echo "Memory leak: $memory_leak bytes"

  # Kill the flutter app
  kill $flutter_pid
}

run_mem_leak_analysis
