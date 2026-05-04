#!/bin/bash

lcov --list coverage/lcov.info
genhtml coverage/lcov.info -o coverage/html
