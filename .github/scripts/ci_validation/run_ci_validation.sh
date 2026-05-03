#!/bin/bash

source .github/scripts/secrets_validation/validate_secrets.sh

run_ci_validation() {
  # existing validation logic
  validate_secrets
  # existing validation logic
}

run_ci_validation

./.github/scripts/ci_validation/run_ui_integration_test.sh

# Executa a validação do peer review
./.github/scripts/docs_validation/peer_review/validate_peer_review.sh
