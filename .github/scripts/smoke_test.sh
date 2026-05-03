#!/bin/bash

# Run smoke test using flutter driver
flutter drive --target=test_driver/app.dart --driver=test_driver/app_test.dart --profile --export-logs=smoke_test_log.txt

# Get the status of the smoke test
status=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)

# Save the status to a file
echo "$status" > smoke_test_status.txt
