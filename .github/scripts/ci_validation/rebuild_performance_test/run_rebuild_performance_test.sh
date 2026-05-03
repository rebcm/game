#!/bin/bash

# Define the number of iterations for the performance test
ITERATIONS=100

# Run the rebuild performance test
flutter drive --target=test_driver/main.dart --driver=test_driver/rebuild_performance_test.dart --iterations=$ITERATIONS
