#!/bin/sh

set -e

echo "Environment: $RAILS_ENV"

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec rails server -b 0.0.0.0