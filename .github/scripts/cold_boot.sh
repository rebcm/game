#!/bin/bash

# Kill the app process if it's running
pkill -f "rebcm"

# Wait for the process to be killed
sleep 2

# Start the app again
flutter run &
