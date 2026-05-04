# Secrets Configuration Documentation

This document explains how to configure secrets for the project.

## Keystore Secrets

To inject keystore secrets, follow these steps:

1. Set `KEYSTORE_FILE` and `KEYSTORE_PASSWORD` as secrets in the repository settings.
2. Ensure the `validate_secrets.sh` script is executed during the CI pipeline.

## Additional Information

Refer to the `validate_secrets.sh` script for implementation details.
### Android Signing Configuration

The following secrets are required for Android signing configuration:

* KEYSTORE_FILE
* KEYSTORE_PASSWORD
* KEY_ALIAS
* KEY_PASSWORD
