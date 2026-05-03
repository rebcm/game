#!/bin/bash

# Set environment variables
set -a
source .env
set +a

# Login to wrangler
wrangler login

# Put secrets
wrangler secret put DATABASE_URL << 'EOD'
${DATABASE_URL}
EOD

wrangler secret put API_KEY << 'EOD'
${API_KEY}
EOD
