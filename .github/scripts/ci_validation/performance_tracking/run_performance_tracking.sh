#!/bin/bash

flutter drive --target=./benchmarks/performance_tracking/performance_tracking_test.dart --driver=./test_driver/integration_test.dart --profile --no-sandbox
