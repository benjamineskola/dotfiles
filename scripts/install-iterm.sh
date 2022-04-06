#!/bin/sh
set -e

defaults write com.googlecode.iterm2 DynamicProfilesPath "$HOME/.config/iterm2"

if [ -z "$(find "$HOME/.config/fish/conf.d" -maxdepth 1 -name zzz_iterm2_shell_integration.fish -mtime -1)" ]; then
    curl https://iterm2.com/shell_integration/fish >"$HOME/.config/fish/conf.d/zzz_iterm2_shell_integration.fish"
fi

ln -sf ~/.config/scripts/iterm* ~/Library/Application\ Support/iTerm2/Scripts/
