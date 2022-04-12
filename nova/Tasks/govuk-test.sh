#!/bin/sh
set -e

type="$1"

test_command='help'
if grep -q rspec "$PWD"/Gemfile; then
    test_command='spec'
elif grep -q minitest "$PWD"/Gemfile; then
    test_command='test'
fi

if [ "$type" = "local" ]; then
    bundle exec rails "$test_command"
elif [ "$type" = "docker" ]; then
    govuk-docker-run bundle exec rails "$test_command"
fi
