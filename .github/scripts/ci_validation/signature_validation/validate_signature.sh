#!/bin/bash

# Extract APK signature from CI build
CI_APK_SIGNATURE=$(unzip -p path/to/ci/apk.apk META-INF/CERT.RSA | keytool -printcert -v | grep 'SHA256:' | cut -d ':' -f 2-)

# Extract local APK signature
LOCAL_APK_SIGNATURE=$(unzip -p path/to/local/apk.apk META-INF/CERT.RSA | keytool -printcert -v | grep 'SHA256:' | cut -d ':' -f 2-)

# Compare signatures
if [ "$CI_APK_SIGNATURE" == "$LOCAL_APK_SIGNATURE" ]; then
  echo "Signatures match"
  exit 0
else
  echo "Signatures do not match"
  exit 1
fi
