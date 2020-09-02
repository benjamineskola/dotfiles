#!/bin/sh
set -e

if command -v brew; then
  brew bundle --global install | grep -v '^Using'
fi
