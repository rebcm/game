#!/bin/bash

echo "Validating environment variables..."

if [ -f .env ]; then
  while IFS= read -r line; do
    if [[ $line =~ ^[A-Za-z_][A-Za-z0-9_]*= ]]; then
      var=${line%%=*}
      var=${var%% }
      if ! grep -rq "$var" .; then
        echo "Error: Variable $var is not used in the code."
        exit 1
      fi
    fi
  done < .env
else
  echo "No .env file found."
  exit 1
fi
