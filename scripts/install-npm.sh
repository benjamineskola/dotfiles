#!/bin/sh
set -e

if command -v npm; then
  xargs npm install --silent -g <npm-globals.txt
  asdf reshim nodejs
fi
