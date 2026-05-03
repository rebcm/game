#!/bin/bash

openapi-generator generate -i https://example.com/swagger.json -g dart -o ./lib/openapi/client -c ./lib/openapi/swagger_config.yaml
