#!/bin/bash

flutter test --coverage
coverage_threshold=80
coverage=$(lcov -r coverage/lcov.info 'lib/main.dart' 'lib/generated/*' 'test/*' -o coverage/filtered_lcov.info && genhtml coverage/filtered_lcov.info -o coverage/html && grep -oP '(?<=lines......: )\d+(?=%)' coverage/html/index.html)

if (( $(echo "$coverage >= $coverage_threshold" | bc -l) )); then
  echo "Coverage is above threshold: $coverage%"
  exit 0
else
  echo "Coverage is below threshold: $coverage% (expected $coverage_threshold%)"
  exit 1
fi
