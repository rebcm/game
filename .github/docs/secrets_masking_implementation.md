# Secrets Masking Implementation

## Overview

This document outlines the implementation details for masking secrets in the CI pipeline.

## Masking Secrets

To mask sensitive values, the `mask_secrets.sh` script is used. This script defines a function `mask_sensitive_values` that takes a value as input and prints the `::add-mask::` command followed by the sensitive value.

## Usage

To mask a sensitive value, call the `mask_sensitive_values` function with the value as an argument.

## Example
