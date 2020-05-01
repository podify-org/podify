#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

bundle exec sequel -m db/migrate "$DATABASE_URL"
# rails db:migrate

[[ ! -z "$PRECOMPILE_ASSETS" ]] && rails assets:precompile

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
