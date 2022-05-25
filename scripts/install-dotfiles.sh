#!/bin/sh
set -e

for i in _* private/_*; do
    test -e "$i" &&
        ln -sfh ".config/$i" "$HOME/.$(basename "$i" | sed 's/^_//')"
done
find -L "$HOME" -type l -maxdepth 1 -name '.*' -exec rm {} +

if [ -d "$HOME/Library/Preferences/espanso" ] || ! [ -e "$HOME/Library/Preferences/espanso" ]; then
    if ! [ -L "$HOME/Library/Preferences/espanso" ]; then
        rm -rf "$HOME/Library/Preferences/espanso"
        ln -s "$XDG_CONFIG_HOME/espanso" "$HOME/Library/Preferences/espanso"
    fi
fi

if [ -d "$HOME/Library/Preferences/rustfmt" ] || ! [ -e "$HOME/Library/Preferences/rustfmt" ]; then
    if ! [ -L "$HOME/Library/Preferences/rustfmt" ]; then
        rm -rf "$HOME/Library/Preferences/rustfmt"
        ln -s "$XDG_CONFIG_HOME/rustfmt" "$HOME/Library/Preferences/rustfmt"
    fi
fi
