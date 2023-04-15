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

log "Install Hammerspoon spoons"
if [ -d "$XDG_CONFIG_HOME/_hammerspoon/Spoons/vendor" ]; then
    cd "$XDG_CONFIG_HOME/_hammerspoon/Spoons/vendor"
    git pull --depth 1
else
    git clone --depth 1 https://github.com/Hammerspoon/Spoons.git "$XDG_CONFIG_HOME/_hammerspoon/Spoons/vendor"
fi
if [ -d "$XDG_CONFIG_HOME/_hammerspoon/Spoons/Bear.spoon" ]; then
    cd "$XDG_CONFIG_HOME/_hammerspoon/Spoons/Bear.spoon"
    git pull --depth 1
else
    git clone --depth 1 https://github.com/dcreemer/hammerspoon-bear.git "$XDG_CONFIG_HOME/_hammerspoon/Spoons/Bear.spoon"
fi
