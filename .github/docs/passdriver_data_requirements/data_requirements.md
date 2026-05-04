## Data Requirements for Passdriver

### Overview

This document outlines the data requirements for the Passdriver feature.

### Requirements

1. The R2 service should be mocked for integration tests.
2. The R2 mock should support put, get, delete, and list operations.

### Implementation

The R2 mock is implemented in `test/mocks/r2_mock/r2_mock.dart`.
The R2 service is implemented in `lib/services/r2_service/r2_service.dart`.
