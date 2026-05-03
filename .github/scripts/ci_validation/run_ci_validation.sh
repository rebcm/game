#!/bin/bash

# Outros testes...
./.github/scripts/ci_validation/clean_build/run_clean_build_validation.sh
.run_microfone_usage_description_validation.sh
  # Run peer review validation
  .github/scripts/docs_validation/peer_review/validate_peer_review.sh
  # Run peer review validation
  .github/scripts/docs_validation/peer_review/validate_peer_review.sh
./.github/scripts/ci_validation/documentacao_test/run_documentacao_test.sh

# Executa a validação das versões mínimas suportadas pelo Flutter SDK
.github/scripts/docs_validation/flutter_sdk_versoes/validate_flutter_sdk_versoes.sh
