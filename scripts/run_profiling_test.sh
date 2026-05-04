#!/bin/bash

flutter drive --driver=test/profiling_tests/profiling_test_driver.dart --target=test/profiling_tests/scene_rebuild_profiling_test.dart --profile --trace-systrace --target-platform android
