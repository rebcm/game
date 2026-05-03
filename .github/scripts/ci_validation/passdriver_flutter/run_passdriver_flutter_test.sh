#!/bin/bash

# Execute passdriver flutter tests
flutter test --dart-define=TEST_ENV=ci

# Validate if the pipeline steps match the documentation
diff .github/docs/pipeline_documentation.md ./docs/actual_pipeline_steps.md
