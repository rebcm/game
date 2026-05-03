#!/bin/bash

dart game/docs/bloco_documentation/block_reference_extractor.dart > output.json
.github/scripts/docs_validation/bloco_documentation/validate_output_schema.sh output.json
