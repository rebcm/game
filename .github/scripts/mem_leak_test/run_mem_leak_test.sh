#!/bin/bash

# Script to measure memory usage before and after destroying estado_jogo.dart

# Navigate to the project root
cd /home/user/game

# Run the Flutter driver test to measure memory usage
flutter drive --target=test_driver/mem_leak_test.dart --driver=test_driver/mem_leak_test_driver.dart

# Collect and print the memory usage results
