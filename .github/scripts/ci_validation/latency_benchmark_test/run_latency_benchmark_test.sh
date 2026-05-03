#!/bin/bash

# Run latency benchmark test for Flutter isolate communication
flutter drive --target=test_driver/latency_benchmark_test.dart --driver=test_driver/latency_benchmark_test_driver.dart
