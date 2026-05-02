#!/bin/bash

# Limpa registros do D1 e objetos do R2
curl -X DELETE https://api.example.com/d1/registros
aws s3 rm s3://example-bucket/r2/objetos --recursive
