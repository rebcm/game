# CI/CD Pipeline Documentation

## Overview

This document describes the CI/CD pipeline for the Rebeca game project.

## Pipeline Steps

1. Checkout code
2. Setup Flutter
3. Verify Flutter version
4. Setup JDK
5. Verify Java version
6. Install dependencies
7. Analyze code
8. Run tests

## Triggers

The pipeline is triggered on push events to the main branch.

## Code Coverage Test

The code coverage test is executed using the `run_code_coverage_test.sh` script.

### Configuration

The code coverage test is configured to run automatically after the execution of the unit tests and widget tests.

### Report Generation

The code coverage report is generated using the `lcov` tool.
