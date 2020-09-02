#!/bin/sh
set -e

if command -v go; then
  xargs go get -u <go-globals.txt
  asdf reshim golang
fi
