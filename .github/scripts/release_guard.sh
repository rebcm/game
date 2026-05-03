#!/bin/bash

# Release Guard Script
# Protects artifacts tagged with release or stable tags from automatic deletion

# Check if the environment variable GITHUB_EVENT_NAME is set
if [ -z "$GITHUB_EVENT_NAME" ]; then
  echo "GITHUB_EVENT_NAME is not set. Exiting."
  exit 1
fi

# Check if the event is a delete event
if [ "$GITHUB_EVENT_NAME" != "delete" ]; then
  echo "Not a delete event. Exiting."
  exit 0
fi

# Get the tag name from the event payload
TAG_NAME=$(jq -r '.ref' <<< "$GITHUB_EVENT_PATH")

# Check if the tag is a release or stable tag
if [[ "$TAG_NAME" =~ ^refs/tags/(release|stable) ]]; then
  echo "Tag $TAG_NAME is protected. Aborting deletion."
  exit 1
else
  echo "Tag $TAG_NAME is not protected. Deletion allowed."
  exit 0
fi
