#!/bin/bash
set -e

rm -f /review_app/tmp/pids/server.pid

# ECS用に追記
bundle exec rails db:migrate:reset RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1
# bundle exec rails db:create RAILS_ENV=production
# bundle exec rails db:migrate RAILS_ENV=production
bundle exec rails db:seed RAILS_ENV=production

exec "$@"