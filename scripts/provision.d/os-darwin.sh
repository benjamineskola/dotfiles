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
