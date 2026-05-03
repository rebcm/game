#!/bin/bash

set -e

flutter analyze
if [ $? -ne 0 ]; then
  echo "Analyze failed, stopping pipeline"
  exit 1
fi

flutter test
flutter drive --target=test/integration_test/e2e_test/e2e_pipeline_test.dart
