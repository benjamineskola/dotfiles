#!/bin/sh
set -e

if command -v nvim
  nvim +PlugUpgrade +PlugClean! +PlugUpdate +PlugInstall +qall
fi
