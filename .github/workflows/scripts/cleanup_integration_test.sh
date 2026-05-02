#!/bin/bash

# Remove registros do D1
curl -X DELETE https://staging-d1.example.com/registros

# Remove objetos do R2
curl -X DELETE https://staging-r2.example.com/objetos
