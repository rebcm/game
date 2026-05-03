#!/bin/bash

status=$(curl -s -o /dev/null -w "%{http_code}" https://example.com)
if [ $status != 200 ]; then
  echo "Smoke test failed with status $status"
  exit 1
fi
