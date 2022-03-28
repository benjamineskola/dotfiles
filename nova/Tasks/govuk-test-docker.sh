#!/bin/sh
set -e

test_command='help'
if grep -q rspec "$PWD"/Gemfile; then
	test_command='spec'
elif grep -q minitest "$PWD"/Gemfile; then
	test_command='test'
fi

govuk-docker-run bundle exec rails "$test_command"
