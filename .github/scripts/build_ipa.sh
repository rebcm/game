#!/bin/bash

set -e

flutter build ipa --export-options-plist=.github/scripts/ExportOptions.plist
