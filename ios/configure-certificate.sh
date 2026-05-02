#!/bin/bash

echo "$IOS_CERTIFICATE" | base64 --decode > certificate.p12
echo "$IOS_CERTIFICATE_PASSWORD" > certificate.password
