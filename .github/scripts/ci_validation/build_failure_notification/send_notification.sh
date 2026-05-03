#!/bin/bash

curl -X POST -H 'Content-type: application/json' --data '{"text":"Build failed"}' $SLACK_WEBHOOK_URL
