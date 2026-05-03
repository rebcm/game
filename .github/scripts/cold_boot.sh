#!/bin/bash

# Kill the app process
pkill -f rebcm

# Wait for the process to be killed
sleep 5

# Restart the app
flutter run --release &
