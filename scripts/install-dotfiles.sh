#!/bin/sh
set -e

for i in _* private/_*; do
  test -e "$i" &&
    ln -sfh ".config/$i" "$HOME/.$(basename "$i" | sed 's/^_//')"
done
find -L "$HOME" -type l -maxdepth 1 -name '.*' -exec rm {} +
