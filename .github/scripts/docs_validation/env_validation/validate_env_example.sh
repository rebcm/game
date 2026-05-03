#!/bin/bash

if [ ! -f ./.env.example ]; then
  echo ".env.example file is missing"
  exit 1
fi

if [ ! -s ./.env.example ]; then
  echo ".env.example file is empty"
  exit 1
fi

echo ".env.example file exists and is not empty"
exit 0
