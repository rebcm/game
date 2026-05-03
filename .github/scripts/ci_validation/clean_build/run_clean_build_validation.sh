#!/bin/bash

# Navigate to the project root
cd /home/user/game

# Run flutter clean
flutter clean

# Run flutter pub get
flutter pub get

# Run dart analyze
dart analyze
