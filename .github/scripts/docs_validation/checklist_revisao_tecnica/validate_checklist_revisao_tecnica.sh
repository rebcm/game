#!/bin/bash

# Validate checklist revisão técnica
dart ./.github/scripts/docs_validation/checklist_revisao_tecnica/checklist_revisao_tecnica.dart

# Validar conteúdo da revisão ortográfica
bash .github/scripts/docs_validation/checklist_revisao_tecnica/validate_checklist_ortografica.sh

# Validar task 1777666324-13-sub-6-disc-1777777797-3
bash .github/scripts/docs_validation/checklist_revisao_tecnica/validate_task_1777666324-13-sub-6-disc-1777777797-3.sh
