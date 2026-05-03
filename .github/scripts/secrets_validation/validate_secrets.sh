#!/bin/bash

if [ -z "$DEPLOY_TOKEN" ]; then
  echo "DEPLOY_TOKEN is not set"
  exit 1
fi

if [ -z "$CI_DEPLOY_USER" ]; then
  echo "CI_DEPLOY_USER is not set"
  exit 1
fi
