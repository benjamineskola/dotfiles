#!/bin/sh
set -e

if command -v gem && test -x "$(command -v gem)"; then
  gem install bundler
  bundle install
  asdf reshim ruby
fi
