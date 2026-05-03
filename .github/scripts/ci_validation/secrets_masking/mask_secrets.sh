#!/bin/bash

mask_secret() {
  echo "::add-mask::$1"
}

# Example usage: mask_secret "$SECRET_VALUE"
