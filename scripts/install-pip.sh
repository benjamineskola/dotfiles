#!/bin/sh
set -e

if command -v pip3 && test -x "$(command -v python3)"; then
  pip3 install --upgrade pip
  pip3 install -r requirements.txt | grep -v '^Requirement already satisfied'
  asdf reshim python
fi
