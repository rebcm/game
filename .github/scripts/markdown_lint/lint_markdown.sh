#!/bin/bash

# Install markdownlint-cli if not already installed
npm install -g markdownlint-cli

# Lint markdown files
markdownlint ./README.md ./CHANGELOG.md ./.github/docs/**/*.md
