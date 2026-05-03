#!/bin/bash

# Define the permission matrix test
echo "Permission Granted,Pipeline Result" > permissions_matrix.csv
echo "true,Success" >> permissions_matrix.csv
echo "false,Error 403" >> permissions_matrix.csv

# Validate the permissions matrix
while IFS=, read -r permission granted pipeline_result; do
  if [ "$permission" = "true" ] && [ "$pipeline_result" != "Success" ]; then
    echo "Error: Permission granted but pipeline result is $pipeline_result"
    exit 1
  elif [ "$permission" = "false" ] && [ "$pipeline_result" != "Error 403" ]; then
    echo "Error: Permission not granted but pipeline result is $pipeline_result"
    exit 1
  fi
done < permissions_matrix.csv

echo "Permissions matrix test passed"
