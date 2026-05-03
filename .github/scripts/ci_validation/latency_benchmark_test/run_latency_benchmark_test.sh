#!/bin/bash

# Implement the script to run the latency benchmark test
# Use flutter drive or integration_test command to run the test
# Capture and report the results

flutter drive --driver=test_driver/integration_test.dart --target=integration_test/latency_benchmark_test/latency_benchmark_test.dart
