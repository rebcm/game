#!/bin/bash

# Executar validações de CI

./.github/scripts/docs_validation/fluxo_aprovacao_conteudo/validate_fluxo_aprovacao_conteudo.sh
./test/integration_tests/memory_leak_tests/run_focus_node_leak_test.sh
./.github/scripts/ci_validation/run_responsividade_test.sh
# Executar validação do mapeamento de estruturas sugeridas
.github/scripts/docs_validation/mapeamento_estruturas_sugeridas/validate_mapeamento_estruturas_sugeridas.sh
./.github/scripts/ci_validation/run_audio_test.sh
./.github/scripts/ci_validation/run_text_overflow_test.sh
./.github/scripts/ci_validation/run_audio_edge_cases_test.sh
./.github/scripts/ci_validation/run_audio_edge_cases_test.sh
./.github/scripts/ci_validation/run_audio_edge_cases_test.sh
