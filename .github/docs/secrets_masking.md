# Secrets Masking

To prevent sensitive information from being exposed in GitHub Actions logs, 
we use the `echo ::add-mask::` command to mask secret values.

## Configuration

The `.github/scripts/ci_validation/secrets_masking/mask_secrets.sh` script 
loads secrets from the `.env` file and masks them.

## Usage

This script should be executed at the beginning of the CI workflow to ensure 
that all sensitive values are properly masked.
