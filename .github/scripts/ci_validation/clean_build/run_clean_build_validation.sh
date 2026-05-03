#!/bin/bash

# Navigate to the project root
cd /home/user/game

# Execute flutter clean
flutter clean

# Execute flutter pub get
flutter pub get

# Execute dart analyze
dart analyze --fatal-infos
