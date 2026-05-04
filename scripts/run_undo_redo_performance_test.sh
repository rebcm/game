#!/bin/bash

flutter drive --driver=test/performance_tests/undo_redo_test/undo_redo_performance_test_driver.dart --target=test/performance_tests/undo_redo_test/undo_redo_performance_test.dart --profile --trace-systrace --target-platform android
