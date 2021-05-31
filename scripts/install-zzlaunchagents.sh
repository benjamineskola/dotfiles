#!/bin/sh
set -e

if [ "$(uname -s)" = Darwin ]; then
  test -d LaunchAgents && mkdir -p ~/Library/LaunchAgents
  for i in LaunchAgents/*.plist; do
    if [ -f "$HOME/.config/LaunchAgents/$(basename "$i")" ]; then
      launchctl unload "$i"
    fi
    if [ -f "$i" ]; then
      ln -f "$HOME/.config/$i" "$HOME/Library/LaunchAgents" &&
        launchctl load "$HOME/Library/LaunchAgents/$(basename "$i")"
    fi
  done

  for i in "$HOME"/Library/LaunchAgents/*.plist; do
    if ! [ -f "$HOME/.config/LaunchAgents/$(basename "$i")" ]; then
      launchctl unload "$i"
      rm "$i"
    fi
  done
fi
