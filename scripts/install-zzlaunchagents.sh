#!/bin/sh
set -e

if [ "$(uname -s)" = Darwin ]; then
    test -d LaunchAgents && mkdir -p ~/Library/LaunchAgents
    for i in LaunchAgents/*.plist; do
        launchctl unload "$HOME/Library/LaunchAgents/$(basename "$i")"
        sed -E "s,\\\$PATH,$PATH,g;  s,\\\$HOMEBREW_PREFIX,$HOMEBREW_PREFIX,g; s,\\\$HOME,$HOME,g; s,\\\$XDG_CONFIG_HOME,$XDG_CONFIG_HOME,g; s,\\\$XDG_DATA_HOME,$XDG_DATA_HOME,g; s,\\\$XDG_CACHE_HOME,$XDG_CACHE_HOME,g" "$HOME/.config/$i" >"$HOME/Library/LaunchAgents/$(basename "$i")"
        launchctl load "$HOME/Library/LaunchAgents/$(basename "$i")"
    done

    for i in "$HOME"/Library/LaunchAgents/uk.eskola.*.plist; do
        if ! [ -f "$HOME/.config/LaunchAgents/$(basename "$i")" ]; then
            launchctl unload "$i"
            rm "$i"
        fi
    done
fi
