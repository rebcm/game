#!/bin/bash

# Load secrets from .env file
set -a
source .env
set +a

# Mask sensitive values in GitHub Actions logs
echo "::add-mask::$SENSITIVE_VALUE_1"
echo "::add-mask::$SENSITIVE_VALUE_2"
# Add more sensitive values as needed

# Continue with the rest of the CI script
