#!/bin/bash

flutter test --coverage
lcov --summary coverage/lcov.info
