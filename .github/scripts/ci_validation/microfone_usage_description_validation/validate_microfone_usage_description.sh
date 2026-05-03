#!/bin/bash

INFO_PLIST="ios/Runner/Info.plist"
MICROPHONE_USAGE_DESCRIPTION=$(plutil -extract NSMicrophoneUsageDescription raw "$INFO_PLIST")

if [ "$MICROPHONE_USAGE_DESCRIPTION" != "O microfone é usado para gravar áudio enquanto você cria." ]; then
    echo "Erro: NSMicrophoneUsageDescription não atende aos critérios de aceitação."
    exit 1
fi
