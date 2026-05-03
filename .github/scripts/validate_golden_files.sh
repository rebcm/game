#!/bin/bash

if [ -n "$(git status --porcelain golden_files/)" ]; then
  echo "Golden files are not up-to-date. Please update the golden files and commit the changes."
  exit 1
fi
