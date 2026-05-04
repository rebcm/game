#!/bin/bash

# Run CI/CD pipeline locally
docker run --rm -v $(pwd):/app -w /app cirrusci/flutter:stable-jdk17 /bin/bash -c "flutter pub get && dart analyze && flutter test && flutter build"
