#!/bin/bash

# Exit on fail
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

bundle check || bundle install --binstubs="$BUNDLE_BIN"

exec "$@"
