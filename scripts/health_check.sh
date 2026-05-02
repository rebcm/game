#!/bin/bash

curl -s -o /dev/null -w "%{http_code}" https://rebcm.pages.dev | grep -q "200"
if [ $? -ne 0 ]; then
  echo "Health check failed"
  exit 1
fi
