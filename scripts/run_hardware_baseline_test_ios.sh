#!/bin/bash

flutter drive --driver=test/integration_tests/performance_test/performance_test_driver.dart --target=test/integration_tests/performance_test/performance_test.dart --profile --trace-systrace --target-platform ios
