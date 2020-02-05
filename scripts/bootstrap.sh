#!/bin/sh
for i in _* private/_*; do
  test -e "$i" &&
    ln -sfh ".config/$i" "$HOME/.$(basename "$i" | sed 's/^_//')"
done

if [ "$(uname -s)" = Darwin ]; then
  if [ "$(hostname -s)" = Benjamins-MBP ]; then
    test -d LaunchAgents && mkdir -p ~/Library/LaunchAgents
    for i in LaunchAgents/*.yml; do
      scripts/yaml2plist.rb "$i" >"$HOME/Library/LaunchAgents/$(basename "$i" .yml).plist"
    done
    for i in LaunchAgents/*.plist; do
      test -e "$i" &&
        ln -f "$HOME/.config/$i" "$HOME/Library/LaunchAgents"
    done
  fi

fi

command -v bat && bat cache --build
