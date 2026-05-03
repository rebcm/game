#!/bin/bash

# Validate bloco documentation against the schema
jsonschema -i ./docs/bloco_documentation.json ./.github/scripts/docs_validation/bloco_documentation/output_schema.json
