#!/bin/bash

flutter build ios --release --no-codesign
xcrun -sdk iphoneos PackageApplication -v build/ios/Release-iphoneos/Runner.app -o build/ios/ipa/game.ipa
