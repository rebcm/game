#!/bin/bash

# Define notification channel (Slack, Discord, or Email)
NOTIFICATION_CHANNEL=${NOTIFICATION_CHANNEL:-Slack}

# Configure webhook URL or email credentials based on the chosen channel
if [ "$NOTIFICATION_CHANNEL" == "Slack" ]; then
  SLACK_WEBHOOK_URL=${SLACK_WEBHOOK_URL}
  if [ -z "$SLACK_WEBHOOK_URL" ]; then
    echo "Error: Slack webhook URL is not set."
    exit 1
  fi
elif [ "$NOTIFICATION_CHANNEL" == "Discord" ]; then
  DISCORD_WEBHOOK_URL=${DISCORD_WEBHOOK_URL}
  if [ -z "$DISCORD_WEBHOOK_URL" ]; then
    echo "Error: Discord webhook URL is not set."
    exit 1
  fi
elif [ "$NOTIFICATION_CHANNEL" == "Email" ]; then
  EMAIL_CREDENTIALS=${EMAIL_CREDENTIALS}
  if [ -z "$EMAIL_CREDENTIALS" ]; then
    echo "Error: Email credentials are not set."
    exit 1
  fi
else
  echo "Error: Invalid notification channel."
  exit 1
fi

# Send notification using the configured channel
send_notification() {
  local message=$1
  if [ "$NOTIFICATION_CHANNEL" == "Slack" ]; then
    curl -X POST -H 'Content-type: application/json' --data '{"text":"'"$message"'"}' $SLACK_WEBHOOK_URL
  elif [ "$NOTIFICATION_CHANNEL" == "Discord" ]; then
    curl -X POST -H 'Content-type: application/json' --data '{"content":"'"$message"'"}' $DISCORD_WEBHOOK_URL
  elif [ "$NOTIFICATION_CHANNEL" == "Email" ]; then
    # Implement email sending logic using EMAIL_CREDENTIALS
    echo "Sending email notification: $message"
  fi
}

# Example usage
send_notification "CI build failed."
