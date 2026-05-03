#!/bin/bash

source .github/scripts/secrets_validation/validate_secrets.sh

run_ci_validation() {
  # existing validation logic
  validate_secrets
  # existing validation logic
}

run_ci_validation
