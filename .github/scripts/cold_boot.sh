#!/bin/bash

# Kill the app process if it's running
pkill -f rebcm

# Wait for the process to be fully terminated
sleep 2

# Restart the app
flutter run &
