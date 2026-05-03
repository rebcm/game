#!/bin/bash

# Decrypt secrets using GPG
gpg --quiet --batch --yes --decrypt --passphrase="$SECRET_PASSPHRASE" --output key.jks key.jks.gpg
