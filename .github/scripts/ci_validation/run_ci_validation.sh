#!/bin/bash

# existing tests
./.github/scripts/ci_validation/run_audio_test.sh
./.github/scripts/ci_validation/run_memory_leak_test.sh

# new integration test
./.github/scripts/ci_validation/integracao/run_integracao_test.sh
