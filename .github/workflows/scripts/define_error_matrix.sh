#!/bin/bash

# Define a matriz de edge cases para a API
error_matrix=(
  "401 Unauthorized"
  "404 Not Found"
  "500 Internal Server Error"
  "Conexão instável"
  "Timeout"
)

# Salva a matriz em um arquivo
echo "${error_matrix[@]}" > ./documentacao/matriz_erro.txt
