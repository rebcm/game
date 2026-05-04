#!/bin/bash

# Define variables for the deploy strategy decision
CLOUDFLARE_WRANGLER_ACTION='cloudflare/wrangler-action'
WRANGLER_CLI='wrangler'

# Function to check if wrangler is installed
check_wrangler_installed() {
  if command -v wrangler &> /dev/null; then
    echo "Wrangler CLI is installed."
  else
    echo "Wrangler CLI is not installed. Please install it before proceeding."
    exit 1
  fi
}

# Decide on the deploy strategy
decide_deploy_strategy() {
  # For this task, we decide to use the Wrangler CLI via shell script
  echo "Using $WRANGLER_CLI for deployment."
}

# Main execution
check_wrangler_installed
decide_deploy_strategy
