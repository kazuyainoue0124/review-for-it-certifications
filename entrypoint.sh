#!/bin/bash
set -e

rm -f /review_app/tmp/pids/server.pid

exec "$@"