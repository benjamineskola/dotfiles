#!/bin/sh
set -e

if [ "$(uname -s)" = Darwin ]; then
  if [ "$(hostname -s)" = MacBook-Air ]; then
    test -d LaunchAgents && mkdir -p ~/Library/LaunchAgents
    for i in LaunchAgents/*.yml; do
      yaml2plist "$i" "$HOME/Library/LaunchAgents/$(basename "$i" .yml).plist" &&
        launchctl load "$HOME/Library/LaunchAgents/$(basename "$i" .yml).plist"
    done

    for i in LaunchAgents/*.plist; do
      test -e "$i" &&
        ln -f "$HOME/.config/$i" "$HOME/Library/LaunchAgents" &&
        launchctl load "$HOME/Library/LaunchAgents/$(basename "$i")"
    done

    for i in "$HOME"/Library/LaunchAgents/*.plist; do
      if ! [ -f "$HOME/.config/LaunchAgents/$(basename "$i")" ] || [ -f "$HOME/.config/LaunchAgents/$(basename "$i" .plist).yml" ]; then
        launchctl unload "$i"
        rm "$i"
      fi
    done
  fi
fi
