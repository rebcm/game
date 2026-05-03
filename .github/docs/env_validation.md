# Environment Variables Validation

The application now validates the presence of required environment variables at startup.

## Required Variables

The following variables are checked:

* KEY1
* KEY2
<!-- Add other required keys here as per .env.example -->

## Error Handling

If any required variable is missing, the application will log an error and exit.
