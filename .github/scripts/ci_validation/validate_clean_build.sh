#!/bin/bash

echo "Executando flutter clean..."
flutter clean

echo "Executando flutter pub get..."
flutter pub get

echo "Executando dart analyze..."
dart analyze --fatal-infos --fatal-warnings .
