#!/bin/sh
set -e

if [ "$(uname -s)" = Darwin ]; then
  if [ "$(hostname -s)" = MacBook-Air ]; then
    test -d LaunchAgents && mkdir -p ~/Library/LaunchAgents
    for i in LaunchAgents/*.yml; do
      yaml2plist "$i" >"$HOME/Library/LaunchAgents/$(basename "$i" .yml).plist"
    done
    for i in LaunchAgents/*.plist; do
      test -e "$i" &&
        ln -f "$HOME/.config/$i" "$HOME/Library/LaunchAgents"
    done
  fi
fi
