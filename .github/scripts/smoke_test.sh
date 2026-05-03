#!/bin/bash

# Run flutter driver smoke test
flutter drive --target=test_driver/app.dart --driver=test_driver/app_test.dart --headless

# Save the status to a file
echo $? > smoke_test_status.txt
