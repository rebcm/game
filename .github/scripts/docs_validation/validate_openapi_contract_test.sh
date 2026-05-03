#!/bin/bash

# Validate OpenAPI contract test
if ! dart run build_runner test test/api/services/block_service_test.dart; then
  echo "OpenAPI contract test failed"
  exit 1
fi
