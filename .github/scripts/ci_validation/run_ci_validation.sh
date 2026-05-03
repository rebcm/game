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
# Executa a validação da documentação das dicas
./.github/scripts/docs_validation/dicas/validate_dicas_documentation.sh
