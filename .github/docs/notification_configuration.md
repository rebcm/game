# Notification Configuration

To configure notifications for CI build failures, follow these steps:

1. Choose a notification channel: Slack, Discord, or Email.
2. Set the `NOTIFICATION_CHANNEL` variable in the `.env` file accordingly.
3. Configure the required credentials or webhook URL for the chosen channel.

## Slack Configuration

1. Create a Slack webhook URL.
2. Set `SLACK_WEBHOOK_URL` in the `.env` file.

## Discord Configuration

1. Create a Discord webhook URL.
2. Set `DISCORD_WEBHOOK_URL` in the `.env` file.

## Email Configuration

1. Prepare your email credentials.
2. Set `EMAIL_CREDENTIALS` in the `.env` file.

Example `.env` configuration:
NOTIFICATION_CHANNEL=Slack
SLACK_WEBHOOK_URL=https://example.com/slack-webhook
{"pt-BR": "Tradução para pt-BR"}
