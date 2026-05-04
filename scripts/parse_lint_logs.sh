#!/bin/bash

flutter analyze --no-fatal-infos --no-fatal-warnings > lint_logs.txt
dart test_driver/lint_parser_test/lint_log_parser.dart lint_logs.txt
