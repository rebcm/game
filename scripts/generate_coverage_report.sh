#!/bin/bash

flutter test --coverage
lcov --remove coverage/lcov.info 'lib/i18n/*' 'test/*' -o coverage/lcov.info
genhtml coverage/lcov.info -o coverage/html
