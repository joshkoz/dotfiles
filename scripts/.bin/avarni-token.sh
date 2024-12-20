#!/bin/bash

set -e

# Your 1Password item name and field designations
ONEPASSWORD_ITEM_NAME="Avarni Platform Dev"
AUTH0_CLIENT_SECRET=$(op item get "$ONEPASSWORD_ITEM_NAME" --fields client_secret --cache)
if [[ -z "$AUTH0_CLIENT_SECRET" ]]; then
    echo "Failed to retrieve client_secret from 1Password"
    exit 1
fi

CREDENTIALS=$(op item get "$ONEPASSWORD_ITEM_NAME" --fields client_secret,audience,domain,client_id)

# Split credentials into username and password
IFS=',' read -r AUTH0_CLIENT_SECRET AUTH0_AUDIENCE AUTH0_DOMAIN AUTH0_CLIENT_ID <<< "$CREDENTIALS"

# Perform the login to Auth0
REQUEST_BODY='{"client_id":"'"$AUTH0_CLIENT_ID"'","client_secret":"'"$AUTH0_CLIENT_SECRET"'","audience":"'"$AUTH0_AUDIENCE"'","grant_type":"client_credentials"}'
TOKEN_RESPONSE=$(curl -s --request POST \
  --url "https://${AUTH0_DOMAIN}/oauth/token" \
  --header 'content-type: application/json' \
  --data $REQUEST_BODY)

# Extract token from response
ACCESS_TOKEN=$(echo $TOKEN_RESPONSE | jq -r '.access_token')

# Check if we got a token
if [[ -z "$ACCESS_TOKEN" ]]; then
    echo "Failed to retrieve auth token"
    exit 1
fi

# Copy token to clipboard
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    echo "$ACCESS_TOKEN" | xclip -selection clipboard

elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    echo "$ACCESS_TOKEN" | wl-copy
fi

echo "Auth token copied to clipboard."
