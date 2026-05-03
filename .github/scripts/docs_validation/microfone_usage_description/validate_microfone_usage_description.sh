#!/bin/bash

if grep -q "NSMicrophoneUsageDescription" ios/Runner/Info.plist; then
    DESCRIPTION=$(grep -A1 "NSMicrophoneUsageDescription" ios/Runner/Info.plist | tail -n1 | sed -e 's/^[[:space:]]*//;s/[[:space:]]*$//;s/<string>//;s/<\/string>//')
    if [ "$DESCRIPTION" != "O aplicativo precisa acessar o microfone para gravar sons personalizados para os blocos voxel." ]; then
        echo "Descrição de uso do microfone incorreta."
        exit 1
    fi
else
    echo "NSMicrophoneUsageDescription não encontrado no Info.plist"
    exit 1
fi
