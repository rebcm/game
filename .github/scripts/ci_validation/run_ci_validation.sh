#!/bin/bash

./.github/scripts/ci_validation/run_ui_integration_test.sh

# Executar validação da revisão ortográfica e técnica
./.github/scripts/docs_validation/peer_review/validate_peer_review.sh


  # Validação da documentação SEO
  ./.github/scripts/docs_validation/seo/validate_seo_documentation.sh
./.github/scripts/ci_validation/documentacao_test/run_documentacao_test.sh
./.github/scripts/ci_validation/documentacao_test/run_documentacao_test.sh

./.github/scripts/docs_validation/flutter_sdk_versoes/validate_flutter_sdk_versoes.sh

./.github/scripts/ci_validation/run_ux_dicas_tests.sh
./.github/scripts/ci_validation/documentacao_test/run_documentacao_test.sh
./.github/scripts/ci_validation/microfone_usage_description_validation/validate_microfone_usage_description.sh
./.github/scripts/ci_validation/camera_usage_description_validation/validate_camera_usage_description.sh
./.github/scripts/ci_validation/photo_library_usage_description_validation/validate_photo_library_usage_description.sh
./.github/scripts/ci_validation/documentacao_test/run_documentacao_test.sh
