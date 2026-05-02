#!/bin/bash

URL=$1

response=000
if [ $response -eq 200 ]; then
  echo "Site está online"
else
  echo "Site está offline"
  exit 1
fi
