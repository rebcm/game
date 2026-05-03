# Swagger Implementation Guide

This document outlines the steps to implement Swagger in the backend repository.

## Steps

1. Clone the backend repository.
2. Create a `swagger.yaml` file in the root of the backend repository.
3. Define the API endpoints and schema in the `swagger.yaml` file.
4. Run the `validate_swagger.sh` script to validate the Swagger YAML file.

## Notes

* The `validate_swagger.sh` script is available in the `.github/scripts/ci_validation/swagger_validation` directory.
* The Swagger YAML file is expected to be at the path `../backend/swagger.yaml` relative to the game repository.
