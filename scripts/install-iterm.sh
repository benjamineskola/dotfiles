#!/bin/sh
set -e

if [ "$(uname -s)" = Darwin ]; then
  mkdir -p "$HOME/Library/Application Support/iTerm2"
  ln -sfhF ../../../.config/iterm2 "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
fi

test -z "$(find "$HOME/.config/fish/conf.d" -maxdepth 1 -name zzz_iterm2_shell_integration.fish -mtime -1)" &&
  curl https://iterm2.com/shell_integration/fish >"$HOME/.config/fish/conf.d/zzz_iterm2_shell_integration.fish"
