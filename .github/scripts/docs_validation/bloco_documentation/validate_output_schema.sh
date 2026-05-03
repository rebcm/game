#!/bin/bash

npm install -g jsonschema
jsonschema -i ./.github/scripts/docs_validation/bloco_documentation/output.json ./.github/scripts/docs_validation/bloco_documentation/output_schema.json
