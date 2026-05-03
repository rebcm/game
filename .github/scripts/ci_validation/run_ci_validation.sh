#!/bin/bash

./.github/scripts/ci_validation/run_ui_integration_test.sh

# Executar validação da revisão ortográfica e técnica
./.github/scripts/docs_validation/peer_review/validate_peer_review.sh


  # Validação da documentação SEO
  ./.github/scripts/docs_validation/seo/validate_seo_documentation.sh
