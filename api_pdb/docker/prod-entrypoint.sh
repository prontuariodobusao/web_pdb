#!/bin/sh

set -e

echo "Environment: $RAILS_ENV"

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec rails db:migrate

bundle exec puma -C config/puma/production.rb