#!/bin/bash

flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/deploy_validation_test/deploy_validation_test.dart
