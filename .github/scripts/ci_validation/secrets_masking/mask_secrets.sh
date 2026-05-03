#!/bin/bash

# Mask sensitive values to avoid exposure in GitHub Actions logs
mask_sensitive_values() {
  echo "::add-mask::$1"
}

# Example usage:
# mask_sensitive_value "your_sensitive_value_here"
