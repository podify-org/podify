#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

if [ "$RUN_MIGRATIONS" = "yes" ]; then
    bundle exec sequel -m db/migrate "$DATABASE_URL"
fi

if [ "$PRECOMPILE_ASSETS" = "yes" ]; then
    rails assets:precompile
fi

exec "$@"
