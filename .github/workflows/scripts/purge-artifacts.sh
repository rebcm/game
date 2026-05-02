#!/bin/bash

REPO=$1
BRANCH=$2
TOKEN=$3

if [ -z "$REPO" ] || [ -z "$BRANCH" ] || [ -z "$TOKEN" ]; then
  REPO=$REPO
  BRANCH=$BRANCH
  TOKEN=$GITHUB_TOKEN
fi

ARTIFACTS_URL="https://api.github.com/repos/$REPO/actions/artifacts"
ARTIFACTS=$(curl -s -H "Authorization: token $TOKEN" $ARTIFACTS_URL | jq '.artifacts[]')

echo "Purging artifacts..."
while IFS= read -r artifact; do
  ID=$(echo "$artifact" | jq '.id')
  CREATED_AT=$(echo "$artifact" | jq -r '.created_at')
  if [ $(date -d "$CREATED_AT" +%s) -lt $(date -d "7 days ago" +%s) ]; then
    echo "Deleting artifact $ID"
    curl -s -X DELETE -H "Authorization: token $TOKEN" "$ARTIFACTS_URL/$ID"
  fi
done < <(echo "$ARTIFACTS")
