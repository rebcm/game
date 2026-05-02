#!/bin/bash

if [ ! -f android.keystore.jks ]; then
  echo "Android keystore file is missing"
  exit 1
fi

if [ ! -f ios.certificate.p12 ]; then
  echo "iOS certificate file is missing"
  exit 1
fi
