#!/bin/sh
set -e

if command -v nvim; then
  nvim +PlugUpgrade +PlugClean! +PlugUpdate +PlugInstall +qall
fi
