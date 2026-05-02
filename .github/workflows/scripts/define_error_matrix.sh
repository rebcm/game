#!/bin/bash

# Define a matriz de comportamento de erro
declare -A error_matrix
error_matrix["timeout"]=retry
error_matrix["connection_error"]=retry
error_matrix["invalid_response"]=fail-fast

# Imprima a matriz de comportamento de erro
for error in "${!error_matrix[@]}"; do
  echo "$error: ${error_matrix[$error]}"
done
