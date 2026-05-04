#!/bin/bash

# Force Garbage Collection before measuring heap
flutter drive --driver=test/integration_tests/memory_test/memory_test_driver.dart --target=test/integration_tests/memory_test/memory_test.dart --profile --trace-systrace --profile-skip-build-runner
