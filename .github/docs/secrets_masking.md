# Secrets Masking Documentation

## Purpose
This documentation explains the implementation of secrets masking in the CI/CD pipeline to prevent sensitive information from being exposed in logs.

## Implementation
The `mask_secrets.sh` script is used to replace sensitive information with a masked version. The secrets are loaded from environment variables.

## Usage
The `run_mask_secrets.sh` script demonstrates how to use `mask_secrets.sh` with the loaded secrets.
