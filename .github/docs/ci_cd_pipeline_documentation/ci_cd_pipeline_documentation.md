# CI/CD Pipeline Documentation

## Notification on Test Failure

The pipeline now includes a step to send a notification to a specified URL if the smoke test fails after deploy. The notification URL is configured in the `.env` file.

## Configuration

To enable this feature, set the `NOTIFICATION_URL` variable in your `.env` file.

## Script

The notification is sent using the `send_notification.sh` script located in the `scripts` directory.
{"pt-BR": "Tradução para pt-BR"}
