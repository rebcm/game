#!/bin/bash

# Configure secrets for the project
configure_secrets() {
  echo "Configuring secrets..."
  wrangler secret put DATABASE_URL
  wrangler secret put API_KEY
  # Add other secrets as needed
}

configure_secrets
