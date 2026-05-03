#!/bin/bash

flutter build apk --release
flutter build ios --release --no-codesign
