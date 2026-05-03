#!/bin/bash

# Validate dicas content against the game implementation
dart .github/scripts/docs_validation/dicas/extract_dicas_strings.dart

# Chama o script de validação do template
bash .github/scripts/docs_validation/dicas/run_validate_dicas_template.sh
