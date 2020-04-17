#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

[[ ! -z "PRECOMPILE_ASSETS" ]] && bundle exec rake assets:precompile

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
