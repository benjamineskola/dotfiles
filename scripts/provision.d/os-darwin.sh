#!/bin/sh
set -e
log "Don't automatically rearrange spaces"
defaults write com.apple.dock mru-spaces -bool false

log "Update Homebrew and install required packages"
if [ -z "$(find /opt/homebrew -type f -mtime -1 | head -n 1)" ]; then
    brew update
    brew upgrade
    brew bundle --global install
    brew bundle --global cleanup
fi

log "Link preferences into place"
# shellcheck disable=SC2043
for pref in espanso; do
    ln -sfh "$XDG_CONFIG_HOME/$pref" "$HOME/Library/Preferences/$pref"
done
log "Link application support into place"
# shellcheck disable=SC2043
for pref in rustfmt; do
    ln -sfh "$XDG_CONFIG_HOME/$pref" "$HOME/Library/Application Support/$pref"
done
