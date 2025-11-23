#!/bin/sh

CONFIG_PATH=/data/options.json

# Internxt credentials
export INXT_USER="$(jq -r '.user' $CONFIG_PATH)"
export INXT_PASSWORD="$(jq -r '.password' $CONFIG_PATH)"
export INXT_TWOFACTORCODE="$(jq -r '.twofactorcode // empty' $CONFIG_PATH)"
export INXT_OTPTOKEN="$(jq -r '.otptoken // empty' $CONFIG_PATH)"

# WebDAV port and protocol to use
export WEBDAV_PORT=3005
export WEBDAV_PROTOCOL="http"

# Create htpasswd for nginx basic auth
WEBDAV_USER="$(jq -r '.webdav_user' $CONFIG_PATH)"
WEBDAV_PASSWORD="$(jq -r '.webdav_password' $CONFIG_PATH)"
htpasswd -bc /tmp/.htpasswd "$WEBDAV_USER" "$WEBDAV_PASSWORD"

# Start nginx in background
nginx

# Start the WebDAV server
exec /app/docker/entrypoint.sh
