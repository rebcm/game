# Secrets Masking Implementation

## Overview

This document describes the implementation of secrets masking in the CI pipeline.

## Masking Secrets

The `mask_secrets.sh` script is used to mask sensitive values in the GitHub Actions logs.

## Usage

The script is executed in the CI pipeline to mask sensitive values.

## Configuration

The sensitive values are loaded from the `.env` file.

## Implementation Details

The script uses the `echo ::add-mask::` command to mask sensitive values.
