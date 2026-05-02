#!/bin/bash
wrangler secret put DATABASE_URL --env production <<< "${DATABASE_URL}"
wrangler secret put API_KEY --env production <<< "${API_KEY}"
