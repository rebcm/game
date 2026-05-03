#!/bin/bash

# Executar validações de CI

./.github/scripts/docs_validation/fluxo_aprovacao_conteudo/validate_fluxo_aprovacao_conteudo.sh
./test/integration_tests/memory_leak_tests/run_focus_node_leak_test.sh
