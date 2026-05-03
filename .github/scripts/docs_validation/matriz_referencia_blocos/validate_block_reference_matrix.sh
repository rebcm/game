#!/bin/bash

npm install -g jsonschema
jsonschema -i ./.github/scripts/docs_validation/matriz_referencia_blocos/output.json ./.github/scripts/docs_validation/matriz_referencia_blocos/output_schema.json
