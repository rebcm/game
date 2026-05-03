#!/bin/bash

# Clean and rebuild the project to ensure no compilation issues
flutter clean
flutter pub get
dart analyze --fatal-infos
