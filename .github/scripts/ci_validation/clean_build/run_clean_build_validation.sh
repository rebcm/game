#!/bin/bash

# Clean and rebuild the project to ensure there are no compilation issues
flutter clean
flutter pub get
dart analyze --fatal-infos
