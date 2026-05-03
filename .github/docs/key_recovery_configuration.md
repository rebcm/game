# Key Recovery Configuration

This document outlines the configuration for recovering the keystore used in the project.

## Steps to Recover Keystore

1. Store the Base64 encoded keystore in a GitHub Secret named `KEYSTORE_BASE64`.
2. Use the `recover_key.sh` script to decode the secret and recover the keystore.

## Script Details

The `recover_key.sh` script is responsible for decoding the Base64 encoded keystore and saving it to a file named `keystore.jks`.

### Environment Variables

- `KEYSTORE_BASE64`: The Base64 encoded keystore.

### Usage

The script is designed to be used in a CI/CD pipeline. It can be triggered manually or automatically based on the pipeline configuration.
