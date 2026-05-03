#!/bin/bash

if grep -q 'TODO' categorias.md; then
  echo "TODO found in categorias.md"
  exit 1
fi
