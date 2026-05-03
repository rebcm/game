#!/bin/bash

bash .github/scripts/ci_validation/run_microfone_usage_description_validation.sh

./.github/scripts/ci_validation/latency_benchmark_test/run_latency_benchmark_test.sh

./.github/scripts/ci_validation/documentacao_test/run_documentacao_test.sh
# Executar validação de permissões
./.github/scripts/ci_validation/run_permission_validation.sh

